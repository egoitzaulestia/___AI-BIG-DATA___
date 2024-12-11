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





#####################
#Regresion Logistica#
#####################

packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

# Importamos datos Ventas.RData
load("Ventas.RData")
# save(datos2,file = "aaaa.RData") Ejemplo de salvar un dataframe
datos = datos

datos$ventas_altas2[datos$ventas_altas=="Si"]=1
datos$ventas_altas2[datos$ventas_altas=="No"]=0
datos$ventas_altas=NULL
datos$ventas_altas2 = as.factor(datos$ventas_altas2)

datos$US2[datos$US=="Yes"]=1
datos$US2[datos$US=="No"]=0
datos$US=NULL

datos$Urban2=as.numeric(datos$Urban=="Yes")
datos$Urban= NULL

# Convertir ShelveLoc en una variable ordinal con valores específicos
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)  # Convertir a valores numéricos

# Escalamos los datos
datos[,c(1,2,3,4,5,6,7,8,10,11)] = scale(datos[,c(1,2,3,4,5,6,7,8,10,11)])

aciertolog=c()
indice = createMultiFolds(datos$ventas_altas2, k = 5, times = 1) # Cogemos nuestra variable a elegir
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  regresionlog = glm(ventas_altas2~., data=datostrain,family=binomial)
  prediccionlog <- predict(regresionlog,datostst,type = "response")
  datostst$prediccionlog=0
  datostst$prediccionlog[prediccionlog>0.5]=1
  datostst$prediccionlog=as.factor(datostst$prediccionlog)
  resultadoslog=cbind.data.frame(datostst$ventas_altas2,datostst$prediccionlog,prediccionlog)
  #confusionMatrix(datostst$prediccionlog, datostst$Churn2)
  resultado   = confusionMatrix(datostst$prediccionlog, datostst$ventas_altas2)$overall[1]
  aciertolog = rbind(aciertolog,c(resultado))
}

regresionlog
summary(regresionlog)
confusionMatrix(datostst$prediccionlog, datostst$ventas_altas2) 
aciertolog # Nos devuelve los 5 accuracies de cada fold de la VALIDACIÓN CRUZADA
mean(aciertolog)

table(datos$ventas_altas2)
sum((datos$ventas_altas2=="0"))/nrow(datos)

####################################


rm(list=ls())

# Importamos datos Ventas.RData
load("Ventas.RData")
datos = datos

# Preparación de datos
datos$ventas_altas2[datos$ventas_altas=="Si"] = 1
datos$ventas_altas2[datos$ventas_altas=="No"] = 0
datos$ventas_altas = NULL
datos$ventas_altas2 = as.factor(datos$ventas_altas2)

datos$US2[datos$US=="Yes"] = 1
datos$US2[datos$US=="No"] = 0
datos$US = NULL

datos$Urban2 = as.numeric(datos$Urban == "Yes")
datos$Urban = NULL

# Convertir ShelveLoc en una variable ordinal y luego a numérico
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)

# Escalamos los datos
datos[, c(1,2,3,4,5,6,7,8,10,11)] = scale(datos[, c(1,2,3,4,5,6,7,8,10,11)])

# Inicializamos vectores para almacenar las precisiones
aciertolog_test = c()
aciertolog_train = c()

# Validación cruzada
set.seed(123)  # Para reproducibilidad
indice = createMultiFolds(datos$ventas_altas2, k = 5, times = 1)

