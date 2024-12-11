rm(list=ls())
packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

packages <- c("e1071","caret","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

packages <- c("tibble","e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

##################
#Regresión lineal#
##################


rm(list=ls())
library(MASS)
library(caret)

# Cargar el dataset
data("Boston")
datos = Boston

# Almacenar resultados
acierto = c()

# Crear folds para validación cruzada
indice = createMultiFolds(datos$medv, k = 5, times = 1)

# Bucle para entrenamiento y evaluación
for (i in 1:length(indice)) {
  datostrain = datos[indice[[i]], ]
  datostst = datos[-indice[[i]], ]
  
  # Modelo de regresión lineal
  regresion = lm(medv ~ ., data = datostrain)
  
  # Predicción
  prediccion = predict(regresion, datostst)
  
  # Calcular R^2 manualmente
  resultado = 1 - (sum((datostst$medv - prediccion)^2) / sum((datostst$medv - mean(datostst$medv))^2))
  
  # Almacenar resultados
  acierto = rbind(acierto, c(resultado))
}

# Promedio del R^2 de los folds
mean(acierto)
acierto

# Ajustar un modelo final con todos los datos
regresion = lm(medv ~ ., data = datos)
summary(regresion)


#####################
#Árboles de decisión#
#####################

# Limpiar el entorno
# Limpiar el entorno
rm(list = ls())

# Cargar paquetes necesarios
if (!require("rpart")) install.packages("rpart")
if (!require("caret")) install.packages("caret")
if (!require("rpart.plot")) install.packages("rpart.plot")
library(rpart)
library(caret)
library(rpart.plot)

# Cargar el dataset
data("Boston", package = "MASS")
datos <- Boston

# Almacenar resultados para los modelos
acierto_arbol <- c()

# Crear folds para validación cruzada
indice <- createMultiFolds(datos$medv, k = 5, times = 1)

# Bucle para entrenar y evaluar el modelo usando validación cruzada
for (vector in indice) {
  # Dividir en conjunto de entrenamiento y prueba
  datostrain <- datos[vector, ]
  datostst <- datos[-vector, ]
  
  # Entrenar el árbol de decisión
  arbol <- rpart(medv ~ ., data = datostrain, maxdepth = 4)
  
  # Predicciones en el conjunto de prueba
  prediccion <- predict(arbol, datostst)
  
  # Calcular R² manualmente
  resultado <- 1 - (sum((datostst$medv - prediccion)^2) /
                      sum((datostst$medv - mean(datostst$medv))^2))
  
  # Guardar resultado
  acierto_arbol <- rbind(acierto_arbol, c(resultado))
}

# Métricas de validación cruzada
cat("R² promedio en validación cruzada:", mean(acierto_arbol), "\n")


# Graficar el árbol final (última iteración)
rpart.plot(arbol, cex = 0.6, main = "Árbol de decisión")

# Evaluación final en el último fold
ver <- data.frame(
  Realidad = datostst$medv,
  Predicción = prediccion
)

# Calcular errores
ver$Error <- ver$Realidad - ver$Predicción
mean_error <- mean(abs(ver$Error))

# Mostrar métricas de error
cat("Error medio absoluto (MAE):", mean_error, "\n")
cat("Percentiles del error absoluto:", quantile(abs(ver$Error), probs = c(0.05, 0.95)), "\n")

# Graficar el error
hist(ver$Error, main = "Histograma del Error", xlab = "Error")
hist(abs(ver$Error), main = "Histograma del Error Absoluto", xlab = "Error Absoluto")
plot(
  ver$Realidad, ver$Predicción,
  xlab = "Realidad (medv)", ylab = "Predicción (medv)",
  main = "Predicción vs Realidad"
)




###############
#Random Forest#
###############

# Parámetros:

# ·ntree:
# Number of trees to grow. This should not be set to too small a number, 
# to ensure that every input row gets predicted at least a few times.

# ·mtry:	
# Number of variables randomly sampled as candidates at each split.
# Note that the default values are different for classification
# (sqrt(p) where p is number of variables in x) and regression (p/3)

#El parámetro mtry controla el número de características (o variables) que se consideran 
#al momento de dividir un nodo en un árbol de decisión. Esto se hace aleatoriamente en cada árbol, 
#lo que es una de las características clave que diferencia a un Random Forest de un árbol de decisión 
#tradicional (que evalúa todas las características disponibles en cada división).

# Limpiar el entorno
rm(list = ls())

# Cargar paquetes necesarios
if (!require("randomForest")) install.packages("randomForest")
if (!require("caret")) install.packages("caret")
library(randomForest)
library(caret)

# Cargar el dataset Boston
data("Boston", package = "MASS")
datos <- Boston

# Almacenar resultados de validación cruzada
aciertoRF <- c()       # Acierto en datos de prueba
aciertoRFtrain <- c()  # Acierto en datos de entrenamiento

# Crear folds para validación cruzada
indice <- createMultiFolds(datos$medv, k = 5, times = 1)

# Bucle para entrenamiento y evaluación con validación cruzada
for (i in 1:length(indice)) {
  # Dividir en conjunto de entrenamiento y prueba
  datostrain <- datos[indice[[i]], ]
  datostst <- datos[-indice[[i]], ]
  
  # Entrenar modelo Random Forest
  modeloRF <- randomForest(medv ~ ., data = datostrain, ntree = 1000, mtry = 3)
  
  # Predicciones
  predicciontrain <- predict(modeloRF, datostrain)  # En entrenamiento
  prediccion <- predict(modeloRF, datostst)        # En prueba
  
  # Calcular R² en datos de prueba
  resultado <- 1 - (sum((datostst$medv - prediccion)^2) /
                      sum((datostst$medv - mean(datostst$medv))^2))
  
  # Calcular R² en datos de entrenamiento
  resultadotrain <- 1 - (sum((datostrain$medv - predicciontrain)^2) /
                           sum((datostrain$medv - mean(datostrain$medv))^2))
  
  # Almacenar resultados
  aciertoRF <- rbind(aciertoRF, c(resultado))
  aciertoRFtrain <- rbind(aciertoRFtrain, c(resultadotrain))
}

# Resultados finales
cat("R² promedio en datos de prueba:", mean(aciertoRF), "\n")
cat("R² promedio en datos de entrenamiento:", mean(aciertoRFtrain), "\n")

# Comparar aciertos en prueba y entrenamiento
aciertototal <- cbind(AciertoPrueba = aciertoRF, AciertoEntrenamiento = aciertoRFtrain)
print(aciertototal)

# Evaluación de errores en el último fold
ver <- data.frame(
  Realidad = datostst$medv,
  Predicción = prediccion
)
ver$Error <- ver$Realidad - ver$Predicción

# Métricas de error
cat("Error medio absoluto (MAE):", mean(abs(ver$Error)), "\n")
cat("Percentiles del error absoluto:", quantile(abs(ver$Error), probs = c(0.05, 0.95)), "\n")

# Importancia de variables
importanciarf <- as.data.frame(importance(modeloRF))
print("Importancia de Variables:")
print(importanciarf)

# Nodos terminales
cat("Número de nodos terminales:", length(unique(prediccion)), "\n")

# Gráficos
plot(
  ver$Realidad, ver$Predicción,
  xlab = "Valores Reales (medv)", ylab = "Predicciones",
  main = "Predicciones vs Realidad"
)
abline(0, 1, col = "red", lwd = 2)  # Línea ideal





#########
#XGBoost#
#########

# Limpiar el entorno
rm(list = ls())

# Cargar paquetes necesarios
if (!require("xgboost")) install.packages("xgboost")
if (!require("caret")) install.packages("caret")
if (!require("dplyr")) install.packages("dplyr")
library(xgboost)
library(caret)
library(dplyr)

# Cargar el dataset Boston
data("Boston", package = "MASS")
datos <- Boston

# Almacenar resultados para el modelo
aciertoXGBoost <- c()

# Crear folds para validación cruzada
indice <- createMultiFolds(datos$medv, k = 5, times = 1)

# Bucle para entrenamiento y evaluación con validación cruzada
for (i in 1:length(indice)) {
  # Dividir datos en entrenamiento y prueba
  datostrain <- datos[indice[[i]], ]
  datostst <- datos[-indice[[i]], ]
  
  # Crear matrices de entrenamiento y prueba para XGBoost
  train_y <- datostrain$medv
  train_x <- datostrain %>% select(-medv)
  test_x <- datostst %>% select(-medv)
  test_y <- datostst$medv
  
  dtrain <- xgb.DMatrix(data = as.matrix(train_x), label = train_y)
  dtest <- xgb.DMatrix(data = as.matrix(test_x))
  
  # Parámetros de XGBoost
  xgb_params <- list(
    colsample_bytree = 1,     # Variables por árbol
    subsample = 1,            # Porcentaje de datos para cada árbol
    booster = "gbtree",
    max_depth = 9,            # Profundidad máxima del árbol
    min_child_weight = 1.5,
    reg_alpha = 0.8,
    reg_lambda = 0.6,
    seed = 42,
    eta = 0.03,               # Tasa de aprendizaje
    eval_metric = "rmse",     # Métrica de evaluación
    objective = "reg:squarederror",
    gamma = 0
  )
  
  # Entrenar el modelo
  gb_dt <- xgb.train(
    params = xgb_params,
    data = dtrain,
    nrounds = 1000,
    verbose = 0  # Para evitar exceso de mensajes en consola
  )
  
  # Predicción en datos de prueba
  prediccionxgb <- predict(gb_dt, dtest)
  
  # Calcular R² manualmente
  resultado <- 1 - (sum((test_y - prediccionxgb)^2) / sum((test_y - mean(test_y))^2))
  
  # Guardar resultado
  aciertoXGBoost <- rbind(aciertoXGBoost, c(resultado))
}

# Resultados finales
cat("R² promedio en validación cruzada:", mean(aciertoXGBoost), "\n")

# Importancia de las variables
imp_matrix <- as_tibble(xgb.importance(feature_names = colnames(train_x), model = gb_dt))
print("Importancia de Variables:")
print(imp_matrix)

# Evaluación de errores en el último fold
ver <- data.frame(
  Realidad = test_y,
  Predicción = prediccionxgb
)
ver$Error <- ver$Realidad - ver$Predicción

# Métricas de error
cat("Error medio absoluto (MAE):", mean(abs(ver$Error)), "\n")
cat("Percentiles del error absoluto:", quantile(abs(ver$Error), probs = c(0.05, 0.95)), "\n")

# Gráfico de Predicción vs Realidad
plot(
  ver$Realidad, ver$Predicción,
  xlab = "Valores Reales (medv)", ylab = "Predicciones",
  main = "Predicciones vs Realidad"
)
abline(0, 1, col = "red", lwd = 2)  # Línea ideal




##############################################################
#     Repetimos el XGBoost pero esta vez                     #
#     vamos a seleccionar las variables más importantes      #
##############################################################

# Limpiar el entorno
rm(list = ls())

# Cargar paquetes necesarios
if (!require("xgboost")) install.packages("xgboost")
if (!require("caret")) install.packages("caret")
if (!require("dplyr")) install.packages("dplyr")
library(xgboost)
library(caret)
library(dplyr)

# Cargar el dataset Boston
data("Boston", package = "MASS")
datos <- Boston

# Almacenar resultados para el modelo
aciertoXGBoost <- c()

# Crear folds para validación cruzada
indice <- createMultiFolds(datos$medv, k = 5, times = 1)

# Bucle para entrenamiento y evaluación con validación cruzada
for (i in 1:length(indice)) {
  # Dividir datos en entrenamiento y prueba
  datostrain <- datos[indice[[i]], ]
  datostst <- datos[-indice[[i]], ]
  
  # Crear matrices de entrenamiento y prueba para XGBoost
  train_y <- datostrain$medv
  train_x <- datostrain %>% select(-medv)
  test_x <- datostst %>% select(-medv)
  test_y <- datostst$medv
  
  dtrain <- xgb.DMatrix(data = as.matrix(train_x), label = train_y)
  dtest <- xgb.DMatrix(data = as.matrix(test_x))
  
  # Parámetros de XGBoost
  xgb_params <- list(
    colsample_bytree = 1,     # Variables por árbol
    subsample = 1,            # Porcentaje de datos para cada árbol
    booster = "gbtree",
    max_depth = 9,            # Profundidad máxima del árbol
    min_child_weight = 1.5,
    reg_alpha = 0.8,
    reg_lambda = 0.6,
    seed = 42,
    eta = 0.03,               # Tasa de aprendizaje
    eval_metric = "rmse",     # Métrica de evaluación
    objective = "reg:squarederror",
    gamma = 0
  )
  
  # Entrenar el modelo
  gb_dt <- xgb.train(
    params = xgb_params,
    data = dtrain,
    nrounds = 1000,
    verbose = 0  # Para evitar exceso de mensajes en consola
  )
  
  # Predicción en datos de prueba
  prediccionxgb <- predict(gb_dt, dtest)
  
  # Calcular R² manualmente
  resultado <- 1 - (sum((test_y - prediccionxgb)^2) / sum((test_y - mean(test_y))^2))
  
  # Guardar resultado
  aciertoXGBoost <- rbind(aciertoXGBoost, c(resultado))
}

# Resultados finales
cat("R² promedio en validación cruzada:", mean(aciertoXGBoost), "\n")

# **Selección de Variables (Importancia)**
imp_matrix <- xgb.importance(feature_names = colnames(train_x), model = gb_dt)
print("Importancia de Variables:")
print(imp_matrix)

# Seleccionar las mejores variables (e.g., top 5)
top_variables <- imp_matrix %>% top_n(5, wt = Gain) %>% pull(Feature)
print("Top 5 variables más importantes:")
print(top_variables)

# Crear nuevos datasets solo con las mejores variables
train_x_top <- train_x[, top_variables]
test_x_top <- test_x[, top_variables]

# Crear matrices para XGBoost con las mejores variables
dtrain_top <- xgb.DMatrix(as.matrix(train_x_top), label = train_y)
dtest_top <- xgb.DMatrix(as.matrix(test_x_top))

# Entrenar nuevamente con las mejores variables
gb_dt_top <- xgb.train(
  params = xgb_params,
  data = dtrain_top,
  nrounds = 1000,
  verbose = 0
)

# Predicción y evaluación con las mejores variables
prediccionxgb_top <- predict(gb_dt_top, dtest_top)
resultado_top <- 1 - (sum((test_y - prediccionxgb_top)^2) / sum((test_y - mean(test_y))^2))
cat("R² en prueba con las mejores variables:", resultado_top, "\n")

# Evaluación de errores en el último fold con las mejores variables
ver <- data.frame(
  Realidad = test_y,
  Predicción = prediccionxgb_top
)
ver$Error <- ver$Realidad - ver$Predicción

# Métricas de error
cat("Error medio absoluto (MAE):", mean(abs(ver$Error)), "\n")
cat("Percentiles del error absoluto:", quantile(abs(ver$Error), probs = c(0.05, 0.95)), "\n")

# Gráfico de Predicción vs Realidad
plot(
  ver$Realidad, ver$Predicción,
  xlab = "Valores Reales (medv)", ylab = "Predicciones",
  main = "Predicciones vs Realidad (Mejores Variables)"
)
abline(0, 1, col = "red", lwd = 2)  # Línea ideal



