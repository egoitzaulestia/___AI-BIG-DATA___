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
# library(mice)

# Limpiar el entorno de trabajo
rm(list=ls())

# Cargamos los datos
train = read.csv("train.csv")
test = read.csv("test.csv")
# full_data = bind_rows(train, test)

###############################################################
#                                                             #
#     EXPLORACIÓN GENERAL de los datos del conjunto Boston    #
#                                                             #
###############################################################

# Paso 1: Resumen general del conjunto de datos

# Dimensiones del conjunto de datos
# El marco de datos Boston tiene 506 filas y 14 columnas.
cat("Número de filas:", nrow(train), "filas\n")
cat("Número de columnas:", ncol(train), "columnas\n")

# Vista general de las primeras filas
head(train, 3)

# Resumen estadístico básico
summary(train)

# Tipos de variables
str(train)


# Paso 2: Análisis de valores faltantes
# Comprobamos si hay valores faltantes
cat("¿Hay valores faltantes en el conjunto de datos?\n")
sapply(train, function(x) sum(is.na(x)))

# Porcentaje de valores faltantes (si existen)
sapply(train, function(x) mean(is.na(x))) * 100



# Seleccionar solo columnas numéricas
numeric_columns <- sapply(train, is.numeric)
df_numeric <- train[, numeric_columns]

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
datos_melt <- melt(train)
ggplot(datos_melt, aes(x = value)) +
  geom_histogram(bins = 30, fill = "blue", color = "black") +
  facet_wrap(~variable, scales = "free") +
  labs(title = "Histogramas de las variables", x = "Valores", y = "Frecuencia")



# Histograma con R base
hist(train$LotArea,
     breaks = 30,  # Número de bins
     col = "blue",
     main = "Distribución de LotArea",
     xlab = "LotArea",
     ylab = "Frecuencia")


# Identificación de outliers con boxplots
boxplot.stats(train$SalePrice)$out
boxplot(train$SalePrice, main = "Boxplot de SalePrice", col = "lightblue")


# Cargar los datos (ajusta la ruta según tu archivo)
data <- train 

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
train <- convert_to_factors(train)
str(train)  # Verifica que 'name' y 'gender' sean ahora factores

# Niveles de la variable MSZoning
levels(train$MSZoning)


### Corrección de NAs que corresponden a una categoría

# Comprobamos si hay valores faltantes
cat("¿Hay valores faltantes en el conjunto de datos?\n")
sapply(train, function(x) sum(is.na(x)))

# Porcentaje de valores faltantes (si existen)
sapply(train, function(x) mean(is.na(x))) * 100


#############################
# Proporción de NAs en Alley
table(is.na(train$Alley))

# Convertir a character
train$Alley <- as.character(train$Alley)

# Reemplazar los NAs por "No alley access"
train$Alley[is.na(train$Alley)] <- "No alley access"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
train$Alley <- as.factor(train$Alley)


################################
# Proporción de NAs en BsmtQual
table(is.na(train$BsmtQual))

################################
# Proporción de NAs en BsmtCond
table(is.na(train$BsmtCond))

################################
# Proporción de NAs en BsmtCond
table(is.na(train$BsmtExposure))

################################
# Proporción de NAs en BsmtCond
table(is.na(train$BsmtFinType1))

# Reemplazar NAs por "No Basement" en varias columnas
# # Lista de columnas a modificar
basement_columns = c("BsmtQual", "BsmtCond", "BsmtExposure", "BsmtFinType1", "BsmtFinType2")

for (col in basement_columns) {
  # Convertir a character si es factor (evitar errores)
  train[[col]] =as.character(train[[col]])
  
  # Reemplazar NAs por "No Basement
  train[[col]][is.na(train[[col]])] = "No Basement"
  
  # (Opcional) Convertir nuevamente a factor si lo necesitas como tal
  train[[col]] = as.factor(train[[col]])
  
}


################################
# Proporción de NAs en FireplaceQu
table(is.na(train$FireplaceQu))

