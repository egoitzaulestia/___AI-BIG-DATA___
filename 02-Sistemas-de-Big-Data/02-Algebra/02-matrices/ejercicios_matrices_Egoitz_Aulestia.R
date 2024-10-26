rm(list=ls())

######################## Ejercicio Matrices con R ########################################

# Carmos la libreía Matrix (para entrar en la simulación XP)
library(Matrix)


######## Ejercicio 1 ##########

# Demostrar que se cumple la igualdad AI3 = A donde

# Definir la matriz A
A = matrix(c(3, 1, 2, 1, 1, 3), nrow = 2, byrow = TRUE)

# Imprimir la matriz A
print("Matriz A:")
print(A)

# Definir la matriz identidad I3 de tamaño 3
I3 = diag(1, 3)

# Imprimir la matriz identidad I3
print("Matriz identidad I3:")
print(I3)

# Multiplicar la matriz A por la matriz identidad I3
resultado = A %*% I3

# Imprimir el resultado de la multiplicación
print("Resultado de A * I3:")
print(resultado)

# Verificar si el resultado es igual a la matriz A original
if (all(resultado == A)) {
  print("La igualdad A * I3 = A se cumple.")
} else {
  print("La igualdad A * I3 = A no se cumple.")
}




######## Ejercicio 2 ##########

# Instalar y cargar el paquete matlib (si no lo tienes instalado)
# install.packages("matlib")
library(matlib)

# Definir la matriz B
B = matrix(c(2, 1, 2, 1, 0, 3), nrow = 2, byrow = TRUE)

# Imprimir la matriz B
print("Matriz B:")
print(B)

# Calcular la matriz escalonada reducida
matriz_escalonada_reducida = echelon(B, verbose = TRUE, fractions = TRUE)

# Otra opción para calcular la matriz escalonada es  la función gaussianElimination 
# matriz_escalonada_reducida <- gaussianElimination(B, verbose = TRUE, fractions = TRUE)

# Mostrar el resultado
print("Matriz escalonada reducida de B:")
print(matriz_escalonada_reducida)




######## Ejercicio 3 ##########

# Proposicion. Sean A, B ∈ Mm×n(K) dos matrices cualesquiera. Entonces, se cumple que
# rg(A) = rg(kA) 0 ̸= k ∈ K

# Definimos dos matrices "A" y "B"
A = matrix(c(1, 2, 3, 4, 5, 6), nrow = 2, byrow = TRUE)
B = matrix(c(2, 4, 6, 1, 0, -1), nrow = 2, byrow = TRUE)

# Definimos un escalar distinto
k = 3

# Calcular el rango de A y el rango de kA
rango_A = rankMatrix(A)[1]
rango_kA = rankMatrix(k * A)[1]

# Calcular el rango de B y el rango de kA
rango_B = rankMatrix(B)[1]
rango_kB = rankMatrix(k * B)[1]


# Mostrar los resultados para A
print(paste("Rango de A:", rango_A))
print(paste("Rango de kA:", rango_kA))

# Verificar si los rangos de A son iguales
if (rango_A == rango_kA) {
  print("Se cumple que rg(A) = rg(kA) para la matriz A.")
} else {
  print("No se cumple que rg(A) = rg(kA) para la matriz A.")
}

# Mostrar los resultados para B
print(paste("Rango de B:", rango_B))
print(paste("Rango de kB:", rango_kB))

# Verificar si los rangos de B son iguales
if (rango_B == rango_kB) {
  print("Se cumple que rg(B) = rg(kB) para la matriz B.")
} else {
  print("No se cumple que rg(B) = rg(kB) para la matriz B.")
}




######## Ejercicio 4 ##########

# Primera igualdad: tr(A + B) = tr(A) + tr(B)

# Definir dos matrices cuadradas A y B
A = matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE)
B = matrix(c(5, 6, 7, 8), nrow = 2, byrow = TRUE)

# Calcular la traza de A, B y A + B
tr_A = sum(diag(A))  # tr(A)
tr_B = sum(diag(B))  # tr(B)
tr_A_plus_B = sum(diag(A + B))  # tr(A + B)

# Verificar la igualdad
print(paste("tr(A + B):", tr_A_plus_B))
print(paste("tr(A) + tr(B):", tr_A + tr_B))

if (tr_A_plus_B == (tr_A + tr_B)) {
  print("La igualdad tr(A + B) = tr(A) + tr(B) se cumple.")
} else {
  print("La igualdad tr(A + B) = tr(A) + tr(B) no se cumple.")
}

# Segunda igualdad: tr(kA) = k * tr(A)

# Definir un escalar k
k = 3

# Calcular la traza de kA
tr_kA = sum(diag(k * A))  # tr(kA)
tr_A_escalado = k * tr_A  # k * tr(A)

# Verificar la igualdad
print(paste("tr(kA):", tr_kA))
print(paste("k * tr(A):", tr_A_escalado))

