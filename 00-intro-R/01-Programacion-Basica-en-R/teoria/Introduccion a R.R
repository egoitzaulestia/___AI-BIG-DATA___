# Introduccion a R

# El primer paso, siempre, es limpiar nuestro area de trabajo.

rm(list=ls())

# Lo primero que podemos hacer es realizar una serie de calculos simples.

1+1
5-4
3*8
25/5


# A continuacion creamos una serie de variables.

x <- 1
x = 1
y <- x + 1

# Tambien las podemos visualizar en la consola.

y

# Tambien podemos crear vectores.

z<-1:20

# Igualmente podemos visualizarlo.

z

# Otro vector con los numeros deseados.

x <- c(10,20,30,40,50)
x

# Contamos los elementos del vector

length(x)

# Podemos crear un nuevo vector que contenga solo unos datos del anterior.

y <- x[1:3]
y

# Con el simbolo "-" excluimos datos.
# En este caso lo realizamos segun su posicion.
# Eliminamos los tres primeros datos.

z <- x[-c(1:3)]
z

# Tambien podemos seleccionar los datos que cumplan una determinada condicion.

b <- x[ x > 37]
b


# Tambien podemos crear vectores que incluyan numeros y letras.

y<-c("a",1)
y

# Vemos el tipo de datos que contienen la "X" y la "Y"

class(x)
class(y)

x[3] + 5
y[2] + 5
# Uno es numerico y otro son caracteres es decir lo considera texto.

# Le pedimos que nos muestre los elementos que hemos creado.

ls()

# Podemos crear un vector con varios grupos de datos.

x<-c(1:5,10:53,7,9,4:19,6,1:3)

# Tambien podemos cambiar el formato de los datos.
x <- as.character(x)
x
y = as.numeric(y)
# El texto aparece entre comillas.

# Otra opcion es crear listas.
# Tambien las podemos visualizar.

mylist <- list(name="Fred", wife="Mary",no.children=3,child.ages=c(4,7,9))
mylist
mylist$name
# O realizar consultas

attributes(mylist)
names(mylist)

# Le pedimos que nos muestre los elementos deseados.
# Puede ser por el nuemro de la variable.
# Tambien por el nombre de esta.

mylist[4]
mylist["child.ages"]

mylist["child.ages"][2]
# Mostramos un elemento de una variable.
mylist[[4]][1]
mylist$child.ages[2]

# Ahora creamos matrices de datos.

mdat <- matrix(data = c(1,2,3, 11,12,13, 21,22,23),
               nrow = 3, ncol = 3, byrow = TRUE,
               dimnames = list(c("row1", "row2", "row3"),
                               c("v1", "V2", "V3")))

# Y las mostramos en la consola.

mdat

# O le hacemos consultas

attributes(mdat)


# Igualmente podemos mostrar ciertos datos.

# Por filas.
mdat[c(1,3),]

# Por columnas.
mdat[,c(1,3)]

# Ambas
mdat[c(1,3),c(1,2)]

# A?adimos nuevos elementos a una matriz ya creada.
# Y lo vemos en la consola

# A?adimos una fila

mdat <- rbind(mdat, rnew=0)
mdat

# O una columna

mdat <- cbind(mdat, new=5)
mdat


# El siguiente elemento son factores.
# Le indicamos los niveles.
# Lo visualizamos

y<- factor(c("V","M","M","M","M","V"), levels=c("V","M"))
y

sexo <- factor(c("Mujer", "Hombre", "Mujer", "Mujer", "Hombre"))
print(sexo)

# Mostramos los diferentes elementos existentes.
# Vemos su orden.

nlevels(y)
levels(y)
levels(y)[1]
levels(y)[2]

# Una vez que conocemos su orden podemos cambiar el nombre

levels(y)[1]<-"Varon"
levels(y)[2]<-"Mujer"
y

# Comprobamos.

nlevels(y)
levels(y)
levels(y)[1]
levels(y)[2]


# El ultimo elemento son los Data Frames.
# Creamos un data frame

mydata <- data.frame(x=c(1,11,21), y=c(20,30,40), z=c("Juan","Maria","Leticia") )

# Lo visualizamos

mydata

# Contamos el numero de filas y de columnas

nrow(mydata)
ncol(mydata)

# Vemos las dimensiones

dim(mydata)

# Tambien podemos cambiar los nombres de las variables

colnames(mydata)<-c("ntrans","edad","nombre")
Bool = c(T,T,F)

v2 = mydata[,Bool]


j=mydata[,colnames(mydata)=="ntrans", drop = FALSE]

# Vemos sus caracteristicas
str(mydata)

# Filtramos datos.
# Con un criterio
mydata[mydata$ntrans>3,]

# Que cumpla dos croterios simultaneamente
mydata[mydata$ntrans>=3 & mydata$nombre=="Maria",]

# La "!" excluye a quien cumpla esa condicion
mydata[mydata$ntrans>3 & mydata$nombre!="Juan",]

# Tambien podemos hacer que cumpla una condicion solo.

mydata[mydata$nombre=="Maria" | mydata$nombre=="Leticia",]

# Asi no cumple ninguna condicion

mydata[mydata$nombre=="Maria" & mydata$nombre=="Leticia",]


# Creacion de funciones.

# Creamos una funcion que eleve al cuadrado.
Cuadrado = function(x) {x^2}

# La aplicamos.
Cuadrado(2)

# Creamos una funcion que calcule el area de un triangulo.
AreaTriangulo = function (a,b) {a*b/2}

# La aplicamos.
AreaTriangulo(5,4)


# Condicionales.

# Si el numero es mayor que 0 devolver positico.
x <- 5
if(x > 0){
  print("Positivo")
}

# Si el numero es mayor que 0 devolver positivo y si es menor negativo.
x <- -2
if(x > 0){
  print("Positivo")
} else{
  print("Negativo")
}

# Devolver:
  # Si el numero es mayor que 0: positivo.
  # Si es igual a 0 neutro.
  # Si es menor que 0 negativo.

x <- -1
if(x > 0){
  print("Positivo")
} else if (x==0) {
  print("Neutro")
} else{
  print("Negativo")
}


if(x > 0){
  print("Positivo")
} 
if (x==0) {
  print("Neutro")
} 
if (x<0){
  print("Negativo")
}
