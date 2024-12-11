########################################################
#                                                      #
#           House Prices — CEBANC-REGRESION            #
#                                                      #
########################################################

library(RcmdrMisc)
library(car)
library(pROC)
library(caret)
library(ggplot2)
library(dplyr)
# library(mice)

# Limpiar el entorno de trabajo
rm(list=ls())

# Cargamos los datos
train = read.csv("train.csv")
test = read.csv("test.csv")
full_data = bind_rows(train, test) # bind_rows(), library(dplyr)

###############################################################
#                                                             #
#     EXPLORACIÓN GENERAL de los datos del conjunto Boston    #
#                                                             #
###############################################################

# Paso 1: Resumen general del conjunto de datos

# Dimensiones del conjunto de datos
# El marco de datos Boston tiene 506 filas y 14 columnas.
cat("Número de filas:", nrow(full_data), "filas\n")
cat("Número de columnas:", ncol(full_data), "columnas\n")

# Vista general de las primeras filas
head(full_data, 3)

# Resumen estadístico básico
summary(full_data)

# Tipos de variables
str(full_data)


# Paso 2: Análisis de valores faltantes
# Comprobamos si hay valores faltantes
cat("¿Hay valores faltantes en el conjunto de datos?\n")
sapply(full_data, function(x) sum(is.na(x)))

# Porcentaje de valores faltantes (si existen)
sapply(full_data, function(x) mean(is.na(x))) * 100



# Seleccionar solo columnas numéricas
numeric_columns <- sapply(full_data, is.numeric)
df_numeric <- full_data[, numeric_columns]

# Mostrar las columnas seleccionadas
print(df_numeric)

# Matriz de correlación
cor_matrix <- cor(df_numeric)
round(cor_matrix, 2)

# Visualización de la matriz de correlación
library(corrplot)
corrplot(cor_matrix, method = "color", type = "upper", tl.cex = 0.7)



##################################################################
#                                                                #
#     Exploración PARTICULAR de los datos del conjunto Boston    #
#                                                                #
##################################################################

# Análisis de cada variable

# Distribución de cada variable
library(ggplot2)

