
########### EJERCICIOS ESPACIOS VECTORIALES ##################################################################

rm(list = ls())

# Ejercicio 1
# En el espacio vectorial R2 sobre el cuerpo R. ¿Es el vector (4, 6) 
# una combinación lineal de los vectores (1, 0) y (1, 2)?
  
# Definimos la matriz de coeficientes y el vector de términos independientes
A = matrix(c(1, 1, 0, 2), nrow = 2, byrow = TRUE)
A
b = c(4, 6)
b

# Resolvemos el sistema de ecuaciones
solucion = solve(A, b)

# Mostramos la solución
solucion

print("Sí, el vector (4, 6) una combinación lineal")
print("(4,6) = 1⋅(1,0 ) + 3⋅(1,2)")


# Ejercicio 2
# En el espacio vectorial R3 sobre el cuerpo R. ¿Es el vector (1, 0, 0) 
# una combinación lineal de los vectores (0, 3, 0) y (0, 0, 2)?

# Definimos la matriz de coeficientes y el vector de términos independientes
A <- matrix(c(3, 0, 0, 0, 3, 0, 0, 0, 2), nrow = 3, byrow = TRUE)
b <- c(1, 0, 0)

# Resolvemos el sistema de ecuaciones
solucion <- solve(A, b)

# Mostramos la solución
solucion
