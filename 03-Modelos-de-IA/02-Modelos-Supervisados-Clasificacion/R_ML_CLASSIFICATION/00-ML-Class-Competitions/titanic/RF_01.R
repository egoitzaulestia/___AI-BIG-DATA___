# Limpiar el entorno y establecer semilla para reproducibilidad
rm(list = ls())
set.seed(42)

# Cargar librerías necesarias
library(data.table)
library(dplyr)
library(caret)
library(rpart)
library(randomForest)
library(Matrix)
library(pROC)
library(tidyr)
library(glmnet)

# 1. Leer los datos
train <- fread("train.csv", stringsAsFactors = FALSE)
test <- fread("test.csv", stringsAsFactors = FALSE)

# 2. Preprocesamiento y Ingeniería de Características en el Conjunto de Entrenamiento

## 2.1 Imputación de valores faltantes en 'Embarked' usando el modo
train[Embarked == "" | is.na(Embarked), Embarked := "S"]
train[, Embarked := factor(Embarked)]

## 2.2 Imputación de valores faltantes en 'Fare' usando la mediana
train[is.na(Fare), Fare := median(Fare, na.rm = TRUE)]

## 2.3 Imputación de valores faltantes en 'Age' usando un modelo predictivo
age_model <- rpart(Age ~ Pclass + Sex + Fare + SibSp + Parch + Embarked,
                   data = train[!is.na(Age)], method = "anova")
train[is.na(Age), Age := predict(age_model, train[is.na(Age)])]

## 2.4 Ingeniería de características en el conjunto de entrenamiento

# Crear 'Title' y 'FamilySize'
train[, `:=`(
  Title = sub('(.*, )|(\\..*)', '', Name),
  FamilySize = SibSp + Parch + 1
)]

# Crear 'IsAlone' usando 'FamilySize'
train[, IsAlone := ifelse(FamilySize == 1, 1, 0)]

# Continuar con las transformaciones
train[, `:=`(
  AgeGroup = cut(Age,
                 breaks = c(0, 12, 18, 25, 35, 60, Inf),
                 labels = c("Child", "Teenager", "YoungAdult", "Adult", "MiddleAged", "Senior")),
  FareGroup = cut(Fare,
                  breaks = c(-Inf, 7.91, 14.454, 31, Inf),
                  labels = c("LowFare", "MedFare", "HighFare", "VeryHighFare"))
)]

# Simplificar títulos
train[, Title := case_when(
  Title %in% c('Mlle', 'Ms') ~ 'Miss',
  Title == 'Mme' ~ 'Mrs',
  Title %in% c('Lady', 'Countess', 'Capt', 'Col', 'Don', 'Dr', 'Major', 'Rev',
               'Sir', 'Jonkheer', 'Dona') ~ 'Rare',
  TRUE ~ Title
)]

# Convertir variables categóricas a factores
categorical_vars <- c("Pclass", "Sex", "Embarked", "Title", "IsAlone", "AgeGroup", "FareGroup")
train[, (categorical_vars) := lapply(.SD, as.factor), .SDcols = categorical_vars]

# 3. Preprocesamiento y Ingeniería de Características en el Conjunto de Prueba

## 3.1 Imputación de valores faltantes en 'Embarked'
test[Embarked == "" | is.na(Embarked), Embarked := "S"]
test[, Embarked := factor(Embarked)]

## 3.2 Imputación de valores faltantes en 'Fare'
test[is.na(Fare), Fare := median(train$Fare, na.rm = TRUE)] # Usar mediana de 'train'

## 3.3 Imputación de valores faltantes en 'Age'
test[is.na(Age), Age := predict(age_model, test[is.na(Age)])]

## 3.4 Ingeniería de características en el conjunto de prueba

# Crear 'Title' y 'FamilySize'
test[, `:=`(
  Title = sub('(.*, )|(\\..*)', '', Name),
  FamilySize = SibSp + Parch + 1
)]