# Histogramas de las variables
library(reshape2)
datos_melt <- melt(full_data)
ggplot(datos_melt, aes(x = value)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(title = "Histogramas de las variables", x = "Valores", y = "Frecuencia")



# Histograma con R base
hist(full_data$LotArea,
     breaks = 30,  # Número de bins
     col = "blue",
     main = "Distribución de LotArea",
     xlab = "LotArea",
     ylab = "Frecuencia")


# Identificación de outliers con boxplots
boxplot.stats(full_data$SalePrice)$out
boxplot(full_data$SalePrice, main = "Boxplot de SalePrice", col = "lightblue")


# Cargar los datos (ajusta la ruta según tu archivo)
data <- full_data 

# Eliminar filas con valores faltantes en 'LotFrontage' y 'SalePrice'
data_clean <- na.omit(data[, c("LotFrontage", "SalePrice")])

# Calcular la correlación
correlation <- cor(data_clean$LotFrontage, data_clean$SalePrice)

# Imprimir el resultado
print(paste("La correlación entre LotFrontage y SalePrice es:", correlation))

cor(data_clean$LotFrontage, data_clean$SalePrice)
cor(data_clean$LotFrontage, data_clean$SalePrice, method = "kendall")
cor(data_clean$LotFrontage, data_clean$SalePrice, method = "spearman")




# Histograma con R base
hist(train$LotFrontage,
     breaks = 30,  # Número de bins
     col = "blue",
     main = "Distribución de LotFrontage",
     xlab = "LotFrontage",
     ylab = "Frecuencia")


# Identificación de outliers con boxplots
boxplot.stats(train$LotFrontage)$out
boxplot(train$LotFrontage, main = "Boxplot de LotFrontage", col = "lightblue")


# # Cálculo del rango intercuartílico (IQR)
# Q1 <- quantile(data_clean$LotFrontage, 0.25)
# Q3 <- quantile(data_clean$LotFrontage, 0.75)
# IQR <- Q3 - Q1
# 
# # Límites para detectar outliers
# lower_bound <- Q1 - 1.5 * IQR
# upper_bound <- Q3 + 1.5 * IQR
# 
# # Identificar outliers
# outliers <- data_clean$LotFrontage[data_clean$LotFrontage < lower_bound | data_clean$LotFrontage > upper_bound]
# print(outliers)
# 
# # Filtrar datos sin outliers
# data_no_outliers <- data_clean[data_clean$LotFrontage >= lower_bound & data_clean$LotFrontage <= upper_bound, ]
# 
# # Correlación sin outliers
# cor_no_outliers <- cor(data_no_outliers$LotFrontage, data_no_outliers$SalePrice)
# print(paste("Correlación sin outliers (Pearson):", cor_no_outliers))
# 
# 
# # Identificación de outliers con boxplots
# boxplot.stats(data_no_outliers$LotFrontage)$out
# boxplot(data_no_outliers$LotFrontage, main = "Boxplot de LotFrontage", col = "lightblue")
# 
# boxplot.stats(train$SalePrice)$out
# boxplot(train$SalePrice, main = "Boxplot de SalePrice", col = "lightblue")
# 
# cor(data_no_outliers$LotFrontage, data_no_outliers$SalePrice)
# cor(data_no_outliers$LotFrontage, data_no_outliers$SalePrice, method = "kendall")
# cor(data_no_outliers$LotFrontage, data_no_outliers$SalePrice, method = "spearman")



##################################################################
#                                                                #
#          LIMPIEZA y TRANSFORMACIÓN de los datos                #
#                                                                #
##################################################################

# PASO 1 :: Convertir variables categóricas (como character) a factor

# Función para convertir varaibles categóricas (como character) a factor
convert_to_factors <- function(data) {
  # Convertir columnas tipo character a factor
  data[] <- lapply(data, function(col) {
    if (is.character(col)) {
      return(as.factor(col))
    } else {
      return(col)
    }
  })
  return(data)
}

# Convertir las variables categóricas (como character) a factor
full_data <- convert_to_factors(full_data)
str(full_data)  # Verifica que 'name' y 'gender' sean ahora factores

# Niveles de la variable MSZoning
levels(train$MSZoning)


### Corrección de NAs que corresponden a una categoría

# Comprobamos si hay valores faltantes
cat("¿Hay valores faltantes en el conjunto de datos?\n")
sapply(full_data, function(x) sum(is.na(x)))

# Porcentaje de valores faltantes (si existen)
sapply(full_data, function(x) mean(is.na(x))) * 100


#############################
# Proporción de NAs en Alley
table(is.na(full_data$Alley))

# Convertir a character
full_data$Alley <- as.character(full_data$Alley)

# Reemplazar los NAs por "No alley access"
full_data$Alley[is.na(full_data$Alley)] <- "No alley access"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
full_data$Alley <- as.factor(full_data$Alley)


################################
# Proporción de NAs en BsmtQual
table(is.na(full_data$BsmtQual))

################################
# Proporción de NAs en BsmtCond
table(is.na(full_data$BsmtCond))

################################
# Proporción de NAs en BsmtCond
table(is.na(full_data$BsmtExposure))

################################
# Proporción de NAs en BsmtCond
table(is.na(full_data$BsmtFinType1))


# Reemplazar NAs por "No Basement" en varias columnas
# # Lista de columnas a modificar
basement_columns = c("BsmtQual", "BsmtCond", "BsmtExposure", "BsmtFinType1", "BsmtFinType2")

for (col in basement_columns) {
  # Convertir a character si es factor (evitar errores)
  full_data[[col]] =as.character(full_data[[col]])
  
  # Reemplazar NAs por "No Basement
  full_data[[col]][is.na(full_data[[col]])] = "No Basement"
  
  # (Opcional) Convertir nuevamente a factor si lo necesitas como tal
  full_data[[col]] = as.factor(full_data[[col]])
  
}


################################
# Proporción de NAs en FireplaceQu
table(is.na(full_data$FireplaceQu))

# Convertir a character
full_data$FireplaceQu <- as.character(full_data$FireplaceQu)

# Reemplazar los NAs por "No alley access"
full_data$FireplaceQu[is.na(full_data$FireplaceQu)] <- "No Fireplace"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
full_data$FireplaceQu <- as.factor(full_data$FireplaceQu)


################################
# Proporción de NAs en GarageType
table(is.na(full_data$GarageType))
################################
# Proporción de NAs en GarageFinish
table(is.na(full_data$GarageFinish))
################################
# Proporción de NAs en GarageQual
table(is.na(full_data$GarageQual))
################################
# Proporción de NAs en GarageCond
table(is.na(full_data$GarageCond))

# Reemplazar NAs por "No Garage" en varias columnas
# # Lista de columnas a modificar
no_garage_columns = c("GarageType", "GarageFinish", "GarageQual", "GarageCond")


for (col in no_garage_columns) {
  # Convertir a character si es factor (evitar errores)
  full_data[[col]] =as.character(full_data[[col]])
  
  # Reemplazar NAs por "No Basement
  full_data[[col]][is.na(full_data[[col]])] = "No Garage"
  
  # (Opcional) Convertir nuevamente a factor si lo necesitas como tal
  full_data[[col]] = as.factor(full_data[[col]])
  
}

################################
# Proporción de NAs en PoolQC
table(is.na(full_data$PoolQC))

# Convertir a character
full_data$PoolQC <- as.character(full_data$PoolQC)

# Reemplazar los NAs por "No alley access"
full_data$PoolQC[is.na(full_data$PoolQC)] <- "No Pool"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
full_data$PoolQC <- as.factor(full_data$PoolQC)


################################
# Proporción de NAs en Fence
table(is.na(full_data$Fence))

# Convertir a character
full_data$Fence <- as.character(full_data$Fence)

# Reemplazar los NAs por "No alley access"
full_data$Fence[is.na(full_data$Fence)] <- "No Fence"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
full_data$Fence <- as.factor(full_data$Fence)


################################
# Proporción de NAs en MiscFeature
table(is.na(full_data$MiscFeature))

# Convertir a character
full_data$MiscFeature <- as.character(full_data$MiscFeature)

# Reemplazar los NAs por "No alley access"
full_data$MiscFeature[is.na(full_data$MiscFeature)] <- "None"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
full_data$MiscFeature <- as.factor(full_data$MiscFeature)


################################
# Proporción de NAs en Electrical
table(is.na(full_data$Electrical))

# ANOVA
anova_result <- aov(SalePrice ~ Electrical, data = full_data)
summary(anova_result)

# Comparación post-hoc
tukey_result <- TukeyHSD(aov(SalePrice ~ Electrical, data = full_data))
print(tukey_result)

# Boxplot
boxplot(SalePrice ~ Electrical, data = full_data, main = "SalePrice por categoría de Electrical", xlab = "Electrical", ylab = "SalePrice")

# Tabla de contingencia
table(full_data$Electrical, full_data$Neighborhood)

# Gráfico de mosaico (para visualizar relaciones entre dos VARIABLES CATEGÓRICAS)
mosaicplot(table(full_data$Electrical, full_data$Neighborhood), main = "Relación entre Electrical y Neighborhood", color = TRUE)


# Imputar el valor perdido de Electrical mediante un árbol de regresión
library(rpart)

# Crear un modelo para predecir Electrical (ignorando el NA temporalmente)
train_no_na <- full_data[!is.na(full_data$Electrical), ]
model <- rpart(Electrical ~ SalePrice + YearBuilt + Neighborhood, data = train_no_na, method = "class")

summary(model)

# Predecir el valor del NA
predicted_value <- predict(model, full_data[is.na(full_data$Electrical), ], type = "class")

# Reemplazar el NA con el valor predicho
full_data$Electrical[is.na(full_data$Electrical)] <- as.character(predicted_value)



garageYrBlt = full_data[is.na(full_data$GarageYrBlt), ]
garageYrBlt
# Reemplazar NA con 0 para indicar "Sin Garaje"
full_data$GarageYrBlt[is.na(full_data$GarageYrBlt)] <- 0


correlation <- cor(full_data$LotFrontage, full_data$LotArea, use = "complete.obs")
print(correlation)

library(ggplot2)

ggplot(full_data, aes(x = LotArea, y = LotFrontage)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relación entre LotArea y LotFrontage", x = "LotArea", y = "LotFrontage")

ggplot(full_data, aes(x = Neighborhood, y = LotFrontage)) +
  geom_boxplot(fill = "orange", outlier.color = "red") +
  labs(title = "Distribución de LotFrontage por Neighborhood", x = "Neighborhood", y = "LotFrontage") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))




