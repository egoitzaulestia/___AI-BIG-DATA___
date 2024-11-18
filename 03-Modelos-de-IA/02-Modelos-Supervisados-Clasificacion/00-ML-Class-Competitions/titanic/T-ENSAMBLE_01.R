# Clear the workspace and set seed for reproducibility
rm(list=ls())
set.seed(42)

# Load necessary libraries
library(data.table)
library(dplyr)
library(caret)
library(rpart)
library(randomForest)
library(xgboost)
library(e1071)
library(Matrix)
library(pROC)
library(tidyr)
library(glmnet)

# 1. Read the data
train <- fread("train.csv", stringsAsFactors = FALSE)
test <- fread("test.csv", stringsAsFactors = FALSE)

# Add 'Survived' column to test set
test$Survived <- NA

# Combine train and test datasets
full_data <- bind_rows(train, test)

# 2. Feature Engineering

## 2.1 Extract Titles from Names
full_data$Title <- gsub('(.*, )|(\\..*)', '', full_data$Name)
# Simplify titles
full_data$Title[full_data$Title %in% c('Mlle', 'Ms')] <- 'Miss'
full_data$Title[full_data$Title == 'Mme'] <- 'Mrs'
full_data$Title[full_data$Title %in% c('Lady', 'Countess','Capt', 'Col','Don', 'Dr', 'Major', 'Rev', 
                                       'Sir', 'Jonkheer', 'Dona')] <- 'Rare'
full_data$Title <- factor(full_data$Title)

## 2.2 Create FamilySize and IsAlone features
full_data$FamilySize <- full_data$SibSp + full_data$Parch + 1
full_data$IsAlone <- ifelse(full_data$FamilySize == 1, 1, 0)
full_data$IsAlone <- factor(full_data$IsAlone)

## 2.3 Impute missing Embarked values
full_data$Embarked[full_data$Embarked == ""] <- "S"
full_data$Embarked <- factor(full_data$Embarked)

## 2.4 Impute missing Fare values
full_data$Fare[is.na(full_data$Fare)] <- median(full_data$Fare, na.rm = TRUE)

## 2.5 Impute missing Age values using a predictive model
age_impute <- rpart(Age ~ Pclass + Sex + Fare + SibSp + Parch + Embarked + Title + FamilySize,
                    data = full_data[!is.na(full_data$Age), ], method = "anova")
full_data$Age[is.na(full_data$Age)] <- predict(age_impute, full_data[is.na(full_data$Age), ])

## 2.6 Create AgeGroup feature
full_data$AgeGroup <- cut(full_data$Age,
                          breaks = c(0, 12, 18, 25, 35, 60, Inf),
                          labels = c("Child", "Teenager", "YoungAdult", "Adult", "MiddleAged", "Senior"))

## 2.7 Create FareGroup feature
full_data$FareGroup <- cut(full_data$Fare,
                           breaks = c(-Inf, 7.91, 14.454, 31, Inf),
                           labels = c("LowFare", "MedFare", "HighFare", "VeryHighFare"))

## 2.8 Extract Deck information from Cabin
full_data$Deck <- substr(full_data$Cabin, 1, 1)
full_data$Deck[full_data$Deck == ""] <- "U"
full_data$Deck <- factor(full_data$Deck)

## 2.9 Create TicketCount feature (number of passengers sharing the same ticket)
ticket_counts <- full_data %>% group_by(Ticket) %>% summarize(TicketCount = n())
full_data <- left_join(full_data, ticket_counts, by = "Ticket")

## 2.10 Create FamilyID feature
full_data$Surname <- sapply(full_data$Name, function(x) strsplit(x, split = '[,.]')[[1]][1])
full_data$FamilyID <- paste(full_data$FamilySize, full_data$Surname, sep = "")
full_data$FamilyID[full_data$FamilySize <= 2] <- 'Small'
famIDs <- data.frame(table(full_data$FamilyID))
famIDs <- famIDs[famIDs$Freq <= 2,]
full_data$FamilyID[full_data$FamilyID %in% famIDs$Var1] <- 'Small'
full_data$FamilyID <- factor(full_data$FamilyID)

# Drop temporary variables
full_data$Surname <- NULL

# 3. Convert categorical variables to factors
categorical_vars <- c("Pclass", "Sex", "Embarked", "Title", "AgeGroup", "FareGroup", "Deck", "IsAlone", "FamilyID")
# full_data[categorical_vars] <- lapply(full_data[categorical_vars], factor)
full_data <- as.data.frame(full_data)
full_data[categorical_vars] <- lapply(full_data[categorical_vars], factor)

# 4. Handle missing values (if any remain)
full_data[is.na(full_data)] <- -999

# 5. Split back into train and test sets
train_data <- full_data[1:nrow(train), ]
test_data <- full_data[(nrow(train) + 1):nrow(full_data), ]

# Remove columns that won't be used
drop_columns <- c("PassengerId", "Name", "Ticket", "Cabin", "Survived")
train_features <- train_data[, !(names(train_data) %in% drop_columns)]
train_labels <- train_data$Survived
test_features <- test_data[, !(names(test_data) %in% drop_columns)]
test_passenger_id <- test_data$PassengerId

