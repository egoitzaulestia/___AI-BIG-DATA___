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


install.packages("plotly")



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

# Inicializamos listas para almacenar resultados de cada fold (sin columna 'Fold')
resultados_test <- data.frame(Accuracy = numeric(), Sensitivity = numeric(), Specificity = numeric())
resultados_train <- data.frame(Accuracy = numeric(), Sensitivity = numeric(), Specificity = numeric())

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
  matriz_test <- confusionMatrix(datostst$prediccionlog, datostst$ventas_altas2)
  resultados_test <- rbind(resultados_test, data.frame(
    Accuracy = matriz_test$overall["Accuracy"],
    Sensitivity = matriz_test$byClass["Sensitivity"],
    Specificity = matriz_test$byClass["Specificity"]
  ))
  
  # Predicciones en el conjunto de entrenamiento
  prediccionlog_train <- predict(regresionlog, datostrain, type = "response")
  datostrain$prediccionlog = ifelse(prediccionlog_train > 0.5, 1, 0)
  datostrain$prediccionlog = as.factor(datostrain$prediccionlog)
  
  # Matriz de confusión para los datos de entrenamiento
  matriz_train <- confusionMatrix(datostrain$prediccionlog, datostrain$ventas_altas2)
  resultados_train <- rbind(resultados_train, data.frame(
    Accuracy = matriz_train$overall["Accuracy"],
    Sensitivity = matriz_train$byClass["Sensitivity"],
    Specificity = matriz_train$byClass["Specificity"]
  ))
  
  # Imprimir resultados de cada fold para entrenamiento y prueba
  cat("Fold:", i, "\n")
  cat("Datos de prueba - Accuracy:", matriz_test$overall["Accuracy"], 
      "Sensitivity:", matriz_test$byClass["Sensitivity"], 
      "Specificity:", matriz_test$byClass["Specificity"], "\n")
  cat("Datos de entrenamiento - Accuracy:", matriz_train$overall["Accuracy"], 
      "Sensitivity:", matriz_train$byClass["Sensitivity"], 
      "Specificity:", matriz_train$byClass["Specificity"], "\n\n")
}

# Información adicional: modelo, resumen y matriz de confusión final de datos de prueba
print("Modelo de regresión logística final en el último fold:")
print(regresionlog)
print(summary(regresionlog))
print(confusionMatrix(datostst$prediccionlog, datostst$ventas_altas2))

# Verificación de distribución de la variable objetivo
cat("\nDistribución de la variable objetivo (ventas_altas2):\n")
print(table(datos$ventas_altas2))
cat("Proporción de '0':", sum((datos$ventas_altas2 == "0")) / nrow(datos), "\n")

# Función para mostrar el resumen de métricas sin columna 'Fold'
mostrar_resumen_metricas <- function(resultados_test, resultados_train) {
  cat("\nResumen de precisión en datos de prueba y entrenamiento:\n")
  
  # Renombrar las filas para indicar los folds
  rownames(resultados_test) <- paste("Fold_", 1:nrow(resultados_test), sep = "")
  rownames(resultados_train) <- paste("Fold_", 1:nrow(resultados_train), sep = "")
  
  # Mostrar resultados de cada fold para datos de prueba
  cat("\nDatos de prueba:\n")
  print(resultados_test)
  
  # Calcular y mostrar promedio en datos de prueba
  cat("\nPromedio en datos de prueba:\n")
  print(colMeans(resultados_test))
  
  # Mostrar resultados de cada fold para datos de entrenamiento
  cat("\nDatos de entrenamiento:\n")
  print(resultados_train)
  
  # Calcular y mostrar promedio en datos de entrenamiento
  cat("\nPromedio en datos de entrenamiento:\n")
  print(colMeans(resultados_train))
}

# Llamar a la función después de la validación cruzada
mostrar_resumen_metricas(resultados_test, resultados_train)


# VISUALIAZACIÓN DE LOS DATOS

###### Gráfico 1 (Plotly) #######
# Cargar ggplot2
library(ggplot2)