garageYrBlt = full_data[is.na(full_data$GarageYrBlt), ]
garageYrBlt
# Reemplazar NA con 0 para indicar "Sin Garaje"
full_data$GarageYrBlt[is.na(full_data$GarageYrBlt)] <- 0

# Reemplazar NA con 0 para indicar "Sin Coches"
full_data$GarageCars[is.na(full_data$GarageCars)] <- 0

# Reemplazar NA con 0 para indicar "Sin Area de Garaje"
full_data$GarageArea[is.na(full_data$GarageArea)] <- 0



MSZoningNaData = full_data[is.na(full_data$GarageYrBlt), ]
MSZoningNaData

# Tabla cruzada de MSZoning y Neighborhood
table(test$MSZoning, test$Neighborhood)

# Distribución de MSZoning según BldgType
table(test$MSZoning, test$BldgType)


# Tabla cruzada de MSZoning y Neighborhood
table(test$BldgType, test$Neighborhood)


################################
# Proporción de NAs en FireplaceQu
table(is.na(full_data$FireplaceQu))

# Convertir a character
full_data$FireplaceQu <- as.character(full_data$FireplaceQu)

# Reemplazar los NAs por "No alley access"
full_data$FireplaceQu[is.na(full_data$FireplaceQu)] <- "No Fireplace"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
full_data$FireplaceQu <- as.factor(full_data$FireplaceQu)


