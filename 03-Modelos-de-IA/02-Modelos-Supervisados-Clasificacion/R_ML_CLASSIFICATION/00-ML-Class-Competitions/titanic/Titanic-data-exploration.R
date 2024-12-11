rm(list=ls())


# 1. Importar los datos

train <- read.csv("train.csv")
test <- read.csv("test.csv")


# 2. Exploración inicial

#### a. Estructura y dimensiones del dataset

str(train)
dim(train)
summary(train)

#### b. Comprobar valores faltantes

colSums(is.na(train)) # 177 NAs (valores perdidios) en Age


############################################
#### c. Visualización inicial de datos #####
############################################

######### S U R V I V E D #########

# Nivel de supervivencia

# Número de supervivientes y muertos
counts <- table(train$Survived)
num_survived <- counts[2]   # Supervivientes
num_dead <- counts[1]       # Muertos

# Porcentaje de supervivientes
percentage_survived <- (num_survived / sum(counts)) * 100

# Resultados
cat("Número de supervivientes:", num_survived, 
    "\nNúmero de muertos:", num_dead, 
    "\nPorcentaje de supervivientes:", round(percentage_survived, 2), 
    "%\n")


# Grafico de barras

# Instalar plotly si no está instalado
# if (!require(plotly)) install.packages("plotly")
library(plotly)

# Crear un dataframe con los datos
bar_data <- data.frame(
  Status = c("Muertos", "Supervivientes"),
  Count = as.numeric(counts)
)

# Calcular los porcentajes
bar_data$Percentage <- round((bar_data$Count / sum(bar_data$Count)) * 100, 2)

# Crear el gráfico de barras interactivo
fig <- plot_ly(
  bar_data,
  x = ~Status,                 # Eje X: las categorías
  y = ~Count,                  # Eje Y: los valores numéricos
  type = 'bar',                # Tipo de gráfico: barras
  text = ~paste("Conteo:", Count, "<br>",
                "Porcentaje:", Percentage, "%"), # Texto interactivo
  hoverinfo = 'text',          # Mostrar solo el texto al pasar el ratón
  marker = list(color = c('red', 'blue')) # Colores personalizados
)

# Añadir título y etiquetas
fig <- fig %>%
  layout(
    title = "Distribución de Supervivencia",
    xaxis = list(title = "Estado"),
    yaxis = list(title = "Cantidad"),
    showlegend = FALSE          # Oculta la leyenda (opcional para barras)
  )

# Mostrar el gráfico
fig

# Crear etiquetas con porcentajes
labels <- paste(c("Muertos", "Supervivientes"), round(counts / sum(counts) * 100, 2), "%")

# Graficar el pie chart
pie(
  counts,
  labels = labels,
  main = "Distribución de Supervivencia",
  col = c("red", "blue")
)

# Crear un dataframe con los datos
pie_data <- data.frame(
  Status = c("Muertos", "Supervivientes"),
  Count = as.numeric(counts)
)

# Crear un dataframe con los datos
pie_data <- data.frame(
  Status = c("Muertos", "Supervivientes"),
  Count = as.numeric(counts)
)

# Calcular los porcentajes
pie_data$Percentage <- round((pie_data$Count / sum(pie_data$Count)) * 100, 2)

# Crear el gráfico de pie interactivo
fig <- plot_ly(
  pie_data,
  labels = ~Status,             # Etiquetas
  values = ~Count,              # Valores (número de muertos y supervivientes)
  type = 'pie',                 # Tipo de gráfico: pie
  textinfo = 'label+percent+value',  # Mostrar etiquetas, porcentajes y valores
  hoverinfo = 'text',           # Mostrar texto interactivo
  text = ~paste(Status, "<br>", 
                "Conteo:", Count, "<br>", 
                "Porcentaje:", Percentage, "%"), # Texto al pasar el mouse
  marker = list(colors = c('red', 'blue')) # Colores personalizados
)

# Añadir título
fig <- fig %>%
  layout(
    title = "Distribución de Supervivencia",
    showlegend = TRUE
  )

# Mostrar el gráfico
fig


# Calcular el número de supervivientes por género
survival_gender <- train %>%
  group_by(Sex) %>%
  summarise(
    Total = n(),                                  # Total de cada género
    Survived = sum(Survived),                     # Supervivientes por género
    SurvivalRate = round((Survived / Total) * 100, 2) # Porcentaje de supervivencia
  )

# Mostrar los resultados
print(survival_gender)

