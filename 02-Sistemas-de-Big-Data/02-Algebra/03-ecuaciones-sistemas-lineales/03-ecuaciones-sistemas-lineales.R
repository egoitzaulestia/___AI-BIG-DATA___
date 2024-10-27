

################# EJERCICIOS: Ecuaciones y Sistemas Lineales con R ##############################################


rm(list=ls())


###################
### Ejercicio 1 ###
###################

# Identificar (sin programar) si los siguientes sistemas de ecuaciones son lineales 
# y en caso de que lo sean escribir en R las matrices (de coeficientes y de términos independientes) 
# asociadas a cada sistema.

# x1x2 −3x3 +2x4 = 1 
# −x1 + x2 + 2x3 = −1
# NO ES UNA ECUACIÓN LINEAL
 
# 2x1−x2−3x3 = 113 
# −x1+x2+2x3 = −1
# SÍ ES UNA ECUACIÓN LINEAL

#  2*x1 − 1*x2 − 3*x3   = 113 
# −1*x1 + 1*x2 + 2*x3   =  −1

A = rbind(c(2, 1, -3), c(-1, 1, 2))
A
b = cbind(c(133, -1))
b
ampli = cbind(A, b)
ampli


# x1+3x2−4x3 = 1 
# −10x1 −x2 −3x3x4 = 0
# NO ES UNA ECUACIÓN LINEAL


# x21+x2 = 1 
# x1−x2−3x3+x4 = 0
# NO ES UNA ECUACIÓN LINEAL




###################
### Ejercicio 2 ###
###################

# Decidir la compatibilidad de los siguientes sistemas utilizando el Teorema de Rouche-Frobenius
# y en caso de que el sistema sea compatible determinado calcular su solución.

# Sistema 1
# 1*x1 + 1*x3 = 1
# 1*x2 + 1*x3 = 1

# Definir la matriz de coeficientes A y el vector de términos independientes b
A = rbind(c(1, 0, 1), c(0, 1, 1))
b = c(1, 1)

# Crear la matriz ampliada
ampli = cbind(A, b)

# Mostrar A, b y la matriz ampliada
print("Matriz A:")
print(A)
print("Vector de términos independientes b:")
print(b)
print("Matriz ampliada (A|b):")
print(ampli)

# Calcular el rango de A y el rango de la matriz ampliada
rango_A = qr(A)$rank
rango_ampliada = qr(ampli)$rank
num_incognitas = ncol(A)

# Mostrar los rangos
print(paste("Rango de A:", rango_A))
print(paste("Rango de la matriz ampliada (A|b):", rango_ampliada))
print(paste("Número de incógnitas:", num_incognitas))

# Verificar compatibilidad
if (rango_A == rango_ampliada) {
  if (rango_A == num_incognitas) {
    print("El sistema es compatible determinado.")
  } else {
    print("El sistema es compatible indeterminado.")
  }
} else {
  print("El sistema es incompatible.")
}


# Sistema 2
# 1*x1 + 1* x2 = 2 
# 1*x1 − 1* x2 = 0

# Definir la matriz de coeficientes A y el vector de términos independientes b
A = rbind(c(1, 1), c(1, -1))
b = c(2, 0)

# Crear la matriz ampliada
ampli = cbind(A, b)

# Mostrar A, b y la matriz ampliada
print("Matriz A:")
print(A)
print("Vector de términos independientes b:")
print(b)
print("Matriz ampliada (A|b):")
print(ampli)

# Calcular el rango de A y el rango de la matriz ampliada
rango_A = qr(A)$rank
rango_ampliada = qr(ampli)$rank
num_incognitas = ncol(A)

# Mostrar los rangos
print(paste("Rango de A:", rango_A))
print(paste("Rango de la matriz ampliada (A|b):", rango_ampliada))
print(paste("Número de incógnitas:", num_incognitas))

# Verificar compatibilidad
if (rango_A == rango_ampliada) {
  if (rango_A == num_incognitas) {
    print("El sistema es compatible determinado.")
    # Calcular la solución si el sistema es compatible determinado
    sol = solve(A, b)
    print("Solución:")
    print(sol)
  } else {
    print("El sistema es compatible indeterminado.")
  }
} else {
  print("El sistema es incompatible.")
}


#  Sistema 3
# 1*x1 + 1*x2 + 1*x3 + 2*x4 = -1
# 2*x1 + 1*x2 + 1*x3 + 4*x4 = -3
# 1*x1 + 1*x2 + 1*x3 + 2*x4 = -1
# 3*x1 + 2*x3 + 4*x4        = -6