# Crear un data frame con los valores de Accuracy de cada fold en resultados_test
df_acierto <- resultados_test

# Renombrar las filas para que aparezcan como Fold_1, Fold_2, etc.
rownames(df_acierto) <- paste0("Fold_", 1:nrow(df_acierto))

# Calcular la precisión promedio en los datos de prueba
mean_accuracy <- mean(df_acierto$Accuracy)

# Crear el gráfico de barras para la precisión en cada fold
ggplot(df_acierto, aes(x = rownames(df_acierto), y = Accuracy)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +  # Gráfico de barras para cada pliegue
  geom_hline(yintercept = mean_accuracy, color = "red", linetype = "dashed") +  # Línea de precisión promedio
  labs(title = "Precisión en cada Fold de la Validación Cruzada",
       x = "Fold",
       y = "Precisión (Accuracy)") +
  theme_minimal() +
  annotate("text", x = 1, y = mean_accuracy + 0.02, 
           label = paste("Precisión Promedio:", round(mean_accuracy, 3)), color = "red") +
  geom_text(aes(label = sprintf("%.3f", Accuracy)), vjust = -0.5) +  # Mostrar precisión sobre cada barra
  scale_x_discrete(labels = rownames(df_acierto))  # Aseguramos etiquetas Fold_1, Fold_2, etc.


###### Gráfico 2 (Plotly) #######
# Cargar las librerías necesarias
library(plotly)

# Renombrar las filas para que aparezcan como Fold_1, Fold_2, etc.
rownames(df_acierto) <- paste0("Fold_", 1:nrow(df_acierto))

# Crear el gráfico de barras interactivo con Plotly
fig <- plot_ly(df_acierto, x = ~rownames(df_acierto), y = ~Accuracy, type = 'bar', name = 'Accuracy per Fold',
               text = ~sprintf("%.3f", Accuracy), textposition = 'outside') %>%
  add_trace(y = ~rep(mean_accuracy, nrow(df_acierto)), type = 'scatter', mode = 'lines', 
            line = list(color = 'red', dash = 'dash'), name = 'Mean Accuracy') %>%
  layout(
    title = "Precisión en cada Fold de la Validación Cruzada",
    xaxis = list(title = "Fold", tickvals = rownames(df_acierto), ticktext = rownames(df_acierto)),
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
save(datos2,file = "aaaa.RData")

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



########################
########################
########################

######################
# Árbol de Decisión #
#####################

# Instalación y carga de librerías necesarias
packages <- c("caret", "rpart", "rpart.plot", "rattle", "ggplot2", "plotly")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
lapply(packages, require, character.only=TRUE)

# Limpiar el entorno
rm(list=ls())

# Importar y preparar los datos
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

# Convertir ShelveLoc en una variable ordinal y luego a numérico
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)

# Escalamos los datos
datos[, c(1,2,3,4,5,6,7,8,10,11)] = scale(datos[, c(1,2,3,4,5,6,7,8,10,11)])

# Configuración de validación cruzada y almacenamiento de métricas
set.seed(123)
resultados_test <- data.frame(Accuracy = numeric(), Sensitivity = numeric(), Specificity = numeric())
resultados_train <- data.frame(Accuracy = numeric(), Sensitivity = numeric(), Specificity = numeric())
indice = createMultiFolds(datos$ventas_altas2, k = 5, times = 1)

# Validación cruzada
for (i in 1:length(indice)) {
  datostrain = datos[indice[[i]], ]
  datostst = datos[-indice[[i]], ]
  
  # Ajuste del modelo de árbol de decisión
  tree <- rpart(ventas_altas2 ~ ., data = datostrain, method = "class", 
                control = rpart.control(minsplit = 1, maxdepth = 7, cp = 0))
  
  # Predicciones y evaluación en el conjunto de prueba
  predicciones_test <- predict(tree, datostst, type = "class")
  matriz_test <- confusionMatrix(predicciones_test, datostst$ventas_altas2)
  resultados_test <- rbind(resultados_test, data.frame(
    Accuracy = matriz_test$overall["Accuracy"],
    Sensitivity = matriz_test$byClass["Sensitivity"],
    Specificity = matriz_test$byClass["Specificity"]
  ))
  
  # Predicciones y evaluación en el conjunto de entrenamiento
  predicciones_train <- predict(tree, datostrain, type = "class")
  matriz_train <- confusionMatrix(predicciones_train, datostrain$ventas_altas2)
  resultados_train <- rbind(resultados_train, data.frame(
    Accuracy = matriz_train$overall["Accuracy"],
    Sensitivity = matriz_train$byClass["Sensitivity"],
    Specificity = matriz_train$byClass["Specificity"]
  ))
  
  # Imprimir métricas de cada fold
  cat("Fold:", i, "\n")
  cat("Datos de prueba - Accuracy:", matriz_test$overall["Accuracy"], 
      "Sensitivity:", matriz_test$byClass["Sensitivity"], 
      "Specificity:", matriz_test$byClass["Specificity"], "\n")
  cat("Datos de entrenamiento - Accuracy:", matriz_train$overall["Accuracy"], 
      "Sensitivity:", matriz_train$byClass["Sensitivity"], 
      "Specificity:", matriz_train$byClass["Specificity"], "\n\n")
}

# Resumen de métricas
mostrar_resumen_metricas <- function(resultados_test, resultados_train) {
  cat("\nResumen de precisión en datos de prueba y entrenamiento:\n")
  
  # Renombrar filas con Fold_1, Fold_2, etc.
  rownames(resultados_test) <- paste("Fold_", 1:nrow(resultados_test), sep = "")
  rownames(resultados_train) <- paste("Fold_", 1:nrow(resultados_train), sep = "")
  
  # Mostrar métricas para cada fold y promedio en datos de prueba
  cat("\nDatos de prueba:\n")
  print(resultados_test)
  cat("\nPromedio en datos de prueba:\n")
  print(colMeans(resultados_test))
  
  # Mostrar métricas para cada fold y promedio en datos de entrenamiento
  cat("\nDatos de entrenamiento:\n")
  print(resultados_train)
  cat("\nPromedio en datos de entrenamiento:\n")
  print(colMeans(resultados_train))
}

# Llamada a la función de resumen
mostrar_resumen_metricas(resultados_test, resultados_train)

# Visualización de resultados
library(ggplot2)
df_acierto <- resultados_test
rownames(df_acierto) <- paste0("Fold_", 1:nrow(df_acierto))
mean_accuracy <- mean(df_acierto$Accuracy)

# Gráfico de barras para la precisión en cada fold
ggplot(df_acierto, aes(x = rownames(df_acierto), y = Accuracy)) +
  geom_bar(stat = "identity", fill = "skyblue", color = "black") +
  geom_hline(yintercept = mean_accuracy, color = "red", linetype = "dashed") +
  labs(title = "Precisión en cada Fold de la Validación Cruzada",
       x = "Fold",
       y = "Precisión (Accuracy)") +
  theme_minimal() +
  annotate("text", x = 1, y = mean_accuracy + 0.02, 
           label = paste("Precisión Promedio:", round(mean_accuracy, 3)), color = "red") +
  geom_text(aes(label = sprintf("%.3f", Accuracy)), vjust = -0.5) +
  scale_x_discrete(labels = rownames(df_acierto))

# Gráfico interactivo con Plotly
library(plotly)
fig <- plot_ly(df_acierto, x = ~rownames(df_acierto), y = ~Accuracy, type = 'bar', name = 'Accuracy per Fold',
               text = ~sprintf("%.3f", Accuracy), textposition = 'outside') %>%
  add_trace(y = ~rep(mean_accuracy, nrow(df_acierto)), type = 'scatter', mode = 'lines', 
            line = list(color = 'red', dash = 'dash'), name = 'Mean Accuracy') %>%
  layout(
    title = "Precisión en cada Fold de la Validación Cruzada",
    xaxis = list(title = "Fold", tickvals = rownames(df_acierto), ticktext = rownames(df_acierto)),
    yaxis = list(title = "Precisión (Accuracy)"),
    annotations = list(
      x = 1, y = mean_accuracy, text = paste("Precisión Promedio:", round(mean_accuracy, 3)), 
      xref = "x", yref = "y", showarrow = TRUE, arrowhead = 7, ax = 0, ay = -40
    )
  )
fig

# Visualización del árbol de decisión
prp(tree, cex = 0.5, main = "Árbol de Decisión con prp()")
rpart.plot(tree, cex = 0.5, main = "Árbol de Decisión con rpart.plot()")

# Resumen del modelo
summary(tree)
print(tree)




###################
# K-vecinos o KNN #
###################

packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

# Importamos datos Ventas.RData
load("Ventas.RData")
datos = datos

colnames(datos)

# Preparación de datos
datos$US2[datos$US=="Yes"] = 1
datos$US2[datos$US=="No"] = 0
datos$US = NULL

datos$Urban2 = as.numeric(datos$Urban == "Yes")
datos$Urban = NULL

# Convertir ShelveLoc en una variable ordinal y luego a numérico
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)

