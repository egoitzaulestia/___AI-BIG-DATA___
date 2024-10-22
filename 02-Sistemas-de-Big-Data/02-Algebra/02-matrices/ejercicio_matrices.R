rm(list=ls())

######################## Ejercicio Matrices con R ########################################

library(Matrix)

# Ejercicio 1
# Demostrar que se cumple la igualdad AI3 = A donde

# Definir la matriz A
A <- matrix(c(3, 1, 2, 1, 1, 3), nrow = 2, byrow = TRUE)

# Imprimir la matriz A
print("Matriz A:")
print(A)

# Definir la matriz identidad I3 de tamaño 3
I3 <- diag(1, 3)

# Imprimir la matriz identidad I3
print("Matriz identidad I3:")
print(I3)

# Multiplicar la matriz A por la matriz identidad I3
resultado <- A %*% I3

# Imprimir el resultado de la multiplicación
print("Resultado de A * I3:")
print(resultado)

# Verificar si el resultado es igual a la matriz A original
if (all(resultado == A)) {
  print("La igualdad A * I3 = A se cumple.")
} else {
  print("La igualdad A * I3 = A no se cumple.")
}



# Ejercicio 2

# Instalar y cargar el paquete matlib (si no lo tienes instalado)
# install.packages("matlib")
library(matlib)

# Definir la matriz B
B = matrix(c(2, 1, 2, 1, 0, 3), nrow = 2, byrow = TRUE)

# Imprimir la matriz B
print("Matriz B:")
print(B)

# Calcular la matriz escalonada reducida
matriz_escalonada_reducida <- echelon(B, verbose = TRUE, fractions = TRUE)

# Otra opción para calcular la matriz escalonada es  la función gaussianElimination 
# matriz_escalonada_reducida <- gaussianElimination(B, verbose = TRUE, fractions = TRUE)


# Mostrar el resultado
print("Matriz escalonada reducida de B:")
print(matriz_escalonada_reducida)




# Ejercicio 3
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
A <- matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE)
B <- matrix(c(5, 6, 7, 8), nrow = 2, byrow = TRUE)

# Calcular la traza de A, B y A + B
tr_A <- sum(diag(A))  # tr(A)
tr_B <- sum(diag(B))  # tr(B)
tr_A_plus_B <- sum(diag(A + B))  # tr(A + B)

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
k <- 3

# Calcular la traza de kA
tr_kA <- sum(diag(k * A))  # tr(kA)
tr_A_escalado <- k * tr_A  # k * tr(A)

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
A <- matrix(c(1, 2, 3, 4), nrow = 2, byrow = TRUE)
B <- matrix(c(5, 6, 7, 8), nrow = 2, byrow = TRUE)

# Calcular la traza de AB
AB <- A %*% B  # Multiplicar A por B
tr_AB <- sum(diag(AB))  # Calcular la traza de AB

# Calcular la traza de BA
BA <- B %*% A  # Multiplicar B por A
tr_BA <- sum(diag(BA))  # Calcular la traza de BA

# Mostrar los resultados
print(paste("tr(AB):", tr_AB))
print(paste("tr(BA):", tr_BA))

# Verificar si las trazas son iguales
if (tr_AB == tr_BA) {
  print("Se cumple que tr(AB) = tr(BA).")
} else {
  print("No se cumple que tr(AB) = tr(BA).")
}




######## Ejercicio 5 ##########

# Definir la matriz A
A <- matrix(c(3, 6, -5, 0,
              1, 1, 2, 9,
              2, 4, -3, 1), 
            nrow = 3, byrow = TRUE)

# Mostrar la matriz A
print("Matriz A:")
print(A)

# Calcular el rango de la matriz A
rango_A <- rankMatrix(A)[1]  # Calcular el rango de A

# Convertir A a su forma escalonada reducida (forma fila reducida por Gauss-Jordan)
A_escalonada <- gaussianElimination(A, verbose = FALSE)

# Calcular el rango de la matriz escalonada
rango_escalonada <- rankMatrix(A_escalonada)[1]

# Mostrar los resultados
print(paste("Rango de A:", rango_A))
print(paste("Rango de la matriz escalonada de A:", rango_escalonada))

# Verificar si los rangos coinciden
if (rango_A == rango_escalonada) {
  print("Los rangos coinciden.")
} else {
  print("Los rangos no coinciden.")
}