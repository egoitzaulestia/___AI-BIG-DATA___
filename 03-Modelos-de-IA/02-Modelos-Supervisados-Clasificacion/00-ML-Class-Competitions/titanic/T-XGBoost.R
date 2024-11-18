rm(list=ls())

#################################################
################# T I T A N I C #################
#################################################
################# X G B o o s t #################
#################################################


# 1. Importar los datos

train <- read.csv("train.csv")
test <- read.csv("test.csv")


#######################################
### 3. Limpieza y preprocesamiento ####
#######################################


######### E M B A R K E D #########

train$Embarked <- as.factor(train$Embarked)
levels(train$Embarked) # ""  "C" "Q" "S"

# Identificar los índices donde Embarked es ""
indices <- which(train$Embarked == "")

# Mostrar las filas correspondientes
train[indices, ]

# Identificar los índices donde Fare es 80 (80.0000)
indices <- which(train$Fare == 80.0000)

# Mostrar las filas correspondientes
train[indices, ] 

# Reemplazar "" con "S" en Embarked
train$Embarked[train$Embarked == ""] <- "S"

# Eliminar el nivel vacío "" de la columna Embarked
train$Embarked <- droplevels(train$Embarked)
levels(train$Embarked) # "C" "Q" "S"


######### C A B I N #########
levels(train$Cabin)
train$Cabin = as.factor(train$Cabin)
levels(train$Cabin)
length(train$Cabin[levels(train$Cabin) == "C23 C25 C27"])
train$Deck <- substr(train$Cabin, 1, 1)


######### P C L A S S #########

# Transformación de variable a factor
train$Pclass = as.factor(train$Pclass)

######### S E X #########

# Transformación de variable a factor
train$Sex = as.factor(train$Sex)

######### A G E #########

# 3. Imputación con un modelo predictivo (Random Forest)
# Modelo Random Forest para predecir las edades faltantes en función de las demás variables.
# a. Preparar los datos
#    Un subset con las filas donde Age no es NA para entrenar el modelo, 
#    y otro con las filas donde Age es NA para predecir.
train_with_age <- train[!is.na(train$Age), ]
train_missing_age <- train[is.na(train$Age), ]


# 5. Selección de características
# Identifica las variables más importantes para el modelo.
# Considera eliminar variables irrelevantes como Ticket o Cabin.
train_selected <- train[, c("Survived", "Pclass", "Sex", "Age", "Fare", "Embarked", "SibSP", "Parch")]


######### Modelo XGBoost ##########

# 1. Preparar los datos

# XGBoost requiere que las variables sean numéricas. 

# Convertir variables categóricas a factores y luego a numéricas
# train_data$Sex = as.numeric(as.factor(train_data$Sex))  # Sexo
train_data$Sex = as.numeric(train_data$Sex)  # Sexo
# train_data$Embarked = as.numeric(as.factor(train_data$Embarked))  # Embarked
train_data$Embarked = as.numeric(train_data$Embarked)  # Embarked
train_data$Pclass = as.numeric(train_data$Pclass)


valid_data$Sex <- as.numeric(as.factor(valid_data$Sex))
valid_data$Embarked <- as.numeric(as.factor(valid_data$Embarked))
valid_data$Pclass = as.numeric(as.factor(valid_data$Pclass))


# 2. Cargar XGBoost
library(xgboost)

# 3. Convertir los datos a formato DMatrix
# XGBoost funciona con su propio formato de datos llamado DMatrix

# Crear matrices para entrenamiento y validación
train_matrix <- xgb.DMatrix(data = as.matrix(train_data[, -1]), label = train_data$Survived)
valid_matrix <- xgb.DMatrix(data = as.matrix(valid_data[, -1]), label = valid_data$Survived)

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

# Entrenar el modelo
xgb_model <- xgb.train(
  params = params_extended,
  data = train_matrix,
  nrounds = 1000,                 # Número de iteraciones
  watchlist = list(train = train_matrix, eval = valid_matrix),
  early_stopping_rounds = 13,    # Parar si no mejora
  verbose = 1                    # Mostrar progreso
)

# Predecir probabilidades
predictions <- predict(xgb_model, as.matrix(valid_data[, -1]))

# Convertir probabilidades a clases (umbral 0.5)
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Convertir a factores
valid_data$Survived <- factor(valid_data$Survived, levels = c(0, 1))
predicted_classes <- factor(predicted_classes, levels = c(0, 1))

# Calcular la matriz de confusión
library(caret)
confusionMatrix(predicted_classes, valid_data$Survived)






# Relación entre Parch y Survived
table(train_clean$Parch, train_clean$Survived)

# Relación entre SibSp y Survived
table(train_clean$SibSp, train_clean$Survived)

# Visualización para Parch
library(ggplot2)
ggplot(train_clean, aes(x = factor(Parch), fill = factor(Survived))) +
  geom_bar(position = "fill") +
  labs(title = "Relación entre Parch y Supervivencia", x = "Parch", y = "Proporción", fill = "Supervivencia")

