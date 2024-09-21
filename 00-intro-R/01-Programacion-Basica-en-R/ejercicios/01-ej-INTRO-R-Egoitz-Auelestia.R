# 01-EJERCICIOS INTRODUCCIÓN

# El primer paso, siempre, es limpiar nuestro area de trabajo.

rm(list=ls())


##########################################
# 1- Realizar las siguientes operaciones
##########################################

# ● Sumar 25,3 y 35,1.

25.3 + 35.1

# ● Restar 15 menos 8,2.

15 + 8.2 

# ● Multiplicar 12 por 4.

12 * 4

# ● Dividir 15 entre 3.

15 / 3

# ● Calcular la raíz cuadrada de 125.

sqrt(125)

# ● Elevar 2 a la 8.

2^8


##########################################################
# 2- Crear variables con las operaciones del ejercicio 1
##########################################################

# ● a

a <- 25.3 + 35.1
a

# ● b

b <- 15 + 8.2
b

# ● c

c <- 12 * 4
c

# ● d

d <- 15 / 3
d

# ● e

e <- sqrt(125)
e

# ● f

f <- 2 ^ 8
f


####################################
# 3- Crear los siguientes vectores
####################################

# ● Un vector que vaya del 20 al 127.

z <- 20:127
z

# ● Un vector que incluya los números 5, 12, 25, 8, 46 y 52.

z2 <- c(5, 12, 25, 8, 46, 52)
z2

# ● Un vector que vaya del 35 al 80 e incluya a continuación el 10 y el 100.

z3 <- c(35:80, 10, 100)
z3

# ● Crear un vector con las 5 primeras letras del abecedario y los 5 primeros números enteros.

# Opción "a":

z4 <- c("a", "b", "c", "d", "e", 1, 2, 3, 4, 5)

# Opción "b":

z4a <- c("a", "b", "c", "d", "e", c(1:5))
z4a

# Opción "c":

z4x <- c("a", "b", "c", "d", "e")
z4y <- c(1:5)
z4z <- c(z4x, z4y)
z4z


##################################################
# 4- Realizar las siguientes tareas con vectores
##################################################

# ● Determinar el número de elementos de cada vector creado en el punto 3.

length(z)

length(z2)

length(z3)

length(z4)

length(z4x)
length(z4y)
length(z4z)

# ● Crear otro vector seleccionando los primeros 5 elementos del primer vector.

z
z5 = z[1:5]
z5

# ● Crear otro vector excluyendo los primeros 100 elementos del primer vector.

z6 = z[-c(1:100)]
z6

# ● Crear un nuevo vector con los datos del primer vector mayores o iguales que 99.

z7 = z[z > 99]
z7

# ● Determinar la clase del primer vector creado en el ejercicio 3 y del cuarto.

class(z)

# ● Transformar la clase del segundo vector a texto

z8 = as.character(z)
z8


##################################################################
# 5- Crear las siguientes listas y realizar las siguiente tareas
##################################################################

# ● Crear una lista con los nombres de 5 personas, su edad y su altura.

mylist <- list(name=c("ima", "jox", "aitzol", "zebe", "ego"), age=c(41, 41, 40, 42, 41), height=c(1.80, 1.71, 1.78, 1.81, 1.73))
mylist

# ● Mostrar de dos formas diferentes los atributos de la lista.

attributes(mylist)
names(mylist)

# ● Mostrar el segundo elemento de la lista.

mylist[2]

# ● Mostrar el cuarto valor de ese elemento.

mylist[[2]][4]
mylist[["age"]][4] # Indexación posicional mediante str


# ● Mostrar el último elemento de la primera variable.

mylist[[1]][5]
# mylist[[1]][length(mylist)] # buscar en casa como acceder by lenght


###############################################################
# 6- Crear una matriz de 4x4 y realizar las siguientes tareas
###############################################################

mdat <- matrix(data= c(1:16),
               nrow = 4, ncol = 4, byrow = T,
               dimnames = list(c("row1", "row2", "row3", "row4"), # FILAS
                               c("v1", "v2", "v3", "v4")))        # COLUMNAS 

