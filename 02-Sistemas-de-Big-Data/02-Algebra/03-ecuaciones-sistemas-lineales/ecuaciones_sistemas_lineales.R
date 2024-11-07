
################# Ecuaciones y Sistemas Lineales con R ##############################################

rm(list=ls())


#1.SISTEMAS COMPATIBLES DETERMINADOS.

#1.1 
#Funcion solve(A,B) / A = matriz de coeficientes, B = matriz columna de terminos independientes

#Condicion de la funcion solve(A,B) -> sistema compatible determinado

# 1*x1 + 1*x2 + 2*x3  =  9 
# 2*x1 + 4*x2 - 3*x3  =  1 
# 3*x1 + 6*x2 - 5*x3  =  0 

#1.paso: forma matricial
A = rbind(c(1,1,2),c(2,4,-3),c(3,6,-5))
A
cbind(c(1,2,3),c(1,4,6),c(2,-3,-5))
b = c(9,1,0)
ampli = cbind(A,b)
ampli

#2.paso: TEOREMA Rouche-Frobenius:
#Existen soluciones para el sistema (sistema compatible) SI Y SOLO SI
#el rango de la matriz completa es igual al rango de la matriz incompleta.
#y, si se cumple esto, entonces tenemos dos opciones:
#Si rg(A)= numero_incognitas -> unica solucion (determinado)
#Si no -> infinitas soluciones
qr(A)$rank == qr(ampli)$rank #existen soluciones
qr(A)$rank == ncol(A) #una unica solucion

#3.paso: funcion solve()
solucion = solve(A,b)
solucion

ampli


rm(list=ls())

#1.2.
#Libreria matlib -> funcion Solve().
#La funcion Solve() utiliza eliminacion Gaussiana para resolver el sistema AX=b

# (OBSERVACION! los usuarios de MAC tienen que ir a xquartz.org e instalar el paquete.)

#sistema:
#  2*x1 + 2*x2  =  1 
# -1*x1 + 1*x2  =  2 

#1.paso: forma matricial
A = rbind(c(2,2),c(-1,1))
b = c(1,2)
ampli = cbind(A,b)
ampli

library(matlib)
showEqn(A,b) #mostrar el sistema de ecuaciones
R(A) #mostrar rango
R(ampli)

#2.paso: teorema Rouche-Frobenius:
#Existen soluciones para el sistema (sistema determinado) SI Y SOLO SI
#el rango de la matriz completa es igual al rango de la matriz incompleta.
#y, si se cumple esto, entonces tenemos dos opciones:
#Si rg(A)=numero_incognitas -> unica solucion (determinado)
#Si no -> infinitas soluciones

#comprobar si el sistema es compatible
all.equal(R(A),R(ampli)) 
R(A) == R(ampli) #compatible
#comprobar si el sistema es compatible determinado
R(A) == ncol(A) #determinado

#3.paso: funcion Solve()
solucion = Solve(A,b,fractions = TRUE)
#fractions -> soluciones en formato fracción (no decimal)




#2. REPRESENTACIÓN DE SISTEMAS 

#Podemos representar las ecuaciones con la libreria matlib,
#es decir, podemos dibujar las ecuacones con varias funciones
#de la libreria: 
  #2 incognitas -> plotEqn()
  #3 incognitas -> plotEqn3d()

#Ejercicio: 2 ecuaciones + 2 incognitas
#  2*x1 + 2*x2  =  1 
# -1*x1 + 1*x2  =  2 

#1.paso: forma matricial
A = rbind(c(2,2),c(-1,1))
b = c(1,2)
showEqn(A,b)

#2.paso: aplicar la función correspondiente
plotEqn(A,b)

#punto de interseccion es la solucion del sistema.
solucion = Solve(A,b,fractions = TRUE)
solucion


#Ejercicio: 3 ecuaciones 2 incognitas:
# 4*x1 + 2*x2  =  3 
# 1*x1 - 2*x2  =  2 
# 3*x1 + 4*x2  =  1

#1.paso: forma matricial
A = rbind(c(4,2),c(1,-2),c(3,4))
b = c(3,2,1)
showEqn(A,b)

ampli=cbind(A,b)
ampli
R(A) == R(ampli)
R(A)==ncol(A)

#2.paso: aplicar la funcion correspondiente
plotEqn(A,b)

#punto de interseccion es la solucion del sistema.
solucion = Solve(A,b,fractions = TRUE)
solucion



#Ejercicio: 3 ecuaciones + 3 incognitas
 #1*x1 + 1*x2 + 2*x3  =  9 
 #2*x1 + 4*x2 - 3*x3  =  1 
 #3*x1 + 6*x2 - 5*x3  =  0

#1.paso: forma matricial
A = rbind(c(1,1,2),c(2,4,-3),c(3,6,-5))
b = c(9,1,0)
showEqn(A,b)

ampli=cbind(A,b)
R(A) == R(ampli)
R(A)==ncol(A)

