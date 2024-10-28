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
#50 = 0*m+n

x = c(0, 1, 2, 3, 4)
y = c(50, 66.5, 75, 81, 86.5)

#1.paso: ajustar a la recta y = mx+n (mx+n = y) nuestros datos 

#2.paso: tipo de sistema (incompatible/compatible) con el Teorema de R-F


#3.paso: existencia de la inversa lateral (izquierda)


#4.paso: cálculo de la matriz inversa a izquierda


#5.paso: Resolver el sistema. AX = b -> x = inversa*b
#  X = solucion



#6.paso: Graficamos

# x |  0    1     2    3    4
#-------------------------------
# y | 50  66.5   75   81   86.5

# datos = data.frame(cbind(c(0,1,2,3,4),c(50,66.5,75,81,86.5)))


# library(ggplot2)
# ggplot() + 
#   geom_point(aes(x = datos$X1, y = datos$X2), colour = "red")+ 
#   geom_abline(slope = solucion[1], intercept = solucion[2], col='blue')