if (tr_kA == tr_A_escalado) {
  print("La igualdad tr(kA) = k * tr(A) se cumple.")
} else {
  print("La igualdad tr(kA) = k * tr(A) no se cumple.")
}




######## Ejercicio 5 ##########

# Definir dos matrices cuadradas A y B
A = matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE)
B = matrix(c(5, 6, 7, 8), nrow = 2, byrow = TRUE)

# Calcular la traza de AB
AB = A %*% B  # Multiplicar A por B
tr_AB = sum(diag(AB))  # Calcular la traza de AB

# Calcular la traza de BA
BA = B %*% A  # Multiplicar B por A
tr_BA = sum(diag(BA))  # Calcular la traza de BA

# Mostrar los resultados
print(paste("tr(AB):", tr_AB))
print(paste("tr(BA):", tr_BA))

# Verificar si las trazas son iguales
if (tr_AB == tr_BA) {
  print("Se cumple que tr(AB) = tr(BA).")
} else {
  print("No se cumple que tr(AB) = tr(BA).")
}




######## Ejercicio 6 ##########

# Cargar el paquete matlib 
library(matlib)

# Definir la matriz A
A = matrix(c(3, 6, -5, 0,
             1, 1, 2, 9,
             2, 4, -3, 1), 
           nrow = 3, byrow = TRUE)

# Mostrar la matriz A
print("Matriz A:")
print(A)

# Calcular el rango de la matriz A
rango_A = rankMatrix(A)[1]  # Calcular el rango de A

# Convertir A a su forma escalonada usando echelon()
A_escalonada = echelon(A, verbose = FALSE)

# Calcular el rango de la matriz escalonada (la forma escalonada)
rango_escalonada = rankMatrix(A_escalonada)[1]

# Mostrar los resultados
print(paste("Rango de A:", rango_A))
print(paste("Rango de la matriz escalonada de A:", rango_escalonada))

# Verificar si los rangos coinciden
if (rango_A == rango_escalonada) {
  print("Los rangos coinciden.")
} else {
  print("Los rangos no coinciden.")
}




######## Ejercicio 7 ##########

# Definir la matriz A
A = matrix(c(1, 3, -1,
             0, 2, 3,
             -1, 0, 2), 
           nrow = 3, byrow = TRUE)

# Mostrar la matriz A
print("Matriz A:")
print(A)

# Calcular el determinante de A para verificar si es invertible
det_A = det(A)

# Mostrar el determinante de A
print(paste("Determinante de A:", det_A))

# Verificar si la matriz es invertible
if (det_A != 0) {
  print("La matriz A es invertible.")
  
  # Calcular la inversa de A usando solve()
  inversa_A = solve(A)
  
  # Mostrar la inversa de A
  print("Inversa de A:")
  print(inversa_A)
  
} else {
  print("La matriz A no es invertible.")
}



######## Ejercicio 8 ##########
# Calcular A4 y A6 siendo A la matriz del anterior ejercicio.

# Instalar y cargar el paquete expm si no está instalado
library(expm)

# Calcular A^4
A4 = A %^% 4

# Calcular A^6
A6 = A %^% 6

# Mostrar los resultados
print("Matriz A^4:")
print(A4)

print("Matriz A^6:")
print(A6)


# Sin usar lalibrería expm
# Calcular A^2
A2 = A %*% A

# Calcular A^4 como (A^2)^2
A4 = A2 %*% A2

# Calcular A^6 como A^4 %*% A^2
A6 = A4 %*% A2

# Mostrar los resultados
print("Matriz A^4:")
print(A4)

print("Matriz A^6:")
print(A6)



######## Ejercicio 9 ##########

# Condiciones para ser una matriz escalonada reducida por filas:
#   1 - Cada fila no nula tiene un 1 principal (pivote).
#   2 - Cada 1 principal es el único número distinto de 
#       cero en su columna.
#   3 - Los 1 principales de cada fila están más a la derecha 
#       que los 1 principales de la fila anterior.
#   4 - Las filas completamente cero, si existen, 
#       deben estar en la parte inferior de la matriz.


#       2 0 0  5
# A = ( 0 1 0 -2 )
#       0 0 1  4

# Conclusión:
#   - La matriz A no es escalonada reducida por filas, 
#     ya que el primer pivote debería ser 1 en lugar de 2


#       1 0 0  5
# B = ( 0 1 0 -2 )
#       0 1 1  4

# Conclusión:
#   - La matriz B no es escalonada reducida por filas, 
#     ya que la tercera fila contiene un valor no nulo 
#     en una columna que ya tiene un pivote en una fila superior.


#       1 0 0  5
# C = ( 0 1 1 -2 )
#       0 0 1  4

# Conclusión:
#   - La matriz C no es escalonada reducida por filas, 
#     ya que la segunda fila tiene un valor no nulo 
#     en la misma columna del pivote de la tercera fila.


