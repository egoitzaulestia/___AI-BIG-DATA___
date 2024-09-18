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










def registro(func):
    def funcion_medida():
        inicio = time.time()
        salida = func() # Aquí activamos en la función
        final = time.time()
        print(f"Tiempo de ejecución de la función \"{func.__name__}()\" es de {final - inicio} segundos")
        return salida
    return funcion_medida



@registro
def log():
    time.sleep(1)
    return "terminé"

log()


def registro_hora_actual(func):
    def funcion_medida():
        inicio = time.time()
        salida = func() # Aquí activamos en la función
        final = time.time()
        print(f"Tiempo de ejecución de la función \"{func.__name__}()\" es de {final - inicio} segundos")
        return salida
    return funcion_medida





def medir_tiempo(func):
    def funcion_medida():
        inicio = time.time()
        salida = func() # Aquí activamos en la función
        final = time.time()
        print(f"Tiempo de ejecución de la función {func.__name__}, {final - inicio} segundos")
        return salida
    return funcion_medida


@medir_tiempo
def ejemplo():
    time.sleep(1)
    return "terminé"

ejemplo()


def medir_tiempo(func):
    def funcion_medida(mensaje):
        mensaje = mensaje.replace("Hola", "Adiós")
        inicio = time.time()
        salida = func(mensaje)
        final = time.time()
        print(f"Tiempo de ejecución de la función {func.__name__}, {final - inicio} segundos")
        salida = salida.upper()
        return salida
    return funcion_medida


@medir_tiempo
def ejemplo2(mensaje):
    print(mensaje)
    salida = "Terminé"
    return salida
    
ejemplo2("Hola Mundo")


def medir_tiempo(func):
    def funcion_medida(**mensaje):
        inicio = time.time()
        for elemento in mensaje:
            print(elemento)
        salida = func(**mensaje)
        final = time.time()
        print(f"Tiempo de ejecución de la función {func.__name__}, {final - inicio} segundos")
        return salida
    return funcion_medida

@medir_tiempo
def ejemplo(m1, m2, m3):
    time.sleep(1)
    return m2

ejemplo(m1 = "Hola", m2 = "Adios", m3 = "Hasta Luego")

@medir_tiempo
def ejemplo3(mensaje):
    time.sleep(3)
    return mensaje

ejemplo3("Hola que tal")
ejemplo3("Hola como estás")
