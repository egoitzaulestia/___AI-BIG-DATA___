# EJERCICIOS CORRECCIÓN TIPOGRÁFICA Egoitz Aulestia

# Lo primero es borrar el data frame

rm(list=ls())


# 1. Cargar los datos de “train2”.

df <- read.csv("train2.csv", header = TRUE, sep = ",", stringsAsFactors = T)

summary(df)


# 2. Mostrar los niveles de la variable “LotConfig”.

levels(df$LotConfig)


# 3. Mostrar el número de elementos de cada nivel.

table(df$LotConfig)


# 4. Crear un diccionario con los términos correctos:
#    a. Corner
#    b. CulDSac
#    c. FR2
#    d. FR3
#    e. Inside

library(stringdist)
correcto = c("Corner", "CulDSac", "FR2", "FR3", "Inside") # En R a un conjunto o vector de caracteres o palabras se le llama diccionario
class(correcto)


# 5. Crear una variable que corrija los errores topográficos existentes, permitirle un
# máximo de 4 cambios de letras.

match = amatch(df$LotConfig,correcto,maxDist=4) 


# 6. Corregir los errores en la tabla train2.

corregidos = correcto[match] # Creamos un vector character con los errores tipográficos corregidos
res = cbind.data.frame(df$LotConfig,corregidos)
table(df$LotConfig,corregidos)
table(res$corregidos)

df = cbind(df, res$corregidos)
summary(df[length(df)])
df$LotConfig = NULL
names(df)[names(df) == "res$corregidos"] = "LotConfig"


# 7. Comprobar que se ha realizado correctamente

levels(df$LotConfig) # NULL

# Ovservamos que nos da NULL. 
# Esto se debe a que cuando hemos creado la variable "corregidos" se trataba de una variable character 
# Por lo tanto, debemos reconvertir la variable LotConfig a factor. 

# Convertimos la variable LotConfig a factor
df$LotConfig = as.factor(df$LotConfig) 
levels(df$LotConfig) # Ahora sí, tenemos los niveles "Corner", "CulDSac", "FR2", "FR3" y "Inside".

# Recolocamos la variable LotConfig en su posición incial. Hacemos ncol(df)-1 para evitar duplicar la variable.
df = df[, c(names(df)[1:10], "LotConfig", names(df)[12:ncol(df)-1])] 


# 8. Guardar los datos.

write.csv(df, "train2.csv", row.names=FALSE) 