for (i in 1:length(indice)) {
  datostrain = datos[indice[[i]], ]
  datostst = datos[-indice[[i]], ]
  
  # Ajuste del modelo de regresión logística
  regresionlog = glm(ventas_altas2 ~ ., data = datostrain, family = binomial)
  
  # Predicciones en el conjunto de prueba
  prediccionlog_test <- predict(regresionlog, datostst, type = "response")
  datostst$prediccionlog = ifelse(prediccionlog_test > 0.5, 1, 0)
  datostst$prediccionlog = as.factor(datostst$prediccionlog)
  
  # Matriz de confusión para los datos de prueba
  resultado_test = confusionMatrix(datostst$prediccionlog, datostst$ventas_altas2)$overall["Accuracy"]
  aciertolog_test = rbind(aciertolog_test, c(resultado_test))
  
  # Predicciones en el conjunto de entrenamiento
  prediccionlog_train <- predict(regresionlog, datostrain, type = "response")
  datostrain$prediccionlog = ifelse(prediccionlog_train > 0.5, 1, 0)
  datostrain$prediccionlog = as.factor(datostrain$prediccionlog)
  
  # Matriz de confusión para los datos de entrenamiento
  resultado_train = confusionMatrix(datostrain$prediccionlog, datostrain$ventas_altas2)$overall["Accuracy"]
  aciertolog_train = rbind(aciertolog_train, c(resultado_train))
}

# Resumen de resultados
cat("Precisión promedio en los datos de prueba:", mean(aciertolog_test), "\n")
cat("Precisión promedio en los datos de entrenamiento:", mean(aciertolog_train), "\n")

# Mostrar los modelos y sus resúmenes
print(summary(regresionlog))


############################

rm(list=ls())

# Importamos datos Ventas.RData
load("Ventas.RData")
# save(datos2,file = "aaaa.RData") Ejemplo de salvar un dataframe
datos = datos


datos$ventas_altas2[datos$ventas_altas=="Si"]=1
datos$ventas_altas2[datos$ventas_altas=="No"]=0
datos$ventas_altas=NULL
datos$ventas_altas2 = as.factor(datos$ventas_altas2)


datos$US2[datos$US=="Yes"]=1
datos$US2[datos$US=="No"]=0
datos$US=NULL

datos$Urban2=as.numeric(datos$Urban=="Yes")
datos$Urban= NULL

# Convertir ShelveLoc en una variable ordinal con valores específicos
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)  # Convertir a valores numéricos

# Eliminación de variables no significativas
datos$Population= NULL
# datos$Age= NULL
datos$Education= NULL
datos$US2= NULL
datos$Urban2= NULL

# Escalamos los datos
datos[, c(1,2,3,4,5,6)] = scale(datos[, c(1,2,3,4,5,6)])

aciertolog=c()
indice = createMultiFolds(datos$ventas_altas2, k = 5, times = 1) # Cogemos nuestra variable a elegir
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  regresionlog = glm(ventas_altas2~., data=datostrain,family=binomial)
  prediccionlog <- predict(regresionlog,datostst,type = "response")
  datostst$prediccionlog=0
  datostst$prediccionlog[prediccionlog>0.5]=1
  datostst$prediccionlog=as.factor(datostst$prediccionlog)
  resultadoslog=cbind.data.frame(datostst$ventas_altas2,datostst$prediccionlog,prediccionlog)
  #confusionMatrix(datostst$prediccionlog, datostst$Churn2)
  resultado   = confusionMatrix(datostst$prediccionlog, datostst$ventas_altas2)$overall[1]
  aciertolog = rbind(aciertolog,c(resultado))
  
}

regresionlog
summary(regresionlog)
confusionMatrix(datostst$prediccionlog, datostst$ventas_altas2) 
aciertolog # Nos devuelve los 5 accuracies de cada fold de la VALIDACIÓN CRUZADA
mean(aciertolog)

table(datos$ventas_altas2)
sum((datos$ventas_altas2=="0"))/nrow(datos)


# Cargar librerías necesarias
library(ggplot2)

# Convertimos el vector aciertolog en un data frame para facilitar la visualización
df_acierto <- data.frame(
  Fold = 1:length(aciertolog),
  Accuracy = aciertolog
)

# Calculamos la media de precisión
mean_accuracy <- mean(aciertolog)