# Renombrar la categoría "C (all)" a "C"
levels(full_data$MSZoning)[levels(full_data$MSZoning) == "C (all)"] <- "C"

# Verificar cambios
levels(full_data$MSZoning)
table(full_data$MSZoning)


# Verificar cambios
table(full_data$MSZoning)





# Filtrar las filas con y sin NA en MSZoning
mszoning_complete <- full_data[!is.na(full_data$MSZoning), ]
mszoning_na <- full_data[is.na(full_data$MSZoning), ]

# Verificar cuántos valores faltan
cat("Valores faltantes en MSZoning:", nrow(mszoning_na), "\n")

# Seleccionar variables potencialmente relacionadas
variables_relevantes <- c("Neighborhood", "LotArea", "LotFrontage", "OverallQual", "SalePrice")
mszoning_complete <- mszoning_complete[, c(variables_relevantes, "MSZoning")]
mszoning_na <- mszoning_na[, variables_relevantes]

library(rpart)

# Entrenar el modelo con los datos completos
modelo_mszoning <- rpart(MSZoning ~ ., data = mszoning_complete, method = "class")

# Resumen del modelo
summary(modelo_mszoning)


# Predecir las categorías para los valores faltantes
predicciones_mszoning <- predict(modelo_mszoning, mszoning_na, type = "class")

# Asignar las predicciones a las filas originales
full_data$MSZoning[is.na(full_data$MSZoning)] <- predicciones_mszoning

# Verificar si quedan valores faltantes
cat("Valores faltantes en MSZoning después de la imputación:", sum(is.na(full_data$MSZoning)), "\n")


# Comprobar las predicciones
table(full_data$MSZoning[is.na(full_data$MSZoning)], predicciones_mszoning)

# Visualizar el árbol de decisión
library(rpart.plot)
rpart.plot(modelo_mszoning)




# MSZoning = full_data[is.na(full_data$MSZoning), ]
# MSZoning
# # Reemplazar NA por "RL"
# full_data$MSZoning[is.na(full_data$MSZoning)] <- "RL"




# Convertir las variables categóricas (como character) a factor
test <- convert_to_factors(test)
str(train)  # Verifica que 'name' y 'gender' sean ahora factores

# Niveles de la variable MSZoning
levels(full_data$MSZoning)



# Comprobamos si hay valores faltantes
cat("¿Hay valores faltantes en el conjunto de datos?\n")
cat("Datos TRAIN")
sapply(train, function(x) sum(is.na(x)))
sapply(test, function(x) sum(is.na(x)))
cat("Datos TEST")
sapply(full_data, function(x) sum(is.na(x)))

test[is.na(test$GarageCars),]
# Filtrar filas donde GarageCars es NA
rows_with_na <- test[is.na(test$GarageCars), ]
print(rows_with_na)


# Porcentaje de valores faltantes (si existen)
cat("Datos TRAIN")
sapply(train, function(x) mean(is.na(x))) * 100
cat("Datos TEST")
sapply(test, function(x) mean(is.na(x))) * 100

summary(test)


###########################################################################
###########################################################################
###########################################################################
###########################################################################
###########################################################################
###########################################################################
###########################################################################
###########################################################################





###################
# VALORES PERDIDOS

check_missing_values <- function(data) {
  # Identificar columnas con NAs
  na_counts <- sapply(data, function(col) sum(is.na(col)))
  
  # Calcular porcentaje de NAs
  na_percentage <- (na_counts / nrow(data)) * 100
  
  # Calcular mediana y moda para las columnas con NAs
  median_values <- sapply(data, function(col) {
    if (is.numeric(col)) {
      return(median(col, na.rm = TRUE)) # Mediana ignorando NAs
    } else {
      return(NA) # No aplicable para variables no numéricas
    }
  })
  
  mode_values <- sapply(data, function(col) {
    if (is.factor(col) || is.character(col)) {
      # Calcular moda para variables categóricas
      unique_vals <- unique(na.omit(col))
      if (length(unique_vals) == 0) {
        return(NA)
      }
      return(unique_vals[which.max(tabulate(match(col, unique_vals)))])
    } else if (is.numeric(col)) {
      # Calcular moda para variables numéricas
      unique_vals <- unique(na.omit(col))
      return(unique_vals[which.max(tabulate(match(col, unique_vals)))])
    } else {
      return(NA)
    }
  })
  
  # Crear un dataframe con los resultados
  na_summary <- data.frame(
    Variable = names(na_counts),
    NAs = na_counts,
    Percentage = round(na_percentage, 2),
    Median = median_values,
    Mode = mode_values
  )
  
  # Filtrar solo las columnas con NAs
  na_summary <- na_summary[na_summary$NAs > 0, ]
  
  return(na_summary)
}