# Para visualizar los resultados
cat("Número de supervivientes de mujeres:", survival_gender$Survived[survival_gender$Sex == "female"], "\n")
cat("Número de supervivientes de hombres:", survival_gender$Survived[survival_gender$Sex == "male"], "\n")
cat("Porcentaje de supervivencia de mujeres:", survival_gender$SurvivalRate[survival_gender$Sex == "female"], "%\n")
cat("Porcentaje de supervivencia de hombres:", survival_gender$SurvivalRate[survival_gender$Sex == "male"], "%\n")

# Gráfico de barras apiladas interactivo que muestra la distribución 
# de hombres y mujeres supervivientes por cada clase (Pclass)

library(plotly)
library(dplyr)

# Filtrar y calcular la distribución correctamente
stacked_data <- train %>%
  filter(Survived == 1) %>%   # Filtrar solo los supervivientes
  group_by(Pclass, Sex) %>%
  summarise(Count = n()) %>%
  ungroup()

# Crear el gráfico de barras apiladas interactivo
fig <- plot_ly(
  stacked_data,
  x = ~Pclass,                  # Clase de pasajero en el eje X
  y = ~Count,                   # Cantidad en el eje Y
  color = ~Sex,                 # Colores por género
  type = "bar",                 # Tipo de gráfico: barra
  text = ~paste(
    "Clase:", Pclass, "<br>",
    "Sexo:", Sex, "<br>",
    "Cantidad de Supervivientes:", Count
  ),                            # Texto al pasar el ratón
  hoverinfo = "text"            # Mostrar solo el texto al interactuar
)

# Añadir personalización y apilado
fig <- fig %>%
  layout(
    title = "Supervivientes por Clase y Género",
    barmode = "stack",          # Barras apiladas
    xaxis = list(title = "Clase"),
    yaxis = list(title = "Cantidad"),
    legend = list(title = list(text = "Género"))
  )

# Mostrar el gráfico
fig


# Instalar ggplot2 si no está instalado
# if (!require(ggplot2)) install.packages("ggplot2")
library(ggplot2)
library(dplyr)

# Filtrar solo los supervivientes
survivors_by_class <- train %>%
  filter(Survived == 1) %>%
  group_by(Pclass) %>%
  summarise(Count = n())

# Crear el gráfico de barras
ggplot(survivors_by_class, aes(x = factor(Pclass), y = Count, fill = factor(Pclass))) +
  geom_bar(stat = "identity") +
  labs(
    title = "Supervivientes por Clase",
    x = "Clase",
    y = "Cantidad de Supervivientes",
    fill = "Clase"
  ) +
  theme_minimal()



library(ggplot2)

# Crear scatterplot
ggplot(train_clean, aes(x = Age, y = Survived)) +
  geom_point(position = position_jitter(width = 0, height = 0.05), alpha = 0.5) +
  labs(
    title = "Scatterplot de Edad y Supervivencia",
    x = "Edad",
    y = "Supervivencia (0 = No, 1 = Sí)"
  ) +
  theme_minimal()




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


# Graficar el valor promedio de Fare por categoría de Embarked
# Cargar ggplot2
library(ggplot2)

# Calcular el promedio de Fare por Embarked y graficar
ggplot(train, aes(x = Embarked, y = Fare)) +
  stat_summary(fun = mean, geom = "bar", fill = "steelblue", color = "black") +
  labs(title = "Promedio de Fare por Embarked",
       x = "Embarked",
       y = "Fare promedio") +
  theme_minimal()


# Tabla de contingencia entre Pclass y Embarked
table_class_embarked <- table(train$Pclass, train$Embarked)
print(table_class_embarked)

library(ggplot2)

# Crear el gráfico de barras apiladas
ggplot(train, aes(x = factor(Pclass), fill = Embarked)) +
  geom_bar(position = "fill") +  # "fill" normaliza las proporciones
  labs(
    title = "Distribución de Clase por Puerta de Embarque",
    x = "Clase",
    y = "Proporción",
    fill = "Puerto de Embarque"
  ) +
  theme_minimal()

# Prueba Chi-cuadrado
chi_test <- chisq.test(table_class_embarked)
print(chi_test)
# Proporciones por fila
prop_table <- prop.table(table_class_embarked, margin = 1)
print(prop_table)


###
##### Cuántos hombres y mujeres había en cada puerta de embarque (Embarked)
###

# Tabla de contingencia entre Sex y Embarked
table_sex_embarked <- table(train$Sex, train$Embarked)
print(table_sex_embarked)

