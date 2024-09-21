#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 18 10:20:40 2024

@author: Egoitz Aulestia Padilla
"""




######################################################
# Ejercicio 1: Decorador de Validación de Parámetros #
######################################################


"""
Crea un decorador llamado validar_parametros que tome una función y verifique si los parámetros 
cumplen ciertas condiciones antes de llamar a la función. 

Por ejemplo, puedes implementar una validación que asegure que los números ingresados son positivos.
"""


# Ejercicio 1 -> VERSIÓN 1:
# ------------------------

#Función decoradora validar_parametros() -> valida paramatros individuales de un número entero
def validar_parametros(func):
    # Función que se ejecuta antes que la función original
    def wrapper(entrada):
        # Verificar si la entrada NO es un número entero
        if not isinstance(entrada, int):
            raise TypeError("Debes introducir un número entero")
        # Verificar si la entrada es un número negativo
        elif entrada < 0:
            raise ValueError("fEl número {entrada} es negativo, debe ser positivo")
        salida = func(entrada)
        return salida
    return wrapper


# Función num_enteros() con la el decorador @validar_parametros
@validar_parametros
def num_entero(x):
    return x # Solo devuelve el número o la lista sin hacer nada especial


# Pruebas con ejemplos:

num_entero(5)
num_entero(-32)
num_entero("Thales of Miletus")


# --------------------------------------------------------------------------------------------------------------


# Ejercicio 1 -> VERSIÓN 2:
# ------------------------

# Función decoradora validar_parametros -> valida tanto paramatros individuales y listas de números enteros
def validar_parametros(func):
    # Función que se ejecuta antes que la función original
    def wrapper(entrada):
        # Verificar si la entrada es un número entero
        if isinstance(entrada, int):
            if entrada < 0:
                raise ValueError(f"El número {entrada} es negativo, debe ser positivo")
        # Verificar si es una lista de números enteros
        elif isinstance(entrada, list):
            for i, x in enumerate(entrada):
                if not isinstance(x, int):
                    raise TypeError("Todos los elementos de la lista deben ser números enteros")
                if x < 0:
                    raise ValueError(f"El número {x} situado en la posición {i} de la lista es negativo, debe ser positivo")
        # Si no es ni un número ni una lista de números
        else:
            raise TypeError("El parámetro introducido debe ser un número entero o una lista de números enteros")
        return func(entrada)
    return wrapper


# Función num_enteros() con la el decorador @validar_parametros
@validar_parametros
def num_enteros(x):
    return x # Solo devuelve el número o la lista sin hacer nada especial


# Pruebas con ejemplos:

num_enteros(1)                  # 1

num_enteros(-2)                 # ValueError: El número -2 es negativo, debe ser positivo
num_enteros("boom")             # TypeError: El parámetro introducido debe ser un número entero o una lista de números enteros

num_enteros([3, 5, 8])          # [3, 5, 8]

num_enteros([13, "21", 34])     # TypeError: Todos los elementos de la lista deben ser números enteros
num_enteros([55, -89, 144])     # ValueError: El número -89 situado en la posición 1 de la lista es negativo, debe ser positivo


# --------------------------------------------------------------------------------------------------------------


# Ejercicio 1 -> VERSIÓN 3:
# ------------------------

# Función decoradora validar_parametros -> Versión dos más compacta de la segunda opción mostrada anteriormente
def validar_parametros(func):
    def wrapper(entrada):
        # Verificar si es un número entero
        if isinstance(entrada, int):
            if entrada < 0:
                raise ValueError(f"El número {entrada} es negativo, debe ser positivo")
        # Verificar si es una lista de números enteros
        elif isinstance(entrada, list):
            # Verficar que todos los elementos de la lista sean enteros. Si alguno no lo es, la condición será False y se lanzará un TypeError
            if not all(isinstance(x, int) for x in entrada):
                raise TypeError("Todos los elementos en la lista deben ser números enteros")
            # Verificar que al menos un elemento de la lista NO sea positivo. Si es así, la condición será True y se lanzará un ValueError.
            if any(x < 0 for x in entrada):
                raise ValueError("Todos los números en la lista deben ser positivos")
        else:
            raise TypeError("El parámetro debe ser un número entero o una lista de números enteros")
        return func(entrada)
    return wrapper


# Función num_enteros() con la el decorador @validar_parametros
@validar_parametros
def num_enteros_final(x):
    return x    


# Pruebas con ejemplos:

num_enteros_final(1)                  # 1

num_enteros_final(-2)                 # ValueError: El número -2 es negativo, debe ser positivo
num_enteros_final("boom")             # TypeError: El parámetro introducido debe ser un número entero o una lista de números enteros


num_enteros_final([3, 5, 8])          # [3, 5, 8]

num_enteros_final([13, "21", 34])     # TypeError: Todos los elementos de la lista deben ser números enteros
num_enteros_final([55, -89, 144])     # ValueError: Todos los números en la lista deben ser positivos


# --------------------------------------------------------------------------------------------------------------




###########################################################
# Ejercicio 2: Decorador(es) para la función lista primos #
###########################################################


"""
Crea una función decoradora para la función lista primos que verifique que el 
tatvalor del parámetro de entrada limite es correcto y filtre la salida eliminando 
los valores de la lista de primos terminados en 7, por ejemplo, el 17.
"""


# Ejercicio 2 -> VERSIÓN 1
# ------------------------

def es_primo(numero):
    es_primo = True
    factor = 2
    
    # Buscamos factores menores que el número
    while factor <= int(numero**0.5):
        if numero % factor == 0:
            es_primo = False
            break
        factor += 1
        
    return es_primo


def validar_entrada(func):
    def wrapper(entrada):
        try:
            if not isinstance(entrada, int):
                raise TypeError(f"\"{entrada}\" no es un número entero")
            if entrada < 2:  # Cambiamos a < 2
                raise ValueError(f"{entrada} no es un número válido, debe ser un entero mayor que 1")
            return func(entrada)
        except (TypeError, ValueError) as e:
            print(f"Error: {e}")  # Personaliza el manejo del error
            raise e  # Re-lanza el error para que siga siendo manejable
    return wrapper


def filtrar_salida(func):
    def wrapper(limite):
        salida = func(limite) 
        salida = list(filter(lambda num: num % 10 != 7, salida))
        return salida
    return wrapper


@filtrar_salida
@validar_entrada
def lista_primos(limite): 
    """
    lista_primos = []\n
    for i in range(2, limite):
        \tif es_primo(i):\n
            \t\tlista_primos.append(i)\n
    return lista_primos
    """
    return [i for i in range(2, limite) if es_primo(i)]


# Pruebas con ejemplos:

lista_primos(80)        # [2, 3, 5, 11, 13, 19, 23, 29, 31, 41, 43, 53, 59, 61, 71, 73, 79]

lista_primos(1)         # ValueError: 1 no es un número válido, debe ser un entero mayor que 1
lista_primos(-34)       # ValueError: -34 no es un número válido, debe ser un entero mayor que 1
lista_primos("Neo")     # TypeError: "Neo" no es un número entero


# --------------------------------------------------------------------------------------------------------------


# Ejercicio 2 -> VERSIÓN 2
# ------------------------

"""
He creado un decorador `filtrar_salida` personalizable, que permite introducir el dígito 
que se desea filtrar de los números generados.