# Convertir a character
train$FireplaceQu <- as.character(train$FireplaceQu)

# Reemplazar los NAs por "No alley access"
train$FireplaceQu[is.na(train$FireplaceQu)] <- "No Fireplace"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
train$FireplaceQu <- as.factor(train$FireplaceQu)


################################
# Proporción de NAs en GarageType
table(is.na(train$GarageType))
################################
# Proporción de NAs en GarageFinish
table(is.na(train$GarageFinish))
################################
# Proporción de NAs en GarageQual
table(is.na(train$GarageQual))
################################
# Proporción de NAs en GarageCond
table(is.na(train$GarageCond))

# Reemplazar NAs por "No Garage" en varias columnas
# # Lista de columnas a modificar
no_garage_columns = c("GarageType", "GarageFinish", "GarageQual", "GarageCond")

for (col in no_garage_columns) {
  # Convertir a character si es factor (evitar errores)
  train[[col]] =as.character(train[[col]])
  
  # Reemplazar NAs por "No Basement
  train[[col]][is.na(train[[col]])] = "No Garage"
  
  # (Opcional) Convertir nuevamente a factor si lo necesitas como tal
  train[[col]] = as.factor(train[[col]])
  
}

################################
# Proporción de NAs en PoolQC
table(is.na(train$PoolQC))

# Convertir a character
train$PoolQC <- as.character(train$PoolQC)

# Reemplazar los NAs por "No alley access"
train$PoolQC[is.na(train$PoolQC)] <- "No Pool"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
train$PoolQC <- as.factor(train$PoolQC)


################################
# Proporción de NAs en Fence
table(is.na(train$Fence))

# Convertir a character
train$Fence <- as.character(train$Fence)

# Reemplazar los NAs por "No alley access"
train$Fence[is.na(train$Fence)] <- "No Fence"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
train$Fence <- as.factor(train$Fence)


################################
# Proporción de NAs en MiscFeature
table(is.na(train$MiscFeature))

# Convertir a character
train$MiscFeature <- as.character(train$MiscFeature)

# Reemplazar los NAs por "No alley access"
train$MiscFeature[is.na(train$MiscFeature)] <- "None"

# (Opcional) Volver a convertir a factor, si lo necesitas como factor
train$MiscFeature <- as.factor(train$MiscFeature)


################################
# Proporción de NAs en Electrical
table(is.na(train$Electrical))

# ANOVA
anova_result <- aov(SalePrice ~ Electrical, data = train)
summary(anova_result)

# Comparación post-hoc
tukey_result <- TukeyHSD(aov(SalePrice ~ Electrical, data = train))
print(tukey_result)

# Boxplot
boxplot(SalePrice ~ Electrical, data = train, main = "SalePrice por categoría de Electrical", xlab = "Electrical", ylab = "SalePrice")

# Tabla de contingencia
table(train$Electrical, train$Neighborhood)

# Gráfico de mosaico (para visualizar relaciones entre dos VARIABLES CATEGÓRICAS)
mosaicplot(table(train$Electrical, train$Neighborhood), main = "Relación entre Electrical y Neighborhood", color = TRUE)


# Imputar el valor perdido de Electrical mediante un árbol de regresión
library(rpart)

# Crear un modelo para predecir Electrical (ignorando el NA temporalmente)
train_no_na <- train[!is.na(train$Electrical), ]
model <- rpart(Electrical ~ SalePrice + YearBuilt + Neighborhood, data = train_no_na, method = "class")

summary(model)

# Predecir el valor del NA
predicted_value <- predict(model, train[is.na(train$Electrical), ], type = "class")

# Reemplazar el NA con el valor predicho
train$Electrical[is.na(train$Electrical)] <- as.character(predicted_value)



garageYrBlt = train[is.na(train$GarageYrBlt), ]
garageYrBlt
# Reemplazar NA con 0 para indicar "Sin Garaje"
train$GarageYrBlt[is.na(train$GarageYrBlt)] <- 0