library(ggplot2)

# Crear el gráfico de barras apiladas
ggplot(train, aes(x = Embarked, fill = Sex)) +
  geom_bar(position = "stack") +  # Cambia "stack" por "fill" para proporciones
  labs(
    title = "Distribución de Hombres y Mujeres por Puerto de Embarque",
    x = "Puerto de Embarque",
    y = "Cantidad",
    fill = "Sexo"
  ) +
  theme_minimal()

# Proporciones por columna (puerto de embarque)
prop_table_sex_embarked <- prop.table(table_sex_embarked, margin = 2)
print(prop_table_sex_embarked)




# 1. Porcentaje de supervivencia respecto al puerto de embarque:
library(dplyr)
library(ggplot2)

# Calcular el porcentaje de supervivencia por puerto de embarque
survival_by_embark = train %>%
  group_by(Embarked) %>%
  summarise(SurvivalRate = mean(Survived) * 100)

# Visualizar el porcentaje de supervivencia por puerto de embarque
ggplot(survival_by_embark, aes(x = Embarked, y = SurvivalRate)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  labs(title = "Porcentaje de Supervivencia por Puerto de Embarque",
       x = "Puerto de Embarque",
       y = "Porcentaje de Supervivencia") +
  theme_minimal()






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

# # 1. Imputación basada en la mediana o la media
# # Opción más simple, pero menos precisa.
# train$Age[is.na(train$Age)] <- median(train$Age, na.rm = TRUE)  # Usar la mediana

# # 2. Imputación según grupos (Pclass, Sex, etc.)
# # Calcular la mediana o la media de Age para cada grupo (clase de pasajero y sexo) 
# # y luego imputar en función del grupo al que pertenece cada pasajero.
# library(dplyr)
# train <- train %>%
#   group_by(Pclass, Sex) %>%
#   mutate(Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age))

# 3. Imputación con un modelo predictivo (Random Forest)
# Modelo Random Forest para predecir las edades faltantes en función de las demás variables.
# a. Preparar los datos
#    Un subset con las filas donde Age no es NA para entrenar el modelo, 
#    y otro con las filas donde Age es NA para predecir.
train_with_age <- train[!is.na(train$Age), ]
train_missing_age <- train[is.na(train$Age), ]

# b. Evaluar el modelo antes de imputar valores
library(randomForest)
set.seed(123)  # Fijar semilla para reproducibilidad

# Dividir train_with_age en conjunto de entrenamiento y prueba
sample_index <- sample(seq_len(nrow(train_with_age)), size = 0.7 * nrow(train_with_age))
train_data <- train_with_age[sample_index, ]
test_data <- train_with_age[-sample_index, ]

# Entrenar el modelo en el conjunto de entrenamiento
rf_model <- randomForest(Age ~ Pclass + Sex + SibSp + Parch + Fare, data = train_data, na.action = na.omit)

# Predecir en el conjunto de prueba
predicted_ages <- predict(rf_model, test_data)

# Calcular el error medio absoluto (MAE) y el error cuadrático medio (RMSE)
mae <- mean(abs(predicted_ages - test_data$Age))  # Error medio absoluto
rmse <- sqrt(mean((predicted_ages - test_data$Age)^2))  # Error cuadrático medio

# Imprimir los resultados
cat("Desviación del modelo:")
cat("Error Medio Absoluto (MAE):", mae, "años de erro promedio\n")
cat("Error Cuadrático Medio (RMSE):", rmse, "años de error promedio\n")

# c. Imputación de los valores faltantes
# Entrenar el modelo con todos los datos que tienen Age
rf_model_full <- randomForest(Age ~ Pclass + Sex + SibSp + Parch + Fare, data = train_with_age, na.action = na.omit)

# Predecir las edades faltantes en el conjunto con Age == NA
train_missing_age$Age <- predict(rf_model_full, train_missing_age)

# d. Combinar los datasets
# Reemplaza los valores imputados en el dataset original
train[is.na(train$Age), "Age"] <- train_missing_age$Age


summary(train)


# 5. Selección de características
# Identifica las variables más importantes para el modelo.
# Considera eliminar variables irrelevantes como Ticket o Cabin.
train_selected <- train[, c("Survived", "Pclass", "Sex", "Age", "Fare", "Embarked", "SibSp", "Parch")]

# 6. División de datos
# Divide los datos en un conjunto de entrenamiento y validación.
library(caret)
set.seed(123)
trainIndex <- createDataPartition(train_selected$Survived, p = 0.8, list = FALSE)
train_data <- train_selected[trainIndex, ]
valid_data <- train_selected[-trainIndex, ]


# 7. Construcción del modelo

# a. Modelo inicial: Árbol de decisión
library(rpart)
tree_model <- rpart(Survived ~ ., data = train_data, method = "class")

# b. Visualización del árbol
library(rpart.plot)
rpart.plot(tree_model)


# 8. Evaluación del modelo

# Convertir Survived a factor en el dataset de validación
valid_data$Survived <- factor(valid_data$Survived, levels = c(0, 1))

# Predecir con el modelo
predictions <- predict(tree_model, valid_data, type = "class")

# Asegurar que predictions sea un factor con los mismos niveles
predictions <- factor(predictions, levels = c(0, 1))

# Calcular la matriz de confusión
confusionMatrix(predictions, valid_data$Survived)



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

# # Parámetros del modelo
# params <- list(
#   objective = "binary:logistic",  # Clasificación binaria
#   eval_metric = "error",         # Métrica de evaluación (tasa de error)
#   eta = 0.1,                     # Tasa de aprendizaje
#   max_depth = 6                  # Profundidad máxima del árbol
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



######### Modelo de Red Neuronal ##########

# 1. Preparar los datos

# Convertir variables categóricas a numéricas
train_data$Sex <- as.numeric(as.factor(train_data$Sex))
train_data$Embarked <- as.numeric(as.factor(train_data$Embarked))

valid_data$Sex <- as.numeric(as.factor(valid_data$Sex))
valid_data$Embarked <- as.numeric(as.factor(valid_data$Embarked))

# Seleccionar y escalar variables numéricas
new_columns <- c("Age", "Pclass", "Sex", "Survived")
train_data <- train_data[new_columns]
valid_data <- valid_data[new_columns]

scale_columns <- c("Age", "Pclass", "Sex")
train_data[scale_columns] <- scale(train_data[scale_columns])
valid_data[scale_columns] <- scale(valid_data[scale_columns])

# 2. Cargar la librería para la red neuronal
library(nnet)

# 3. Entrenar la red neuronal
set.seed(123)
nn_model <- nnet(Survived ~ ., 
                 data = train_data, 
                 size = 10,     # Número de neuronas en la capa oculta
                 maxit = 200,   
                 linout = FALSE,
                 decay = 0.01)

# 4. Evaluar el modelo

# Predecir en datos de validación
predictions <- predict(nn_model, valid_data, type = "raw")

# Convertir probabilidades a clases binarias con un umbral de 0.5
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Convertir a factores para la evaluación
predicted_classes <- factor(predicted_classes, levels = c(0, 1))
valid_data$Survived <- factor(valid_data$Survived, levels = c(0, 1))

# Calcular la matriz de confusión
library(caret)
confusionMatrix(predicted_classes, valid_data$Survived)

# 5. Visualizar la red neuronal (opcional)
# Si deseas visualizar la red neuronal, puedes usar NeuralNetTools
# install.packages("NeuralNetTools")
library(NeuralNetTools)
plotnet(nn_model)




#####################################

# Seleccionar y escalar variables numéricas
new_columns <- c("Age", "Pclass", "Sex", "Survived")
train_data <- train_data[new_columns]
valid_data <- valid_data[new_columns]

scale_columns <- c("Age")
train_data[scale_columns] <- scale(train_data[scale_columns])
valid_data[scale_columns] <- scale(valid_data[scale_columns])


# Preparación de datos
train_data$Sex <- as.factor(train_data$Sex)
train_data$Pclass <- as.factor(train_data$Pclass)

valid_data$Sex <- as.factor(valid_data$Sex)
valid_data$Pclass <- as.factor(valid_data$Pclass)

c("Survived", "Pclass", "Sex", "Age", "Fare", "Embarked")

# Entrenar el modelo de regresión logística
logistic_model <- glm(Survived ~ ., data = train_data, family = binomial)

# Resumen del modelo
summary(logistic_model)

# Predecir en el conjunto de validación
predictions <- predict(logistic_model, valid_data, type = "response")
predicted_classes <- ifelse(predictions > 0.5, 1, 0)

# Convertir a factores para la evaluación
valid_data$Survived <- factor(valid_data$Survived, levels = c(0, 1))
predicted_classes <- factor(predicted_classes, levels = c(0, 1))

# Evaluar el modelo
library(caret)
confusionMatrix(predicted_classes, valid_data$Survived)


#####################################

