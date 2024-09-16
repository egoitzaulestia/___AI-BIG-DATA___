rm(list=ls())

# 1. Cargar los datos de trainmod (Los creados en el apartado anterior).

datos <- read.csv("trainmod.csv",header = TRUE,sep = ",",stringsAsFactors = TRUE)


# 2. Mostrar los datos.

show(datos)


# 3. Realizar un resumen estadístico de los datos y realizar una interpretación.

summary(datos)


# 4. Determinar los niveles existentes para la variable “Crisis”.

levels(datos$Crisis)


# 5. Sustituir los “Si” por “Crisis” y los “No” por “Burbuja”.

datos$Crisis = as.character(datos$Crisis)
datos$Crisis[datos$Crisis == "Si"] = "Crisis"
datos$Crisis[datos$Crisis == "No"] = "Burbuja"
datos$Crisis = as.factor((datos$Crisis))


# 6. Determinar la clase de cada uno de los datos.

sapply(datos, class)


# 7. Realizar un gráfico del precio de venta.

hist(datos$SalePrice,main = "Distribucion de la temperatura", xlab = "Temperatura", ylab = "Frecuencia", col= "blue")

# Cambiar los titulos de la gráfica
