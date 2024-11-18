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
library(kernlab)

# 1. Read the data
train <- fread("train.csv", stringsAsFactors = FALSE)
test <- fread("test.csv", stringsAsFactors = FALSE)

# Add 'Survived' column to test set
test$Survived <- NA

# Combine train and test datasets
full_data <- rbindlist(list(train, test), use.names = TRUE, fill = TRUE)

# 2. Feature Engineering

## 2.1 Extract Titles from Names
full_data[, Title := sub('(.*, )|(\\..*)', '', Name)]
# Simplify titles
full_data[Title %in% c('Mlle', 'Ms'), Title := 'Miss']
full_data[Title == 'Mme', Title := 'Mrs']
full_data[Title %in% c('Lady', 'Countess','Capt', 'Col','Don', 'Dr', 'Major', 'Rev', 
                       'Sir', 'Jonkheer', 'Dona'), Title := 'Rare']

## 2.2 Create FamilySize and IsAlone features
full_data[, FamilySize := SibSp + Parch + 1]
full_data[, IsAlone := ifelse(FamilySize == 1, 1, 0)]

## 2.3 Impute missing Embarked values
full_data[Embarked == "", Embarked := "S"]

## 2.4 Impute missing Fare values
full_data[is.na(Fare), Fare := median(Fare, na.rm = TRUE)]

## 2.5 Impute missing Age values using a predictive model
age_impute <- rpart(Age ~ Pclass + Sex + Fare + SibSp + Parch + Embarked + Title + FamilySize,
                    data = full_data[!is.na(Age)], method = "anova")
full_data[is.na(Age), Age := predict(age_impute, full_data[is.na(Age)])]

## 2.6 Create AgeGroup feature
full_data[, AgeGroup := cut(Age,
                            breaks = c(0, 12, 18, 25, 35, 60, Inf),
                            labels = c("Child", "Teenager", "YoungAdult", "Adult", "MiddleAged", "Senior"))]

## 2.7 Create FareGroup feature
full_data[, FareGroup := cut(Fare,
                             breaks = c(-Inf, 7.91, 14.454, 31, Inf),
                             labels = c("LowFare", "MedFare", "HighFare", "VeryHighFare"))]

## 2.8 Extract Deck information from Cabin
full_data[, Deck := substr(Cabin, 1, 1)]
full_data[Deck == "", Deck := "U"]

## 2.9 Create TicketCount feature (number of passengers sharing the same ticket)
full_data[, TicketCount := .N, by = Ticket]

## 2.10 Create FamilyID feature
full_data[, Surname := sapply(Name, function(x) strsplit(x, split = '[,.]')[[1]][1])]
full_data[, FamilyID := paste(FamilySize, Surname, sep = "")]
full_data[FamilySize <= 2, FamilyID := 'Small']
famIDs <- full_data[, .N, by = FamilyID][N <= 2, FamilyID]
full_data[FamilyID %in% famIDs, FamilyID := 'Small']
full_data[, FamilyID := factor(FamilyID)]

# Drop temporary variables
full_data[, Surname := NULL]

# 3. Convert categorical variables to factors using data.table syntax
# List of categorical variables
categorical_vars <- c("Pclass", "Sex", "Embarked", "Title", "AgeGroup", "FareGroup", "Deck", "IsAlone", "FamilyID")

# Convert to factors
full_data[, (categorical_vars) := lapply(.SD, factor), .SDcols = categorical_vars]

# 4. Handle missing values (if any remain)
full_data[is.na(full_data)] <- -999

# 5. Split back into train and test sets
train_data <- full_data[1:nrow(train)]
test_data <- full_data[(nrow(train) + 1):.N]

# Remove columns that won't be used
drop_columns <- c("PassengerId", "Name", "Ticket", "Cabin", "Survived")
train_features <- train_data[, !..drop_columns]
train_labels <- as.factor(train_data$Survived)
test_features <- test_data[, !..drop_columns]
test_passenger_id <- test_data$PassengerId

# 6. Prepare data for modeling
# Create dummy variables using model.matrix
train_matrix <- model.matrix(~ . - 1, data = train_features)
test_matrix <- model.matrix(~ . - 1, data = test_features)

# Ensure train and test have the same columns
train_cols <- colnames(train_matrix)
test_cols <- colnames(test_matrix)
missing_cols <- setdiff(train_cols, test_cols)
for (col in missing_cols) {
  test_matrix <- cbind(test_matrix, setNames(data.table(0), col))
}
test_matrix <- test_matrix[, train_cols, with = FALSE]

# 7. Standardize features
preProcValues <- preProcess(train_matrix, method = c("center", "scale"))
train_matrix <- predict(preProcValues, train_matrix)
test_matrix <- predict(preProcValues, test_matrix)

# 8. Model Training and Ensembling

## 8.1 Cross-validation setup
tr_control <- trainControl(method = "cv", number = 5, classProbs = TRUE)

## 8.2 Initialize prediction matrices
train_predictions <- data.table(Actual = as.numeric(as.character(train_labels)))
test_predictions <- data.table(PassengerId = test_passenger_id)

## 8.3 Define models to use in ensemble
models_list <- list()

### Random Forest
set.seed(42)
rf_model <- train(x = train_matrix, y = train_labels,
                  method = "rf",
                  trControl = tr_control,
                  tuneLength = 5)
models_list$rf <- rf_model

### Gradient Boosting Machine (GBM)
set.seed(42)
gbm_model <- train(x = train_matrix, y = train_labels,
                   method = "gbm",
                   trControl = tr_control,
                   verbose = FALSE,
                   tuneLength = 5)
models_list$gbm <- gbm_model

### XGBoost
set.seed(42)
xgb_model <- train(x = train_matrix, y = train_labels,
                   method = "xgbTree",
                   trControl = tr_control,
                   tuneLength = 5)
models_list$xgb <- xgb_model

### Support Vector Machine (SVM)
set.seed(42)
svm_model <- train(x = train_matrix, y = train_labels,
                   method = "svmRadial",
                   trControl = tr_control,
                   tuneLength = 5,
                   prob.model = TRUE)
models_list$svm <- svm_model

### Logistic Regression
set.seed(42)
glm_model <- train(x = train_matrix, y = train_labels,
                   method = "glm",
                   trControl = tr_control)
models_list$glm <- glm_model

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
stack_train_features <- as.data.frame(train_predictions[, -1])  # Remove 'Actual' column
stack_train_labels <- as.factor(train_predictions$Actual)
stack_test_features <- as.data.frame(test_predictions[, -1])    # Remove 'PassengerId' column

## 9.2 Train second-level model (e.g., Logistic Regression)
set.seed(42)
stack_model <- train(x = stack_train_features, y = stack_train_labels,
                     method = "glm",
                     trControl = trainControl(method = "cv", number = 5))

# 10. Evaluate model performance
stack_train_pred <- predict(stack_model, stack_train_features)
confusion <- confusionMatrix(stack_train_pred, stack_train_labels, positive = "1")
print(confusion)

# 11. Make final predictions on test data
final_pred <- predict(stack_model, stack_test_features)
# Convert predictions to binary (assuming '1' is positive class)
final_pred_class <- ifelse(final_pred == "1", 1, 0)
submission <- data.table(PassengerId = test_passenger_id, Survived = final_pred_class)
fwrite(submission, "stacked_submission.csv", row.names = FALSE)
