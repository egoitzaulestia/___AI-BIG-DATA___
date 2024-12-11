rm(list=ls())

df4 <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";",stringsAsFactors = TRUE)


summary(df4)

# Lo primero es cambiar el formato de la fecha a formato fecha.

df4$CET <- as.POSIXct(as.character(df4$CET), format="%d/%m/%Y")

# A continuacion vemos los levels de events

levels(df4$Events)

# En este caso cuando no aparece ningun evento no es un dato perdido sino que es simplemente que no ha ocurrido nada.

levels(df4$Events)[1] <- "No_evento"

table(df4$Events)


#El siguiente paso es analizar la existencia de outliers

boxplot(df4$Max.TemperatureC)
boxplot(df4$Mean.TemperatureC)
boxplot(df4$Min.TemperatureC)
a1=boxplot(df4$Max.Humidity)
boxplot(df4$Mean.Humidity)
boxplot(df4$Min.Humidity)
boxplot(df4$Max.Sea.Level.PressurehPa)
boxplot(df4$Min.Sea.Level.PressurehPa)
boxplot(df4$Min.Sea.Level.PressurehPa)
boxplot(df4$Precipitationmm)
a1$out

# Vamos a ver que sucede con el resto de los datos cuando se dan estos outliers

b1=subset(df4,Max.Humidity==16)
b2=subset(df4,Max.Humidity==26)
b3=subset(df4,Max.Humidity==28)

b4 = df4[df4$Precipitationmm>0 & df4$Events=="No_evento",]
# A continuacion pasamos a ver los datos perdidos

# Podemos sumar los valores perdidos.
# El total
total   = sum(is.na(df4))
total

# Por filas (Para cada observacion)
fila    = apply(df4,1,function(x) sum(is.na(x)))
fila = as.data.frame(fila)
fila

# Por columnas (Para cada variable)
columna = apply(df4,2,function(x) sum(is.na(x)))
columna

# O tener los datos en porcentaje.

# El total
pTotal=100*sum((is.na(df4))/(ncol(df4)*nrow(df4)))
pTotal

# Por columnas
pMiss <- function(x){100*sum(is.na(x))/length(x)}
apply(df4,2,pMiss)

# Por filas (Aunque no tenga mucho sentido por la gran cantidad de datos)
a = as.data.frame(apply(df4,1,pMiss))


# Tambien lo podemos hacer graficamente

library(VIM)
par(mfrow=c(1,1))
aggr_plot <- aggr(df4, col=c('navyblue','red'), numbers=TRUE, sortVars=FALSE, 
                  labels=names(df4), cex.axis=.3, gap=1,
                  ylab=c("Histograma de valores perdidos","Patron"))

options(scipen = 999)
# Otra forma de visualizarlos.

library(mice)
reporte = md.pattern(df4)

# Una vez que tenemos los valores perdidos identificados tenemos que decidir que hacer con ellos.

# La primera opcion es eliminarlos, se puede hacer variable a variable
datoscomp = df4[!is.na(df4$Max.TemperatureC),]

df41 <- subset(df4,Max.TemperatureC!="NA")
df41 <- subset(df41,Mean.TemperatureC!="NA")
df41 <- subset(df41,Min.TemperatureC!="NA")
df41 <- subset(df41,Max.Humidity!="NA")
df41 <- subset(df41,Mean.Humidity!="NA")
df41 <- subset(df41,Min.Humidity!="NA")

# Esto puede ser util para poder eliminar unas variables y estimar otras.

# Tambien se pueden eliminar todas a la vez.

rm(list=ls())
df4 <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";")
df411<-df4[complete.cases(df4),]


# Tambien podemos crear una funcion que elimine variables en funcion de los NAs.
# Creamos el criterio.
criterioCol = apply(df4,2,function(x){100*sum(is.na(x))/length(x)}<30)

# Lo aplicamos
df4 = df4[,(criterioCol)]

