rm(list=ls())
packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

packages <- c("e1071","caret","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

packages <- c("tibble","e1071","rpart","rpart.plot","class","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

install.packages("SDMTools")
library(SDMTools)
#######################################
#                                     #
#           BOSTON HOUSING            #
#                                     #
#######################################

# Valores de Viviendas en los Suburbios de Boston

# La variable medv es la variable objetivo.

# Descripción de los datos
# El marco de datos Boston tiene 506 filas y 14 columnas.

# Este marco de datos contiene las siguientes columnas:

# crim
# Per capita crime rate by town.
# (Tasa de criminalidad per cápita por ciudad.)

# zn
# Proportion of residential land zoned for lots over 25,000 sq.ft.
# (Proporción de terrenos residenciales designados para lotes de más de 25,000 pies cuadrados.)

# indus
# Proportion of non-retail business acres per town.
# (Proporción de acres dedicados a negocios no comerciales por ciudad.)

# chas
# Charles River dummy variable (= 1 if tract bounds river; 0 otherwise).
# (Variable dummy del río Charles (= 1 si el tramo limita con el río; 0 en caso contrario).)

# nox
# Nitrogen oxides concentration (parts per 10 million).
# (Concentración de óxidos de nitrógeno (partes por 10 millones).)

# rm
# Average number of rooms per dwelling.
# (Número promedio de habitaciones por vivienda.)

# age
# Proportion of owner-occupied units built prior to 1940.
# (Proporción de unidades ocupadas por propietarios construidas antes de 1940.)

# dis
# Weighted mean of distances to five Boston employment centres.
# (Promedio ponderado de distancias a cinco centros de empleo en Boston.)

# rad
# Index of accessibility to radial highways.
# (Índice de accesibilidad a carreteras radiales.)

# tax
# Full-value property-tax rate per $10,000.
# (Tasa de impuesto a la propiedad sobre el valor total por cada $10,000.)

# ptratio
# Pupil-teacher ratio by town.
# (Relación alumno-maestro por ciudad.)

# black
# 1000(Bk - 0.63)^2 where Bk is the proportion of blacks by town.
# (1000(Bk - 0.63)^2 donde Bk es la proporción de personas negras por ciudad.)

# lstat
# Lower status of the population (percent).
# (Porcentaje de población con estatus socioeconómico bajo.)

# medv
# Median value of owner-occupied homes in $1000s.
# (Valor medio de las viviendas ocupadas por propietarios, en miles de dólares.)
  


# Limpiar el entorno de trabajo
rm(list=ls())

# Cargamos los datos
library (MASS)

data("Boston")
datos = Boston


###############################################################
#                                                             #
#     EXPLORACIÓN GENERAL de los datos del conjunto Boston    #
#                                                             #
###############################################################

# Paso 1: Resumen general del conjunto de datos

# Dimensiones del conjunto de datos
# El marco de datos Boston tiene 506 filas y 14 columnas.
cat("Número de filas:", nrow(datos), "filas\n")
cat("Número de columnas:", ncol(datos), "columnas\n")

# Vista general de las primeras filas
head(datos)

# Resumen estadístico básico
summary(datos)

# Tipos de variables
str(datos)


# Paso 2: Análisis de valores faltantes
# Comprobamos si hay valores faltantes
cat("¿Hay valores faltantes en el conjunto de datos?\n")
sapply(datos, function(x) sum(is.na(x)))

# Porcentaje de valores faltantes (si existen)
sapply(datos, function(x) mean(is.na(x))) * 100


# Paso 3: Estadísticas descriptivas para todas las variables
# Estadísticas generales (media, desviación estándar, etc.)
library(dplyr)

datos %>%
  summarise(across(everything(), list(
    Media = mean,
    Mediana = median,
    Min = min,
    Max = max,
    SD = sd
  )))


# Paso 4: Matriz de correlación para variables numéricas

# Matriz de correlación
cor_matrix <- cor(datos)
round(cor_matrix, 2)

# Visualización de la matriz de correlación
library(corrplot)
corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.7)



##################################################################
#                                                                #
#     Exploración PARTICULAR de los datos del conjunto Boston    #
#                                                                #
##################################################################

# Paso 5: 
# Análisis de cada variable

# Distribución de cada variable
library(ggplot2)

# Histogramas de las variables
library(reshape2)
datos_melt <- melt(datos)
ggplot(datos_melt, aes(x = value)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(title = "Histogramas de las variables", x = "Valores", y = "Frecuencia")


# Paso 6: 
# Relación entre la variable dependiente (medv) y otras variables

# Boxplot de la variable `medv` respecto a las categorías de `chas`
ggplot(datos, aes(x = factor(chas), y = medv)) +
  geom_boxplot(fill = "orange") +
  labs(title = "Distribución de MEDV según CHAS", x = "CHAS (cerca del río)", y = "MEDV")

# Relación entre `medv` y variables numéricas
ggplot(datos, aes(x = lstat, y = medv)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relación entre LSTAT y MEDV", x = "LSTAT", y = "MEDV")


# Paso 7: 
# Detección de outliers

# Identificación de outliers con boxplots
boxplot.stats(datos$medv)$out
boxplot(datos$medv, main = "Boxplot de MEDV", col = "lightblue")


# Paso 8: 
# Variables categóricas

# Análisis de frecuencia para `chas`
table(datos$chas)

# Visualización de la distribución de `chas`
ggplot(datos, aes(x = factor(chas))) +
  geom_bar(fill = "green", color = "black") +
  labs(title = "Frecuencia de CHAS", x = "CHAS", y = "Frecuencia")



###########################################
#                                         #
#             REGRESIÓN LINEA             #
#                                         #
###########################################

############################################################
# Paso 1: Análisis exploratorio previo a la regresión lineal
############################################################

# Resumen básico de los datos
summary(datos)

# Matriz de correlación para identificar relaciones
library(corrplot)
cor_matrix <- cor(datos)
corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.7)


# Comprobación de valores faltantes
cat("¿Hay valores faltantes en los datos?\n")
sapply(datos, function(x) sum(is.na(x)))


#####################################################
# Paso 2: Transformación de datos
#####################################################

# Codificar las variables categóricas
datos$chas = as.factor(datos$chas)


#####################################################
# Paso 3: Dividir los datos en entrenamiento y prueba (test)
#####################################################

# Dividir los datos en conjunto de entrenamiento y conjunto de test
# install.packages("caTools")
library(caTools)
set.seed(123)
split = sample.split(datos$medv, SplitRatio = 0.8)
training_set = subset(datos, split == TRUE)
testing_set = subset(datos, split == FALSE)


#####################################################
# Paso 4: Ajustar un modelo de regresión lineal y Validación Cruzada
#####################################################

# # CV de manera manual
# #####################
# # Número de folds
# k <- 5
# set.seed(42)  # Asegurar reproducibilidad
# 
# # Crear índices de los folds
# folds <- createFolds(datos$medv, k = k)
# 
# # Inicializar vectores para guardar métricas
# r2_values <- c()
# rmse_values <- c()
# 
# # Validación cruzada manual
# for (i in 1:k) {
#   # Dividir en conjunto de entrenamiento y validación
#   training_set <- datos[-folds[[i]], ]
#   testing_set <- datos[folds[[i]], ]
#   
#   # Entrenar el modelo en el conjunto de entrenamiento
#   regression <- lm(medv ~ ., data = training_set)
#   
#   # Predecir en el conjunto de validación
#   y_pred <- predict(regression, newdata = testing_set)
#   
#   # Calcular métricas
#   r2 <- 1 - sum((y_pred - testing_set$medv)^2) / sum((testing_set$medv - mean(testing_set$medv))^2)
#   rmse_val <- rmse(testing_set$medv, y_pred)
#   
#   # Guardar métricas
#   r2_values <- c(r2_values, r2)
#   rmse_values <- c(rmse_values, rmse_val)
# }
# 
# # Métricas promedio de los folds
# cat("R2 promedio:", mean(r2_values), "\n")
# cat("RMSE promedio:", mean(rmse_values), "\n")


# CV con la librería caret
# Usar el paquete caret para la validación cruzada
library(caret)

# Configuración de validación cruzada con 5 folds
control <- trainControl(method = "cv", number = 5)  # Cambia "number" según tus necesidades

# Ajustar el modelo de regresión lineal con CV
regression_cv <- train(
  medv ~ .,                  # Fórmula del modelo
  data = training_set,       # Usamos el conjunto de entrenamiento
  method = "lm",             # Método de regresión lineal
  trControl = control        # Configuración de CV
)

# Resultados de CV
print(regression_cv)

# Métricas promedio de validación cruzada
cat("RMSE promedio:", regression_cv$results$RMSE, "\n")
cat("R-cuadrado promedio:", regression_cv$results$Rsquared, "\n")

# Resumen del modelo ajustado
summary(regression_cv$finalModel)



#####################################################
# Paso 5: Evaluación del modelo en datos de prueba
#####################################################

# Predicciones en los datos de prueba
y_pred <- predict(regression_cv$finalModel, newdata = testing_set)

# Calcular métricas en el conjunto de prueba
library(Metrics)
rmse_value <- rmse(testing_set$medv, y_pred)
r2_value <- 1 - sum((y_pred - testing_set$medv)^2) / sum((testing_set$medv - mean(testing_set$medv))^2)

cat("RMSE en datos de prueba:", rmse_value, "\n")
cat("R-cuadrado en datos de prueba:", r2_value, "\n")



#####################################################
# Paso 6: Diagnóstico del modelo
#####################################################

# Residuos
par(mfrow = c(2, 2))  # Dividir pantalla para múltiples gráficos
plot(regression_cv)


#####################################################
# Paso 7: Visualización de las predicciones
#####################################################

# Comparar valores reales vs predichos
library(ggplot2)
ggplot(data = NULL, aes(x = testing_set$medv, y = y_pred)) +
  geom_point(color = "blue", alpha = 0.6) +
  geom_abline(intercept = 0, slope = 1, color = "red", linetype = "dashed") +
  labs(title = "Valores reales vs. predichos",
       x = "Valores reales (medv)",
       y = "Valores predichos (medv)") +
  theme_minimal()


#####################################################
# Paso 8: Identificación de variables significativas
#####################################################

# Ver las variables más relevantes basadas en el modelo ajustado
cat("Coeficientes del modelo:\n")
print(summary(regression_cv)$coefficients)