datos$ventas_altas2[datos$ventas_altas=="Si"] = 1
datos$ventas_altas2[datos$ventas_altas=="No"] = 0
datos$ventas_altas = NULL
datos$ventas_altas2 = as.factor(datos$ventas_altas2)

# Escalamos los datos
datos[, c(1,2,3,4,5,6,7,8,9,10)] = scale(datos[, c(1,2,3,4,5,6,7,8,9,10)])

# Separamos los datos de la clase
label = datos[,11]
datos = datos[,-11]


# Primero, vamos a hacer una particion 80-20
indice = createDataPartition(label, p = 0.8, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]
labeltra = label[ indice]
labeltst = label[-indice]
labeltst=as.data.frame(labeltst)
colnames(labeltst)="ventas_altas"
labeltst$Churn=as.factor(labeltst$ventas_altas)

library(class)
prediccion=knn(datostra, datostst, labeltra, k = 5)
prediccion=as.factor(prediccion)
resultado = confusionMatrix(prediccion, labeltst$Churn)
resultado


# La funcion knn nos puede devolver tambien elementos en los que tiene duda (con un umbral)
prediccion=knn(datostra, datostst, labeltra, k = 10,l=7)
prediccion
resultado = confusionMatrix(prediccion,labeltst$Churn)
resultado

