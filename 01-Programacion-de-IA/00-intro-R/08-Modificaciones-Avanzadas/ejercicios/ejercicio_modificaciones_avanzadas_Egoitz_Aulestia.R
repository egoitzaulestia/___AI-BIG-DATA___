# Limpiamos el entorno de trabajo  
rm(list=ls())


# 1. Cargar “trainmod”.
datos = read.csv("trainmod.csv",stringsAsFactors = TRUE)

# Resumen de los datos "trainmod"
summary(datos)



# 2. Agregar el Precio de Venta en función de la variable “MSZoning”. Calculando:
#.   a. Importe total de las transacciones.

# Numero total de transacciones por MSZoning 
Tipo = aggregate(SalePrice ~ MSZoning, data = datos, sum)


#.   b. Número total de transacciones.

# Importe total de las transacciones por MSZoning
CountTipo = aggregate(SalePrice ~ MSZoning, data = datos, length)


#.   c. Valor medio de las transacciones.

# Valir medio de las transacciones por MSZoning
MeanTipo = aggregate(SalePrice ~ MSZoning, data = datos, mean)


#    d. Desviación típica de las transacciones.

# Desviación de las transacciones por MSZoning
DesvTipo = aggregate(SalePrice ~ MSZoning, data = datos, sd)



# 3. Agregar el Precio de venta en función de la variable “MSZoning” y la variable “Crisis”. 
#    Calculando:

#    a. Importe total de las transacciones.

# Importe total de las transacciones por 'MSZoning' y 'Crisis'
Tipo2 = aggregate(SalePrice ~ MSZoning + Crisis, data = datos,sum)

#    b. Número total de transacciones:

# Número total de transacciones por 'MSZoning' y 'Crisis'
CountTipo2 = aggregate(SalePrice ~ MSZoning + Crisis, data = datos, length)


#.   c. Valor medio de las transacciones:

# Valor medio de las transacciones por 'MSZoning' y 'Crisis'
MeanTipo2 = aggregate(SalePrice ~ MSZoning + Crisis, data = datos, mean)


#    d. Desviación típica de las transacciones:

# Desviación típica de las transacciones por 'MSZoning' y 'Crisis'
DesvTipo2 = aggregate(SalePrice ~ MSZoning + Crisis, data = datos, sd)


# 4. Graficar de las agregaciones anteriores el Importe Total y el Número Total de 
#    transacciones, de la siguiente forma:
#       a. Valor en el eje de la Y.
#       b. MSZoning en el eje X.
#       c. Color en función de si se vendió en la crisis o fuera de ella.

options(scipen = 999) # Nos ayuda a eleminar la notación cientifica 5+0e
# Podemos graficarlo.
library(ggplot2)

# Gráfico de barras apiladas del importe total de las ventas, diferenciando si fue en crisis o no
ggplot(Tipo2, aes(x = MSZoning, y = SalePrice, fill = Crisis)) + 
  ggtitle("Importe Total de Ventas") + 
  geom_bar(stat="identity") +
  labs(x = "MSZoning", y = "Importe Total (SalePrice)") + 
  theme_minimal()

# Gráfico con barras separadas del importe total de las ventas, diferenciando si fue en crisis o no
ggplot(Tipo2, aes(x = MSZoning, y = SalePrice, fill = Crisis)) + 
  ggtitle("Importe Total de Ventas") + 
  geom_bar(stat = "identity", position = "dodge") +  # con 'position = dodge' separamos las barras por Crisis
  labs(x = "MSZoning", y = "Importe Total (SalePrice)") + 
  theme_minimal()


# Gráfico de barras apiladas con el número total de transacciones, diferenciando si fue en crisis o no
ggplot(CountTipo2, aes(x = MSZoning, y = SalePrice, fill = Crisis)) + 
  ggtitle("Total de ventas") + 
  geom_bar(stat="identity") +
  labs(x = "MSZoning", y = "Número Total de Transacciones") +
  theme_minimal()

# Gráfico de barras separadas con el número total de transacciones, diferenciando si fue en crisis o no
ggplot(CountTipo2, aes(x = MSZoning, y = SalePrice, fill = Crisis)) + 
  ggtitle("Número Total de Transacciones") + 
  geom_bar(stat = "identity", position = "dodge") +  # con 'position = dodge' separamos las barras por Crisis
  labs(x = "MSZoning", y = "Número Total de Transacciones") + 
  theme_minimal()



# 5. Unir las tablas “Valor Medio” y “ Desviación Típica” calculadas en el puntodos.

# Con la funcion Merge unimos las dos tablas.
DatosFinal = merge(MeanTipo, DesvTipo, by = "MSZoning")

# 6. Cambiar los nombres de las variables de la tabla anterior y poner “Media” y 
#    “Desviación”.

# Renombramos las columnas 
names(DatosFinal) <- c("MSZoning", "Media", "Desviación")


# 7. Calcular el cociente entre Media y Desviación.

DatosFinal["Cociente"] = DatosFinal$Media / DatosFinal$Desviacio
# 8. Normalizar la tablas creadas en el ejercicio tres.

# tambien se puede normalizar la tabla por dos filas.
FechaCP_Tipo = dcast(datos2,fecha+cp~tipo, value.var = "importetotal")

# 9. Verticalizar los datos originales por la Id.
