# Limpiar el entorno y establecer semilla para reproducibilidad
rm(list=ls())
set.seed(123)

# Cargar librerías necesarias
library(xgboost)
library(caret)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rpart)
library(data.table)

# 1. Leer los datos
train <- fread("train.csv", stringsAsFactors = FALSE)
test <- fread("test.csv", stringsAsFactors = FALSE)

# Añadir columna 'Survived' al conjunto de test para unificar los datos
test$Survived <- NA

# Combinar los conjuntos de datos
full_data <- bind_rows(train, test)

# 2. Ingeniería de características

## 2.1 Extraer títulos de los nombres
full_data$Title <- gsub('(.*, )|(\\..*)', '', full_data$Name)
# Agrupar títulos poco comunes
rare_titles <- c('Lady', 'Countess', 'Capt', 'Col', 'Don', 'Dr', 'Major', 'Rev', 
                 'Sir', 'Jonkheer', 'Dona')
full_data$Title[full_data$Title %in% rare_titles] <- 'Rare'
full_data$Title[full_data$Title == 'Mlle'] <- 'Miss' 
full_data$Title[full_data$Title == 'Ms'] <- 'Miss'
full_data$Title[full_data$Title == 'Mme'] <- 'Mrs'
full_data$Title <- factor(full_data$Title)

## 2.2 Crear variable 'FamilySize'
full_data$FamilySize <- full_data$SibSp + full_data$Parch + 1

## 2.3 Crear variable 'IsAlone'
full_data$IsAlone <- ifelse(full_data$FamilySize == 1, 1, 0)
full_data$IsAlone <- factor(full_data$IsAlone)

## 2.4 Rellenar valores faltantes en 'Embarked' con el modo
full_data$Embarked[full_data$Embarked == ""] <- "S"
full_data$Embarked <- factor(full_data$Embarked)

## 2.5 Rellenar valores faltantes en 'Fare' con la mediana
full_data$Fare[is.na(full_data$Fare)] <- median(full_data$Fare, na.rm = TRUE)

## 2.6 Imputar valores faltantes en 'Age' utilizando un modelo predictivo
age_model <- rpart(Age ~ Pclass + Sex + Fare + Embarked + Title + FamilySize,
                   data = full_data[!is.na(full_data$Age), ],
                   method = "anova")
full_data$Age[is.na(full_data$Age)] <- predict(age_model, full_data[is.na(full_data$Age), ])

## 2.7 Crear variable 'AgeGroup'
full_data$AgeGroup <- cut(full_data$Age,
                          breaks = c(0, 12, 18, 25, 35, 60, Inf),
                          labels = c("Child", "Teenager", "YoungAdult", "Adult", "MiddleAged", "Senior"))

## 2.8 Crear variable 'FareGroup'
full_data$FareGroup <- cut(full_data$Fare,
                           breaks = quantile(full_data$Fare, probs = seq(0, 1, 0.2), na.rm = TRUE),
                           include.lowest = TRUE,
                           labels = c("VeryLow", "Low", "Medium", "High", "VeryHigh"))

## 2.9 Crear variable 'Deck' a partir de 'Cabin'
full_data$Deck <- substr(full_data$Cabin, 1, 1)
full_data$Deck[full_data$Deck == ""] <- "U"  # U de 'Unknown'
full_data$Deck <- factor(full_data$Deck)

## 2.10 Crear variable 'TicketPrefix'
full_data$TicketPrefix <- sapply(full_data$Ticket, function(x) strsplit(x, " ")[[1]][1])
full_data$TicketPrefix <- ifelse(full_data$TicketPrefix %in% c("A", "P", "SOTON/OQ", "STON/O2.", "S.C./PARIS", "SC/AH", "SC/PARIS", "SC/Paris"), full_data$TicketPrefix, "Other")
full_data$TicketPrefix <- factor(full_data$TicketPrefix)

# 3. Manejo de outliers

## 3.1 Transformación logarítmica en 'Fare'
full_data$Fare <- log1p(full_data$Fare)

## 3.2 Detección y manejo de outliers en 'Age' usando el rango intercuartílico
Q1 <- quantile(full_data$Age, 0.25)
Q3 <- quantile(full_data$Age, 0.75)
IQR <- Q3 - Q1
full_data$Age[full_data$Age < (Q1 - 1.5 * IQR)] <- Q1
full_data$Age[full_data$Age > (Q3 + 1.5 * IQR)] <- Q3