# Identificar variables con NAs y sus porcentajes
missing_summary <- check_missing_values(full_data)
print(missing_summary)





# Función de limpieza (preservamos SalePrice)
clean_data <- function(data, na_threshold = 20, target_column = NULL) {
  # Si se proporciona una columna objetivo, exclúyela temporalmente del proceso de limpieza
  if (!is.null(target_column)) {
    target_values <- data[[target_column]]  # Guardar los valores de la columna objetivo
    data[[target_column]] <- NULL          # Eliminar la columna temporalmente
  }
  
  # Paso 1: Calcular porcentaje de NAs
  na_percentage <- sapply(data, function(col) mean(is.na(col)) * 100)
  
  # Paso 2: Eliminar variables con más del umbral de NAs
  data <- data[, na_percentage <= na_threshold]
  
  # Paso 3: Imputar valores faltantes en las variables restantes
  data <- data %>%
    mutate(across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .))) %>%
    mutate(across(where(is.factor), ~ {
      if (any(is.na(.))) {
        moda <- names(sort(table(., useNA = "no"), decreasing = TRUE))[1]
        return(ifelse(is.na(.), moda, as.character(.)))
      } else {
        return(.)
      }
    }))
  
  # Reinsertar la columna objetivo si existía
  if (!is.null(target_column)) {
    data[[target_column]] <- target_values
  }
  
  return(data)
}

# Aplicar la función asegurando que 'SalePrice' no se elimina
full_data_clean <- clean_data(full_data, na_threshold = 20, target_column = "SalePrice")

# Verificar si quedan valores faltantes
colSums(is.na(full_data_clean))

# Separar los datos de nuevo en train y test
train_clean <- full_data_clean[1:nrow(train), ]
test_clean <- full_data_clean[(nrow(train) + 1):nrow(full_data), ]

# Verificar si la columna SalePrice está presente
cat("Columnas en train_clean:", colnames(train_clean), "\n")
cat("Columnas en test_clean:", colnames(test_clean), "\n")

# Verificar las dimensiones
cat("Dimensiones del conjunto de entrenamiento (train_clean):", dim(train_clean), "\n")
cat("Dimensiones del conjunto de prueba (test_clean):", dim(test_clean), "\n")



# RegModel.1 <- lm(SalePrice ~ . , data=train_clean)
# summary(RegModel.1)



# Cargar el paquete necesario
library(MASS)

# Paso 1: Crear un modelo inicial con todas las variables
RegModel.1 <- lm(SalePrice ~ ., data = train_clean)

# Paso 2: Aplicar stepwise regression
stepwise_model <- stepAIC(
  RegModel.1,
  direction = "both",  # Alternativas: "forward" o "backward"
  trace = TRUE         # Mostrar el proceso paso a paso
)

# Paso 3: Ver el resumen del modelo final seleccionado
summary(stepwise_model)

# Paso 4: Ver las variables seleccionadas por el modelo stepwise
cat("Variables seleccionadas por stepwise regression:\n")
print(names(stepwise_model$coefficients))

# Paso 5: Verificar que no haya valores faltantes en train_clean y test_clean
cat("Valores faltantes en train_clean:\n")
colSums(is.na(train_clean))
cat("Valores faltantes en test_clean:\n")
colSums(is.na(test_clean))

# Paso 6: Realizar predicciones en el conjunto de test_clean
predictions <- predict(stepwise_model, newdata = test_clean)

# Paso 7: Verificar las predicciones realizadas
head(predictions)

# Paso 8: Crear un archivo de salida para Kaggle
submission <- data.frame(Id = test$Id, SalePrice = predictions)
file = "submission_lm_1129_03_.csv"
write.csv(submission, file, row.names = FALSE)

cat("Archivo de predicciones guardado como", file,"\n")



######################################

# install.packages("/Users/egoitzaulestiapadilla/Downloads/catboost", repos = NULL, type = "source")


library(catboost)
library(dplyr)

# Paso 1: Asegurar que las variables categóricas estén correctamente convertidas a factores
convert_to_factors <- function(data) {
  data[] <- lapply(data, function(col) {
    if (is.character(col)) {
      return(as.factor(col))
    } else {
      return(col)
    }
  })
  return(data)
}