En esta función, opté por usar una lista por comprensión en lugar de `filter()` con una lambda, 
ya que las listas por comprensión son más concisas, más legibles y, en algunos casos, más rápidas.

La diferencia de rendimiento entre ambas es mínima, pero las listas por comprensión tienden a ser 
más eficientes, ya que `filter()` debe llamar a la función lambda en cada iteración, 
lo que agrega una pequeña sobrecarga.

"""

def es_primo(numero):
    es_primo = True
    factor = 2
    
    # Buscamos factores menores que el número
    while factor <= int(numero**0.5):
        if numero % factor == 0:
            es_primo = False
            break
        factor += 1
        
    return es_primo


def validar_entrada(func):
    def wrapper(entrada):
        try:
            if not isinstance(entrada, int):
                raise TypeError(f"\"{entrada}\" no es un número entero")
            if entrada < 2:  # Cambiamos a < 2
                raise ValueError(f"{entrada} no es un número válido, debe ser un entero mayor que 1")
            return func(entrada)
        except (TypeError, ValueError) as e:
            print(f"Error: {e}")  # Personaliza el manejo del error
            raise e  # Re-lanza el error para que siga siendo manejable
    return wrapper



# Decorador personalizable para filtrar números que terminan en el dígito especificado
def filtrar_salida(digito=7):
    def decorador(func):
        def wrapper(limite):
            salida = func(limite)
            # Filtro para eliminar números que terminan en el dígito especificado
            salida = [num for num in salida if num % 10 != digito]
            # # Opción filter con lambda
            # salida = list(filter(lambda num: num % 10 != digito, salida))
            return salida
        return wrapper
    return decorador


"""
Debemos invocar `filtrar_salida` como una función, es decir, con paréntesis `()`, 
incluso si ya hemos asignado un valor por defecto (en este caso, 7).

