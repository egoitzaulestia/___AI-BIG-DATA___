# Lo primero es borrar el data frame

rm(list=ls())

# Cargamos los datos

df2 <- read.csv("Ejemplo_2mod.csv",header = TRUE,sep = ";", stringsAsFactors = T)

# Lo primero como siempre es conocer los datos

summary(df2)
table(df2$Survived,df2$Sex)

# Observamos que "survived" lo ha tomado como numerico cuando es un factor por lo que hay que cambiarlo
# Lo mismo ocurre con la clase

df2$Survived <- as.factor(df2$Survived)
df2$Pclass <- as.factor(df2$Pclass)

# Cuando tenemos un variable que es un factor podemos ver los valores que toma

levels(df2$Cabin) # Hay que corrigir 
levels(df2$Embarked) 
levels(df2$Survived)
levels(df2$Pclass)
levels(df2$Sex)

table(df2$Sex)

# Aquellos valores que vienen en blanco son valores perdidos
# Debemos convertirlos en NAs para poder trabajar mejor con ellos.

levels(df2$Cabin)[1]<-NA
levels(df2$Embarked)[1]<-NA

# En la variable sexo hay variables erroneas que debemos corregir

# Una opcion es hacerlo a mano pero hay que corregir cada tipo de error.

df2$Sex[df2$Sex=="mle"]="male"

# Miramos los valores posibles de sex otra vez

table(df2$Sex)


# Vemos que no hay ningun "mle" y han pasado a ser "male", pero aunque haya 0 "mle", 
# la variable "mle" no ha desaparecido, y eso no nos interesa. 

# Otra opcion es definir los correctos y ordenarle que haga los cambios necesarios.
# Aproxima cada palabra a la que mas se parezca de las correctas.
# Se le puede poner un limite.

library(stringdist) # importamos librería
correcto = c("female", "male") # Creamos un diccionario con las palabras correctas
amatch("bilbo",correcto,maxDist=3) # Linea de codigo de MUESTRA. No hacer caso ha esta linea...
match = amatch(df2$Sex,correcto,maxDist=3) 
corregidos = correcto[match]
res = cbind.data.frame(df2$Sex,corregidos)
table(df2$Sex,corregidos)
table(df2$Survived,corregidos)
table(df2$Survived,df2$Sex)
table(res$corregidos)

#Ahora hay que sustituir en df2 la nueva variable corregida
df2=cbind(df2,res$corregidos)
df2$Sex=NULL
names(df2)[names(df2)=="res$corregidos"]="Sex"

# Comprobamos que han hecho los cambios 

table(df2$Sex)
df2$Sex = as.factor(df2$Sex)
levels(df2$Sex)

# En caso de que nos interese se puede separar el apellido del nombre

library(plyr)
a = strsplit(as.character(df2$Name), split = ",")

a[[3]][2]

apellido = c()
for (i in 1:length(a)){
  ape = a[[i]][1]
  apellido = rbind(apellido,ape) # Si no inicializamos el vector apellido = c(), nos daría error
}

apellido = as.data.frame(apellido)

b = ldply(strsplit(as.character(df2$Name), split = ","))[[1]] # De está manera creamos un vector

c = ldply(strsplit(as.character(df2$Name), split = ",")) # Si no ponemos [[i]] nos crea un dataframe

df2$apellido <- ldply(strsplit(as.character(df2$Name), split = ","))[[1]] # De esta manera creamos una nueva varaible y metemos el vector en él
df2$apellido <- as.factor(df2$apellido)
df2$nombre=ldply(strsplit(as.character(df2$Name), split = ","))[[2]]
df2$nombre=as.factor(df2$nombre)




# Esto nos puede servir para encontrar parentescos en caso de necesidad.

# Eliminamos las variables que no nos interesan

df2$PassengerId <- NULL
df2$Name <- NULL

df2$Vuelta = paste0(df2$apellido, ", ", df2$nombre)
# Una vez que hemos llegado a este punto tenemos los datos limpios y sin errores.
# Ahora es el momento de decidir que se hace con los valores perdidos.
# Antes de tomar ninguna decision un grafico puede ayudar.

# En la variable edad habia valores perdidos.
# Es una variable continua por lo que usamos un grafico de barras

hist(df2$Age,main = "Distribucion de la edad", xlab = "Edad", ylab = "Frecuencia", col= "blue")
#plot(df2$Age,main = "Distribucion de la edad", xlab = "Edad", ylab = "Frecuencia", col= "blue")

# ?Observais algo en los datos?
# La distribucion presenta una peque?a cola hacia la derecha.
# Esto podria condicionar un modelo de regresion para estimarla.


# Para variables categoricas es mas adecuado un plot

plot(df2$Sex,main = "Distribucion del sexo", xlab = NULL, ylab = "Frecuencia", col= "blue")
plot(df2$Embarked,main = "Distribucion del embarque", xlab = "Puerta de embarque", ylab = "Frecuencia", col= "darkgreen")