# Creamos el gráfico
ggplot(df_acierto, aes(x = factor(Fold), y = Accuracy)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +  # Gráfico de barras para cada pliegue
  geom_hline(yintercept = mean_accuracy, color = "red", linetype = "dashed") +  # Línea de precisión promedio
  labs(title = "Precisión en cada Fold de la Validación Cruzada",
       x = "Fold",
       y = "Precisión (Accuracy)") +
  theme_minimal() +
  annotate("text", x = 1, y = mean_accuracy + 0.02, 
           label = paste("Precisión Promedio:", round(mean_accuracy, 3)), color = "red")



###### Gráfico 2 (Plotly) #######
# Cargar las librerías necesarias
library(plotly)

# Convertimos el vector aciertolog en un data frame para facilitar la visualización
df_acierto <- data.frame(
  Fold = 1:length(aciertolog),
  Accuracy = aciertolog
)

# Calculamos la media de precisión
mean_accuracy <- mean(aciertolog)

# Creamos el gráfico de barras interactivo con Plotly
fig <- plot_ly(df_acierto, x = ~Fold, y = ~Accuracy, type = 'bar', name = 'Accuracy per Fold') %>%
  add_trace(y = ~rep(mean_accuracy, length(aciertolog)), type = 'scatter', mode = 'lines', 
            line = list(color = 'red', dash = 'dash'), name = 'Mean Accuracy') %>%
  layout(
    title = "Precisión en cada Fold de la Validación Cruzada",
    xaxis = list(title = "Fold"),
    yaxis = list(title = "Precisión (Accuracy)"),
    annotations = list(
      x = 1, y = mean_accuracy, text = paste("Precisión Promedio:", round(mean_accuracy, 3)), 
      xref = "x", yref = "y", showarrow = TRUE, arrowhead = 7, ax = 0, ay = -40
    )
  )

# Mostrar el gráfico
fig



###################
#Arbol de decision#
###################


rm(list=ls())


# Importamos datos Ventas.RData
load("Ventas.RData")

datos2 = datos
# save(datos2,file = "aaaa.RData")

library(caret)

set.seed(123456)
indice = createDataPartition(datos$ventas_altas, p = 0.75, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]

library(rpart)
library(rpart.plot)
library(rattle)

tree = rpart(ventas_altas ~ ., data = datostra,minsplit=1,maxdepth=3,cp=0)
out = predict(tree, datostst, type = "class")

testlabels = datostst$ventas_altas

tab = table(out, testlabels) 
print(tab)

arbol_1 = sum(out==testlabels)/length(testlabels)

confusionMatrix(out,datostst$ventas_altas)
confusionMatrix(out, as.factor(datostst$ventas_altas))

prp(tree, cex=.5,main="Arbol")
rpart.plot(tree,cex=.5)

summary(tree)
tree


###########


# Limpiar el entorno
rm(list=ls())

# Cargar los datos
load("Ventas.RData")
datos = datos

# Preprocesamiento de datos
datos$ventas_altas2[datos$ventas_altas == "Si"] <- 1
datos$ventas_altas2[datos$ventas_altas == "No"] <- 0
datos$ventas_altas <- NULL
datos$ventas_altas2 <- as.factor(datos$ventas_altas2)

datos$US2[datos$US == "Yes"] <- 1
datos$US2[datos$US == "No"] <- 0
datos$US <- NULL

datos$Urban2 <- as.numeric(datos$Urban == "Yes")
datos$Urban <- NULL

# Librerías necesarias
library(caret)
library(rpart)
library(rpart.plot)
library(rattle)

# Dividir datos en entrenamiento y prueba (75%-25%)
set.seed(123456)
indice <- createDataPartition(datos$ventas_altas2, p = 0.75, times = 1, list = FALSE)
datostra <- datos[indice, ]
datostst <- datos[-indice, ]

# Crear y ajustar el modelo de árbol de decisión
tree <- rpart(ventas_altas2 ~ ., data = datostra, method = "class", 
              control = rpart.control(minsplit = 1, maxdepth = 8, cp = 0))

# Realizar predicciones en el conjunto de prueba
predicciones <- predict(tree, datostst, type = "class")

# Evaluación del modelo: Matriz de confusión y precisión
testlabels <- datostst$ventas_altas2
tab <- table(predicciones, testlabels)
print(tab)

# Calcular precisión del modelo en el conjunto de prueba
accuracy <- sum(predicciones == testlabels) / length(testlabels)
cat("Precisión del árbol de decisión:", accuracy, "\n")

# Usar la función confusionMatrix de caret para métricas adicionales
conf_matrix <- confusionMatrix(predicciones, testlabels)
print(conf_matrix)

# Visualizar el árbol de decisión
prp(tree, cex = 0.5, main = "Árbol de Decisión con prp()")
rpart.plot(tree, cex = 0.5, main = "Árbol de Decisión con rpart.plot()")

# Resumen del modelo
summary(tree)
print(tree)


# Ejemplo en R para un modelo de clasificación
library(caret)
set.seed(123)

# Dividir el conjunto de datos en entrenamiento y prueba
indice <- createDataPartition(datos$ventas_altas2, p = 0.75, list = FALSE)
train_data <- datos[indice, ]
test_data <- datos[-indice, ]

# Entrenar un modelo (por ejemplo, un árbol de decisión)
modelo <- rpart(ventas_altas2 ~ ., data = train_data, method = "class")

# Evaluar el rendimiento en el conjunto de entrenamiento
pred_train <- predict(modelo, train_data, type = "class")
confusionMatrix(pred_train, train_data$ventas_altas2) # Mide la precisión en entrenamiento

# Evaluar el rendimiento en el conjunto de prueba
pred_test <- predict(modelo, test_data, type = "class")
confusionMatrix(pred_test, test_data$ventas_altas2) # Mide la precisión en prueba




#################
#K-vecinos o KNN#
#################

packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)


