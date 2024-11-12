rm(list=ls())

# Paso 1: Preparar los Datos
# Cargar los datos y hacer las transformaciones que has mencionado
datos = read.csv("churn.csv", stringsAsFactors = TRUE)
datos$Churn2[datos$Churn == "False."] <- 0
datos$Churn2[datos$Churn == "True."] <- 1
datos$Churn <- NULL
datos$Churn2 <- as.factor(datos$Churn2)

datos$Int.l.Plan2[datos$Int.l.Plan == "no"] <- 0
datos$Int.l.Plan2[datos$Int.l.Plan == "yes"] <- 1
datos$Int.l.Plan <- NULL

datos$VMail.Plan <- as.numeric(datos$VMail.Plan == "yes")

# Eliminar variables no necesarias
datos$State <- NULL
datos$Area.Code <- NULL
datos$Phone <- NULL
datos$Account.Length <- NULL


# Paso 2: Dividir los Datos en Conjunto de Entrenamiento y Prueba

library(caret)
set.seed(123)
trainIndex <- createDataPartition(datos$Churn2, p = 0.7, list = FALSE)
datosTrain <- datos[trainIndex, ]
datosTest <- datos[-trainIndex, ]


# Paso 3: Crear el Modelo Completo y Realizar ANOVA

# Crear el modelo completo
modelo_completo <- glm(Churn2 ~ ., data = datosTrain, family = binomial)

# Realizar una prueba ANOVA para evaluar la significancia de las variables
anova_resultados <- anova(modelo_completo, test = "Chisq")
print(anova_resultados)


# Paso 4: Eliminar Variables No Significativas y Ajustar el Modelo
# Supongamos que "variableX" es una variable no significativa
modelo_reducido <- glm(Churn2 ~ VMail.Message+Day.Mins+Intl.Mins+Intl.Calls+CustServ.Calls+Int.l.Plan2, data = datosTrain, family = binomial)
anova(modelo_completo, modelo_reducido, test = "Chisq")


# Paso 5: Evaluar el Modelo Final en el Conjunto de Prueba
# Hacer predicciones con el modelo optimizado
predicciones <- predict(modelo_reducido, newdata = datosTest, type = "response")
datosTest$prediccion <- ifelse(predicciones > 0.5, 1, 0)
datosTest$prediccion <- as.factor(datosTest$prediccion)

# Evaluar el modelo
confusionMatrix(datosTest$prediccion, datosTest$Churn2)

modelo_reducido
summary(regresionlog)
confusionMatrix(datostst$prediccionlog, datostst$Churn) 
aciertolog # Nos devuelve los 5 accuracies de cada fold de la VALIDACIÓN CRUZADA
mean(aciertolog)

table(datos$Churn2)
sum((datos$Churn2=="0"))/nrow(datos)


