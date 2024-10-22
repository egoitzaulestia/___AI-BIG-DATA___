rm(list=ls())

df4 <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";", stringsAsFactors = T)

summary(df4)

# Lo primero es cambiar el formato de la fecha a formato fecha.
x = factor(c("1","3","4"))
x1 = as.numeric(x)
x2 = as.numeric(as.character(x))

df4$CET <- as.POSIXct(as.character(df4$CET), format="%d/%m/%Y")

# A continuacion vemos los levels de events (evento (la variable Eventos))

levels(df4$Events)
levels(df4$Max.TemperatureC)

# En este caso cuando no aparece ningun evento no es un dato perdido sino que es simplemente que no ha ocurrido nada.

levels(df4$Events)[1] <- "No_evento"

# El primer filtro es quedarse con las variables que cumplan un criterio.
Booleano1 = df4$Events=="Rain"

lluvia=df4[df4$Events=="Rain",]

# Tambien podemos aplicar dos criterios (uno u otro)

lluvia2=df4[df4$Events=="Rain" |df4$Events=="Rain-Snow",]

# Tambien lo podemos aplicar a variables cuantitativas.
dias_frios=df4[df4$Max.TemperatureC<=10,]

# Tambien podemos convinar dos criterios de variables diferentes.
dias_frios_o_lluviosos=df4[df4$Max.TemperatureC<=10 |df4$Events=="Rain",]

# Tambien podemos exigir que cumpla varias condiciones a la vez.
dias_frios_y_lluviosos=df4[df4$Max.TemperatureC<=10 & df4$Events=="Rain",]
Dias_calidos_y_lluviosos=df4[df4$Max.TemperatureC>10 & (df4$Events=="Rain" | df4$Event=="Rain-Snow"),]

# Otra opcion es seleccionar los datos que no cumplan una condicion.
Dias_no_lluviosos=df4[df4$Events!="Rain",]
Dias_no_lluviosos2=df4[!df4$Events=="Rain",]

# O que no cumplan dos caracteristicas
Dias_no_lluviosos2=df4[df4$Events!="Rain" & df4$Event!="Rain-Snow",]

Dias_calidos_y_no_lluviosos=df4[df4$Max.TemperatureC>10 & df4$Events!="Rain",]

# La siguiente opcion es filtrar los datos por el tipo de variable.

# El primer punto es ver los tipos de datos que tenemos.

sapply(df4,class)

is.numeric(df4$WindDirDegrees)
# Seleccionamos los factores.
Factores=df4[,sapply(df4,is.factor), drop = F] # drop igual a FALSE nos mantiene SIEMPRE en DataFrame
# Factores=as.data.frame(Factores)

# O los integer (Numeros Enteros).
Integer=df4[,sapply(df4,is.integer)]


# Podemos crear una funcion que permita eliminar variables que solo tengan un valor.

# Creamos una variable numerica y una cuantitativa.
# Con un unico valor. # Una variable que no varie hay que DESCARTARLA
df4$Uno=1
df4$a="a"
df4$a=as.factor(df4$a)


criterio = apply(df4,2,function(x) length(unique(na.omit(x)))) > 1
seleccion = df4[,criterio]



# Creamos una funcion especifica para factores.
criterio1 = sapply(Factores,function(x) nlevels(x)) > 1
Fac_No_Uni = Factores[,criterio1]

# O aquellos que no lleguen a un determinado numero
criterio2 = apply(df4,2,function(x) length(unique(x))) > 70
seleccion2 = df4[,criterio2]

# O aquellos que pasen de un determinado numero de valores.
criterio3 = apply(df4,2,function(x) length(unique(x))) < 70
seleccion3 = df4[,criterio3]

# El ultimo criterio es eliminar duplicados
# Lo aplicamos a seleccion3 
rep = duplicated(seleccion3, incomparables = FALSE)
rep=as.data.frame(rep)
table(rep)
datosNuevos = seleccion3[!rep,]
datosRepetidos = seleccion3[rep,]

df41 = df4[,colnames(df4)=="Events" | colnames(df4)=="CET"]

columnasInteresantes = c("Events","CET")
filtradoa=df4[colnames(df4) %in% columnasInteresantes]
filtradoa=df4[colnames(df4) %in% c("Events","CET","Max.TemperatureC")]

# Otra forma de filtrar es igualando las variables de dos tablas.
coldf4=colnames(df4)
colselec2=colnames(seleccion2)

filtrado=df4[coldf4 %in% colselec2]
Opuesto=df4[!coldf4 %in% colselec2]

# O por filas.
rowdf4=rownames(df4)
B=df4[0:500,]
rowB=rownames(B)

filtrado2=df4[rowdf4 %in% rowB,]
Opuesto2=df4[!rowdf4 %in% rowB,]

# O por los elementos de una variable.
filtrado3=df4[df4$Events %in% B$Events,]
Opuesto3=df4[!df4$Events %in% B$Events,]

filtrado4=df4[df4$Events %in% c("Rain","Rain-Snow","Fog"),]

# Otra opcion es quedarnos con los valores unicos de una variable.
unique(df4$Max.TemperatureC)
unique(na.omit(df4$Max.TemperatureC)) # omitimos los NA
length(unique(na.omit(df4$Uno)))>1 