rm(list = ls())
set.seed(42)

# Importamos datos Ventas.RData
load("Ventas.RData")
datos = datos

# Preprocesamiento de datos
datos$ventas_altas2[datos$ventas_altas == "Si"] <- 1
datos$ventas_altas2[datos$ventas_altas == "No"] <- 0
datos$ventas_altas <- NULL
datos$ventas_altas2 <- as.factor(datos$ventas_altas2)

datos$US2[datos$US == "Yes"] <- 1
datos$US2[datos$US == "No"] <- 0
datos$US <- NULL

datos$Urban2 <- as.numeric(datos$Urban == "Yes")
datos$Urban <- NULL

# Convertir ShelveLoc en una variable ordinal con valores específicos
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)  # Convertir a valores numéricos

# Escalamos los datos
datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)] <- scale(datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)])

# Validación cruzada KNN
library(class)
library(caret)

aciertos_knn <- c()  # Vector para almacenar las precisiones de cada fold
k_values <- seq(1, 15, 2)  # Valores impares de k para KNN
best_k <- 0
best_accuracy <- 0

# División de datos en folds para validación cruzada
indice <- createMultiFolds(datos$ventas_altas2, k = 5, times = 1)

for (k in k_values) {
  # Almacenar accuracies para este valor de k
  aciertos_fold <- c()
  
  for (i in 1:length(indice)) {
    datostrain <- datos[indice[[i]], ]
    datostst <- datos[-indice[[i]], ]
    
    label_train <- datostrain$ventas_altas2
    datostrain <- datostrain[, -which(names(datostrain) == "ventas_altas2")]
    
    label_test <- datostst$ventas_altas2
    datostst <- datostst[, -which(names(datostst) == "ventas_altas2")]
    
    # Predicción con KNN
    prediccion <- knn(train = datostrain, test = datostst, cl = label_train, k = k)
    
    # Calcular accuracy para este fold
    accuracy <- confusionMatrix(prediccion, label_test)$overall["Accuracy"]
    aciertos_fold <- c(aciertos_fold, accuracy)
  }
  
  # Promedio de accuracy para este valor de k
  mean_accuracy <- mean(aciertos_fold)
  aciertos_knn <- c(aciertos_knn, mean_accuracy)
  
  # Verificar si este es el mejor k
  if (mean_accuracy > best_accuracy) {
    best_accuracy <- mean_accuracy
    best_k <- k
  }
}

# Resultados
cat("Mejor valor de k:", best_k, "\n")
cat("Mejor accuracy promedio:", best_accuracy, "\n")