"""
@filtrar_salida()  # Los paréntesis son necesarios para invocar el decorador, incluso cuando se usa el valor por defecto.
@validar_entrada
def lista_primos(limite): 
    """
    lista_primos = []\n
    for i in range(2, limite):
        \tif es_primo(i):\n
            \t\tlista_primos.append(i)\n
    return lista_primos

    """
    return [i for i in range(2, limite) if es_primo(i)]


lista_primos(100)


# --------------------------------------------------------------------------------------------------------------





####################################
# Ejercicio 3: Decorador para Logs #
####################################


"""
Implementa un decorador llamado registro que registre información sobre la llamada
a la función, como el nombre de la función, los argumentos y el resultado.
Imprime esta información en la consola cada vez que la función decorada se ejecuta.

Que en vez de imprimir en consola guarde la hora actual y la información
en un archivo txt.

En este ejercicio puedes usar ChatGPT, pero entonces tendrás que explicar el código
a tus compañeros.
"""


import time
from datetime import datetime

# inicio = time.time()
# fin = time.time()
# tiempo_transcurrido = fin - inicio


# inicio = time.time()
# print("Hola")
# fin = time.time()
# tiempo_transcurrido = fin - inicio
# print(fin - inicio)







def registro(func):
    def funcion_medida(x):
        inicio = time.time()
        salida = func(x) # Aquí activamos en la función
        final = time.time()
        hora_actual = datetime.now()
        print(f"{hora_actual} Tiempo de ejecución de la función \"{func.__name__}()\" es de {final - inicio} segundos")
        return salida
    return funcion_medida


# La función log hara distintas cosas y despues el decorador registrará a que hora se ha relizado
@registro
def log(x):
    x *= 2
    time.sleep(1)
    return x

log(2)





# PROFE 

import time
from datetime import datetime


def es_primo(numero):
    es_primo = True
    factor = 2
    
    # Buscamos factores menores que el número
    while factor <= int(numero**0.5):
        if numero % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(factor)
            break
        factor += 1
        
    return es_primo


# def registro(func):
#     def wrapper(*args, **kwargs):
#         inicio = time.time()
#         resultado = func(*args,**kwargs)
#         final = time.time()
#         hora_actual = datetime.now()
#         info = f"""---------------------------------------------------------------
# Registro: {hora_actual}
# Función: {func.__name__}()
# Tiempo de ejecución: {final - inicio} segundos
# Argumentos posicionales : {args},
# Argumentos por clave {kwargs}
# Resultado: {resultado}\n
# """
#         with open("teoria/datos/registro.text", "a") as archivo:
#                   archivo.write(info)
#         print(info)
#         return resultado
#     return wrapper

def registro(func):
    def wrapper(*args, **kwargs):
        inicio = time.time()
        resultado = func(*args,**kwargs)
        final = time.time()
        hora_actual = datetime.now()
        # Crear el encabezado:
        # if archivo no existe crear encabezado: Time\tFuncion\tTiempoDeEjecucion\tArgumentosPosicionales\tArgumentosClave\tResultado
        info = f"{hora_actual}\tFunción: {func.__name__}()\tTiempo de ejecución: {final - inicio} segundos\tArgumentos posicionales : {args}\tArgumentos por clave {kwargs}\tResultado: {resultado}\n"
        with open("teoria/datos/registro.text", "a") as archivo:
                  archivo.write(info)
        print(info)
        return resultado
    return wrapper



@filtrar_salida
@verificar_entrada
@registro
def lista_primos(limite):
    lista_primos = []
    time.sleep(2)
    for i in range(2, limite):
        if es_primo(i):
            lista_primos.append(i)
    return lista_primos

lista_primos(100)

