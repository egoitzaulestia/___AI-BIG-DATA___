# Limpiar el entorno de trabajo
rm(list=ls())

# Cargar librerías necesarias
library(xgboost)
library(caret)
library(dplyr)
library(rpart)

# 1. Importar los datos
train <- read.csv("train.csv", stringsAsFactors = FALSE)
test <- read.csv("test.csv", stringsAsFactors = FALSE)

# Añadir columna 'Survived' al conjunto de test para unificar los datos
test$Survived <- NA

# Combinar los conjuntos de datos para facilitar el preprocesamiento
full_data <- bind_rows(train, test)

# 2. Limpieza y preprocesamiento

## 2.1 Imputación de valores faltantes

### 2.1.1 Embarked
# Reemplazar valores faltantes en 'Embarked' con el modo
full_data$Embarked[full_data$Embarked == ""] <- "S"
full_data$Embarked <- factor(full_data$Embarked)

### 2.1.2 Fare
# Reemplazar valores faltantes en 'Fare' con la mediana
full_data$Fare[is.na(full_data$Fare)] <- median(full_data$Fare, na.rm = TRUE)

### 2.1.3 Age
# Imputar valores faltantes en 'Age' utilizando un modelo de regresión
age_model <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked,
                   data = full_data[!is.na(full_data$Age), ],
                   method = "anova")
full_data$Age[is.na(full_data$Age)] <- predict(age_model, full_data[is.na(full_data$Age), ])

# 2.2 Creación de variables adicionales

## 2.2.1 Rangos de edad
full_data$AgeGroup <- cut(full_data$Age,
                          breaks = c(0, 12, 18, 35, 60, Inf),
                          labels = c("Niño", "Adolescente", "Joven Adulto", "Adulto", "Mayor"))

## 2.2.2 Tamaño de la familia
full_data$FamilySize <- full_data$SibSp + full_data$Parch + 1

## 2.2.3 Variable 'IsAlone'
full_data$IsAlone <- ifelse(full_data$FamilySize == 1, 1, 0)

# 2.3 Transformación de variables categóricas a factores
full_data$Sex <- factor(full_data$Sex)
full_data$Pclass <- factor(full_data$Pclass)
full_data$SibSp <- factor(full_data$SibSp)
full_data$Parch <- factor(full_data$Parch)
full_data$IsAlone <- factor(full_data$IsAlone)
full_data$AgeGroup <- factor(full_data$AgeGroup)

# 2.4 Creación de variables dummy
dummy_vars <- dummyVars(~ Sex + Pclass + Parch + SibSp + Embarked + AgeGroup + IsAlone,
                        data = full_data)
full_dummy <- data.frame(predict(dummy_vars, newdata = full_data))

# Combinar variables dummy con las numéricas relevantes
full_model_data <- cbind(full_dummy, Fare = full_data$Fare, Survived = full_data$Survived)

# 3. Separar nuevamente en conjuntos de entrenamiento y prueba
train_data <- full_model_data[1:nrow(train), ]
test_data <- full_model_data[(nrow(train) + 1):nrow(full_model_data), ]

# 4. Preparar matrices para XGBoost
train_matrix <- xgb.DMatrix(data = as.matrix(train_data %>% select(-Survived)),
                            label = train_data$Survived)
test_matrix <- xgb.DMatrix(data = as.matrix(test_data %>% select(-Survived)))

# 5. Entrenamiento del modelo XGBoost

## 5.1 Definir parámetros
# params <- list(
#   booster = "gbtree",
#   objective = "binary:logistic",
#   eval_metric = "error",
#   eta = 0.1,
#   max_depth = 10,
#   min_child_weight = 1,
#   subsample = 0.8,
#   colsample_bytree = 0.8
# )

params_extended = list(booster = "gbtree",
                       silent = 0,
                       nthread = 1,
                       eta=  0.3,
                       gamma = 0,
                       max_depth = 9,
                       min_child_weight = 1,
                       max_delta_step = 0,
                       subsample = 1,
                       colsample_bytree = 1,
                       colsample_bylevel = 1,
                       reg_lambda = 1,
                       reg_alpha = 0,
                       tree_method = "auto",
                       sketch_eps = 0.03,
                       scale_pos_weight = 1,
                       updater = "grow_colmaker",
                       refresh_leaf = 1,
                       process_type = "default",
                       grow_policy = "depthwise",
                       max_leaves = 0,
                       max_bin = 256,
                       predictor = "cpu_predictor",
                       objective = "binary:logistic",
                       base_score = 0.5,
                       eval_metric = "error")