# Graficar accuracies
plot(k_values, aciertos_knn, type = "b", col = "blue", pch = 19,
     xlab = "Valores de k", ylab = "Precisión promedio (Accuracy)",
     main = "Optimización de k en KNN")
grid()




#############
# Naive Bayes con Grid Search
#############

rm(list = ls())
set.seed(42)

# Importamos datos Ventas.RData
load("Ventas.RData")
datos <- datos

# Preprocesamiento de datos
datos$ventas_altas2[datos$ventas_altas == "Si"] <- 1
datos$ventas_altas2[datos$ventas_altas == "No"] <- 0
datos$ventas_altas <- NULL
datos$ventas_altas2 <- as.factor(datos$ventas_altas2)

datos$US2[datos$US == "Yes"] <- 1
datos$US2[datos$US == "No"] <- 0
datos$US <- NULL

datos$Urban2 <- as.numeric(datos$Urban == "Yes")
datos$Urban <- NULL

# Convertir ShelveLoc en una variable ordinal con valores específicos
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)  # Convertir a valores numéricos

# Escalamos los datos
datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)] <- scale(datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)])

# Validación cruzada Naive Bayes con búsqueda de hiperparámetros
library(e1071)
library(caret)

laplace_values <- seq(0, 2, by = 0.2)  # Valores de Laplace para explorar
best_laplace <- 0  # Mejor valor de Laplace
best_accuracy <- 0  # Mejor precisión promedio
aciertos_naive <- data.frame(Laplace = numeric(), Accuracy = numeric())  # Resultados

# División de datos en folds para validación cruzada
indice <- createMultiFolds(datos$ventas_altas2, k = 5, times = 1)

for (laplace in laplace_values) {
  aciertos_fold <- c()  # Vector para almacenar las precisiones por fold
  
  for (i in 1:length(indice)) {
    datostrain <- datos[indice[[i]], ]
    datostst <- datos[-indice[[i]], ]
    
    # Entrenamiento del modelo Naive Bayes
    modelo <- naiveBayes(ventas_altas2 ~ ., data = datostrain, laplace = laplace)
    
    # Predicción en el conjunto de prueba
    prediccion <- predict(modelo, datostst, type = "class")
    
    # Calcular la precisión para este fold
    accuracy <- confusionMatrix(prediccion, datostst$ventas_altas2)$overall["Accuracy"]
    aciertos_fold <- c(aciertos_fold, accuracy)
  }
  
  # Promedio de accuracy para este valor de Laplace
  mean_accuracy <- mean(aciertos_fold)
  aciertos_naive <- rbind(aciertos_naive, data.frame(Laplace = laplace, Accuracy = mean_accuracy))
  
  # Actualizar el mejor Laplace si mejora la precisión
  if (mean_accuracy > best_accuracy) {
    best_accuracy <- mean_accuracy
    best_laplace <- laplace
  }
}

# Resultados
cat("Mejor valor de Laplace:", best_laplace, "\n")
cat("Mejor precisión promedio:", best_accuracy, "\n")

# Entrenar modelo final con el mejor Laplace
final_model <- naiveBayes(ventas_altas2 ~ ., data = datos, laplace = best_laplace)

# Visualización de los resultados
library(ggplot2)
ggplot(aciertos_naive, aes(x = Laplace, y = Accuracy)) +
  geom_line(color = "blue") +
  geom_point(color = "red") +
  labs(title = "Grid Search para Naive Bayes (Laplace)",
       x = "Valor de Laplace",
       y = "Precisión promedio (Accuracy)") +
  theme_minimal()




###############
# Random Forest #
###############

# Cargar librerías necesarias
packages <- c("tibble", "e1071", "rpart", "caret", "ggplot2", "randomForest", "data.table")
new <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(new)) install.packages(new)
lapply(packages, require, character.only = TRUE)

rm(list = ls())
set.seed(42)

# Importamos datos Ventas.RData
load("Ventas.RData")
datos <- datos

# Preprocesamiento de datos
datos$ventas_altas2[datos$ventas_altas == "Si"] <- 1
datos$ventas_altas2[datos$ventas_altas == "No"] <- 0
datos$ventas_altas <- NULL
datos$ventas_altas2 <- as.factor(datos$ventas_altas2)

