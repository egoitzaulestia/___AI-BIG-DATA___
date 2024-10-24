rm(list = ls())


#1.Definir un vector: c()
x = c(1,2,3)
y = c(4,5,6)


#2.Dimensión de un vector: length()
dimension_x = length(x)
dimension_y = length(y)


#3.Sumar/restar vectores: + / -
#requisito! misma dimensión
suma = x+y
resta = x-y


#4.Producto por un escalar(número): *
xx=2*x
5*y



#5.Producto escalar de dos vectores:
a = c(1,2)
b = c(2,4)

# Siguiendo la estructura de la fórmula
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
solucion = productoEscalar(a,b)
solucion

# Otra opción
sol2 = a%*%b
sol2



#6. Norma de un vector: modulo del vector

#6.1. Función Norm()
x = c(3,4)
library(pracma)
norma = Norm(x)
norma

#6.2. Función del producto escalar anteriormente definida
norma1 = sqrt(productoEscalar(x,x))
norma1



#7. Distancia entre dos puntos

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
a = c(0,0)
b = c(1,1)
distancia_a_b = distancia(a,b)



#8. Ángulo entre dos vectores (en radianes)

#Necesitamos la funcion de producto escalar

angulo_radianes = function(x,y){
  if (length(x) == length(y)){
    acos(x%*%y/((Norm(x)*Norm(y))))
  }
  else{
    print('No se puede calcular el ángulo entre los dos vectores
          porque no tienen la misma dimensión, no pertenecen al mismo espacio')
  }
}

#Definimos dos vectores y calculamos el angulo que forman
p = c(1,0)
q = c(0,3)
radianes = angulo_radianes(p,q)

#Pasamos los radianes a grados 
grados = (radianes*360)/(2*pi)
grados