correlation <- cor(train$LotFrontage, train$LotArea, use = "complete.obs")
print(correlation)

library(ggplot2)

ggplot(train, aes(x = LotArea, y = LotFrontage)) +
  geom_point(alpha = 0.5, color = "blue") +
  geom_smooth(method = "lm", se = FALSE, color = "red") +
  labs(title = "Relación entre LotArea y LotFrontage", x = "LotArea", y = "LotFrontage")

ggplot(train, aes(x = Neighborhood, y = LotFrontage)) +
  geom_boxplot(fill = "orange", outlier.color = "red") +
  labs(title = "Distribución de LotFrontage por Neighborhood", x = "Neighborhood", y = "LotFrontage") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))



# Comprobamos si hay valores faltantes
cat("¿Hay valores faltantes en el conjunto de datos?\n")
cat("Datos TRAIN")
sapply(train, function(x) sum(is.na(x)))
cat("Datos TEST")
sapply(test, function(x) sum(is.na(x)))

# Porcentaje de valores faltantes (si existen)
cat("Datos TRAIN")
sapply(train, function(x) mean(is.na(x))) * 100
cat("Datos TEST")
sapply(test, function(x) mean(is.na(x))) * 100

summary(test)





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
missing_summary <- check_missing_values(train)
print(missing_summary)


# Función para eliminar e imputar
clean_data <- function(data, na_threshold = 20) {
  # Paso 1: Calcular porcentaje de NAs
  na_percentage <- sapply(data, function(col) mean(is.na(col)) * 100)
  
  # Paso 2: Eliminar variables con más del 5.6% de NAs
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
  
  return(data)
}

library(dplyr)

# Limpiar el conjunto de datos
train_clean <- clean_data(train)

# Verificar si quedan valores faltantes
colSums(is.na(train_clean))

# Verificar si hay valores faltantes
sum(is.na(train_clean))  # Debería ser 0



RegModel.1 <- lm(SalePrice ~ . , data=train_clean)
summary(RegModel.1)


clean_data <- function(data, na_threshold = 5.6) {
  # Paso 1: Calcular porcentaje de NAs
  na_percentage <- sapply(data, function(col) mean(is.na(col)) * 100)
  
  # Paso 2: Eliminar variables con más del umbral de NAs
  data <- data[, na_percentage <= na_threshold]
  
  # Paso 3: Imputar valores faltantes en las variables restantes
  data <- data %>%
    mutate(
      # Imputar numéricas con la mediana
      across(where(is.numeric), ~ ifelse(is.na(.), median(., na.rm = TRUE), .)),
      
      # Imputar categóricas con la moda
      across(where(is.factor), ~ {
        if (any(is.na(.))) {
          moda <- names(sort(table(., useNA = "no"), decreasing = TRUE))[1]
          return(ifelse(is.na(.), moda, .))
        } else {
          return(.)
        }
      }),
      
      # Imputar character con la moda (convertir a factor si es necesario)
      across(where(is.character), ~ {
        if (any(is.na(.))) {
          moda <- names(sort(table(., useNA = "no"), decreasing = TRUE))[1]
          return(ifelse(is.na(.), moda, .))
        } else {
          return(.)
        }
      })
    )
  
  # Retornar los datos limpios
  return(data)
}

# Limpiar el conjunto de prueba
test_clean <- clean_data(test)

# Verificar que no haya valores faltantes en test_clean
colSums(is.na(test_clean))
summary(test)

# Realizar la predicción
predictions <- predict(RegModel.1, newdata = test_clean)

# Ver los resultados
head(predictions)

submission <- data.frame(Id = test$Id, SalePrice = predictions)
write.csv(submission, "submission_lm_1126_01_.csv", row.names = FALSE)



######################################

# Limpiar el entorno de trabajo
rm(list=ls())

# Cargamos los datos
train = read.csv("train.csv")
test = read.csv("test.csv")