# Crear 'IsAlone' usando 'FamilySize'
test[, IsAlone := ifelse(FamilySize == 1, 1, 0)]

# Continuar con las transformaciones
test[, `:=`(
  AgeGroup = cut(Age,
                 breaks = c(0, 12, 18, 25, 35, 60, Inf),
                 labels = c("Child", "Teenager", "YoungAdult", "Adult", "MiddleAged", "Senior")),
  FareGroup = cut(Fare,
                  breaks = c(-Inf, 7.91, 14.454, 31, Inf),
                  labels = c("LowFare", "MedFare", "HighFare", "VeryHighFare"))
)]

# Simplificar títulos
test[, Title := case_when(
  Title %in% c('Mlle', 'Ms') ~ 'Miss',
  Title == 'Mme' ~ 'Mrs',
  Title %in% c('Lady', 'Countess', 'Capt', 'Col', 'Don', 'Dr', 'Major', 'Rev',
               'Sir', 'Jonkheer', 'Dona') ~ 'Rare',
  TRUE ~ Title
)]

# Alinear niveles de variables categóricas entre 'train' y 'test'
for (col in categorical_vars) {
  train_levels <- levels(train[[col]])
  test[[col]][!test[[col]] %in% train_levels] <- NA
  test[[col]] <- factor(test[[col]], levels = train_levels)
}

# 4. Selección de características

features <- c("Pclass", "Sex", "Age", "Fare", "Embarked", "Title", "FamilySize", "IsAlone")

train_data <- train[, c(..features, "Survived")]
test_data <- test[, ..features]

# 5. Preparar datos para el modelo

# Combinar 'train' y 'test' para crear variables dummy consistentes
combined_data <- rbindlist(list(train_data[, -"Survived"], test_data), use.names = TRUE, fill = TRUE)

# Crear variables dummy
dummy_model <- dummyVars(~ ., data = combined_data, fullRank = TRUE)
combined_matrix <- predict(dummy_model, newdata = combined_data)

# Dividir nuevamente en matrices de 'train' y 'test'
train_matrix <- combined_matrix[1:nrow(train_data), ]
test_matrix <- combined_matrix[(nrow(train_data) + 1):nrow(combined_matrix), ]

# Verificar valores faltantes en 'test_matrix'
if (any(is.na(test_matrix))) {
  test_matrix[is.na(test_matrix)] <- 0
}

# Estandarizar características
preProcValues <- preProcess(train_matrix, method = c("center", "scale"))
train_matrix <- predict(preProcValues, train_matrix)
test_matrix <- predict(preProcValues, test_matrix)

# 6. Convertir la variable objetivo a factor
train_labels <- as.factor(train_data$Survived)

# 7. Implementar Validación Cruzada

control <- trainControl(method = "cv", number = 5)

# 8. Entrenar un Modelo Simple (e.g., Random Forest)
# 
# set.seed(42)
# model <- train(
#   x = train_matrix,
#   y = train_labels,
#   method = "rf",
#   trControl = control,
#   tuneLength = 3
# )

# Definir una cuadrícula para los hiperparámetros
rf_grid <- expand.grid(
  mtry = c(2, 3, 4),  # Número de predictores por split
  splitrule = c("gini", "extratrees"),  # Reglas de partición
  min.node.size = c(1, 5, 10)  # Tamaño mínimo de nodos
)

# Entrenar el modelo con validación cruzada y búsqueda en cuadrícula
rf_model <- train(
  x = train_matrix,
  y = train_labels,
  method = "ranger",  # Implementación eficiente de Random Forest
  trControl = trainControl(method = "cv", number = 5, search = "grid"),
  tuneGrid = rf_grid,
  importance = "impurity"  # Permite ver la importancia de las variables
)

# Imprimir los resultados del modelo
print(rf_model)

# 9. Evaluación del Modelo