# ● Mostrar la matriz en la consola.

mdat

# ● Extraer los atributos.

attributes(mdat)

# ● Crear una nueva matriz con las dos primeras filas.

mdat2 <- mdat[c(1:2),]
mdat2

# ● Crear una nueva matriz con las dos primeras columnas.

mdat3 <- mdat[,c(1:2)]
mdat3

# ● Crear una nueva matriz con las dos primeras filas y las tres primeras columnas.

mdat4 <- mdat[1:2, 1:3]
mdat4

# ● Añadir una nueva columna.

mdat <- cbind(mdat, new=8)
mdat

# ● Añadir una nueva fila.
mdat <- rbind(mdat, new=3)
mdat


################################################################################################
# 7- Crear un factor con las notas que se pueden sacar en la Universidad (SS, AP, NT, SB y MH)
#    y realizar las siguientes tareas:
################################################################################################

notas_uni <- factor(c("NT", "AP", "SB", "SB", "MH", "SB"), levels = c("SS", "AP", "NT", "SB", "MH"))
notas_uni

# ● Calcular el número de opciones existentes.

nlevels(notas_uni)

# ● Mostrar los distintos niveles.

levels(notas_uni)

# ● Mostrar el tercer nivel.

levels(notas_uni)[3]

# ● Sustituir “NT” por “Notable”.

levels(notas_uni)[3] <- "Notable"
levels(notas_uni)[3]


######################################################################################
# 8- Crear un DataFrame de 4 variables (Nombre del Jugador, Equipo, Posición y Edad) 
#    y 8 observaciones (Jugadores) y realizar las siguientes tareas:
######################################################################################

mydata <- data.frame(NombreDelJugador = c("Messi", "Cristiano", "Neymar Jr.", "Haaland", "Mbappé", "Lamine Yamal", "Pedri", "Foden"), 
                     Equipo = c("Inter Miami CF", "Al-Nassr FC", "Al Hilal SFC", "Manchester City FC", "Real Madrid CF", "FC Barcelona", "FC Barcelona", "Manchester City FC"),
                     Posción = c("Attacking Midfielder", "Left Winger", "Left Winger ", "Center Forward", "Left Winger", "Right Winger", "Central Midfielder", "Attacking Midfielder"),
                     Edad = c(37, 39, 32, 24, 25, 17, 21, 24))

# ● Visualizarlo por consola.

mydata

# ● Contar el número de filas.

nrow(mydata)

# ● Contar el número de columnas.

ncol(mydata)

# ● Calcular las dimensiones.

dim(mydata)

# ● Cambiar el nombre de las variables a (Nombre, Team, Especialidad y Años).

colnames(mydata) <- c("Nombre", "Team", "Especialidad", "Años")
colnames(mydata)

# ● Seleccionar aquellos jugadores mayores de 25 años.

mydata[mydata$Años > 25, ]

mayor25 = mydata$Años > 25 # filtro
mydata[mayor25, ]

# ● Seleccionar aquellos jugadores de menos de 25 años y mayores de 20.

mydata[(mydata$Años < 25) & (mydata$Años > 20), ]

menor25mayor20 <- (mydata$Años < 25) & (mydata$Años > 20)
mydata[menor25mayor20, ]

# ● Seleccionar aquellos jugadores de menos de 25 años y que tengan una especialidad
#   determinada (según los jugadores creados).

mydata[(mydata$Años < 25) & (mydata$Especialidad == "Central Midfielder"),]

filter1 = (mydata$Años < 25) & (mydata$Especialidad == "Central Midfielder")
mydata[filter1, ]

filter2 = (mydata$Años < 25) & (mydata$Especialidad == "Right Winger")
mydata[filter2, ]

# ● Seleccionar aquellos jugadores de menos de 25 años o que tengan una especialidad
#   determinada (según los jugadores creados).

mydata[(mydata$Años < 25) | (mydata$Especialidad == "Attacking Midfielder"),]


#####################################
# 9- Crear las siguientes funciones
#####################################

