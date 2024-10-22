#Eliminamos todo lo anterior

rm(list=ls())

# 1. Cargar los datos de Train.

# Le ponemos SKIP para saltarnos filas, de esta manera nos cogemos la tbla que nos interesa
datos = read.csv("train.csv",sep=",", encoding = "latin1")


# 2. Para la variable “MSZoning” eliminar de la variable “C (all)” el “ (all)” (sustituirlo por “”).

datos$MSZoning = as.character(datos$MSZoning)     # Convierto en texto
# la función GSUB() -> 1) qué tiene que buscar, 2) que queremos introducir, 3) dónde
datos$MSZoning = gsub(" \\(all\\)", "", datos$MSZoning)  # Borro el punto (o lo reemplazo por nada)

# 3. Comprobar que se ha realizado correctamente el cambio.
datos$MSZoning[31] # Nos devuelve "C" -> Por lo que esta correcto

# 4. En caso de que no se haya realizado correctamente solucionarlo.
table(datos$MSZoning)

# 5. Crear una nueva variable que se llame Crisis.

datos$Crisis = "XXX"


# 6. Transformar la variable anterior para determinar (Debe tomar los valores Sí y No),
#    basándose en la variable “YrSold”, si la casa se vendió en el periodo precrisis 
#    (antes de 2008) o durante la crisis (a partir de 2008).

datos$Crisis[datos$YrSold<2008] = "No"
datos$Crisis[datos$YrSold>=2008] = "Sí"


# 7. Comprobar que se ha realizado correctamente.
table(datos$Street)


# 8. Crear un nuevo grupo de datos con las 10 casas más caras, en función de la
#    variable “SalePrice”.

mostExpensive = datos[order(datos$SalePrice,decreasing=TRUE)[1:10],]


# 9. Determinar la calle en la que se encuentra la casa más cara.
mostExpensiveHouseStreet = datos$Street[which.min(datos$SalePrice)]


# 10. Crear una variable llamada “Reforma” y que muestre los años que pasaron entre la
#     última reforma y la venta (YrSold-YearRemodAdd).

datos$Reforma = datos$YrSold - datos$YearRemodAdd


# 11. Guardar los datos, write.csv(datos, “trainmod.csv”, row.names=FALSE)
write.csv(datos, "trainmod.csv", row.names=FALSE)