#2.paso: aplicar la funcion correspondiente
plotEqn3d(A,b,xlim = c(-3,3) ,ylim =c(0,6) )
#este grafico es interactivo, clicando sobre la imagen 
#podemos rotarla y visualizar el punto de interseccion


#punto de interseccion es la solucion del sistema.
solucion = Solve(A,b,fractions = TRUE)
solucion






#3. METODO DE GAUSS

#Libreria matlib -> Metodo de Gauss

#Funcion echelon() -> calcula la matriz escalonada reducida de cualquier matriz con el metodo de Gauss

#Si reducimos la matriz ampliada a una matriz escalonada reducida equivalente,
#podremos deducir facilmente la solucion del sistema (suponiendo que la haya)

#Ejercicio: 3 ecuaciones + 3 incognitas
#   1*x1 + 1*x2 + 2*x3  =  9 
#   2*x1 + 4*x2 - 3*x3  =  1 
#   3*x1 + 6*x2 - 5*x3  =  0

#1.paso: forma matricial
A = rbind(c(1,1,2),c(2,4,-3),c(3,6,-5))
b = c(9,1,0)

#2.paso: matriz ampliada
ampli = cbind(A,b)

#3.paso: escalonar la matriz ampliada con echelon
echelon(ampli, verbose=TRUE, fraction=TRUE)
#verbose -> muestra operaciones elementales para conseguir la matriz escalonada reducida
#fraction = T -> para no arrasastrar decimales

#RESULTADO DIRECTAMENTE DE LA MATRIZ de los t.indep
#x1 = 1
#x2 = 2
#x3 = 3





#4. SISTEMAS COMPATIBLES INDETERMINADOS

#NO podemos aplicar la funcion solve(), esta funcion solo es para cuando tenemos una unica solucion 
#es decir, sistema compatible determinado

#Ejercicio: 3 ecuaciones + 3 incognitas:

# 1*x1 + 1*x2 - 1*x3  =  2 
# 1*x1 - 1*x2 + 1*x3  =  1 
# 3*x1 + 1*x2 - 1*x3  =  5 

rm(list=ls())

#1.paso: forma matricial
A = rbind(c(1,1,-1),c(1,-1,1),c(3,1,-1))
b = c(2,1,5)


# 2.paso: Compatibilidad del sistema 

#2.paso(1.opcion): Teorema Rouche-Frobenius
library(matlib)
rango_A = R(A)  #2
ampli = cbind(A,b)
rango_ampli = R(ampli) #2
rango_A == rango_ampli
rango_A == ncol(A) # sistema indeterminado (infinitas soluciones)

#2.paso(2.opcion): funcion echelon
echelon(ampli, fraction=TRUE)

#     x_1  x_2  x_3  b            
#[1,]  1   0    0   3/2
#[2,]  0   1   -1   1/2
#[3,]  0   0    0    0

#Esta es la matriz ampliada escalonada reducida y la 3.fila
#nos indica que es un sistema compatible indeterminado.
#Es decir, si tenemos una fila entera de ceros el sistema es indeterminado.

#2.paso(3.opcion): funcion Solve()
Solve(A,b,fractions = T)
#De aqui concluimos que x_2 y x_3 son dependientes y que x_1 toma
#el valor 3/2, por lo que el sistema es indeterminado.


#2.paso(4.opcion): dibujar el sistema
plotEqn3d(A,b,xlim = c(-2,2),ylim = c(-2,2),zlim =c(-2,2))
#vemos claramento como la interseccion de los tres planos es una recta






#5. SISTEMAS INCOMPATIBLES 

#NO podemos aplicar la funcion solve(), esta funcion solo es para cuando tenemos 
#una unica solucion, es decir, sistema compatible determinado

#Ejercicio: 3 ecuaciones + 2 incognitas:
# 1*x1 + 1*x2  =  2 
# 1*x1 - 1*x2  =  1 
# 2*x1 + 1*x2  =  3

rm(list=ls())

#1.paso: forma matricial
A = rbind(c(1,1),c(1,-1),c(2,1))
b = c(2,1,3)

#2.paso(1.opcion): Teorema Rouche-Frobenius
#calculo de los rangos de A y de la matriz ampliada
library(matlib)
rango_A = R(A)  #2
ampli = cbind(A,b)
rango_ampli = R(ampli) #3
rango_A == rango_ampli
#los rangos NO son iguales, por lo que por el teorema 
#deducimos que el sistema es incompatible 



#2.paso(2.opcion): funcion echelon
echelon(ampli, fraction=TRUE)

#     x_1  x_2  b            
#[1,]  1   0    0
#[2,]  0   1    0
#[3,]  0   0    1

#Esta es la matriz ampliada escalonada reducida y la 3.fila nos indica que 0 = 1, 
#una incongruencia. Por lo que el sistema NO tiene solución.

#2.paso(3.opcion): funcion Solve()
Solve(A,b,fractions = T)
# 0  =  1/3  -> sistema incompatible

#2.paso(4.opcion): dibujar el sistema
plotEqn(A,b)
















