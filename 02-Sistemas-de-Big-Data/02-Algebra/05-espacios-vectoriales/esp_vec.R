

########### ESPACIOS VECTORIALES ##################################################################


#1. Un vector v es combinacion lineal de otros vectores (v1 y v2) si el sistema tiene solución

v = c(1,1)

v1 = c(1,0)
v2 = c(0,1)

#Matrices del sistema 
A = cbind(v1,v2)
b = v

#Ver si el sistema es compatible (si tiene solución)-> Teorema Rouché-Frobenius
ampli = cbind(A,b)

library(matlib)
R(A) == R(ampli) #-> TRUE -> Sistema tiene solución y v es combinación lineal de v1 y v2

#numero de incognitas = numero de vectores (2)
R(A) == 2 #-> sistema compatible determinado -> unica solución





# 2.Conjunto de vectores es linealmente dependiente si el sistema es indeterminado

v1 = c(1,0)
v2 = c(1,2)
v3 = c(0,2)

A = cbind(v1,v2,v3)
b = c(0,0) #vector nulo del mismo espacio

#Teorema Rouché-Frobenius -> sistema compatible indeterminado?

ampli = cbind(A,b)

library(matlib)
R(A)==R(ampli) #-> TRUE -> Sistema tiene solución (sistema compatible) 
#numero de incognitas = numero de vectores
R(A) == 3 #-> FALSE -> sistema compatible indeterminado 





# 3.Conjunto de vectores es linealmente independientes si el sistema es determinado 
# y la solución es el vector nulo: (0,..,0)

v1 = c(1,0,0)
v2 = c(0,1,0)
v3 = c(0,0,1)

A = cbind(v1,v2,v3)
b = c(0,0,0) #vector nulo del mismo espacio

#Teorema Rouché-Frobenius -> sistema compatible determinado?

ampli = cbind(A,b)

library(matlib)
R(A) == R(ampli) #-> TRUE -> Sistema tiene solución 
#numero de incognitas = numero de vectores
R(A) == 3 #-> TRUE sistema compatible determinado 

#calculamos la solución para comprobar que es (0,0,0)
solve(A,b)










