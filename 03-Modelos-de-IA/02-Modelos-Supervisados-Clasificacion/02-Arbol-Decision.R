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
####################################
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

# Inicializamos listas para almacenar resultados de cada fold
resultados_test <- data.frame(Fold = integer(), Accuracy = numeric(), Sensitivity = numeric(), Specificity = numeric())
resultados_train <- data.frame(Fold = integer(), Accuracy = numeric(), Sensitivity = numeric(), Specificity = numeric())

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
    Fold = i,
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
    Fold = i,
    Accuracy = matriz_train$overall["Accuracy"],
    Sensitivity = matriz_train$byClass["Sensitivity"],
    Specificity = matriz_train$byClass["Specificity"]
  ))
  
  # Imprimir resultados de cada fold para entrenamiento y prueba
  cat("Fold:", i, "\n")
  cat("Datos de prue. - Accuracy:", matriz_test$overall["Accuracy"], 
      "Sensitivity:", matriz_test$byClass["Sensitivity"], 
      "Specificity:", matriz_test$byClass["Specificity"], "\n")
  cat("Datos de entr. - Accuracy:", matriz_train$overall["Accuracy"], 
      "Sensitivity:", matriz_train$byClass["Sensitivity"], 
      "Specificity:", matriz_train$byClass["Specificity"], "\n\n")
}

# Calcular medias de cada métrica en todos los folds
cat("\nResumen de precisión en datos de prueba y entrenamiento:\n")

print("Datos de prueba")
print(resultados_test)
cat("\nPromedio en datos de prueba:\n")
print(colMeans(resultados_test[, -1]))

print("\nDatos de entrenamiento")
print(resultados_train)
cat("\nPromedio en datos de entrenamiento:\n")
print(colMeans(resultados_train[, -1]))


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
datos$Age= NULL
datos$Education= NULL
datos$US2= NULL
datos$Urban2= NULL

# Escalamos los datos
datos[,c(1,2,3,4,6)] = scale(datos[,c(1,2,3,4,6)])

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



#############

# Cargar las librerías necesarias
library(plotly)
library(dplyr)

# Convertimos el vector aciertolog en un data frame para la visualización de precisión
df_acierto <- data.frame(
  Fold = 1:length(aciertolog),
  Accuracy = aciertolog
)

# Calculamos la media de precisión
mean_accuracy <- mean(aciertolog)

# Crear un data frame para la distribución de clases
class_distribution <- datos %>%
  count(ventas_altas2) %>%
  mutate(percentage = n / sum(n) * 100,
         label = ifelse(ventas_altas2 == 1, "Sí", "No"))

# Creamos el gráfico interactivo con Plotly
fig <- plot_ly()

# Agregar gráfico de barras para precisión en cada pliegue
fig <- fig %>% 
  add_trace(data = df_acierto, x = ~Fold, y = ~Accuracy, type = 'bar', name = 'Accuracy per Fold', 
            marker = list(color = 'skyblue')) %>%
  add_trace(y = ~rep(mean_accuracy, length(aciertolog)), type = 'scatter', mode = 'lines', 
            line = list(color = 'red', dash = 'dash'), name = 'Mean Accuracy') %>%
  layout(
    title = "Precisión en cada Fold de la Validación Cruzada y Distribución de Clases",
    xaxis = list(title = "Fold"),
    yaxis = list(title = "Precisión (Accuracy)"),
    annotations = list(
      x = 1, y = mean_accuracy, text = paste("Precisión Promedio:", round(mean_accuracy, 3)), 
      xref = "x", yref = "y", showarrow = TRUE, arrowhead = 7, ax = 0, ay = -40
    )
  )

# Agregar gráfico de pastel (pie) para distribución de clases
fig <- fig %>%
  add_pie(data = class_distribution, labels = ~label, values = ~percentage, 
          textinfo = 'label+percent', domain = list(x = c(0.8, 1), y = c(0.2, 0.8)), 
          name = "Distribución de Clases") %>%
  layout(
    showlegend = TRUE
  )

# Mostrar el gráfico
fig



# PARA ESCALADO
# utilizamos scale, y también data.normalization

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