prediccion = as.character(prediccion)
prediccion[is.na(prediccion)]="DUDA"
matriz = table(prediccion, labeltst$Churn)
matriz



##############
# Naive-Bayes#
##############

packages <- c("e1071","caret","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

# Importamos datos Ventas.RData
load("Ventas.RData")
datos = datos

colnames(datos)

# Preparación de datos
datos$US2[datos$US=="Yes"] = 1
datos$US2[datos$US=="No"] = 0
datos$US = NULL

datos$Urban2 = as.numeric(datos$Urban == "Yes")
datos$Urban = NULL

# Convertir ShelveLoc en una variable ordinal y luego a numérico
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)

datos$ventas_altas2[datos$ventas_altas=="Si"] = 1
datos$ventas_altas2[datos$ventas_altas=="No"] = 0
datos$ventas_altas = NULL
datos$ventas_altas2 = as.factor(datos$ventas_altas2)

# Escalamos los datos
datos[, c(1,2,3,4,5,6,7,8,9,10)] = scale(datos[, c(1,2,3,4,5,6,7,8,9,10)])

indice = createDataPartition(datos$ventas_altas2, p = 0.8, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]

library(e1071)
modelo=naiveBayes(ventas_altas2~.,datostra)
modelo
prediccion = predict(modelo, datostst, type="class")
resultado = confusionMatrix(prediccion, datostst$ventas_altas2)
ac_basico = resultado$overall[1]
resultado


#Introducimos la correccion de Laplace

modelo=naiveBayes(ventas_altas2~.,datostra,laplace = 1)
prediccion = predict(modelo, datostst, type="class")
resultado = confusionMatrix(prediccion, datostst$ventas_altas2)
ac_laplace = resultado$overall[1]
resultado