datos$US2[datos$US == "Yes"] <- 1
datos$US2[datos$US == "No"] <- 0
datos$US <- NULL

datos$Urban2 <- as.numeric(datos$Urban == "Yes")
datos$Urban <- NULL

# Convertir ShelveLoc en una variable ordinal con valores específicos
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)  # Convertir a valores numéricos

# Escalar los datos
datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)] <- scale(datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)])

# Validación cruzada Random Forest
aciertoRF <- c()  # Vector para almacenar accuracies

# División de datos en folds para validación cruzada
indice <- createMultiFolds(datos$ventas_altas2, k = 5, times = 1)

for (i in 1:length(indice)) {
  datostrain <- datos[indice[[i]], ]
  datostst <- datos[-indice[[i]], ]
  
  # Entrenamiento del modelo Random Forest
  modeloRF <- randomForest(
    ventas_altas2 ~ ., 
    data = datostrain, 
    ntree = 500,          # Número de árboles
    mtry = 4,             # Número de variables consideradas en cada división
    importance = TRUE,    # Calcular importancia de las variables
    nodesize = 1,         # Tamaño mínimo de nodos
    maxnodes = 30         # Máximo número de nodos por árbol
  )
  
  # Predicciones en el conjunto de prueba
  prediccionRF <- predict(modeloRF, datostst, type = "class")
  
  # Calcular precisión para este fold
  accuracy <- confusionMatrix(prediccionRF, datostst$ventas_altas2)$overall["Accuracy"]
  aciertoRF <- rbind(aciertoRF, c(accuracy))
}

# Resultados finales
cat("Precisión promedio (validación cruzada):", mean(aciertoRF), "\n")
cat("Desviación estándar de la precisión:", sd(aciertoRF), "\n")


# Calcular la importancia de las variables
if ("importance" %in% names(modeloRF)) {
  importancia <- as.data.frame(modeloRF$importance)
  importancia <- importancia[order(importancia$MeanDecreaseGini, decreasing = TRUE), ]
  
  # Visualización de importancia de características
  library(ggplot2)
  ggplot(importancia, aes(x = reorder(rownames(importancia), MeanDecreaseGini), y = MeanDecreaseGini)) +
    geom_bar(stat = "identity", fill = "blue") +
    coord_flip() +
    labs(title = "Importancia de Características (Random Forest)",
         x = "Características",
         y = "Importancia (Mean Decrease Gini)") +
    theme_minimal()
} else {
  cat("El modelo no contiene información de importancia de variables.\n")
}


# Mostrar la matriz de confusión del último fold
confusionMatrix(prediccionRF, datostst$ventas_altas2)




###############
# XGBoost #
###############

# Cargar librerías necesarias
packages <- c("tibble", "e1071", "rpart", "caret", "ggplot2", "xgboost", "Matrix", "data.table")
new <- packages[!(packages %in% installed.packages()[, "Package"])]
if (length(new)) install.packages(new)
lapply(packages, require, character.only = TRUE)

rm(list = ls())
set.seed(42)

# Importamos datos Ventas.RData
load("Ventas.RData")
datos <- datos

# Preprocesamiento de datos
datos$ventas_altas2[datos$ventas_altas == "Si"] <- 1
datos$ventas_altas2[datos$ventas_altas == "No"] <- 0
datos$ventas_altas <- NULL
datos$ventas_altas2 <- as.factor(datos$ventas_altas2)

datos$US2[datos$US == "Yes"] <- 1
datos$US2[datos$US == "No"] <- 0
datos$US <- NULL

datos$Urban2 <- as.numeric(datos$Urban == "Yes")
datos$Urban <- NULL

# Convertir ShelveLoc en una variable ordinal con valores específicos
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)  # Convertir a valores numéricos

# Escalar los datos
datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)] <- scale(datos[, c(1, 2, 3, 4, 5, 6, 7, 8, 10, 11)])

# Validación cruzada XGBoost
aciertoXGB <- c()  # Vector para almacenar accuracies