# Convertir las variables categóricas a factores
train_clean <- convert_to_factors(train_clean)
test_clean <- convert_to_factors(test_clean)

# Identificar columnas categóricas (por su índice)
categorical_features <- which(sapply(train_clean, is.factor))

# Paso 2: Crear el Pool de entrenamiento
train_pool <- catboost.load_pool(
  data = train_clean[, -which(names(train_clean) == "SalePrice")], 
  label = train_clean$SalePrice
)

# Confirmar que el Pool de entrenamiento se creó correctamente
print(train_pool)

# Paso 3: Crear el Pool de prueba (no necesita etiquetas)
test_pool <- catboost.load_pool(
  data = test_clean
)

# Confirmar que el Pool de prueba se creó correctamente
print(test_pool)

# Paso 4: Definir los parámetros del modelo
params <- list(
  iterations = 1000,           # Número de iteraciones
  learning_rate = 0.1,         # Tasa de aprendizaje
  depth = 6,                   # Profundidad máxima de los árboles
  loss_function = "RMSE",      # Función de pérdida (en este caso para regresión)
  eval_metric = "RMSE",        # Métrica de evaluación
  random_seed = 42             # Semilla aleatoria para reproducibilidad
)

# Paso 5: Entrenar el modelo
catboost_model <- catboost.train(
  learn_pool = train_pool,
  params = params
)

# Confirmar que el modelo se entrenó correctamente
print(catboost_model)

# Paso 6: Realizar predicciones en el conjunto de prueba
predictions <- catboost.predict(catboost_model, test_pool)

# Paso 7: Guardar las predicciones en un archivo CSV
submission <- data.frame(Id = test$Id, SalePrice = predictions)
write.csv(submission, "catboost_submission_1129_05.csv", row.names = FALSE)





##################################



library(catboost)
library(dplyr)
library(caret)

# Paso 1: Asegurar que las variables categóricas estén correctamente convertidas a factores
convert_to_factors <- function(data) {
  data[] <- lapply(data, function(col) {
    if (is.character(col)) {
      return(as.factor(col))
    } else {
      return(col)
    }
  })
  return(data)
}

train_clean <- convert_to_factors(train_clean)
test_clean <- convert_to_factors(test_clean)

# Identificar columnas categóricas (por su índice)
categorical_features <- which(sapply(train_clean, is.factor))

# Paso 2: Escalado de las variables numéricas (excluyendo SalePrice)
scale_numeric <- function(data, exclude_col) {
  numeric_cols <- which(sapply(data, is.numeric))
  numeric_cols <- numeric_cols[names(data)[numeric_cols] != exclude_col]  # Excluir columna objetivo
  data[numeric_cols] <- scale(data[numeric_cols])
  return(data)
}

# Guardar media y desviación estándar de SalePrice
saleprice_mean <- mean(train_clean$SalePrice)
saleprice_sd <- sd(train_clean$SalePrice)

# Escalar SalePrice en el conjunto de entrenamiento
train_clean$SalePrice <- scale(train_clean$SalePrice, center = saleprice_mean, scale = saleprice_sd)

# Escalar otras variables numéricas
train_clean <- scale_numeric(train_clean, exclude_col = "SalePrice")
test_clean <- scale_numeric(test_clean, exclude_col = NULL)

# Nota: No es estrictamente necesario escalar las variables numéricas para CatBoost,
# ya que maneja valores numéricos automáticamente. Sin embargo, puede ayudar con interpretabilidad.

# Paso 3: Dummies para las variables categóricas
# No es necesario para CatBoost, ya que maneja automáticamente las variables categóricas
# Si se usa otro modelo que no sea CatBoost, puedes descomentar la siguiente línea:
# train_clean <- model.matrix(~ . - 1, data = train_clean)
# test_clean <- model.matrix(~ . - 1, data = test_clean)

# Paso 4: Crear el Pool de entrenamiento
train_pool <- catboost.load_pool(
  data = train_clean[, -which(names(train_clean) == "SalePrice")], 
  label = train_clean$SalePrice
)

# Confirmar que el Pool de entrenamiento se creó correctamente
print(train_pool)

# Paso 5: Crear el Pool de prueba (no necesita etiquetas)
test_pool <- catboost.load_pool(
  data = test_clean,
)

# Confirmar que el Pool de prueba se creó correctamente
print(test_pool)