# 6. Prepare data for modeling
# Create dummy variables
dummy_model <- dummyVars(~ ., data = train_features)
train_matrix <- predict(dummy_model, newdata = train_features)
test_matrix <- predict(dummy_model, newdata = test_features)

# Ensure train and test have the same columns
train_matrix <- as.data.frame(train_matrix)
test_matrix <- as.data.frame(test_matrix)
missing_cols <- setdiff(names(train_matrix), names(test_matrix))
for (col in missing_cols) {
  test_matrix[, col] <- 0
}
test_matrix <- test_matrix[, names(train_matrix)]

# 7. Standardize features
preProcValues <- preProcess(train_matrix, method = c("center", "scale"))
train_matrix <- predict(preProcValues, train_matrix)
test_matrix <- predict(preProcValues, test_matrix)

# 8. Model Training and Ensembling

## 8.1 Cross-validation setup
cv_folds <- createFolds(train_labels, k = 5, list = TRUE, returnTrain = FALSE)

## 8.2 Initialize prediction matrices
train_predictions <- data.frame(Actual = train_labels)
test_predictions <- data.frame(PassengerId = test_passenger_id)

## 8.3 Define models to use in ensemble
models_list <- list()

### Random Forest
rf_model <- train(x = train_matrix, y = as.factor(train_labels),
                  method = "rf",
                  trControl = trainControl(method = "cv", number = 5),
                  tuneLength = 5)
models_list$rf <- rf_model

### Gradient Boosting Machine (GBM)
gbm_model <- train(x = train_matrix, y = as.factor(train_labels),
                   method = "gbm",
                   trControl = trainControl(method = "cv", number = 5),
                   verbose = FALSE,
                   tuneLength = 5)
models_list$gbm <- gbm_model

### XGBoost
xgb_model <- train(x = train_matrix, y = as.factor(train_labels),
                   method = "xgbTree",
                   trControl = trainControl(method = "cv", number = 5),
                   tuneLength = 5)
models_list$xgb <- xgb_model

# ### Support Vector Machine (SVM)
# svm_model <- train(x = train_matrix, y = as.factor(train_labels),
#                    method = "svmRadial",
#                    trControl = trainControl(method = "cv", number = 5),
#                    tuneLength = 5)
# models_list$svm <- svm_model
# 
# models_list$svm = NULL

### Logistic Regression
glm_model <- train(x = train_matrix, y = as.factor(train_labels),
                   method = "glm",
                   trControl = trainControl(method = "cv", number = 5))
models_list$glm <- glm_model

# ## 8.4 Generate predictions on training data for stacking
# for (model_name in names(models_list)) {
#   model <- models_list[[model_name]]
#   pred <- predict(model, train_matrix, type = "prob")[,2]
#   train_predictions[[model_name]] <- pred
# }

## 8.4 Generate predictions on training data for stacking
for (model_name in names(models_list)) {
  model <- models_list[[model_name]]
  pred <- predict(model, train_matrix, type = "prob")[,2]
  # Ensure the prediction length matches the training data
  if (length(pred) != nrow(train_predictions)) {
    stop(paste("Prediction length mismatch for model:", model_name))
  }
  train_predictions[[model_name]] <- pred
}

## 8.5 Generate predictions on test data
# for (model_name in names(models_list)) {
#   model <- models_list[[model_name]]
#   pred <- predict(model, test_matrix, type = "prob")[,2]
#   test_predictions[[model_name]] <- pred
# }

for (model_name in names(models_list)) {
  model <- models_list[[model_name]]
  pred <- predict(model, test_matrix, type = "prob")[,2]
  # Ensure the prediction length matches the test data
  if (length(pred) != nrow(test_predictions)) {
    stop(paste("Prediction length mismatch for model:", model_name))
  }
  test_predictions[[model_name]] <- pred
}


# 9. Stacking - Second level model
# Use predictions from first-level models as features for second-level model

## 9.1 Prepare data for stacking
stack_train_features <- train_predictions[, -1]  # Remove 'Actual' column
stack_train_labels <- train_predictions$Actual
stack_test_features <- test_predictions[, -1]    # Remove 'PassengerId' column

## 9.2 Train second-level model (e.g., Logistic Regression)
stack_model <- train(x = stack_train_features, y = as.factor(stack_train_labels),
                     method = "glm",
                     trControl = trainControl(method = "cv", number = 5))

# 10. Evaluate model performance
stack_train_pred <- predict(stack_model, stack_train_features)
confusion <- confusionMatrix(stack_train_pred, as.factor(stack_train_labels), positive = "1")
print(confusion)

# 11. Make final predictions on test data
final_pred <- predict(stack_model, stack_test_features)
# Convert predictions to binary (assuming 0.5 threshold)
final_pred_class <- ifelse(as.numeric(final_pred) > 1.5, 1, 0)
submission <- data.frame(PassengerId = test_passenger_id, Survived = final_pred_class)
write.csv(submission, "stacked_submission_01.csv", row.names = FALSE)
