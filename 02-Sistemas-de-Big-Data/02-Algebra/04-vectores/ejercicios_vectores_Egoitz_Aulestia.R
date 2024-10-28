
########### EJERCICIOS ESPACIOS VECTORIALES ##################################################################

rm(list = ls())

# Ejercicio 1
# Calcular la suma y la resta de los vectores u = (1, 0,1) y v = (3, 1, −2).

#1.Definir un vector: c()
x = c(1,0,1)
y = c(3,1,-2)

#2.Dimensión de un vector: length()
dimension_x = length(x)
dimension_y = length(y)


#3.Sumar/restar vectores: + / -
#requisito! misma dimensión
suma = x+y
suma
resta = x-y
resta


# Ejercicio 2
# Calcular el producto escalar de los vectores resultantes del anterior ejercicio.

# Función para calcular el producto escala
productoEscalar = function(x,y){
  if (length(x) == length(y)){
    sum(x*y)
  }
  else{
    print('No se puede calcular el producto escalar de estos dos vectores
          porque no tienen la misma dimensión')
  }
}


#Aplicamos la función a dos vectores que definimos nuevamente:
solucion = productoEscalar(x,y)
solucion


# Ejercicio 3
# Sea u = (2, 1, 0). Comprobar que la norma del vector w (siendo w = 3u) es tres veces mayor que la norma de u.
 
# Cargar la librería necesaria
library(pracma)

# Definir el vector u
u = c(2, 1, 0)

# Calcular la norma de u
norma_u = Norm(u)
print(paste("Norma de u:", norma_u))

# Definir el vector w como 3 veces u
w = 3 * u

# Calcular la norma de w
norma_w = Norm(w)
print(paste("Norma de w:", norma_w))

# Comprobar que la norma de w es tres veces mayor que la norma de u
tres_veces_mayor = norma_w == 3 * norma_u
print(paste("¿La norma de w es tres veces la norma de u?:", tres_veces_mayor))


# Ejercicio 4
# Calcular de dos maneras distintas la norma de un vector (cualquiera) de dimensión 3.

library(pracma)

# Definir un vector de dimensión 3
x = c(5, 8, 3)  # Ahora x tiene tres dimensiones

# Opción A: con la función Norm()
norma = Norm(x)
print(paste("Norma usando Norm():", norma))

# Opción B: calcular la norma a través de la raíz cuadrada de la función del producto escalar

# Definimos función del producto escalar
productoEscalar = function(x,y){
  if (length(x) == length(y)){
    sum(x*y)
  }
  else{
    print('No se puede calcular el producto escalar de estos dos vectores
          porque no tienen la misma dimensión')
  }
}
norma1 = sqrt(productoEscalar(x,x))
print(paste("Norma usando producto escalar:", norma1))

# Comprobar que la norma de w es tres veces mayor que la norma de u
misma_norma = norma == norma1
print(paste("¿La variable norma y norma1 tienen la misma norma?:", misma_norma))



# Ejercicio 5
# Calcular la distancia entre los puntos A = (1, 1) y B = (0, 0). 

# Función para calcular la distancia entre dos puntos
distancia = function(x,y){
  if (length(x) == length(y)){
    Norm(x-y)
  }
  else{
    print('No se puede calcular la distancia entre los dos puntos
          porque no tienen la misma dimensión, 
          los puntos no pertenecen al mismo espacio')
  }
}

#Definimos dos puntos y calculamos la distancia entre ellos
a = c(1,1)
b = c(0,0)
distancia_a_b = distancia(a,b)
distancia_a_b

 
# Ejercicio 6
# Calcular el ángulo (en grados) que definen los vectores ⃗u = (2, 0, 0) y ⃗v = (0, 1, 0)
 
# Definimos función de angulo de radianes
angulo_radianes = function(x,y){
  if (length(x) == length(y)){
    acos(x%*%y/((Norm(x)*Norm(y))))
  }
  else{
    print('No se puede calcular el ángulo entre los dos vectores
          porque no tienen la misma dimensión, no pertenecen al mismo espacio')
  }
}

# Definimos dos vectores
u = c(2,0,0)
v = c(0,1,0)

# Calculamos el angulo que forman
radianes = angulo_radianes(u,v)

#Pasamos los radianes a grados 
grados = (radianes*360)/(2*pi)
print(paste("Ángulo en grados:", grados))


# Ejercicio 7
# Calcular un vector w que sea ortonormal a los vectores u = (1, 0, 0) y v = (0, 1, 0).

# Definir los vectores u y v
u = c(1, 0, 0)
v = c(0, 1, 0)

# Calcular el producto cruzado (vector ortogonal a u y v)
w = cross(u, v)
print(paste("Vector ortogonal w antes de normalizar:", paste(w, collapse = ", ")))

# Calcular la norma de w
norma_w = Norm(w)

# Normalizar el vector w para que tenga norma 1
w_ortonormal = w / norma_w
print(paste("Vector ortonormal w:", paste(w_ortonormal, collapse = ", ")))