# Visualización para SibSp
ggplot(train_clean, aes(x = factor(SibSp), fill = factor(Survived))) +
  geom_bar(position = "fill") +
  labs(title = "Relación entre SibSp y Supervivencia", x = "SibSp", y = "Proporción", fill = "Supervivencia")











################################################


Por favor, ayúdame a limpiar y a ordenar el siguiente código.
Necesito:
  - Crear dummies en las variables Sex, Age, Pclass, Parch, SibSp
- Crear los rango de edad de Age


rm(list=ls())

#################################################
################# T I T A N I C #################
#################################################
################# X G B o o s t #################
#################################################


# 1. Importar los datos

train <- read.csv("train.csv")
test <- read.csv("test.csv")


#######################################
### 3. Limpieza y preprocesamiento ####
#######################################


######### E M B A R K E D #########

train$Embarked <- as.factor(train$Embarked)
levels(train$Embarked) # ""  "C" "Q" "S"

# Identificar los índices donde Embarked es ""
indices <- which(train$Embarked == "")

# Mostrar las filas correspondientes
train[indices, ]

# Identificar los índices donde Fare es 80 (80.0000)
indices <- which(train$Fare == 80.0000)

# Mostrar las filas correspondientes
train[indices, ] 

# Reemplazar "" con "S" en Embarked
train$Embarked[train$Embarked == ""] <- "S"

# Eliminar el nivel vacío "" de la columna Embarked
train$Embarked <- droplevels(train$Embarked)
levels(train$Embarked) # "C" "Q" "S"


######### C A B I N #########
levels(train$Cabin)
train$Cabin = as.factor(train$Cabin)
levels(train$Cabin)
length(train$Cabin[levels(train$Cabin) == "C23 C25 C27"])
train$Deck <- substr(train$Cabin, 1, 1)


######### P C L A S S #########

# Transformación de variable a factor
train$Pclass = as.factor(train$Pclass)

######### S E X #########

# Transformación de variable a factor
train$Sex = as.factor(train$Sex)

######### A G E #########

# 3. Imputación con un modelo predictivo (Random Forest)
# Modelo Random Forest para predecir las edades faltantes en función de las demás variables.
# a. Preparar los datos
#    Un subset con las filas donde Age no es NA para entrenar el modelo, 
#    y otro con las filas donde Age es NA para predecir.
train_with_age <- train[!is.na(train$Age), ]
train_missing_age <- train[is.na(train$Age), ]


# 5. Selección de características
# Identifica las variables más importantes para el modelo.
# Considera eliminar variables irrelevantes como Ticket o Cabin.
train_selected <- train[, c("Survived", "Pclass", "Sex", "Age", "Fare", "Embarked", "SibSP", "Parch")]


######### Modelo XGBoost ##########

# 1. Preparar los datos

# XGBoost requiere que las variables sean numéricas. 

# Convertir variables categóricas a factores y luego a numéricas
# train_data$Sex = as.numeric(as.factor(train_data$Sex))  # Sexo
train_data$Sex = as.numeric(train_data$Sex)  # Sexo
# train_data$Embarked = as.numeric(as.factor(train_data$Embarked))  # Embarked
train_data$Embarked = as.numeric(train_data$Embarked)  # Embarked
train_data$Pclass = as.numeric(train_data$Pclass)


valid_data$Sex <- as.numeric(as.factor(valid_data$Sex))
valid_data$Embarked <- as.numeric(as.factor(valid_data$Embarked))
valid_data$Pclass = as.numeric(as.factor(valid_data$Pclass))


# 2. Cargar XGBoost
library(xgboost)

# 3. Convertir los datos a formato DMatrix
# XGBoost funciona con su propio formato de datos llamado DMatrix

# Crear matrices para entrenamiento y validación
train_matrix <- xgb.DMatrix(data = as.matrix(train_data[, -1]), label = train_data$Survived)
valid_matrix <- xgb.DMatrix(data = as.matrix(valid_data[, -1]), label = valid_data$Survived)

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

# Entrenar el modelo
xgb_model <- xgb.train(
  params = params_extended,
  data = train_matrix,
  nrounds = 1000,                 # Número de iteraciones
  watchlist = list(train = train_matrix, eval = valid_matrix),
  early_stopping_rounds = 13,    # Parar si no mejora
  verbose = 1                    # Mostrar progreso
)

# Predecir probabilidades
predictions <- predict(xgb_model, as.matrix(valid_data[, -1]))

# Convertir probabilidades a clases (umbral 0.5)
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Convertir a factores
valid_data$Survived <- factor(valid_data$Survived, levels = c(0, 1))
predicted_classes <- factor(predicted_classes, levels = c(0, 1))

# Calcular la matriz de confusión
library(caret)
confusionMatrix(predicted_classes, valid_data$Survived)
