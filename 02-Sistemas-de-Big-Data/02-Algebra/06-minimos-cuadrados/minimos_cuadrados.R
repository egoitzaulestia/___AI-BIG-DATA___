
########### ESPACIOS VECTORIALES ##################################################################

rm(list = ls())


# Ejercicio 1
# Determinar si las siguientes matrices son de rango pleno por filas o por columnas.

# Cargar la librería Matrix
library(Matrix)

# Definir la matriz A
A <- matrix(c(1, 2, 0), nrow = 1, ncol = 3)

# Calcular el rango de la matriz usando la descomposición QR
rango <- qr(A)$rank
rango
# Verificar si es de rango pleno por filas o columnas
num_filas <- nrow(A)
num_columnas <- ncol(A)

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

# Mostrar el rango de la matriz
cat("El rango de la matriz A es:", rango, "\n")



# b
# Definir la matriz A
B = matrix(c(2, 1, 5, -1, 1, 3), nrow = 2, ncol = 3)

# Calcular el rango de la matriz
rango = rankMatrix(B)
rango

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



# Definir los datos
x = c(0, 1, 2)
y <- c(0, 2, 5)

# Ajustar el modelo de mínimos cuadrados (regresión lineal)
ajuste = lm(y ~ x)

# Obtener los coeficientes de la recta (pendiente y ordenada)
a = coef(ajuste)[2]  # pendiente
b = coef(ajuste)[1]  # intercepto

a
b

# Generar los valores de la recta ajustada
x_linea = seq(min(x), max(x), length.out = 100)
y_linea = a * x_linea + b

# Graficar los puntos y la recta ajustada
plot(x, y, pch = 19, col = "red", xlab = "x", ylab = "y", main = "Ajuste por mínimos cuadrados")
    lines(x_linea, y_linea, col = "blue", lwd = 2)
    legend("topleft", legend = paste("y =", round(a, 2), "x +", round(b, 2)), col = "blue", lwd = 2)