#       1 0 0  5
# D = ( 0 1 0 -2 )
#       0 0 1  4

# Pivotes:
#   - Fila 1: El valor en la posición (1,1) es 1.
#   - Fila 2: El valor en la posición (2,2) es 1.
#   - Fila 3: El valor en la posición (3,3) es 1.

# Verificación de las condiciones:
#   - Cada fila no nula tiene un pivote 1 en una posición diferente
#     y más a la derecha que el pivote de la fila anterior.
#   - Los pivotes 1 son los únicos valores distintos de cero en sus 
#     columnas respectivas.

# Conclusión:
#   - La matriz D sí es una matriz escalonada reducida por filas, 
#     ya que cumple todas las condiciones para serlo.




######## Ejercicio 10 ##########

# Crear una matriz de 3 filas y 4 columnas de un solo elemento no nulo, 
# y calcular la suma y el producto de todos los elementos de la matriz.

# Crear una matriz de 3 filas y 4 columnas con todos los elementos en cero
matriz = matrix(0, nrow = 3, ncol = 4)

# Asignar un único valor no nulo en la posición (2,3) por ejemplo
matriz[2, 3] = 5  # Puedes cambiar el valor si deseas otro número no nulo

# Mostrar la matriz
print("Matriz:")
print(matriz)

# Calcular la suma de todos los elementos de la matriz
suma_elementos = sum(matriz)

# Calcular el producto de todos los elementos de la matriz
producto_elementos = prod(matriz)

# Mostrar los resultados
print(paste("Suma de todos los elementos:", suma_elementos))
print(paste("Producto de todos los elementos:", producto_elementos))




######## Ejercicio 11 ##########

# Crear la matriz I4 de dos maneras diferentes.

# Método 1: Usar la función diag() para crear una matriz identidad de tamaño 4x4
I4_m1 = diag(4)

# Mostrar la matriz creada con el primer método
print("Matriz I4 creada con el método 1:")
print(I4_m1)

# Método 2: Crear una matriz de ceros y asignar 1s en la diagonal manualmente
I4_m2 = matrix(0, nrow = 4, ncol = 4)
diag(I4_m2) = 1

# Mostrar la matriz creada con el segundo método
print("Matriz I4 creada con el método 2:")
print(I4_m2)




######## Ejercicio 12 ##########

# Demostrar mediante un ejemplo que la multiplicación de matrices no es conmutativa.
# ( A × B ) != ( B × A )

# Definir la matriz A
A = matrix(c(4, 8, 2, 6), nrow = 2, byrow = TRUE)

# Definir la matriz B
B = matrix(c(1, 3, 9, 7), nrow = 2, byrow = TRUE)

# Calcular A * B
AB = A %*% B

# Calcular B * A
BA = B %*% A

# Mostrar los resultados
print("Matriz A:")
print(A)

print("Matriz B:")
print(B)

print("Producto A * B:")
print(AB)

print("Producto B * A:")
print(BA)

# Comprobar si son iguales
if (all(AB == BA)) {
  print("La multiplicación es conmutativa en este caso, A * B = B * A")
} else {
  print("La multiplicación no es conmutativa, A * B != B * A")
}




######## Ejercicio 13 ##########

# Sea A la matriz cuadrada A ∈ Mn(K) dada por:

#           1 3          #
#           0 2          #

# Razonar mediante la equivalencia 2 del teorema de caracterización 
# si A es invertible o no, y en caso de que sí lo sea calcular su inversa.

# Definir la matriz A
A = matrix(c(1, 3, 0, 2), nrow = 2, byrow = TRUE)

# Mostrar la matriz A
print("Matriz A:")
print(A)

# Calcular el determinante de A
det_A = det(A)

# Mostrar el determinante de A
print(paste("Determinante de A:", det_A))

# Verificar si la matriz es invertible
if (det_A != 0) {
  print("La matriz A es invertible.")
  
  # Calcular la inversa de A
  inversa_A = solve(A)
  
  # Mostrar la inversa de A
  print("Inversa de A:")
  print(inversa_A)
  
} else {
  print("La matriz A no es invertible.")
}




######## Ejercicio 14 ##########

# Sea B la matriz cuadrada A ∈ Mn(K) dada por:

#           0 3          #
#           0 6          #

# Razonar mediante la propiedad del determinante si B es invertible o no, 
# y en caso de que sí lo sea calcular su inversa.

# Definir la matriz B
B = matrix(c(0, 3, 0, 6), nrow = 2, byrow = TRUE)

# Calcular el determinante de B
det_B = det(B)

# Mostrar el determinante
print(paste("Determinante de B:", det_B))

# Verificar si la matriz es invertible
if (det_B != 0) {
  print("La matriz B es invertible.")
  # Calcular la inversa de B
  inversa_B = solve(B)
  print("Inversa de B:")
  print(inversa_B)
} else {
  print("La matriz B no es invertible.")
}