# Tambien lo podemos hacer por filas (Observaciones)
criterioFila = apply(df4,1,function(x){100*sum(is.na(x))/length(x)}<30)
df4= df4[(criterioFila),]

# Otra opcion es sustituirlos por la media.
# Podemos hacerlo 1 a 1

rm(list=ls())
df4 <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";")
df411<-df4[complete.cases(df4),]

summary(df4)
df42<-df4

mean(df42$Max.TemperatureC,na.rm = TRUE)

df42$Max.TemperatureC[is.na(df42$Max.TemperatureC)]<-mean(df42$Max.TemperatureC,na.rm = TRUE)
df42$Mean.TemperatureC[is.na(df42$Mean.TemperatureC)]<-mean(df42$Mean.TemperatureC,na.rm = TRUE)
df42$Min.TemperatureC[is.na(df42$Min.TemperatureC)]<-mean(df42$Min.TemperatureC,na.rm = TRUE)
df42$Max.Humidity[is.na(df42$Max.Humidity)]<-mean(df42$Max.Humidity,na.rm = TRUE)
df42$Mean.Humidity[is.na(df42$Mean.Humidity)]<-mean(df42$Mean.Humidity,na.rm = TRUE)
df42$Min.Humidity[is.na(df42$Min.Humidity)]<-mean(df42$Min.Humidity,na.rm = TRUE)

summary(df42)

#Tambien se puede hacer de esta forma.


rm(list=ls())
df4 <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";")
df422<-df4
summary(df422)
library(Hmisc)
df422$Max.TemperatureC <- impute(df422$Max.TemperatureC, mean)
df422$Mean.TemperatureC <- impute(df422$Mean.TemperatureC, median)


#Tambien lo podemos realizar todo a la vez

for(i in 1:ncol(df4)){
  df4[is.na(df4[,i]), i] <- mean(df4[,i], na.rm = TRUE)
}




# Otra opcion es realizar una imputacion multiple

library(mice)

# Esto solo se puede hacer para variables numericas por lo que no incluimos el resto.

rm(list=ls())
df4 <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";")

temp <- mice(df4, m=6,maxit=10,meth="rf",seed=1234)
summary(temp)
df44 <- complete(temp,1)
summary(df4)
summary(df44)
par(mfrow=c(2,1))
plot(df4$Max.TemperatureC)
plot(df44$Max.TemperatureC)


# Otra opcion es realizar un modelo para estimar los valores perdidos.
# El problema de esto es que no se pueden estimar aquellas que tengan NAs.
# Otro problema es que hay que hacerlo 1 a 1.

# Vamos a estimar la temperatura maxima.

# El primer paso es seleccionar las que tienen NAs.

rm(list=ls())
df4 <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";")

df43=df4
subset(df4,is.na(Max.TemperatureC)==TRUE)

# Tras ello creamos el modelo, en este caso una regresion pero puede ser otro.

model1 <- lm(Max.TemperatureC ~ Mean.TemperatureC + Min.TemperatureC , data = df43)
summary(model1)

plot(df4$Max.TemperatureC,df4$Mean.TemperatureC)
plot(df4$Max.TemperatureC,df4$Min.TemperatureC)
plot(df4$Mean.TemperatureC,df4$Min.TemperatureC)

# El siguiente paso es analizar si el modelo creado es fiable o no.


# En este caso una vz que hemos visto que es fiable hacemos la sustitucion.
# El primer paso es hacer la prediccion.
df43$Pred1=predict(model1,df43)
# TMax = 0.68 + 1,94*TMed - 0.93*TMin
for (i in 1:nrow(df43)){
  if(is.na(df43$Max.TemperatureC[i]))
    df43$Max.TemperatureC[i]<-df43$Pred1[i]
}


# En este caso no hemos podido eliminar todos los NAs
summary(df43)
temp <- mice(df43[,c(-1,-14)], m=6,maxit=10,meth="pmm",seed=1234)
summary(temp)
df44 <- complete(temp,1)
