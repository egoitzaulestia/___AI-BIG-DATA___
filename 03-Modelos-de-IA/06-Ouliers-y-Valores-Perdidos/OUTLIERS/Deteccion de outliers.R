# Limpiamos el dat frame

rm(list=ls())

# Cargamos los datos

df3 <- read.csv("Ejemplo_3.csv",header = TRUE,sep = ",")

# Lo primero, como siempre, es conocer un poco los datos.

show(df3)
summary(df3)

# A continuacion se debe hacer un grafico de las variables
# Se le puede indicar a R el numero de graficos que se desea visualiar simultaneamente y la psocion de cada uno.
# En este caso hacemos 3x3

par(mfrow=c(3,3))
plot(df3$G1)
plot(df3$G2)
plot(df3$G3)
plot(df3$G4)
plot(df3$G5)
plot(df3$G6)
plot(df3$G7)
plot(df3$G8)
plot(df3$G9)

# El siguiente paso es analizar si existen outliers.
# La forma mas sencilla de verlo es un grafico.
# Podemos hacerlo 1 a 1
par(mfrow=c(1,1))
boxplot(df3$G1)
boxplot(df3$G2)
boxplot(df3$G3)
boxplot(df3$G4)
boxplot(df3$G5)
boxplot(df3$G6)
boxplot(df3$G7)
boxplot(df3$G8)
boxplot(df3$G9)

#Poner todos por separado pero visualizarlos a la vez

par(mfrow=c(3,3))
boxplot(df3$G1)
boxplot(df3$G2)
boxplot(df3$G3)
boxplot(df3$G4)
boxplot(df3$G5)
boxplot(df3$G6)
boxplot(df3$G7)
boxplot(df3$G8)
boxplot(df3$G9)

# Aunque en este caso no se vea excesivamente bien.

# Otra opcio es mostrarlos todos en un grafico.
par(mfrow=c(1,1))
boxplot(df3)

# Utilizando el boxplot podemos extraer los outliers de cada una de las variables
out1=boxplot(df3$G1)
out2=boxplot(df3$G2)
out3=boxplot(df3$G3)
out4=boxplot(df3$G4)
out5=boxplot(df3$G5)
out6=boxplot(df3$G6)
out7=boxplot(df3$G7)
out8=boxplot(df3$G8)
out9=boxplot(df3$G9)


# Los convertimos en data frame

out1=as.data.frame(out1$out)
out2=as.data.frame(out2$out)
out3=as.data.frame(out3$out)
out4=as.data.frame(out4$out)
out5=as.data.frame(out5$out)
out6=as.data.frame(out6$out)
out7=as.data.frame(out7$out)
out8=as.data.frame(out8$out)
out9=as.data.frame(out9$out)

quantile(df3$G1)
# Otra opcion es crear una formula que nos muestre en que observaciones estan los outliers.
FindOutliers <- function(data) {
  lowerq = quantile(data)[2]
  upperq = quantile(data)[4]
  iqr = upperq - lowerq 
  extreme.threshold.upper = (iqr * 3) + upperq
  extreme.threshold.lower = lowerq - (iqr * 3)
  result <- which(data > extreme.threshold.upper | data < extreme.threshold.lower)
}

print(FindOutliers(df3$G1))
# Aplicamos la funcion a todas las columnas del dataset.
outliers <- apply(df3,2,FindOutliers)
outliers


# Modificando la funcion anterior podemos extraer los valores de los outliers.
FindOutliers2 <- function(data) {
  lowerq = quantile(data)[2]
  upperq = quantile(data)[4]
  iqr = upperq - lowerq 
  extreme.threshold.upper = (iqr * 3) + upperq
  extreme.threshold.lower = lowerq - (iqr * 3)
  result <- data[data > extreme.threshold.upper | data < extreme.threshold.lower]
}


outliers2 <- apply(df3,2,FindOutliers2)
outliers2


# Otra forma de visualizarlos

select_outliers <- function(x, na.rm = TRUE, ...) 
{
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  outliers=x[x < (qnt[1] - H) | x > (qnt[2] + H) ]
  outliers
}

outliers3 <- apply(df3,2,select_outliers)
outliers3

# Una vez que los hemos identificado podemos trabajar con ellos.
# Creamos una formula para transformarlos en valores perdidos (NAs)

df3 <- read.csv("Ejemplo_3.csv",header = TRUE,sep = ",")

remove_outliers <- function(x, na.rm = TRUE, ...) 
{
  qnt <- quantile(x, probs=c(.25, .75), na.rm = na.rm, ...)
  H <- 1.5 * IQR(x, na.rm = na.rm)
  y <- x
  y[x < (qnt[1] - H)] <- NA
  y[x > (qnt[2] + H)] <- NA
  y
}

# http://stackoverflow.com/questions/4787332/how-to-remove-outliers-from-a-dataset

# Una vez eliminado los outliers podemos graficar y ver las diferencias
df3sinout=as.data.frame(apply(df3,2,remove_outliers))



# Tambien podemos aplicar la formula creada a una sola variable.
g1 <- remove_outliers(df3$G1)
par(mfrow=c(1,2))

# Y realizar un grafico para ver las diferencias.
hist(df3$G1, main = "Con valores extremos", col = "red")
hist(g1, main = "Sin valores extremos", col = "blue")

# Una vez eliminados los outliers sustituimos la variable

df3$G1<- g1

# Tambien los podemos eliminar todos a la vez.
df3<-df3[complete.cases(df3),]
df3=as.data.frame(df3)



# Otra opcion es marcarlos como outliers y trabajar con ellos.

df3 <- read.csv("Ejemplo_3.csv",header = TRUE,sep = ",")

df3$outlier=FALSE
for (i in 1:ncol(df3)){
  columna = df3[,i]
  if (is.numeric(columna)){
    quartil0.25 = quantile(columna,.1)
    quartil0.75 = quantile(columna,.9)
    df3$outlier = (df3$outlier | columna<(quartil0.25*3) | columna>( quartil0.75*5))
  }
}

table(df3$outlier)


# Tambien se puede utilizar otra formula basada en la media y en la desviacion tipica

df3 <- read.csv("Ejemplo_3.csv",header = TRUE,sep = ",")
df3$outlier=FALSE
for (i in 1:ncol(df3)){
  columna = df3[,i]
  if (is.numeric(columna)){
    media = mean(columna)
    desviacion = sd(columna)
    df3$outlier = (df3$outlier | columna>(media+2*desviacion) | columna<(media-2*desviacion))
  }
}

table(df3$outlier)

# 2, 2, 3, 6, 9, 10, 10 Media y mediana = 6
# 4, 4, 5, 6, 6, 6, 10 Media y mediana = 6
# La ultima forma es hacerlo variable a variable.
# Este es un analisis mas preciso pero requiere mayor trabajo.

a1 <- boxplot(df3$G1)
d1=as.data.frame(a1$out)
df3$outlierG1alto=0
df3$outlierG1bajo=0
df3$outlierG1bajo[df3$G1<=(-0.892)]=1
df3$outlierG1alto[df3$G1>1.395]=1

# Ejemplo multicolinealidad
df3$g10 = 2*df3$G1 + 3*df3$G4
df3$g10[27] = 4
summary(lm(G2 ~ ., data = df3))
