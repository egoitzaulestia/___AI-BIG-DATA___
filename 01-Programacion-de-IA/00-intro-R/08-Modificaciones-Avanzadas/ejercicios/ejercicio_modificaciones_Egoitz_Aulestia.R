rm(list=ls())


# 1. Cargar “trainmod”.

# Cargamos los datos.
datos = read.csv("trainmod.csv",stringsAsFactors = TRUE)

# Lo primero es conocer un poco los datos
summary(datos)



# 2. Agregar el Precio de Venta en función de la variable “MSZoning”. Calculando:
#       a. Importe total de las transacciones.

Tipo = aggregate(SalePrice~MSZoning, data = datos, sum)


#       b. Número total de transacciones.

CountTipo = aggregate(SalePrice~MSZoning, data = datos, length)


#       c. Valor medio de las transacciones.

MeanTipo = aggregate(SalePrice~MSZoning, data = datos, mean)


#       d. Desviación típica de las transacciones.

DesvTipo = aggregate(SalePrice~MSZoning, data = datos, sd)



# 3. Agregar el Precio de venta en función de la variable “MSZoning” y la variable “Crisis”. 
#    Calculando:
#       a. Importe total de las transacciones.

Tipo2 = aggregate(SalePrice~MSZoning + Crisis, data = datos,sum)


#       b. Número total de transacciones.

CountTipo2 = aggregate(SalePrice~MSZoning + Crisis, data = datos, length)


#       c. Valor medio de las transacciones.

MeanTipo2 = aggregate(SalePrice~MSZoning + Crisis, data = datos, mean)


#       d. Desviación típica de las transacciones.

DesvTipo2 = aggregate(SalePrice~MSZoning + Crisis, data = datos, sd)


# 4. Graficar de las agregaciones anteriores el Importe Total y el Número Total de 
#    transacciones, de la siguiente forma:
#       a. Valor en el eje de la Y.
#       b. MSZoning en el eje X.
#       c. Color en función de si se vendió en la crisis o fuera de ella.

options(scipen = 999) # Nos ayuda a eleminar la notación cientifica 5+0e
# Podemos graficarlo.
library(ggplot2)

ggplot(Tipo2,aes(x=MSZoning,y=SalePrice, fill = MSZoning)) + 
  ggtitle("Total de ventas") + 
  geom_bar(stat="identity")


ggplot(CountTipo2,aes(x=MSZoning,y=SalePrice, fill = MSZoning)) + 
  ggtitle("Total de ventas") + 
  geom_bar(stat="identity")

# 5. Unir las tablas “Valor Medio” y “ Desviación Típica” calculadas en el puntodos.

# Con la funcion Merge unimos las dos tablas.
DatosFinal  = merge(Finde_Tipo,Tipo2,by = "tipo")


# 6. Cambiar los nombres de las variables de la tabla anterior y poner “Media” y 
#    “Desviación”.
# 7. Calcular el cociente entre Media y Desviación.
# 8. Normalizar la tablas creadas en el ejercicio tres.
# 9. Verticalizar los datos originales por la Id.