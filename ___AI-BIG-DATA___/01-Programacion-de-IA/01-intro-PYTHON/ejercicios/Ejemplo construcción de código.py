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
    
    
    
    
    