# División de datos en folds para validación cruzada
indice <- createMultiFolds(datos$ventas_altas2, k = 5, times = 1)

# Hiperparámetros iniciales de XGBoost
parametros <- list(
  booster = "gbtree",
  objective = "binary:logistic",  # Clasificación binaria
  eval_metric = "error",         # Métrica de evaluación: error (1-Accuracy)
  eta = 0.1,                     # Tasa de aprendizaje
  max_depth = 6,                 # Profundidad máxima de los árboles
  min_child_weight = 1,          # Peso mínimo de los nodos hoja
  subsample = 0.8,               # Submuestreo de las filas
  colsample_bytree = 0.8         # Submuestreo de las columnas
)

for (i in 1:length(indice)) {
  datostrain <- datos[indice[[i]], ]
  datostst <- datos[-indice[[i]], ]
  
  label_train <- as.numeric(as.character(datostrain$ventas_altas2))
  label_test <- as.numeric(as.character(datostst$ventas_altas2))
  
  datostrain <- datostrain[, -which(names(datostrain) == "ventas_altas2")]
  datostst <- datostst[, -which(names(datostst) == "ventas_altas2")]
  
  # Convertir a formato DMatrix de XGBoost
  dtrain <- xgb.DMatrix(data = as.matrix(datostrain), label = label_train)
  dtest <- xgb.DMatrix(data = as.matrix(datostst), label = label_test)
  
  # Entrenar el modelo
  modeloXGB <- xgb.train(
    params = parametros,
    data = dtrain,
    nrounds = 100,  # Número de iteraciones (árboles)
    watchlist = list(train = dtrain, eval = dtest),
    verbose = 0
  )
  
  # Predicción en el conjunto de prueba
  prediccionXGB <- predict(modeloXGB, dtest)
  prediccionXGB <- ifelse(prediccionXGB > 0.5, 1, 0)  # Umbral 0.5
  
  # Calcular precisión para este fold
  accuracy <- confusionMatrix(factor(prediccionXGB), factor(label_test))$overall["Accuracy"]
  aciertoXGB <- c(aciertoXGB, accuracy)
}

# Resultados finales
cat("Precisión promedio (validación cruzada):", mean(aciertoXGB), "\n")
cat("Desviación estándar de la precisión:", sd(aciertoXGB), "\n")

# Graficar importancia de características
importancia <- xgb.importance(model = modeloXGB)
xgb.plot.importance(importancia, top_n = 10, main = "Importancia de Características")


# Cargar las librerías necesarias
library(plotly)

# Crear un dataframe con las precisiones por fold
df_acierto <- data.frame(
  Fold = factor(1:length(aciertoXGB)),  # Número de cada fold
  Accuracy = aciertoXGB                # Precisión de cada fold
)

# Calcular la precisión promedio
mean_accuracy <- mean(aciertoXGB)

# Gráfico de precisión por fold con ggplot2
library(ggplot2)

ggplot(df_acierto, aes(x = Fold, y = Accuracy)) +
  geom_bar(stat = "identity", fill = "steelblue") +  # Barras para cada fold
  geom_hline(yintercept = mean_accuracy, color = "red", linetype = "dashed", size = 1) +  # Línea de precisión promedio
  annotate("text", x = length(aciertoXGB) - 0.5, y = mean_accuracy + 0.01, 
           label = paste("Precisión Promedio:", round(mean_accuracy, 3)), 
           color = "red", size = 4, hjust = 1) +  # Etiqueta de precisión promedio
  labs(
    title = "Precisión en cada Fold de la Validación Cruzada",
    x = "Fold",
    y = "Precisión (Accuracy)"
  ) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5, size = 14, face = "bold"),
    axis.title = element_text(size = 12),
    axis.text = element_text(size = 10)
  )




##################
# Redes Neuronales #
##################

