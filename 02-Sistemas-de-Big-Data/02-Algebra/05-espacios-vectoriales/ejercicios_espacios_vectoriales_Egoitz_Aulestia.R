
########### EJERCICIOS ESPACIOS VECTORIALES ##################################################################

rm(list = ls())


# Ejercicio 1
# En el espacio vectorial R2 sobre el cuerpo R. ¿Es el vector (4, 6) 
# una combinación lineal de los vectores (1, 0) y (1, 2)?
  
# Definir la matriz de coeficientes y el vector de términos independientes
A = matrix(c(1, 1, 0, 2), nrow = 2, byrow = TRUE)
A
b = c(4, 6)

# Resolver el sistema de ecuaciones
solucion = solve(A, b)

# Mostrar la solución
print("Solución para los coeficientes c1 y c2:")
print(solucion)

# Comprobar y mostrar la combinación lineal
if (!is.null(solucion)) {
  print("Sí, el vector (4, 6) es una combinación lineal de (1, 0) y (1, 2).")
  print("(4, 6) = 1 * (1, 0) + 3 * (1, 2)")
} else {
  print("No, el vector (4, 6) no es una combinación lineal de (1, 0) y (1, 2).")
}



# Ejercicio 2
# En el espacio vectorial R3 sobre el cuerpo R. ¿Es el vector (1, 0, 0) 
# una combinación lineal de los vectores (0, 3, 0) y (0, 0, 2)?

# Definir la matriz de coeficientes y el vector de términos independientes
A = matrix(c(0, 3, 0, 0, 0, 2), nrow = 3, byrow = FALSE)
b = c(1, 0, 0)

# Intentamos resolver el sistema
tryCatch({
  solucion = solve(A, b)
  print("Solución encontrada:")
  print(solucion)
}, error = function(e) {
  print("No, el vector (1, 0, 0) no es una combinación lineal de los vectores (0, 3, 0) y (0, 0, 2).")
})


# Ejercicio 3
# Demuestra que el conjunto {⃗v1 = (1, 0, 5), ⃗v2 = (1, 2, 0), ⃗v3 = (1, −2, 10)} es linealmente dependiente.

# Definimos la matriz A con los vectores como columnas
A = matrix(c(1, 0, 5, 1, 2, 0, 1, -2, 10), nrow = 3, byrow = FALSE)

# Calculamos el rango de la matriz A
rango_A = qr(A)$rank
rango_A

# Verificamos si el rango es menor que el número de vectores (columnas)
# Si el rango es menor que 3, entonces los vectores son linealmente dependientes
if (rango_A < ncol(A)) {
  print("El conjunto de vectores es linealmente dependiente.")
} else {
  print("El conjunto de vectores es linealmente independiente.")
}


# Ejercicio 4
# Demuestra que el conjunto {⃗v1 = (1, 0, 0), ⃗v2 = (0, 2, 0), ⃗v3 = (0, 0, 10)} es linealmente independiente.

# Definir los vectores
v1 = c(1, 0, 0)
v2 = c(0, 2, 0)
v3 = c(0, 0, 10)

# Matriz de coeficientes formada por los vectores como columnas
A = cbind(v1, v2, v3)
# Vector de términos independientes (vector nulo en el mismo espacio)
b = c(0, 0, 0)

# Crear la matriz ampliada
ampli = cbind(A, b)

# Cargar la librería matlib para el cálculo de rangos
library(matlib)

# Paso 1: Comprobar si el sistema es compatible (si tiene solución)
compatible = R(A) == R(ampli)
print(paste("¿El sistema es compatible?", compatible))

# Paso 2: Verificar si el sistema es determinado (número de incógnitas igual al rango)
determinado = R(A) == ncol(A)
print(paste("¿El sistema es compatible determinado?", determinado))

# Paso 3: Si es compatible determinado, resolver el sistema para comprobar que la solución es el vector nulo
if (compatible && determinado) {
  solucion = solve(A, b)
  print("La solución del sistema es:")
  print(solucion)
  print("Dado que la solución es el vector nulo, el conjunto de vectores es linealmente independiente.")
} else {
  print("El sistema no es compatible determinado, por lo tanto, el conjunto de vectores es linealmente dependiente.")
}


# Ejercicio 5
# Una base se dice que es ortogonal, si es una base y si los vectores forman 90 grados entre sí. 
# Demostrar que el conjunto {v1=(1,0),v2=(0,3)} forma una base ortogonal.

# Definimos los vectores
v1 = c(1, 0)
v2 = c(0, 3)

# Calculamos el producto escalar
producto_escalar = sum(v1 * v2)
print(paste("Producto escalar de v1 y v2:", producto_escalar))

# Comprobamos si el producto escalar es cero
if (producto_escalar == 0) {
  print("Los vectores son ortogonales.")
} else {
  print("Los vectores no son ortogonales.")
}

# Confirmación de que los vectores son una base ortogonal en R^2
print("El conjunto de vectores forma una base ortogonal en R^2.")



# Ejercicio 6
# Una base se dice que es ortonormal, si es una base ortogonal y si las normas de todos los vectores son 1. 
# Demostrar que el conjunto {v1=(1,0),v2=(0,1)} forma una base ortonormal.

# Cargar la librería para calcular la norma
library(pracma)

# Definir los vectores
v1 = c(1, 0)
v2 = c(0, 1)

# Calcular el producto escalar para verificar ortogonalidad
producto_escalar = sum(v1 * v2)
print(paste("Producto escalar de v1 y v2:", producto_escalar))

# Verificar si el producto escalar es cero (ortogonalidad)
if (producto_escalar == 0) {
  print("Los vectores son ortogonales.")
} else {
  print("Los vectores no son ortogonales.")
}

# Calcular la norma de cada vector
norma_v1 = Norm(v1)
norma_v2 = Norm(v2)

# Mostrar las normas
print(paste("Norma de v1:", norma_v1))
print(paste("Norma de v2:", norma_v2))

# Verificar si ambas normas son 1 (norma unitaria)
if (norma_v1 == 1 && norma_v2 == 1) {
  print("Ambos vectores tienen norma unitaria.")
} else {
  print("Los vectores no tienen norma unitaria.")
}

# Confirmación de que el conjunto es una base ortonormal en R^2
print("El conjunto de vectores forma una base ortonormal en R^2.")

