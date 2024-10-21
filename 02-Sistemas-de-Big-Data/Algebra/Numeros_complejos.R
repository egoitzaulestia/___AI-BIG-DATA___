############## NÚMEROS COMPLEJOS ###############################################

rm(list=ls())

#Definir un número complejo:

#1. Forma binómica -> parte real + parte imaginaria(i):
#   OBSERVACION! Es necesario escribir ese '1' antes de la i
z1 <- 2+1i
z1 = 2+1i
z1

z2 = 3-2i

#2. Forma de tupla -> (parte real, parte imaginaria):
z2 = complex(real=2,imaginary = -1)
z2

#3. Forma polar -> (modulo, argumento)
z3 = complex(modulus = 2, argument = pi)
z3

#Tipo de dato: funcion typeof(), class()
typeof(z3)
class(z3)

#Parte real / parte imaginaria -> funciones Re(), Im()
Re(z3)
Im(z3)#!!!!!
round(Im(z3),digits = 5)
#Problema de redondeo debido a la representación informática: 
#limitado al numero de bits que utiliza para la representación interna de los datos


#Conjugado
z1
conj = Conj(z1)
conj


#Módulo 
Mod(z1) ==sqrt(2^2+(-1)^2)


#Argumento principal (radianes)
z3
Arg(z3)


#Suma
z1+z2


#Producto por un escalar
3*z2


#Producto de dos numeros complejos
z2*z3
