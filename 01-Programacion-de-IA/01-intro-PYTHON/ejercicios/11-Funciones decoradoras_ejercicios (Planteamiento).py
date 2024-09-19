#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 18 10:20:40 2024

@author: laptop
"""



#Ejercicio 1: Decorador de Validación de Parámetros
"""
Crea un decorador llamado validar_parametros que tome una función y verifique si los parámetros 
cumplen ciertas condiciones antes de llamar a la función. 

Por ejemplo, puedes implementar una validación que asegure que los números ingresados son positivos.
"""



def validar_parametros(func):
    def validacion(x):
        if x < 0:
            return "El número es negativo"
        else:
            return func(x)
    return validacion

@validar_parametros
def num_entero(x):
    return x    

num_entero(-73)




# Ejercicio 2:
    
"""
Crea una función decoradora para la función lista primos que verifique que el 
valor del parámetro de entrada limite es correcto y filtre la salida eliminando 
los valores de la lista de primos terminados en 7, por ejemplo, el 17.
"""

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



def filtrar_primos(func):
    def filtrado(limite):
        digito = 7
        if not isinstance(limite, int):
            raise TypeError("No es un número entero")
        lista_primos_filtrada = []
        lista_primos = func(limite)
        for primo in lista_primos:
            if primo % 10 == digito:
                continue
            else:
                lista_primos_filtrada.append(primo)
        return lista_primos_filtrada
    return filtrado


@filtrarsalida
@filtrar_entrada
@filtrar_primos
def lista_primos(limite):
    try:
        limite = limite
    except:
        print("Hay un error con el numero introducido")
    else:
        lista_primos = []
        for i in range(2, limite):
            if es_primo(i):
                lista_primos.append(i)
        return lista_primos


lista_primos(70.4)




# PROFE

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


def verificar_entrada(func):
    def wrapper(entrada):
        if not isinstance(entrada, int):
            raise TypeError("No es un número entero")
        if entrada < 0:
            raise ValueError("No es un número entero positivo")
        salida = func(entrada)
        return salida
    return wrapper


# # Debajo haremos una función más pequeña
# def filtro_7(numero_primo):
#     if numero_primo % 10 != 7:
#         return True
#     # if str(numero_primo[-1]) == "7": # Esta sería otra opción
#     #     return False
#     else:
#         return False



# # Haremos una función lambda con la siguiente función
# # Si consiguimos hacer una función que se ejecute en unaúnica linea
# # significa que podemos hacer una función lambda
# def filtro_7(num):
#     return num % 10 != 7



# def filtrar_salida(func):
#     def wrapper(limite):
#         salida = func(limite)
#         salida = list(filter(filtro_7, salida))
#         return salida
#     return wrapper


def filtrar_salida(func):
    def wrapper(limite):
        salida = func(limite)
        salida = list(filter(lambda num: num % 10 != 7, salida))
        return salida
    return wrapper


# Es recomendable generar los máximos decoradores posibles que dibidan las distinta
@filtrar_salida
@verificar_entrada
def lista_primos(limite):
    lista_primos = []
    for i in range(2, limite):
        if es_primo(i):
            lista_primos.append(i)
    return lista_primos

lista_primos("100")

#Ejercicio 3: Decorador para Logs

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
# inicio = time.time()
# fin = time.time()
# tiempo_transcurrido = fin - inicio


# inicio = time.time()
# print("Hola")
# fin = time.time()
# tiempo_transcurrido = fin - inicio
# print(fin - inicio)




from datetime import datetime


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