# Paso 6: Cross-validation (Validación cruzada)
params <- list(
  # iterations = 1000,
  iterations = 626,            # Número de iteraciones
  learning_rate = 0.1,         # Tasa de aprendizaje
  depth = 6,                   # Profundidad máxima de los árboles
  loss_function = "RMSE",      # Función de pérdida (en este caso para regresión)
  eval_metric = "RMSE",        # Métrica de evaluación
  random_seed = 42             # Semilla aleatoria para reproducibilidad
)

cv_results <- catboost.cv(
  pool = train_pool,
  params = params,
  fold_count = 5,  # 5-fold cross-validation
  type = "Classical"
)

# Ver resultados del cross-validation
print(cv_results)

# Identificar la iteración con el menor error en el conjunto de validación
best_iteration <- which.min(cv_results$test.RMSE.mean)

# Extraer el valor mínimo de la métrica
best_rmse <- min(cv_results$test.RMSE.mean)

# Imprimir los resultados
cat("Mejor iteración:", best_iteration, "\n")
cat("Mejor RMSE (validación):", best_rmse, "\n")


params$iterations <- 625

# Paso 7: Entrenar el modelo (después de validar los hiperparámetros)
catboost_model <- catboost.train(
  learn_pool = train_pool,
  params = params
)

# Confirmar que el modelo se entrenó correctamente
print(catboost_model)

# Paso 8: Métricas de rendimiento en train y test
# Predicciones en el conjunto de entrenamiento
train_predictions <- catboost.predict(catboost_model, train_pool)

# RMSE en train
train_rmse <- sqrt(mean((train_clean$SalePrice - train_predictions)^2))
print(paste("RMSE en conjunto de entrenamiento:", train_rmse))

# Predicciones en el conjunto de prueba
test_predictions <- catboost.predict(catboost_model, test_pool)

# Nota: No podemos calcular RMSE en el conjunto de prueba si no tenemos etiquetas reales.

# Paso 9: Grid Search para optimizar hiperparámetros
# grid_params <- expand.grid(
#   depth = c(4, 6, 8), 
#   learning_rate = c(0.01, 0.05, 0.1),
#   iterations = c(500, 1000)
# )

# grid_params <- expand.grid(
#   depth = c(4, 6, 8),
#   learning_rate = c(0.01, 0.05),
#   iterations = c(500)
# )

# grid_params <- expand.grid(
#   depth = c(4, 6, 8),
#   learning_rate = c(0.01),
#   iterations = c(1500)
# )

grid_params <- expand.grid(
  depth = c(4, 6),
  learning_rate = c(0.01),
  iterations = c(600)
)

best_rmse <- Inf
best_params <- NULL

for (i in 1:nrow(grid_params)) {
  params <- list(
    iterations = grid_params$iterations[i],
    learning_rate = grid_params$learning_rate[i],
    depth = grid_params$depth[i],
    loss_function = "RMSE",
    eval_metric = "RMSE",
    random_seed = 42,
    thread_count = 4  # Usar 4 hilos para paralelización
  )
  
  # Validación cruzada con los parámetros actuales
  cv_results <- catboost.cv(
    pool = train_pool,
    params = params,
    fold_count = 5,
    type = "Classical"
  )
  
  # Guardar los mejores parámetros
  current_rmse <- min(cv_results$test.RMSE.mean)
  if (current_rmse < best_rmse) {
    best_rmse <- current_rmse
    best_params <- params
  }
}

# Imprimir los mejores hiperparámetros
print(best_params)

# Actualizar las iteraciones con el mejor valor encontrado
best_params$iterations <- 599

# Paso 10: Entrenar el modelo final con los mejores parámetros
catboost_model <- catboost.train(
  learn_pool = train_pool,
  params = best_params
)

# Paso 11: Realizar predicciones en el conjunto de prueba
predictions <- catboost.predict(catboost_model, test_pool)

# Paso 12: Guardar las predicciones en un archivo CSV
submission <- data.frame(Id = test$Id, SalePrice = predictions)
write.csv(submission, "catboost_submission_1130_06.csv", row.names = FALSE)



###########################################

library(catboost)
library(dplyr)
library(caret)

# Paso 1: Asegurar que las variables categóricas estén correctamente convertidas a factores
convert_to_factors <- function(data) {
  data[] <- lapply(data, function(col) {
    if (is.character(col)) {
      return(as.factor(col))
    } else {
      return(col)
    }
  })
  return(data)
}

train_clean <- convert_to_factors(train_clean)
test_clean <- convert_to_factors(test_clean)

# Identificar columnas categóricas (por su índice)
categorical_features <- which(sapply(train_clean, is.factor))


# Paso 3: Crear el Pool de entrenamiento y prueba
train_pool <- catboost.load_pool(
  data = train_clean[, -which(names(train_clean) == "SalePrice")], 
  label = train_clean$SalePrice
)

