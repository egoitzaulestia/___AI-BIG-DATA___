rm(list=ls())

packages <- c("clusterSim","GGally","ggplot2","reshape2","NbClust","outliers","DMwR","factoextra","caret","rpart","e1071","class")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

############
#Clustering#
############

packages <- c("clusterSim","GGally","ggplot2","reshape2","NbClust","outliers","DMwR","factoextra","caret","rpart","e1071","class")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)
library(clusterSim)
library(ggplot2)

rm(list=ls())

# Primero vamos a hacer una clusterizacion sin normalizar.

datos = read.csv("wholesale.csv")
datos$Channel=NULL
datos$Region=NULL
# Ejecutamos Kmeans para buscar 4 clusters

set.seed(123456)
modelo = kmeans(datos,4,nstart=10)

# La salida nos da la siguiente información:
modelo$cluster
modelo$centers
modelo$withinss
modelo$size
modelo$withinss/modelo$size # Gasto medio de cada cluster

# Vamos a usar la clusterizacion para dibujar
datosplot = cbind(datos,cluster=as.factor(modelo$cluster))

datosplot = as.data.frame(modelo$centers)
datosplot$cluster = rownames(datosplot)
datosplot = melt(datosplot,id="cluster")
ggplot(datosplot,aes(x=variable,weight=value,fill=cluster))+
  geom_bar(position="dodge")+
  ggtitle("Centroides sin Normalizar datos")


# Realizamos la misma operacion normalizando los datos.

rm(list=ls())

datos = read.csv("wholesale.csv")
datos$Channel=NULL
datos$Region=NULL

datosn  = data.Normalization(datos,type = "n4",normalization = "column")
minimos = as.numeric(apply(datos,2,min))
maximos = as.numeric(apply(datos,2,max))
set.seed(123456)
modelo = kmeans(datosn,4,nstart=10)
t(apply(modelo$centers,1,function(x) x*(maximos-minimos)+minimos))
# Vamos a usar la clusterización para dibujar

table(modelo$cluster)
datosplot = cbind(datos,cluster=as.factor(modelo$cluster))
datosplot = as.data.frame(modelo$centers)
datosplot$cluster = rownames(datosplot)
datosplot = melt(datosplot,id="cluster")
ggplot(datosplot,aes(x=variable,weight=value,fill=cluster))+
  geom_bar(position="dodge")+
  ggtitle("Centroides Normalizando Datos y Con Outliers")



# Efecto de eliminar los outliers.

rm(list=ls())

datos = read.csv("wholesale.csv")
datos$Channel=NULL
datos$Region=NULL

remove_outliers <- function(x, na.rm = TRUE, ...) 
{
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

datosso=(sapply(datos, remove_outliers))
datosso<-datosso[complete.cases(datosso),]
datosso=as.data.frame(datosso)

datosson  = data.Normalization(datosso,type = "n4",normalization = "column")
minimos = as.numeric(apply(datosso,2,min))
maximos = as.numeric(apply(datosso,2,max))

set.seed(123456)
modelo = kmeans(datosson,4,nstart=10)
t(apply(modelo$centers,1,function(x) x*(maximos-minimos)+minimos))

table(modelo$cluster)
datosplot = cbind(datosso,cluster=as.factor(modelo$cluster))
datosplot = as.data.frame(modelo$centers)
datosplot$cluster = rownames(datosplot)
datosplot = melt(datosplot,id="cluster")
ggplot(datosplot,aes(x=variable,weight=value,fill=cluster))+
  geom_bar(position="dodge")+
  ggtitle("Centroides Normalizando Datos y Sin Outliers")

modelo$size

# Pasamos a determinar el numero optimo de clusters.

rm(list=ls())

datos = read.csv("wholesale.csv")
datos$Channel=NULL
datos$Region=NULL

remove_outliers <- function(x, na.rm = TRUE, ...) 
{
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

datos=(sapply(datos, remove_outliers))
datos<-datos[complete.cases(datos),]
datos=as.data.frame(datos)

datosn = data.Normalization(datos,type="n4",normalization="column")
minimos = as.numeric(apply(datos,2,min))
maximos = as.numeric(apply(datos,2,max))

res = NbClust(data = datosn,method="kmeans")

fitn <- kmeans(datosn, 4,nstart = 10)
clusters=as.data.frame(fitn$centers)
res=cbind.data.frame(rownames(datos),fitn$cluster)


# Graficamente.

datosplot = cbind(datos,cluster=as.factor(fitn$cluster))
datosplot = as.data.frame(fitn$centers)
datosplot$cluster = rownames(datosplot)
datosplot = melt(datosplot,id="cluster")
ggplot(datosplot,aes(x=variable,weight=value,fill=cluster))+
  geom_bar(position="dodge")+
  ggtitle("Centroides Normalizando Datos y Sin Outliers")



table(fitn$cluster)

##################################################
#Clustering compatible con variables cualitativas#
##################################################


rm(list=ls())

datos = read.csv("wholesale.csv")
datos$Channel=NULL
datos$Region=NULL

remove_outliers <- function(x, na.rm = TRUE, ...) 
{
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

datos=(sapply(datos, remove_outliers))
datos<-datos[complete.cases(datos),]
datos=as.data.frame(datos)

library(fpc)
datosn = data.Normalization(datos,type="n4",normalization="column")
modelo = clara(datosn,5)
clusters=as.data.frame(modelo$medoids)
res=cbind.data.frame(rownames(datos),modelo$cluster)


######################
#Reglas de asociacion#
######################

packages <- c("arules","arulesViz","datasets","lubridate","reshape2")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list = ls())


data("Groceries")
datos = Groceries
options(digits=3)

rules = apriori(datos, parameter = list(supp = 0.05, conf = 0.3))

summary(rules)
inspect(rules)
calidad = quality(rules)
w
