rm(list=ls())


######################## Matrices con R ########################################


# CREAR MATRICES.


# 1. Función: matrix() 

# Los datos de la matriz deben ir en un vector c()

# Indicar nímero de filas/columnas con nrow/ncol

# Parametro lógico byrow para indicar si queremos escribir los numeros del vector por fila o por columna

a=c(1,2,3,4)

#crear una fila:
row = matrix(c(1,2,3,4), nrow = 1)
row

#crear una columna: 
col = matrix(c(1,2,3), ncol = 1)
col


#Por fila
A = matrix(c(1,1,3,5,2,4,3,-2,-2,2,-1,3), nrow = 3, ncol = 4, 
           byrow = TRUE)
A

#Por columna
B = matrix(c(1,0,2,3,3,2,1,-2,3), nrow = 3, byrow = FALSE)
B


# 2. Funciones: rbind(), cbind() 

# Las columnas/filas se definen con la función c()
C = rbind(c(1,2,3),c(4,5,6),c(7,8,9))
C

D = cbind(c(1,2,3),c(4,5,6),c(7,8,9))
D




# ACCEDER A UNA MATRIZ.

#Acceder a un elemento: A[i,j]
A[3,3]

#Acceder a una fila 
A[1,]

#Acceder a una columna
A[,3]

#Acceder a dos filas 
A[c(1,2),]

#Acceder a dos columnas
A[,c(1,3)]



# CREAR MATRICES DE UN SOLO ELEMENTO:
ceros = matrix(0,nrow = 3,ncol = 3)
ceros

unos = matrix(1,nrow = 3,ncol = 3)
unos




# MATRIZ DIAGONAL:

# Para crear una matriz diagonal:
# el parámetro de la funcion diag() es un vector que serán los elementos de la diagonal

E = diag(c(1,2,3,4,5,6))
E

# Acceder a la diagonal de una matriz: el parámetro de la funcion diag() es la matriz

diag(D)

#Matriz identidad: 1-s en la diagonal y 0-s en el resto de posiciones

# podemos definir un vector de 1-s
diag(c(1,1,1))


# podemos indicarle la dimensión de la matriz
diag(1)
diag(2) 
diag(3)



# DIMENSIÓN DE UNA MATRIZ:


#Numero de filas
nrow(E)

#Numero de columnas
ncol(E)

#filas y columnas
dim(D)



# OPERACIONES SOBRE MATRICES:

D = cbind(c(1,2,3),c(4,5,6),c(7,8,9))
D

#sumar todos los elementos: sum()
sum(D)

#sumar por filas
rowSums(D)

#sumar por columnas
colSums(D)

#producto de todos los elementos: prod()
prod(D)

#media de todos los elementos: mean()
mean(D)

#media por filas: rowMeans()
rowMeans(D)

#media por columnas: colMeans()
colMeans(D)


#Traspuesta de una matriz: t()
tras = t(D)
tras

#Traza de una matriz: sum(diag())
traza = sum(diag(D))
traza

#Sumar dos matrices: + (conmutativa)
suma = C+D
suma2 = D+C 

#Restar dos matrices: - (conmutativa)
resta = C-D

#Producto de matrices: %*% (NO conmutativa)
producto = C%*%D
producto
producto2 = D%*%C
producto2
producto == producto2

#OBSERVACIÓN!
#no es que C*D nos devuelva un error, sino que no multiplica las matrices como tal, 
#es otro tipo de producto.
C*D
C
D


# IGUALDAD DE MATRICES:
#Comprobar que dos matrices son iguales nos devuelve la comparativa elemento a elemento
C == D




# POTENCIA n-ésima DE UNA MATRIZ:

# 1. Función mtx.exp() del paquete Biodem
#install.packages('Biodem')
library(Biodem)
mtx.exp(C,3)

# 2. Operador %^% del paquete expm
#install.packages('expm')
library(expm)
C%^%3




# RANGO DE UNA MATRIZ:

#función qr(), propiedad rank
qr(C)$rank
R(C)


# INVERSA DE UNA MATRIZ CUADRADA:

#funcion solve()
M = diag(c(3,3,3)) 
M
inversa = solve(M)
inversa

#comprobar que es la inversa 
M%*%inversa 




# DETERMINANTE DE UNA MATRIZ:

#funcion det()
det(M)



# MATRIZ ESCALONADA REDUCIDA
D = cbind(c(1,2,3),c(4,5,6),c(7,8,9))
D

library(matlib)
echelon(D,verbose=T)



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