## 5.2 Realizar validación cruzada para determinar el número óptimo de rondas
cv_model <- xgb.cv(
  params = params,
  data = train_matrix,
  nrounds = 1000,
  nfold = 5,
  early_stopping_rounds = 10,
  verbose = 1
)

best_nrounds <- cv_model$best_iteration

## 5.3 Entrenar el modelo final
final_model <- xgb.train(
  params = params,
  data = train_matrix,
  nrounds = best_nrounds,
  verbose = 1
)

# 6. Evaluación del modelo en el conjunto de entrenamiento
train_pred <- predict(final_model, train_matrix)
train_pred_class <- ifelse(train_pred > 0.5, 1, 0)

confusionMatrix(factor(train_pred_class),
                factor(train_data$Survived),
                positive = "1")

# 7. Predicción en el conjunto de prueba
test_pred <- predict(final_model, test_matrix)
test_pred_class <- ifelse(test_pred > 0.5, 1, 0)

# 8. Crear archivo de submission
submission <- data.frame(PassengerId = test$PassengerId, Survived = test_pred_class)
write.csv(submission, "submission_EA03.csv", row.names = FALSE)


############################################



# Instalar librerías necesarias si no están instaladas
# if (!require(randomForest)) install.packages("randomForest")
library(randomForest)
library(caret)

# 1. Preparar los datos para el modelo
# Convertir Survived a factor (requerido para Random Forest)
train_data$Survived <- as.factor(train_data$Survived)

# Búsqueda de hiperparámetros para optimizar mtry
set.seed(123)
rf_tune <- train(
  Survived ~ ., 
  data = train_data,
  method = "rf",
  tuneGrid = expand.grid(mtry = c(2, 4, 6, 8)),  # Diferentes valores de mtry
  trControl = trainControl(method = "cv", number = 5),  # Validación cruzada
  ntree = 500
)

plot(rf_tune)

# Ver el mejor mtry encontrado
best_mtry <- rf_tune$bestTune$mtry
print(paste("Mejor valor de mtry:", best_mtry))



# 2. Entrenar el modelo Random Forest
set.seed(123)  # Fijar semilla para reproducibilidad
rf_model <- randomForest(
  Survived ~ .,  # Modelo usa todas las variables predictoras
  data = train_data,
  ntree = 500,  # Número de árboles en el bosque
  mtry = best_mtry,  # Número de predictores en cada división
  importance = TRUE  # Hacer seguimiento de la importancia de las variables
)

# 3. Evaluar el modelo en el conjunto de entrenamiento
train_pred <- predict(rf_model, train_data)
confusionMatrix(train_pred, train_data$Survived, positive = "1")

# 4. Predicción en el conjunto de prueba
test_pred <- predict(rf_model, test_data)

# 5. Crear archivo de submission
submission_rf <- data.frame(PassengerId = test$PassengerId, Survived = test_pred)
write.csv(submission_rf, "submission_RF_EA_01.csv", row.names = FALSE)




######################################

# Ajustar el árbol con validación cruzada
set.seed(123)
tree_model_cv <- train(
  Survived ~ ., 
  data = train_data,
  method = "rpart",
  trControl = trainControl(method = "cv", number = 5),
  tuneGrid = expand.grid(cp = seq(0.001, 0.05, by = 0.005))
)

# Ver los mejores hiperparámetros
best_cp <- tree_model_cv$bestTune$cp
print(best_cp)

# Árbol final con el mejor cp
final_tree <- rpart(
  Survived ~ ., 
  data = train_data, 
  method = "class", 
  control = rpart.control(cp = best_cp)
)
rpart.plot(final_tree, type = 3, extra = 102, fallen.leaves = TRUE)

# Predicciones en el conjunto de entrenamiento
train_pred <- predict(final_tree, train_data, type = "class")

# Matriz de confusión
confusionMatrix(train_pred, train_data$Survived, positive = "1")

# Predicciones en el conjunto de prueba
test_pred <- predict(final_tree, test_data, type = "class")

# Crear archivo de submission
submission_tree <- data.frame(PassengerId = test$PassengerId, Survived = test_pred)
write.csv(submission_tree, "submission_tree_EA_01.csv", row.names = FALSE)




######################################

# Limpiar el entorno de trabajo
rm(list = ls())

# Instalar librerías necesarias
# if (!require(rpart)) install.packages("rpart")
# if (!require(rpart.plot)) install.packages("rpart.plot")
# if (!require(caret)) install.packages("caret")
# if (!require(dplyr)) install.packages("dplyr")

library(rpart)
library(rpart.plot)
library(caret)
library(dplyr)

# 1. Importar los datos
train <- read.csv("train.csv", stringsAsFactors = FALSE)
test <- read.csv("test.csv", stringsAsFactors = FALSE)

