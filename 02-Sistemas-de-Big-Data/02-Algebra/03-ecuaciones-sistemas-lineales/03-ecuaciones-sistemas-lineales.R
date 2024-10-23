

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

# x1+3x2−4x3 = 1 
# −10x1 −x2 −3x3x4 = 0
# NO ES UNA ECUACIÓN LINEAL

# x21+x2 = 1 
# x1−x2−3x3+x4 = 0
# NO ES UNA ECUACIÓN LINEAL


#  2*x1 − 1*x2 − 3*x3   = 113 
# −1*x1 + 1*x2 + 2*x3   =  −1

A = rbind(c(2, 1, -3), c(-1, 1, 2))
A
b = cbind(c(133, -1))
b
ampli = cbind(A, b)
ampli

###################
### Ejercicio 2 ###
###################

# Decidir la compatibilidad de los siguientes sistemas utilizando el Teorema de Rouche-Frobenius
# y en caso de que el sistema sea compatible determinado calcular su solución.

# a)

# 1*x1 + 1*x3 = 1
# 1*x2 + 1*x3 = 1

A = rbind(c(1, 0, 1), c(0, 1, 1))
A
b = c(1, 1, 0)
b
ampli = cbind(A, b)
ampli

print("No se cumple ' rg(A) =rg(A|B)=n ', porque tenemos 2 filas y 3 incognitas, por lo tnato, es una ecuación lineal compatible indeterminado")


# b)

# 1*x1 + 1* x2 = 2 
# 1*x1 − 1* x2 = 0

A = rbind(c(1, 1), c(1, -1))
A
b = cbind