# # Cargar librerías necesarias
# packages <- c("ggplot2", "caret", "neuralnet", "NeuralNetTools", "nnet", "clusterSim")
# new <- packages[!(packages %in% installed.packages()[, "Package"])]
# if (length(new)) install.packages(new)
# lapply(packages, require, character.only = TRUE)
# 
# rm(list = ls())
# set.seed(42)
# 
# # Importamos datos Ventas.RData
# load("Ventas.RData")
# datos <- datos
# 
# # Preprocesamiento de datos
# datos$ventas_altas2[datos$ventas_altas == "Si"] <- 1
# datos$ventas_altas2[datos$ventas_altas == "No"] <- 0
# datos$ventas_altas <- NULL
# datos$ventas_altas2 <- as.factor(datos$ventas_altas2)
# 
# datos$US2[datos$US == "Yes"] <- 1
# datos$US2[datos$US == "No"] <- 0
# datos$US <- NULL
# 
# datos$Urban2 <- as.numeric(datos$Urban == "Yes")
# datos$Urban <- NULL
# 
# # Convertir ShelveLoc en una variable ordinal con valores específicos
# datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
# datos$ShelveLoc <- as.numeric(datos$ShelveLoc)  # Convertir a valores numéricos
# 
# # Escalar los datos
# minimos <- as.numeric(apply(datos[, -11], 2, min))
# maximos <- as.numeric(apply(datos[, -11], 2, max))
# datos_norm <- data.Normalization(datos[, -11], type = "n4", normalization = "column")
# datos <- cbind(datos_norm, ventas_altas2 = datos$ventas_altas2)
# 
# # Preparar datos para validación cruzada
# indice <- createDataPartition(datos$ventas_altas2, p = 0.8, times = 1, list = FALSE)
# 
# datostra <- datos[indice, ]
# datostst <- datos[-indice, ]
# 
# labeltra <- class.ind(as.numeric(datostra$ventas_altas2))
# labeltst <- class.ind(as.numeric(datostst$ventas_altas2))
# 
# datostra$ventas_altas2 <- NULL
# datostst$ventas_altas2 <- NULL
# 
# # Crear fórmula válida excluyendo la variable objetivo
# formula <- as.formula(
#   paste(
#     paste(colnames(labeltra), collapse = " + "),  # Variables objetivo
#     "~",
#     paste(setdiff(colnames(datostra), "ventas_altas2"), collapse = " + ")  # Variables predictoras
#   )
# )
# 
# # Verificar fórmula
# print(formula)
# 
# # Asegurarte de que los datos están correctamente preparados
# if (anyNA(datostra)) stop("Valores NA encontrados en datostra.")
# if (anyNA(labeltra)) stop("Valores NA encontrados en labeltra.")
# 
# # Eliminar la columna ventas_altas2 de datostra si aún está presente
# datostra <- datostra[, !colnames(datostra) %in% "ventas_altas2"]
# 
# # Entrenar el modelo de red neuronal
# modelo <- neuralnet(
#   formula,
#   data = cbind(datostra, labeltra),  # Combinar predictores y objetivo
#   hidden = c(10, 9),                # Capas ocultas
#   linear.output = FALSE,
#   lifesign = "full",
#   stepmax = 20000,
#   rep = 7,
#   algorithm = "rprop+",
#   threshold = 0.05
# )
# 
# # Evaluar modelo (si el entrenamiento es exitoso)
# plot(modelo)
# 
# 
# # Realizar predicciones en el conjunto de prueba
# prediccion <- compute(modelo, datostst)
# prediccion_result <- prediccion$net.result
# 
# # Convertir predicciones a clases binarias
# prediccion_df <- as.data.frame(prediccion_result)
# colnames(prediccion_df) <- colnames(labeltst)
# 
# prediccion_final <- apply(prediccion_df, 1, which.max) - 1  # Restar 1 para que coincida con las clases originales
# labeltst_final <- apply(labeltst, 1, which.max) - 1
# 
# # Evaluación de resultados
# prediccion_factor <- as.factor(prediccion_final)
# labeltst_factor <- as.factor(labeltst_final)
# 
# resultado <- confusionMatrix(prediccion_factor, labeltst_factor)
# print(resultado)
# 
# # Visualizar resultados
# summary(prediccion_factor)
# summary(labeltst_factor)
# 
# # Graficar la red neuronal
# plot(modelo)