# Definir la matriz de coeficientes A y el vector de términos independientes b
A = rbind(c(1, 1, 1, 2), c(2, 1, 1, 4), c(1, 1, 1, 2), c(3, 0, 2, 4))
b = c(-1, -3, -1, -6)

# Crear la matriz ampliada
ampli = cbind(A, b)

# Mostrar A, b y la matriz ampliada
print("Matriz A:")
print(A)
print("Vector de términos independientes b:")
print(b)
print("Matriz ampliada (A|b):")
print(ampli)

# Calcular el rango de A y el rango de la matriz ampliada
rango_A = qr(A)$rank
rango_ampliada = qr(ampli)$rank
num_incognitas = ncol(A)

# Mostrar los rangos
print(paste("Rango de A:", rango_A))
print(paste("Rango de la matriz ampliada (A|b):", rango_ampliada))
print(paste("Número de incógnitas:", num_incognitas))

# Verificar compatibilidad
if (rango_A == rango_ampliada) {
  if (rango_A == num_incognitas) {
    print("El sistema es compatible determinado.")
    # Calcular la solución si el sistema es compatible determinado
    sol = solve(A, b)
    print("Solución:")
    print(sol)
  } else {
    print("El sistema es compatible indeterminado.")
  }
} else {
  print("El sistema es incompatible.")
}




#####################
### Ejercicio 3 #####
#####################

rm(list=ls())

# Cargar librería matlib
library(matlib)


# Sistema 1
# 1*x1 - 2*x2 + 1*x3 = 0
# 1*x2 - 2*x3        = 1
# 2*x3               = 6


# Paso 1: Definir el sistema en forma matricial
A1 <- rbind(c(1, -2, 1), c(0, 1, -2), c(0, 0, 2))
b1 <- c(0, 1, 6)
ampli1 <- cbind(A1, b1)

# Paso 2: Verificar compatibilidad
R_A1 <- R(A1)
R_ampli1 <- R(ampli1)
compatible1 <- R_A1 == R_ampli1
determinado1 <- R_A1 == ncol(A1)

# Paso 3: Solución (si es compatible determinado)
if (compatible1 && determinado1) {
  solucion1 <- Solve(A1, b1, fractions = TRUE)
  print("Solución del Sistema 1:")
  print(solucion1)
}

# Graficar en 3D si es compatible
if (ncol(A1) == 3 && compatible1) {
  showEqn(A1, b1)
  plotEqn3d(A1, b1, xlim = c(-5, 5), ylim = c(-5, 5), zlim = c(-5, 5))
}


# Sistema 2
# 2*x1 + 1*x2 - 1*x3 = -3
# 1*x1 - 2*x2 + 2*x3 =  1
# 2*x1 + 1*x2 + 2*x3 =  5

# Paso 1: Definir el sistema en forma matricial
A2 <- rbind(c(2, 1, -1), c(1, -2, 2), c(2, 1, 2))
b2 <- c(-3, 1, 5)
ampli2 <- cbind(A2, b2)

# Paso 2: Verificar compatibilidad
R_A2 <- R(A2)
R_ampli2 <- R(ampli2)
compatible2 <- R_A2 == R_ampli2
determinado2 <- R_A2 == ncol(A2)

# Paso 3: Solución (si es compatible determinado)
if (compatible2 && determinado2) {
  solucion2 <- Solve(A2, b2, fractions = TRUE)
  print("Solución del Sistema 2:")
  print(solucion2)
}
solucion2

# Graficar en 3D si es compatible
if (ncol(A2) == 3 && compatible2) {
  showEqn(A2, b2)
  plotEqn3d(A2, b2, xlim = c(-5, 5), ylim = c(-5, 5), zlim = c(-5, 5))
}


# Sistema 3
# 1*x1 + 2*x2 = 2
# 1*x1 - 1*x2 = 0

# Paso 1: Definir el sistema en forma matricial
A3 <- rbind(c(1, 2), c(1, -1))
b3 <- c(2, 0)
ampli3 <- cbind(A3, b3)

# Paso 2: Verificar compatibilidad
R_A3 <- R(A3)
R_ampli3 <- R(ampli3)
compatible3 <- R_A3 == R_ampli3
determinado3 <- R_A3 == ncol(A3)

# Paso 3: Solución (si es compatible determinado)
if (compatible3 && determinado3) {
  solucion3 <- Solve(A3, b3, fractions = TRUE)
  print("Solución del Sistema 3:")
  print(solucion3)
}

# Graficar en 2D si es compatible
if (ncol(A3) == 2 && compatible3) {
  showEqn(A3, b3)
  plotEqn(A3, b3, xlim = c(-5, 5), ylim = c(-5, 5))
}
