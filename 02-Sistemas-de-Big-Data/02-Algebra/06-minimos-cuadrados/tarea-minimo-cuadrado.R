################ Mínimos cuadrados ##############################################

#Tabla de pares de datos 

#Sistema de m ecuaciones lineales de 2 incognitas: AX = b

#Sistema incompatible (Teorema de Rouché-Frobenius)

#Buscamos una recta que minimice las distancias

#Buscamos la mínima norma(Y-(AX - b))  y la llamaremos SOLUCIÓN MÍNIMO-CUADRÁTICA
#norma mínima = suma de los cuadrados mínima



##### EJEMPLO.######################################################################## 


# Cargar la librería Matrix
library(Matrix)


#La siguiente tabla indica la estatura media (la variable dependiente) en 
#centímetros para niños de 0,1,2,3 y 4 semestres de vida (la variable independiente):

# x |  0    1     2    3    4
#-------------------------------
# y | 50  66.5   75   81   86.5


# Definir los datos
# 50   = 0 * m + n
# 66.5 = 1 * m + n
# 75   = 2 * m + n
# 81   = 3 * m + n
# 86.5 = 4 * m + n


# Datos del problema
x = c(0, 1, 2, 3, 4)
y = c(50, 66.5, 75, 81, 86.5)


# 1. Paso: Ajustar los datos a la recta y = m*x + n.
#    Para ello, planteamos el sistema en forma matricial A * X = b,
#    donde X = [m; n].
#    A = [x, 1] (columna de x y columna de unos)
#    b = y
A = cbind(x, 1)  # Matriz A con la primera columna x y la segunda columna de 1s
b = matrix(y, ncol=1)  # Vector columna b con los valores de y

# 2. Paso: Comprobar el tipo de sistema (incompatible/compatible) usando el Teorema de R-F (Rouché-Frobenius)
rango_A = qr(A)$rank
rango_ampliada = qr(cbind(A, b))$rank

cat("Rango de A:", rango_A, "\n")
cat("Rango de la matriz ampliada:", rango_ampliada, "\n")

if (rango_A == rango_ampliada && rango_A == ncol(A)) {
  cat("El sistema es compatible determinado.\n")
} else if (rango_A == rango_ampliada && rango_A < ncol(A)) {
  cat("El sistema es compatible indeterminado.\n")
} else {
  cat("El sistema es incompatible. Se buscará la solución de mínimos cuadrados.\n")
}

# 3. Paso: Existencia de la inversa lateral (izquierda)
#    La inversa lateral izquierda existe si A tiene rango completo por columnas.
#    Aquí A es de dimensión 5x2, si rango_A = 2, hay rango completo por columnas.
if (rango_A == ncol(A)) {
  cat("La matriz A es de rango completo por columnas, existe inversa lateral izquierda.\n")
} else {
  cat("No existe inversa lateral izquierda.\n")
}


# 4. Paso: Cálculo de la matriz inversa a izquierda
#    Inversa a izquierda: A_inv_izq = (A^T A)^(-1) A^T
A_inv_izq = solve(t(A) %*% A) %*% t(A)

# 5. Paso: Resolver el sistema por mínimos cuadrados
#    X = A_inv_izq * b
solucion = A_inv_izq %*% b
m = solucion[1]
n = solucion[2]

cat("La solución en mínimos cuadrados es: m =", m, ", n =", n, "\n")

# 6. Paso: Graficar los datos y la recta ajustada
# Instalar y cargar ggplot2 si no está instalado
if (!requireNamespace("ggplot2", quietly = TRUE)) {
  install.packages("ggplot2")
}
library(ggplot2)

datos = data.frame(x = x, y = y)

ggplot(datos, aes(x = x, y = y)) +
  geom_point(color = "red", size = 3) +
  geom_abline(slope = m, intercept = n, color = "blue") +
  labs(title = "Ajuste por mínimos cuadrados",
       x = "Semestres",
       y = "Estatura media (cm)") +
  theme_minimal()
       