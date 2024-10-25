
########### ESPACIOS VECTORIALES ##################################################################

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
A = matrix(c(1, 2, 5, -1, 4, 0), nrow = 2, byrow = TRUE)
A
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

# Comprobar si la matriz tiene inversa (solo es posible si es cuadrada)
# Si fuera cuadrada podríamos hacer lo siguiente:
# Intentar calcular la inversa usando la función solve(), que solo funciona para matrices cuadradas
tryCatch({
  inv_A <- solve(A)  # Esto debería dar un error porque A no es cuadrada
}, error = function(e) {
  message("Error: No se puede calcular la inversa porque la matriz no es cuadrada :(")
})

# *
# En el caso de que nos interesase, hay una opción de calcular una pseudoinvers de una matriz
# Cargar la librería MASS que tiene la función ginv para la pseudoinversa
install.packages("MASS")
library(MASS)

# Calcular la pseudoinversa de A
pseudo_inv_A = ginv(A)
pseudo_inv_A


###############
# Ejercicio 3 #
###############

# Opciçon 1 con PLOT

# Definir los datos
x = c(0, 1, 2)
y = c(0, 2, 5)

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
plot(x, y, pch = 19, col = "red", xlab = "x", ylab = "y", main = "Ajuste por mínimos cuadrados") +
    lines(x_linea, y_linea, col = "blue", lwd = 2) +
    legend("topleft", legend = paste("y =", round(a, 2), "x +", round(b, 2)), col = "blue", lwd = 2)

    
    
# Opción 2 con GGPLOT2

# Cargar la librería ggplot2
library(ggplot2)
    
# Crear un marco de datos con los valores de x y y
datos <- data.frame(x = c(0, 1, 2), y = c(0, 2, 5))

# Ajustar el modelo de mínimos cuadrados (regresión lineal), ajuste lineal con lm
ajuste = lm(y ~ x, data = datos)

# Extraer la pendiente (coeficiente) y la intersección
a = coef(ajuste)[2]  # pendiente
b = coef(ajuste)[1]  # intercepto

ggplot(datos, aes(x = x, y =y)) +
  geom_point(colour = "red") + # Puntos rojos
  geom_abline(slope = a, intercept = b, col='blue') + # Linea ajustada
  labs(title = "Ajuste por mínimos cuadrados", x = "x", y = "y") +
  theme_minimal()

    
# Definir los datos
# 0 = 0*m + n
# 2 = 1*m + n
# 5 = 2*m + n

#1.paso: ajustar a la recta y = mx+n (mx+n = y) nuestros datos 

A = matrix(c(0, 1, 2, 1, 1, 1), nrow = 3, byrow = TRUE)
B = matrix(c(0, 2, 5), nrow = 3, byrow = TRUE)
B
#2.paso: tipo de sistema (incompatible/compatible) con el Teorema de R-F
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

cat("Al ser matriz de rango plena por columnas significa que existe una invers lateral de A.")

#3.paso: existencia de la inversa lateral (izquierda)


#4.paso: cálculo de la matriz inversa a izquierda


#5.paso: Resolver el sistema. AX = b -> x = inversa*b
#  X = solucion



#6.paso: Graficamos