# Añadir columna 'Survived' al conjunto de test para unificar los datos
test$Survived <- NA

# Combinar los conjuntos de datos para facilitar el preprocesamiento
full_data <- bind_rows(train, test)

# 2. Limpieza y preprocesamiento

## 2.1 Imputación de valores faltantes

### 2.1.1 Embarked
# Reemplazar valores faltantes en 'Embarked' con el modo
full_data$Embarked[full_data$Embarked == ""] <- "S"
full_data$Embarked <- factor(full_data$Embarked)

### 2.1.2 Fare
# Reemplazar valores faltantes en 'Fare' con la mediana
full_data$Fare[is.na(full_data$Fare)] <- median(full_data$Fare, na.rm = TRUE)

### 2.1.3 Age
# Imputar valores faltantes en 'Age' utilizando un modelo de regresión
age_model <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked,
                   data = full_data[!is.na(full_data$Age), ],
                   method = "anova")
full_data$Age[is.na(full_data$Age)] <- predict(age_model, full_data[is.na(full_data$Age), ])

# 2.2 Creación de variables adicionales

## 2.2.1 Rangos de edad
full_data$AgeGroup <- cut(full_data$Age,
                          breaks = c(0, 12, 18, 35, 60, Inf),
                          labels = c("Niño", "Adolescente", "Joven Adulto", "Adulto", "Mayor"))

## 2.2.2 Tamaño de la familia
full_data$FamilySize <- full_data$SibSp + full_data$Parch + 1

## 2.2.3 Variable 'IsAlone'
full_data$IsAlone <- ifelse(full_data$FamilySize == 1, 1, 0)

# 2.3 Transformación de variables categóricas
full_data$Sex <- factor(full_data$Sex)
full_data$Pclass <- factor(full_data$Pclass)
full_data$Embarked <- factor(full_data$Embarked)
full_data$IsAlone <- factor(full_data$IsAlone)
full_data$AgeGroup <- factor(full_data$AgeGroup)

# 2.4 Separar nuevamente en conjuntos de entrenamiento y prueba
train_data <- full_data[1:nrow(train), ]
test_data <- full_data[(nrow(train) + 1):nrow(full_data), ]

# 3. Entrenamiento del Árbol de Decisión con Validación Cruzada

## 3.1 Usar caret para optimizar el parámetro 'cp'
set.seed(123)
tree_model_cv <- train(
  Survived ~ Pclass + Sex + AgeGroup + Fare + FamilySize + IsAlone + Embarked,
  data = train_data,
  method = "rpart",
  trControl = trainControl(method = "cv", number = 5),  # Validación cruzada con 5 folds
  tuneGrid = expand.grid(cp = seq(0.001, 0.05, by = 0.005))  # Rango de valores de cp
)

# 3.2 Visualizar el mejor 'cp'
best_cp <- tree_model_cv$bestTune$cp
print(paste("Mejor valor de cp:", best_cp))

# 4. Entrenar el modelo final con el mejor 'cp'
final_tree <- rpart(
  Survived ~ Pclass + Sex + AgeGroup + Fare + FamilySize + IsAlone + Embarked,
  data = train_data,
  method = "class",
  control = rpart.control(cp = best_cp)
)

# 5. Visualizar el árbol de decisión
rpart.plot(final_tree, type = 3, extra = 102, fallen.leaves = TRUE)

# 6. Evaluar el modelo en el conjunto de entrenamiento
train_pred <- predict(final_tree, train_data, type = "class")
conf_matrix <- confusionMatrix(train_pred, as.factor(train_data$Survived), positive = "1")
print(conf_matrix)

# 7. Predicciones en el conjunto de prueba
test_pred <- predict(final_tree, test_data, type = "class")

# 8. Crear archivo de submission
submission_tree <- data.frame(PassengerId = test$PassengerId, Survived = test_pred)
write.csv(submission_tree, "submission_tree_optimized_EA_01.csv", row.names = FALSE)



###################################################


# Limpiar el entorno de trabajo
rm(list = ls())

# Instalar librerías necesarias
# if (!require(xgboost)) install.packages("xgboost")
# if (!require(caret)) install.packages("caret")
# if (!require(dplyr)) install.packages("dplyr")
# if (!require(tidyr)) install.packages("tidyr")
# if (!require(ggplot2)) install.packages("ggplot2")

library(xgboost)
library(caret)
library(dplyr)
library(tidyr)
library(ggplot2)

# Leer los datos
train <- read.csv("train.csv", stringsAsFactors = FALSE)
test <- read.csv("test.csv", stringsAsFactors = FALSE)

