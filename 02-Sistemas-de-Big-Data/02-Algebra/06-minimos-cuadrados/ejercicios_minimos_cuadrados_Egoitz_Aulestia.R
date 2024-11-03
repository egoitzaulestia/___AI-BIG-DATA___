
########### EJERCICIOS MÍNIMOS CUADRADOS ##################################################################

rm(list = ls())

###############
# Ejercicio 1 #
###############

# Determinar si las siguientes matrices son de rango pleno por filas o por columnas.

# Cargar la librería Matrix
library(Matrix)


#####################
# Definir la matriz A
A = matrix(c(1, 2, 0), nrow = 1, ncol = 3)

# Calcular el rango de la matriz usando la descomposición QR
rango = qr(A)$rank

# Mostrar el rango de la matriz
cat("El rango de la matriz A es:", rango, "\n")

# Verificar si es de rango pleno por filas o columnas
num_filas = nrow(A)
num_columnas = ncol(A)

# Resultados
if (rango == num_filas) {
  cat("La matriz A es de rango pleno por filas.\n")
} else {
  cat("La matriz A no es de rango pleno por filas.\n")
}

if (rango == num_columnas) {
  cat("La matriz A es de rango pleno por columnas.\n")
} else {
  cat("La matriz A no es de rango pleno por columnas.\n")
}


#####################
# Definir la matriz B
B = matrix(c(2, 1, 5, -1, 1, 3), nrow = 2, ncol = 3)

# Calcular el rango de la matriz
rango = qr(B)$rank

# Mostrar el rango de la matriz
cat("El rango de la matriz B es:", rango, "\n")

# Verificar si es de rango pleno por filas o columnas
num_filas = nrow(B)
num_columnas = ncol(B)

# Resultados
if (rango == num_filas) {
  cat("La matriz B es de rango pleno por filas.\n")
} else {
  cat("La matriz B no es de rango pleno por filas.\n")
}

if (rango == num_columnas) {
  cat("La matriz B es de rango pleno por columnas.\n")
} else {
  cat("La matriz B no es de rango pleno por columnas.\n")
}


#####################
# Definir la matriz C
C = matrix(c(1, 0, -1, 1, 2, 0, 1, 1), nrow = 4, ncol = 2)

# Calcular el rango de la matriz
rango = qr(C)$rank

# Mostrar el rango de la matriz
cat("El rango de la matriz C es:", rango, "\n")

# Verificar si es de rango pleno por filas o columnas
num_filas = nrow(C)
num_columnas = ncol(C)

# Resultados
if (rango == num_filas) {
  cat("La matriz B es de rango pleno por filas.\n")
} else {
  cat("La matriz B no es de rango pleno por filas.\n")
}

if (rango == num_columnas) {
  cat("La matriz B es de rango pleno por columnas.\n")
} else {
  cat("La matriz B no es de rango pleno por columnas.\n")
}


#####################
# Definir la matriz D
D = matrix(c(1, 2, 5, -1, 4, 0), nrow = 2, ncol = 4)

# Calcular el rango de la matriz
rango = qr(D)$rank

# Mostrar el rango de la matriz
cat("El rango de la matriz D es:", rango, "\n")

# Verificar si es de rango pleno por filas o columnas
num_filas = nrow(D)
num_columnas = ncol(D)

# Resultados
if (rango == num_filas) {
  cat("La matriz B es de rango pleno por filas.\n")
} else {
  cat("La matriz B no es de rango pleno por filas.\n")
}

if (rango == num_columnas) {
  cat("La matriz B es de rango pleno por columnas.\n")
} else {
  cat("La matriz B no es de rango pleno por columnas.\n")
}



###############
# Ejercicio 2 #
###############

rm(list = ls())

# Definir la matriz A
A <- matrix(c(1, 2, 5, -1, 4, 0), nrow = 2, byrow = TRUE)
A

# Verificar el rango de A para confirmar si es de rango completo por filas
rango <- qr(A)$rank
cat("El rango de la matriz A es:", rango, "\n")

# Número de filas y columnas
num_filas <- nrow(A)
num_columnas <- ncol(A)

# Comprobamos si la matriz es de rango completo por filas
if (rango == num_filas) {
  cat("La matriz A es de rango pleno por filas, por lo que tiene inversa a la derecha.\n")
} else {
  cat("La matriz A no es de rango pleno por filas, por lo que no tiene inversa a la derecha.\n")
}

# Calcular la pseudo-inversa derecha usando la fórmula: A_derecha_inv = t(A) %*% solve(A %*% t(A))
A_derecha_inv <- t(A) %*% solve(A %*% t(A))
cat("La inversa a la derecha de A es:\n")
print(A_derecha_inv)




###############
# Ejercicio 3 #
###############

    
# Definir los datos
# 0 = 0*m + n
# 2 = 1*m + n
# 5 = 2*m + n

# Cargar la librería necesaria
library(Matrix)

# Datos del ejercicio
x = c(0, 1, 2)
y = c(0, 2, 5)

# Paso 1: Ajuste de los datos a la recta y = ax + b
# La forma de la ecuación en mínimos cuadrados es: A * X = b, donde X = [a, b]
# A = [x, 1] y b = y
A = cbind(x, 1)  # Matriz con las x y una columna de 1s
b = matrix(y, nrow = 3, byrow = TRUE)  # Vector columna con los valores de y

# Paso 2: Determinar el tipo de sistema (compatible o incompatible) mediante el Teorema de Rouché-Frobenius
rango_A = qr(A)$rank
rango_ampliada = qr(cbind(A, b))$rank

cat("Rango de A:", rango_A, "\n")
cat("Rango de la matriz ampliada:", rango_ampliada, "\n")

if (rango_A == rango_ampliada && rango_A == ncol(A)) {
  cat("El sistema es compatible determinado.\n")
} else {
  cat("El sistema es incompatible, buscamos la solución de mínimos cuadrados.\n")
}

# Paso 3 y 4: Verificar la existencia de la inversa lateral izquierda y calcularla
A_inv_izquierda = solve(t(A) %*% A) %*% t(A)

# Paso 5: Resolver el sistema utilizando la inversa lateral
solucion = A_inv_izquierda %*% b
cat("La solución es: a =", solucion[1], ", b =", solucion[2], "\n")

# Paso 6: Graficar los puntos y la recta de ajuste
# Instalar y cargar ggplot2 solo si aún no está instalado
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

# Crear un data frame para los puntos
datos = data.frame(x = x, y = y)

# Graficar los puntos y la recta de ajuste
ggplot(datos, aes(x = x, y = y)) +
  geom_point(color = "red", size = 3) +
  geom_abline(slope = solucion[1], intercept = solucion[2], color = "blue") +
  labs(title = "Ajuste de mínimos cuadrados", x = "X", y = "Y") +
  theme_minimal()