test_pool <- catboost.load_pool(
  data = test_clean
)

# Paso 4: Entrenar el modelo
params <- list(
  iterations = 455,           # Mejor iteración encontrada
  learning_rate = 0.05,       # Mejor tasa de aprendizaje
  depth = 6,                  # Mejor profundidad
  loss_function = "RMSE",     
  eval_metric = "RMSE",       
  random_seed = 42           
)

catboost_model <- catboost.train(
  learn_pool = train_pool,
  params = params
)

# Paso 5: Realizar predicciones
predictions <- catboost.predict(catboost_model, test_pool)


# Paso 6: Guardar las predicciones en un archivo CSV
submission <- data.frame(Id = test$Id, SalePrice = predictions)
write.csv(submission, "catboost_submission_1130_11.csv", row.names = FALSE)




########################################################################



# Separar los datos de nuevo en train y test
train_clean <- full_data_clean[1:nrow(train), ]
test_clean <- full_data_clean[(nrow(train) + 1):nrow(full_data), ]

library(catboost)
library(dplyr)
library(caret)

# Paso 1: Asegurar que las variables categóricas estén correctamente convertidas a factores
convert_to_factors <- function(data) {
  data[] <- lapply(data, function(col) {
    if (is.character(col)) {
      return(as.factor(col))
    } else {
      return(col)
    }
  })
  return(data)
}

train_clean <- convert_to_factors(train_clean)
test_clean <- convert_to_factors(test_clean)

# Identificar columnas categóricas (por su índice)
categorical_features <- which(sapply(train_clean, is.factor))

# Paso 2: Crear el Pool de entrenamiento inicial
train_pool <- catboost.load_pool(
  data = train_clean[, -which(names(train_clean) == "SalePrice")], 
  label = train_clean$SalePrice
)

# Paso 3: Entrenar un modelo preliminar para calcular la importancia de características
# params <- list(
#   iterations = 100,           # Usamos menos iteraciones para un entrenamiento rápido
#   learning_rate = 0.1,        # Tasa de aprendizaje más alta para converger rápidamente
#   depth = 6,                  # Profundidad estándar
#   loss_function = "RMSE",     
#   eval_metric = "RMSE",       
#   random_seed = 42           
# )

params <- list(
  iterations = 1000,           # Número de iteraciones
  learning_rate = 0.1,         # Tasa de aprendizaje
  depth = 6,                   # Profundidad máxima de los árboles
  loss_function = "RMSE",      # Función de pérdida (en este caso para regresión)
  eval_metric = "RMSE",        # Métrica de evaluación
  random_seed = 42             # Semilla aleatoria para reproducibilidad
)


prelim_model <- catboost.train(
  learn_pool = train_pool,
  params = params
)

# Paso 4: Calcular la importancia de las características
feature_importances <- catboost.get_feature_importance(prelim_model, pool = train_pool)
feature_names <- colnames(train_clean[, -which(names(train_clean) == "SalePrice")])

# Combinar los nombres de las características con su importancia
importance_df <- data.frame(
  Feature = feature_names,
  Importance = feature_importances
)

# Ordenar las características por importancia
importance_df <- importance_df %>%
  arrange(desc(Importance))

print(importance_df)

# Paso 5: Seleccionar las N características más importantes (ajustar según sea necesario)
top_features <- importance_df$Feature[1:20]  # Seleccionamos las 20 más importantes

# Filtrar el conjunto de datos con las variables seleccionadas
train_clean <- train_clean[, c(top_features, "SalePrice")]
test_clean <- test_clean[, top_features]

# Paso 6: Crear el Pool de entrenamiento y prueba con las características seleccionadas
train_pool <- catboost.load_pool(
  data = train_clean[, -which(names(train_clean) == "SalePrice")], 
  label = train_clean$SalePrice
)

test_pool <- catboost.load_pool(
  data = test_clean
)

# Paso 7: Entrenar el modelo final
params <- list(
  iterations = 30000,           # Mejor iteración encontrada
  learning_rate = 0.05,       # Mejor tasa de aprendizaje
  depth = 7,                  # Mejor profundidad
  loss_function = "RMSE",     
  eval_metric = "RMSE",       
  random_seed = 42           
)

catboost_model <- catboost.train(
  learn_pool = train_pool,
  params = params
)

# Paso 8: Realizar predicciones
predictions <- catboost.predict(catboost_model, test_pool)

# Paso 9: Guardar las predicciones en un archivo CSV
submission <- data.frame(Id = test$Id, SalePrice = predictions)
write.csv(submission, "catboost_submission_1130_18.csv", row.names = FALSE)