# ● Determine el área de un círculo.

area_circle = function(r) {
  round(pi*(r^2), 2) # Utilizamos la constante predefinida "pi" como pi = 3.1416...
}
area_circle(3)

# ● Determine el área de un rectángulo.

area_rectangle = function(x, y) {x*y}
area_rectangle(2, 4)

# ● Resuelva una ecuación de segundo grado.

# formula ecuación ciadrática // ax^2 + bx + c = 0

resolver_ecuacion_cuadratica = function(a, b, c) {
  # Calculamos el discriminante // Δ = b2 − 4ac
  discriminante = b^2 - 4 * a * c
  
  # Verificamos si el discriminante es negativo
  if (discriminante < 0) {
    return("No hay soluciones reales")
  } else if (discriminante == 0) {
    # Si el discriminante es 0, hay una solución única
    x = -b / (2 * a)
    return(x)
  } else {
    # Si el discriminante es positivo, hay dos soluciones
    x1 = (-b + sqrt(discriminante)) / (2 * a)
    x2 = (-b - sqrt(discriminante)) / (2 * a)
    return(c(x1, x2)) # Devolver las dos soluciones
  }
}

# Valores de la ecuación x^2 + x - 6 = 0
resolver_ecuacion_cuadratica(1, 1, -6)


# ● Determine el perímetro de una circunferencia.

# Hay dos maneraas de calcular el perimetro de un círculo: 
# Opción 1, usando el diámetro (d): C = πd 
perimeter_circle_diameter = function(d) {
  round(pi*d, 2)
} 
perimeter_circle_diameter(5)

# Opción 2, usando el radio (r): C = 2πr --> r = radio
perimeter_circle_radio = function(r) {
  round(2*pi*r, 2)
}
perimeter_circle_radio(8)


#########################################################################################################
# 10- Crear una condicion que determine si una letra es vocal o consonante o si se trata de la Y griega
#########################################################################################################

# Versión simple
char <- "y"
char <- toupper(char)
if(char == "A" | char == "E" | char == "I" | char == "O" | char == "U"){
  print("La letra es una vocal.")
} else if (char == "Y") {
  print("La letra 'y' puede ser una vocal o una consonante según su uso en la palabra que la contiene.")
} else{
  print("La letra es una consonante")
}


# Versión en la que respetamos el caracter introducido (ya sea lower o upper)
char <- "y"
char_upper <- toupper(char)
if(char_upper == "A" | char_upper == "E" | char_upper == "I" | char_upper == "O" | char_upper == "U"){
  print(paste0("La letra '", char, "' es una vocal."))
} else if (char_upper == "Y") {
  print(paste0("La letra '", char, "' puede ser una vocal o una consonante según su uso en la palabra que la contiene."))
} else{
  print(paste0("La letra '", char, "' es una consonante"))
}


# Versión en la que guardamos toda la condicional en una variable y la imprimimos después
char <- "a"
char_upper <- toupper(char)
resultado <- if(char_upper == "A" | char_upper == "E" | char_upper == "I" | char_upper == "O" | char_upper == "U"){
  paste0("La letra '", char, "' es una vocal.")
} else if (char_upper == "Y") {
  paste0("La letra '", char, "' puede ser una vocal o una consonante según su uso en la palabra que la contiene.")
} else{
  paste0("La letra '", char, "' es una consonante")
}

print(paste("Resultado:", resultado))


# Versión freak para imprimir las dobles comillas (con "print" simpre me imprime los "backslash" :/ ),
# aunque he visto que cat no devuelve un objeto str si no que simplemente imprime por pantalla
char <- "y"
char_upper <- toupper(char)
if(char_upper == "A" | char_upper == "E" | char_upper == "I" | char_upper == "O" | char_upper == "U"){
  cat(paste0("La letra \"", char, "\" es una vocal."))
} else if (char_upper == "Y") {
  cat(paste0("La letra \"", char, "\" puede ser una vocal o una consonante según su uso en la palabra que la contiene."))
} else{
  cat(paste0("La letra \"", char, "\" es una consonante"))
}