train_pred <- predict(rf_model, train_matrix)
confusion <- confusionMatrix(train_pred, train_labels, positive = "1")
print(confusion)

# 10. Predicciones en el Conjunto de Prueba

test_pred <- predict(model, test_matrix)

# 11. Crear archivo de submission

submission <- data.frame(PassengerId = test$PassengerId, Survived = test_pred)
write.csv(submission, "RF_Monday_01.csv", row.names = FALSE)



###################################


set.seed(42)

# Definir parámetros iniciales
xgb_params <- list(
  objective = "binary:logistic",
  eval_metric = "logloss",
  eta = 0.1,  # Tasa de aprendizaje
  max_depth = 6,  # Profundidad máxima
  subsample = 0.8,  # Submuestreo de filas
  colsample_bytree = 0.8  # Submuestreo de columnas
)

# Convertir datos a formato DMatrix de XGBoost
dtrain <- xgb.DMatrix(data = train_matrix, label = as.numeric(train_labels) - 1)
dtest <- xgb.DMatrix(data = test_matrix)

# Validación cruzada para determinar el número óptimo de iteraciones
cv_results <- xgb.cv(
  params = xgb_params,
  data = dtrain,
  nrounds = 500,
  nfold = 5,
  early_stopping_rounds = 10,  # Detener si no mejora
  verbose = FALSE
)

# Obtener el mejor número de iteraciones
best_nrounds <- cv_results$best_iteration

# Entrenar el modelo final
xgb_model <- xgb.train(
  params = xgb_params,
  data = dtrain,
  nrounds = best_nrounds,
  verbose = FALSE
)

# Predicciones en el conjunto de prueba
test_pred <- predict(xgb_model, dtest)
test_pred_class <- ifelse(test_pred > 0.5, 1, 0)

# Crear archivo de submission
submission <- data.frame(PassengerId = test$PassengerId, Survived = test_pred_class)
write.csv(submission, "xgb_submission_01.csv", row.names = FALSE)


##################################################


set.seed(42)

# # Definir la cuadrícula de hiperparámetros
# xgb_grid <- expand.grid(
#   nrounds = c(100, 200),  # Reducir a 2 valores
#   max_depth = c(4, 6),    # Reducir a 2 valores
#   eta = c(0.1, 0.3),      # Reducir a 2 valores
#   gamma = c(0, 1),        # Reducir a 2 valores
#   colsample_bytree = c(0.8),  # Fijar un único valor
#   min_child_weight = c(1, 5), # Reducir a 2 valores
#   subsample = c(0.8)          # Fijar un único valor
# )

xgb_grid <- expand.grid(
  nrounds = 600,          # Fijar un valor
  max_depth = c(4, 6),    # Reducir a 2 valores
  eta = c(0.1, 0.2),      # Reducir a 2 valores
  gamma = c(0),           # Mantener un único valor
  colsample_bytree = c(0.8),  # Mantener un único valor
  min_child_weight = c(1, 5), # Reducir a 2 valores
  subsample = c(0.8)          # Mantener un único valor
)


# Entrenar el modelo con validación cruzada
xgb_model <- train(
  x = train_matrix,
  y = train_labels,
  method = "xgbTree",
  trControl = trainControl(method = "cv", number = 5, search = "grid"),
  tuneGrid = xgb_grid
)

# Imprimir los resultados del modelo
print(xgb_model)

# Evaluación en el conjunto de entrenamiento
train_pred <- predict(xgb_model, train_matrix)
confusion <- confusionMatrix(train_pred, train_labels, positive = "1")
print(confusion)

# Predicciones en el conjunto de prueba
test_pred <- predict(xgb_model, test_matrix)

# Crear archivo de submission
submission <- data.frame(PassengerId = test$PassengerId, Survived = test_pred)
write.csv(submission, "xgb_grid_submission_Lunes_02.csv", row.names = FALSE)