# 4. Conversión de variables categóricas a factores
full_data$Sex <- factor(full_data$Sex)
full_data$Pclass <- factor(full_data$Pclass)
full_data$Embarked <- factor(full_data$Embarked)
full_data$AgeGroup <- factor(full_data$AgeGroup)
full_data$FareGroup <- factor(full_data$FareGroup)
full_data$Deck <- factor(full_data$Deck)
full_data$TicketPrefix <- factor(full_data$TicketPrefix)

# 5. Creación de variables dummy
dummy_vars <- dummyVars(~ Pclass + Sex + Embarked + Title + AgeGroup + FareGroup + IsAlone + Deck + TicketPrefix,
                        data = full_data)
full_dummy <- data.frame(predict(dummy_vars, newdata = full_data))

# Combinar variables dummy con variables numéricas relevantes
full_model_data <- cbind(full_dummy,
                         FamilySize = full_data$FamilySize,
                         Fare = full_data$Fare,
                         Survived = full_data$Survived)

# 6. Separar nuevamente en conjuntos de entrenamiento y prueba
train_data <- full_model_data[1:nrow(train), ]
test_data <- full_model_data[(nrow(train) + 1):nrow(full_model_data), ]

# 7. Preparar datos para el modelo
# Definir variables predictoras y variable objetivo
predictors <- names(train_data)[!names(train_data) %in% c("Survived")]

# Crear matrices DMatrix para XGBoost
dtrain <- xgb.DMatrix(data = as.matrix(train_data[, predictors]),
                      label = train_data$Survived)
dtest <- xgb.DMatrix(data = as.matrix(test_data[, predictors]))

# 8. Búsqueda de hiperparámetros usando Grid Search
# Definir grid de parámetros
param_grid <- expand.grid(
  eta = c(0.01, 0.05, 0.1),
  max_depth = c(4, 6, 8),
  subsample = c(0.6, 0.8, 1),
  colsample_bytree = c(0.6, 0.8, 1)
)

# Inicializar variables para almacenar los mejores resultados
best_score <- 0
best_params <- list()
best_nrounds <- 0

# Realizar validación cruzada para encontrar los mejores parámetros
for (i in 1:nrow(param_grid)) {
  params <- list(
    booster = "gbtree",
    objective = "binary:logistic",
    eval_metric = "auc",
    eta = param_grid$eta[i],
    max_depth = param_grid$max_depth[i],
    subsample = param_grid$subsample[i],
    colsample_bytree = param_grid$colsample_bytree[i]
  )
  
  cv_model <- xgb.cv(
    params = params,
    data = dtrain,
    nrounds = 1000,
    nfold = 5,
    early_stopping_rounds = 50,
    verbose = 0,
    maximize = TRUE
  )
  
  mean_auc <- max(cv_model$evaluation_log$test_auc_mean)
  
  if (mean_auc > best_score) {
    best_score <- mean_auc
    best_params <- params
    best_nrounds <- cv_model$best_iteration
  }
}

# Mostrar los mejores parámetros
print(best_params)
print(paste("Best AUC:", best_score))
print(paste("Best nrounds:", best_nrounds))

# 9. Entrenar el modelo final con los mejores parámetros
final_model <- xgb.train(
  params = best_params,
  data = dtrain,
  nrounds = best_nrounds,
  verbose = 0
)

# 10. Evaluación del modelo en el conjunto de entrenamiento
train_pred <- predict(final_model, dtrain)
train_pred_class <- ifelse(train_pred > 0.5, 1, 0)

# Matriz de confusión
confusion <- confusionMatrix(
  factor(train_pred_class),
  factor(train_data$Survived),
  positive = "1"
)
print(confusion)

# 11. Predicciones en el conjunto de prueba
test_pred <- predict(final_model, dtest)
test_pred_class <- ifelse(test_pred > 0.5, 1, 0)

# 12. Crear archivo de submission
submission <- data.frame(PassengerId = test$PassengerId, Survived = test_pred_class)
write.csv(submission, "XGB_Final_01.csv", row.names = FALSE)