# Añadir columna 'Survived' al conjunto de test para unificar los datos
test$Survived <- NA

# Combinar los datos
full_data <- bind_rows(train, test)

# Embarked: Rellenar con el modo ("S") porque solo faltan 2 valores
full_data$Embarked[full_data$Embarked == ""] <- "S"
full_data$Embarked <- factor(full_data$Embarked)

# Fare: Rellenar valores faltantes con la mediana
full_data$Fare[is.na(full_data$Fare)] <- median(full_data$Fare, na.rm = TRUE)

# Age: Imputación basada en un modelo de regresión
age_model <- rpart(Age ~ Pclass + Sex + SibSp + Parch + Fare + Embarked,
                   data = full_data[!is.na(full_data$Age), ],
                   method = "anova")
full_data$Age[is.na(full_data$Age)] <- predict(age_model, full_data[is.na(full_data$Age), ])





# Crear una nueva variable 'FamilySize'
full_data$FamilySize <- full_data$SibSp + full_data$Parch + 1

# Crear una variable binaria 'IsAlone' (viaja solo o acompañado)
full_data$IsAlone <- ifelse(full_data$FamilySize == 1, 1, 0)

# Crear una nueva variable 'Title' basada en el nombre
full_data$Title <- sub(".*, (.*?)\\..*", "\\1", full_data$Name)
rare_titles <- c("Dr", "Rev", "Major", "Col", "Capt", "Don", "Sir", "Jonkheer", "Dona", "Lady", "the Countess")
full_data$Title[full_data$Title %in% rare_titles] <- "Rare"
full_data$Title <- factor(full_data$Title)

# Crear una nueva variable de rango de edad 'AgeGroup'
full_data$AgeGroup <- cut(full_data$Age,
                          breaks = c(0, 12, 18, 35, 60, Inf),
                          labels = c("Child", "Teenager", "YoungAdult", "Adult", "Senior"))

# Crear una nueva variable 'FareGroup' para categorizar Fare
full_data$FareGroup <- cut(full_data$Fare,
                           breaks = quantile(full_data$Fare, probs = seq(0, 1, 0.25), na.rm = TRUE),
                           labels = c("Low", "Medium", "High", "VeryHigh"),
                           include.lowest = TRUE)




# Convertir variables categóricas en factores
full_data$Pclass <- factor(full_data$Pclass)
full_data$Sex <- factor(full_data$Sex)
full_data$Embarked <- factor(full_data$Embarked)
full_data$IsAlone <- factor(full_data$IsAlone)
full_data$AgeGroup <- factor(full_data$AgeGroup)
full_data$FareGroup <- factor(full_data$FareGroup)




dummy_vars <- dummyVars(~ Pclass + Sex + Embarked + Title + AgeGroup + FareGroup + IsAlone, data = full_data)
full_dummy <- data.frame(predict(dummy_vars, newdata = full_data))

# Combinar variables dummy con datos numéricos relevantes
full_model_data <- cbind(full_dummy, FamilySize = full_data$FamilySize, Fare = full_data$Fare, Survived = full_data$Survived)




train_data <- full_model_data[1:nrow(train), ]
test_data <- full_model_data[(nrow(train) + 1):nrow(full_model_data), ]

# Crear las matrices para XGBoost
train_matrix <- xgb.DMatrix(data = as.matrix(train_data %>% select(-Survived)),
                            label = train_data$Survived)
test_matrix <- xgb.DMatrix(data = as.matrix(test_data %>% select(-Survived)))




params <- list(
  booster = "gbtree",
  objective = "binary:logistic",
  eval_metric = "logloss",  # Métrica de evaluación
  eta = 0.1,                # Tasa de aprendizaje
  max_depth = 6,            # Profundidad máxima del árbol
  min_child_weight = 1,     # Peso mínimo en los nodos hijos
  subsample = 0.8,          # Submuestreo de filas
  colsample_bytree = 0.8    # Submuestreo de columnas
)




set.seed(123)
cv_model <- xgb.cv(
  params = params,
  data = train_matrix,
  nrounds = 1000,
  nfold = 5,
  early_stopping_rounds = 10,
  verbose = 1
)

best_nrounds <- cv_model$best_iteration





final_model <- xgb.train(
  params = params,
  data = train_matrix,
  nrounds = best_nrounds,
  verbose = 1
)




# Predicciones en el conjunto de prueba
test_pred <- predict(final_model, test_matrix)
test_pred_class <- ifelse(test_pred > 0.5, 1, 0)

# Crear archivo de submission
submission <- data.frame(PassengerId = test$PassengerId, Survived = test_pred_class)
write.csv(submission, "XGB_EA_01.csv", row.names = FALSE)

