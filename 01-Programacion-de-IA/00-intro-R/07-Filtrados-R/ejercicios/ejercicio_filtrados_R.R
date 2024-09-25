rm(list=ls())

# 1. Cargar los datos de trainmod.

df <- read.csv("trainmod.csv",header = TRUE,sep = ",", stringsAsFactors = T)


# 2. Seleccionar los datos en los que la variable “MSZoning” tome el valor“RM”.

levels(df$MSZoning)

MSZoning_RM = df[df$MSZoning == "RM",]


# 3. Seleccionar los datos en los que la variable “MSZoning” tome el valor “RM” o “C”

MSZoning_RM_o_C = df[df$MSZoning=="RM" | df$MSZoning=="C",]

RM_o_C = df$MSZoning=="RM" | df$MSZoning=="C"
MSZoning_RM_o_Cdf[RM_o_C,]


# 4. Seleccionar los datos en los que el precio de venta sea menor de 100.000$

precio_menor_cienMil = df[df$SalePrice < 100000,]


# 5. Seleccionar los datos en los que el precio de venta sea menor de 100.000$ o la 
#    variable “MSZoning” tome el valor “RM”.

precio_menor_cienMil_o_MSZZoning_RM = df[df$SalePrice < 100000 | df$MSZoning=="RM" ,]


# 6. Seleccionar los datos en los que el precio de venta sea menor de 100.000$ y la 
#    variable “MSZoning” tome el valor “RM”.

precio_menor_cienMil_y_MSZZoning_RM = df[df$SalePrice < 100000 & df$MSZoning=="RM" ,]


# 7. Seleccionar los datos de la variable “MSZoning” que no tomen el valor“RL”.

MSZoning_RL = df[df$MSZoning=="RL",]


# 8. Seleccionar los datos de la variable “MSZoning” que no tomen el valor “RL” y valgan 
#    menos de 120.000 dolares.

MSZoning_RL = df[df$MSZoning=="RL" & df$SalePrice < 120000,]

# 9. Seleccionar las variables que sean factores.

sapply(df,class)

# Seleccionamos los factores.
Factores=df[,sapply(df,is.factor), drop = F] # drop igual a FALSE nos mantiene SIEMPRE en DataFrame


# 10. Eliminar aquellas variables que tomen solo un valor.

criterio = sapply(df,2,function(x) length(unique(na.omit(x)))) > 1
seleccion = df[,criterio]

criterio = sapply(df, function(x) length(unique(na.omit(x))) > 1)
seleccion = df[, criterio]

# 11. Eliminar los duplicados.

rep = duplicated(Factores, incomparables = FALSE)
# rep = as.data.frame(rep)
table(rep)
datosNuevos = Factores[!rep,]
datosRepetidos = Factores[rep,]


# 12. De los datos seleccionar las variables que aparecen en datosImp.




# 13. De los datos seleccionar aquellos que aparecen en casas caras.