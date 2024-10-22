#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Sep 10 12:53:47 2024

@author: laptop
"""

"""
Crea un programa que solicite al usuario un número y utilice un bucle 
while para sumar todos los números primos menores o iguales al número 
ingresado.
"""

numero = ""
while not numero.isnumeric():
    numero = input("Introduzca un número: ")

numero = int(numero)




#---------------------------

numero = 17

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
    
print(es_primo)


# ----------------------------

import time 

numero = ""
while not numero.isnumeric():
    numero = input("Introduzca un número: ")

numero = int(numero)

suma = 1
lista_primos = [1]
candidato_a_primo = 2
while candidato_a_primo <= numero:
    es_primo = True
    factor = 2
    # Buscamos factores menores que el número
    while factor <= int(candidato_a_primo**0.5):
        if candidato_a_primo % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(factor)
            break
        factor += 1
        
    #print(candidato_a_primo)
    #print(es_primo)
    
    if es_primo:
        suma = suma + candidato_a_primo
        lista_primos.append(candidato_a_primo)
    candidato_a_primo += 1
    #print(suma)
    
print(suma) 
print(lista_primos)



# --------------------------------------
# Conversión en generador
# Devolverá un número primo cada vez que le digamos 'next'
# generador_primos = funcion_generadora_primos(100)
    
# next(generador_primos)



def es_primo_GENERADOR():
    es_primo = True
    factor = 2
    # Buscamos factores menores que el número
    while factor <= int(candidato_a_primo**0.5):
        if candidato_a_primo % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(factor)
            break
        factor += 1
    return es_primo



def primos_GENERADOR(n, m):
    for numero in range(n, m+1):
        time.sleep(1)
        if es_primo(numero):
            yield numero
            
            
def generar_primos_GENERADOR(num_ini, num_fin):
    for numero in range(num_ini, num_fin + 1):
        time.sleep(1)
        if es_primo_GENERADOR():
            yield numero

            
numero_PRIMO = primos_GENERADOR(0, 13)
next(numero_PRIMO)

            
generador_de_primos = primos(0,13)

next(generador_de_primos)
next(generador_de_primos)
next(generador_de_primos)
 

    



# -------------------
# -------------------
#      FUNCIÓN 
# -------------------
# -------------------


# MI VERSIÓN

# ----------------------------

import time


def pedir_numero():
    num_ini = ""
    num_fin = ""
    while not num_ini.isnumeric() and num_fin.isnumeric():
        num_ini = input("Introduce un número: ")
        num_fin = input("Introduce un número: ")

    return int(num_ini), int(num_fin)

# ----------------------------

def es_primo(candidato_a_primo):
    factor = 2
    while factor <= int(candidato_a_primo ** 0.5):
        if candidato_a_primo % factor == 0:
            return False
        factor += 1
    return True

# ----------------------------

def generar_primos_GENERADOR(num_ini, num_fin):
    for numero in range(num_ini, num_fin + 1):
        time.sleep(1)
        if es_primo(numero):
            yield numero

num_prim = generar_primos_GENERADOR(0, 8)
next(num_prim)



for primo in generar_primos_GENERADOR(0, 8):
    print(primo)










def procesar_primos():
    # 1. Pedir el número al usuario
    num_ini, num_fin = pedir_numero()


    num_prim_generator = generar_primos_GENERADOR(num_ini, num_fin)
    
    for primo in num_prim_generator:
        print(primo)

    # # 3. Sumar los números primos
    # suma = sumar_primos(lista_primos)

    # # 4. Imprimir los resultados
    # print(f"Lista de primos hasta {numero}: {lista_primos}")
    # print(f"Suma de los números primos: {suma}")

# Llamada a la función principal que usa todas las demás
procesar_primos()
