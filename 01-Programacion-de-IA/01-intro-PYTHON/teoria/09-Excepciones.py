#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  7 17:49:57 2023

@author: Aitor Donado
"""

###############
# Excepciones #
###############

# --------------------------------
# Errores de sintaxis
# Identificados con el código SyntaxError.
# Spyder es capaz de detectarlos

# print("Hola"

# Mensaje -> SyntaxError: unexpected EOF while parsing

# --------------------------------
# Errores de nombre
# Al ejecutar alguna función, método... que no se encuentra definido. Devuelven el código NameError:

#pint("Hola")

# Mensaje -> NameError: name 'pint' is not defined
# La mayoría de errores sintácticos y de nombre los identifican
# los editores de código antes de la ejecución,
# pero existen otros tipos que pasan más desapercibidos.

# --------------------------------
# Errores semánticos
# Estos errores son muy difíciles de identificar porque
# van ligados al sentido del funcionamiento y dependen de la situación.
# En un mismo código a veces pueden ocurrir y otras no.

variable = "Hola"

variable.append()

# Ejemplo pop() con lista vacía
lista = [1,2,3]
lista.pop()
# Fallo de tipo IndexError.
# Esta situación ocurre sólo durante la ejecución del programa,
# por lo que los editores no lo detectarán:
lista_vacia = []
lista_vacia.pop()

# Para prevenir el error deberíamos comprobar que una lista
# tenga como mínimo un elemento antes de intentar sacarlo,
# utilizando la función len():

lista_vacia = []
if len(lista_vacia) > 0:
    lista_vacia.pop()

# Ejemplo lectura de cadena y operación sin conversión a número
# Al leer un valor con input(), éste siempre será un string
# Si intentamos operar con él tendremos un fallo TypeError

numerador = input("Introduce un número: ")
denominador = 5
print("El numerador {} dividido entre el denominador {} es {}".
    format(numerador, denominador, numerador/denominador))

print("Sigo")

# Como ya sabemos este error se elimina transformando la cadena a entero o flotante:
numerador = float(input("Introduce un número: "))
denominador = 5
print("El numerador {} dividido entre el denominador {} es {}".
    format(numerador, denominador, numerador/denominador))

print("Sigo")
# Sin embargo si se introduce un texto, no es posible evitar el error
# Genera un ValueError

# Por lo tanto, debemos aprender a tratar los errores.

###############
# Excepciones #
###############

# Las excepciones son bloques de código que permiten continuar la
# ejecución del programa pese a que ocurra un error.

# -----------------------
# Bloques try - except

# Para prevenir el fallo colocamos código que pueda generar errores
# en un bloque try encadenado a un bloque except para tratar
# la situación excepcional mostrando que ha ocurrido un fallo:


try:
    numerador = input("Introduce un número: ")
    denominador = 5
    print("El numerador {} dividido entre el denominador {} es {}".
        format(numerador, denominador, numerador/denominador))
except:
    print("Ha ocurrido un error, introduce bien el número")
print("Sigo")

# Podemos aprovechar las excepciones para forzar al usuario a introducir
# un número haciendo con un bucle while.
while(True):
    try:
        numerador = float(input("Introduce un número: "))
        denominador = 5
        print("El numerador {} dividido entre el denominador {} es {}".
            format(numerador, denominador, numerador/denominador))
        break  # Importante romper la iteración while si todo ha salido bien
    except:
        print("Ha ocurrido un error, introduce bien el número")

# Bloque else
# Un else después de except para comprobar el caso en que todo funcione correctamente

while(True):
    try:
        numerador = float(input("Introduce un número: "))
        denominador = 5
        print("El numerador {} dividido entre el denominador {} es {}".
            format(numerador, denominador, numerador/denominador))
    except:
        print("Ha ocurrido un error, introduce bien el número")
    else:
        print("Todo ha funcionado correctamente")
        break  # Importante romper la iteración while si todo ha salido bien

# Bloque finally
# El contenido del bloque finally se ejecuta al final, ocurra o no ocurra un error:

while(True):
    try:
        numerador = float(input("Introduce un número: "))
        denominador = 5
        print("El numerador {} dividido entre el denominador {} es {}".
            format(numerador, denominador, numerador/denominador))
    except:
        print("Ha ocurrido un error, introduce bien el número")
    else:
        print("Todo ha funcionado correctamente")
        break  # Importante romper la iteración si todo ha salido bien
    finally:
        print("Fin de la iteración")  # Siempre se ejecuta

#########################
# Excepciones múltiples #
#########################
# En una misma pieza de código pueden ocurrir muchos errores distintos y
# quizá nos interese actuar de forma diferente en cada caso.

# Para ello asignamos la excepción a una variable
# y analizar el tipo de error gracias a su identificador:
while True:
    try:
        numerador = float(input("Introduce un número: "))
        denominador = input("Introduce otro número: ")
        print("El numerador {} dividido entre el denominador {} es {}".
            format(numerador, denominador, numerador/denominador))
    except Exception as e:  # guardamos la excepción como una variable e
        print("Ha ocurrido un error =>", type(e).__name__)
        if type(e).__name__ == "ValueError":
            print("Lo encontré")
        if type(e).__name__ == "TypeError":
            print("corrige el float")
    else:
        break
    finally:
        print("Sigo")



"""
Gracias a los identificadores de errores podemos crear múltiples comprobaciones, 
siempre que dejemos en último lugar la excepción por defecto 
Excepcion que engloba cualquier tipo de error 
(si la pusiéramos al principio las demas excepciones nunca se ejecutarían):
"""
while True:
    try:
        numerador = float(input("Introduce un número: "))
        denominador = (input("Introduce otro número: "))
        print("El numerador {} dividido entre el denominador {} es {}".
            format(numerador, denominador, numerador/denominador))
    except ValueError:
        print("Debes introducir una cadena que sea un número")
    except ZeroDivisionError:
        print("No se puede dividir por cero, prueba otro número")
    except Exception as e:
        print("Ha ocurrido un error no previsto", type(e).__name__)
    break

#############################
# Invocación de excepciones #
#############################

# En algunas ocasiones quizá nos interesa llamar un error manualmente.
def mi_funcion_print(algo=None):
    if algo is None:
        print("Error! No se permite un valor nulo (con un print)")
    else:
        print(algo)

print()
mi_funcion_print()
print("Sigo")
# en vez de avisar del error con un print
# ----------------------
# Instrucción raise
# Gracias a raise podemos lanzar un error manual pasándole el identificador.
def mi_funcion_print(algo=None):
    if algo is None:
        raise ValueError("Error! No se permite un valor nulo")
    else:
        print(algo)


mi_funcion_print()
print("Sigo")

# Luego simplemente podemos añadir un except para tratar
# esta excepción que hemos lanzado:
def mi_funcion_print_utilizada(algo=None):
    try:
        mi_funcion_print(algo)
    except ValueError:
        print("Error! No se permite un valor nulo (desde la excepción)")


mi_funcion_print_utilizada()





#___________#
# Ejercicio #
#-----------#
# 1. Crear una función que genere una excepción de tipo "ValueError" si el usuario
# introduce una edad por consola que sea negativa o mayor de 120 años.


#__________#
# Solución #
#----------#

def introducir_edad():
    edad = int(input("Introduce el edad: "))
    if edad < 0 or edad > 120:
        raise ValueError("ERROR: Es imposible que tengas menos de \"0\" años o más de \"120\" año")
    else:
        print(f"Su edad es {edad}")
        return edad
    
edad_usuario = introducir_edad()
edad_usuario


# Versión PROFE -> Aún no esta termindado

def ingrese_edad():
    edad_str = int(input("Introduce el edad: "))
    if not edad_str.isnumeric():
        raise TypeError("La edad no puede ser texto")
    edad = int(edad_str)
    if edad >

# 2. A continuación, un bucle infinito "while True" que pida la edad y trate el error
# generado por la función. El bucle parará cuando la edad sea correcta.



#__________#
# Solución #
#----------#

def introducir_edad():
    
    edada_str = input("Introduce el edad: ")
    if not edada_str.isnumeric():
        raise TypeError("La edad no puede ser texto")
      
    edad = int(edada_str)
    if edad < 0 or edad > 120:
        raise ValueError("ERROR: Es imposible que tengas menos de \"0\" años o más de \"120\" año")
    else:
        # print(f"Su edad es {edad}")
        return edad



while True:
    try:
        edad_usuario = introducir_edad()
    except ValueError as e:
        print(f"{e}")
        edad_usuario = 0
    except TypeError as e:
        print(f"{e}")
        edad_usuario = 0
    else:
        print(f"Tu edad es {edad_usuario}")
        break  # Importante romper la iteración while si todo ha salido bien
    finally:
        print(edad_usuario)  # Siempre se ejecuta











