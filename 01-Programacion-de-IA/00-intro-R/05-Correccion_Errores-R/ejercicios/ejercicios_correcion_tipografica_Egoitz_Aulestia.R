# EJERCICIOS CORRECCIÓN TIPOGRÁFICA Egoitz Aulestia

# Lo primero es borrar el data frame

rm(list=ls())

# 1. Cargar los datos de “train2”.

df <- read.csv("train2.csv",header = TRUE,sep = ",", stringsAsFactors = T)


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

class(correcto)
library(stringdist)
correcto = c("Corner", "CulDSac", "FR2", "FR3", "Inside") # En R a un conjunto o vector de caracteres o palabras se le llama diccionario
match = amatch(df2$Sex,correcto,maxDist=3) 
corregidos = correcto[match]


res = cbind.data.frame(df2$Sex,corregidos)
table(df2$Sex,corregidos)
table(df2$Survived,corregidos)
table(df2$Survived,df2$Sex)

#Ahora hay que sustituir en df2 la nueva variable corregida
df2=cbind(df2,res$corregidos)
df2$Sex=NULL
names(df2)[names(df2)=="res$corregidos"]="Sex"



# 5. Crear una variable que corrija los errores topográficos existentes, permitirle un
# máximo de 4 cambios de letras.


# 6. Corregir los errores en la tabla train2.
# 7. Comprobar que se ha realizado correctamente