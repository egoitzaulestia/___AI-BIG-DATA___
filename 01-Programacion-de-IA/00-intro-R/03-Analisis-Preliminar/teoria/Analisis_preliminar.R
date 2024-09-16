rm(list=ls())

datos <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";",stringsAsFactors = TRUE)

# El primer objetivo es visualizar los datos.

show(datos)

# El siguiente paso es realizar un "resumen estadistico" de los valores.

summary(datos)

# Vemos que en la variable eventos hay muchos huecos en blanco.
# No son valores perdidos, son dias que no hay evento.
# Hay que solucionarlo.

# Analizamos los niveles que existen.
levels(datos$Events)

# Vemos que el primer nivel es el blanco.

# Lo cambiamos por "No_evento".
levels(datos$Events)[1] <- "No_evento"

# Analizamos los eventos existentes.
table(datos$Events)

# Analizamos los tipos de datos existentes.

sapply(datos, class)

# Observamos que la fecha aparece como factor.
# Esto debe ser corregido.
x = factor(c("20","80","1","4"))
x1 = as.numeric(x)
x2 = as.numeric(as.character(x))

datos$CET <- as.POSIXct(as.character(datos$CET), format="%d/%m/%Y")

# Comprobamos que se ha cambiado.
sapply(datos, class)


# A continuacion realizaremos un analisis grafico.http://127.0.0.1:42171/graphics/plot_zoom_png?width=1904&height=978
# Esto sirve para tener una primera idea de las variables.
# Este analisis se centra en la temperatura maxima.

library(ggplot2)

# Analizamos como se distribuye la temperatura maxima.
ggplot(datos,aes(x=Max.TemperatureC))+geom_bar()

# Tambien podemos analizar la temperatura max en funcion de los eventos.
plot(datos$Events,datos$Max.TemperatureC,las=2,cex.axis=0.5)
# cex.lab=1.5, cex.axis=1.5, cex.main=1.5, cex.sub=1.5
# O como se relacionan la temperatura maxima y la minima.
plot(datos$Max.TemperatureC,datos$Min.TemperatureC)

# Otra opcion es visualizar la relacion entre todas las variables.

# O realizar un histograma de la temperatura maxima.
hist(datos$Max.TemperatureC,main = "Distribucion de la temperatura", xlab = "Temperatura", ylab = "Frecuencia", col= "blue")

# Mostramos un grafico de barras de los eventos cliamtologicos.
plot(datos$Events,main = "Distribucion de los eventos", xlab = NULL, ylab = "Frecuencia", col= "red")

# Realizamos un grafico de puntos de la temperatura maxima.
plot(datos$Max.TemperatureC)


# EL siguiente paso es visualizar las relaciones de todas las variables entre si.
# El primer paso es visualizar graficamente las correlaciones.

is.numeric(datos$Max.TemperatureC)

# El primer paso es seleccionar los datos numericos.
datosNum=datos[,sapply(datos,is.numeric)]

# COn este grafico visualizamos la relacion entre las variables y su correlacion.
library(PerformanceAnalytics)
chart.Correlation(datosNum,hist=T)

# Otra opcion es realizar el siguiente grafico.
library(psych)
pairs.panels(datosNum)

# Tambien podemos analizar solo la correlacion.
correlaciones = cor(datosNum)
library(corrplot)
corrplot(cor(datosNum), method="shade", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=FALSE, cl.pos="n")

# Eliminamos los NAs.
datosNuma<-datosNum[complete.cases(datosNum),]


# Volvemos a visualizar de varias formas.

corrplot(cor(datosNuma), method="shade", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=FALSE, cl.pos="n",tl.cex = 0.6)

corrplot(cor(datosNuma), method="circle", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n",tl.cex = 0.6)

corrplot(cor(datosNuma), method="square", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n",tl.cex = 0.6)

corrplot(cor(datosNuma), method="ellipse", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n",tl.cex = 0.6)

corrplot(cor(datosNuma), method="number", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n",tl.cex = 0.6)

corrplot(cor(datosNuma), method="color", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n",tl.cex = 0.6)

corrplot(cor(datosNuma), method="pie", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n",tl.cex = 0.6)
