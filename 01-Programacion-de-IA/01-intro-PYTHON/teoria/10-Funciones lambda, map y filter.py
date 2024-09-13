#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Thu Mar  9 21:51:51 2023

@author: laptop
"""

#######################
# List comprehension  #
#######################
"""
La comprensión de listas en Python es una característica que permite construir listas 
de manera concisa y legible utilizando una sintaxis compacta. 

Permite crear una lista a partir de otra lista, una cadena, u otra secuencia de datos, 
aplicando una expresión a cada elemento de la secuencia. 

Esto se hace mediante una sintaxis que combina bucles for y condicionales de una manera 
más compacta que los enfoques tradicionales.

Por ejemplo, considera la siguiente comprensión de lista que genera una lista de los 
cuadrados de los números del 0 al 9:
"""
parabola = [x**2 for x in range(10)]
"""
Aquí, x**2 es la expresión que se aplica a cada elemento x en el rango de 0 a 9. 
La comprensión de lista luego crea una lista con los resultados de estas expresiones.

Las comprensiones de lista pueden incluir también condiciones, lo que permite filtrar 
elementos según ciertas condiciones. Por ejemplo:
"""
parabola_pares = [x**2 for x in range(10) if x % 2 == 0]
"""
Esta comprensión de lista crea una lista de los cuadrados de los números del 0 al 9 que son pares.

La función que apliquemos a los elementos de la lista la podemos definir aparte:
"""


def divide2(num):
    print(f"Divido {num} entre 2")
    return num/2

lista_num = [divide2(elemento) for elemento in range(0, 300, 15)]

# Desordenamos la lista de manera aleatoria
import random
random.shuffle(lista_num)

########
# Map  #
########
# map aplica una función cualquiera a un iterable
def duplica(numero):
    return 2 * numero

# map no se ejecuta inmediatamente sino que crea una función generadora
# que en cada petición "next" evalúa la función para un elemento del iterable.
generador = map(duplica, lista_num)

"""
def generador(lista_num):
    for elemento in lista_num:
        yield duplica(elemento)
"""

next(generador)
next(generador)
next(generador)


def imprime(numero):
    return f"Este término está ocupado por el elemento {numero}"


generador2 = map(imprime, lista_num)
next(generador2)
next(generador2)
next(generador2)

# Puedo ejecutar la función en todos los elementos si creo una lista para los resultados
lista_desde_generador = list(generador2)

lista_num2 = list(map(duplica, lista_num))

###########
# Filter  #
###########
# filter, es un map usando una función que devuelve True o False
"""
El resultado es una selección de los elementos que devuelven True al ser pasados por la función.
"""

def tiene_decimales(num):
    if num == int(num):
        return False
    else:
        return True

iterable_num_decimales = filter(tiene_decimales, lista_num)
next(iterable_num_decimales)

lista_num_decimales = list(iterable_num_decimales)

lista_num_decimales = list(filter(tiene_decimales, lista_num))

##########
# Reduce #
##########
"""
Se trata de un comportamiento similar a map.
La diferencia es que el resultado de la ejecución de la función en cada término
se reintroduce como parámetro a la siguiente ejecución
"""
from functools import reduce

# Ejemplo de uso de Reduce en Python:
lista_numeros = [1, 2, 3, 4, 5]
lista_letras = ["a", "b", "c", "d", "e"]

def sumar(a, b):
    # a es el primer término de la lista (la primera vez)
    # o lo que proviene del anterior ciclo (las siguientes veces)
    print(f"a: {a}, b: {b}")
    return a + b

# Los primeros dos elementos del iterable se envían a la función pasada como argumento.
# Luego, la función se aplica tanto al resultado más reciente que se generó como al 
# elemento posterior en el iterable.
# El iterable se procesa hasta el final de este proceso.
# La aplicación de la función de reducción al iterable hace que se devuelva un único valor.

# Ejemplo de uso de Reduce en Python:

resultado = reduce(sumar, lista_numeros)
print(resultado)

resultado = reduce(sumar, lista_letras)
print(resultado)


###########
# Lambda  #
###########
"""
Son funciones que pueden utilizar cualquier número de parámetros pero una única expresión. 
Esta expresión es evaluada y devuelta. 
Se pueden usar en cualquier lugar en el que una función sea requerida. 
"""
def doble(num):
    return num*2

# Lambda por reducción de una función sencilla
iterable2 = map(lambda num: num * 2, lista_num)

next(iterable2)
next(iterable2)
next(iterable2)
next(iterable2)
next(iterable2)
next(iterable2)
next(iterable2)
next(iterable2)
next(iterable2)

iterable3 = map(lambda x, y: x + y, lista_num, lista_num2)

lista_num3 = list(iterable3)

#___________#
# Ejercicio #
#-----------#
# Crear una lista con los números de 0 al 100.


# Dividirlos entre tres con map y una función lambda.


# Filtrar los que tienen parte decimal con una función lambda.


#__________#
# Solución #
#----------#


#___________#
# Ejercicio #
#-----------#
import random
# Creamos una lista de edades que por error contiene números negativos y excesivos
edades = [random.randint(-7, 130) for i in range(500)]
edades.count(-3)
edades.count(121)


# Usar filter para eliminar los valores


# Usar map para sustituirlos por 120 o 0
