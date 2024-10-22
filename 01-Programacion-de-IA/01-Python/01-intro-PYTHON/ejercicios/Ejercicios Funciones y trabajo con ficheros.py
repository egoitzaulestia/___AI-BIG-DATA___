#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 18:12:30 2024

@author: laptop
"""

# 1. Conversión de Temperatura:
"""
Implementa funciones para convertir entre Celsius y Fahrenheit. 
Pide al usuario que ingrese la temperatura y la unidad, y luego 
realiza la conversión.
"""


def farenheit_to_celsius(grados):
    result = round((grados - 32) * (5 / 9), 1)
    return result

farenheit_to_celsius(104)



def celsius_to_farenheit(grados):
    result = round(grados * 1.8 + 32, 1)
    return result

def pedir_grados():
    grados = float(input("Ingrese los grados: "))
    return grados


celsius_to_farenheit(40)

def conversor_temperatura():
    opcion = input("""
                   CONVERSOR DE TEMPERATURA
                   ------------------------
                   
                   1 para convertir de Farenheit a Celsius
                   2 para convertir de Celsius a Farenheit
                   
                   Introduzca su opción: 
                     """)
                     
    if opcion == "1":
        print("Has elegido convertir grados Farenheit a Celsius.")
        grados = pedir_grados()
        conversion = farenheit_to_celsius(grados)
        return conversion
    elif opcion == "2":
        print("Has elegido convertir grados Celsius a Farenheit.")
        grados = pedir_grados()
        conversion = celsius_to_farenheit(grados)
        return conversion
    
# Llamamos a la función principal
conversor_temperatura()

#  Mejorar el mensaje de salida final !!!!!!!!!!!!!



# Versión PROFE: Aitor



# 2. Juego de Adivinanzas:
"""
Desarrolla un juego simple en el que el programa elige un número aleatorio 
y el jugador tiene que adivinarlo. 
Proporciona pistas sobre si el número es mayor o menor. 
Utiliza funciones para organizar el código.
"""

# Importamos la función randint() de la librería random para poder generar numeros aleatorios
from random import randint


# Función para crear un número aleatori
def num_aleatorio():
   num_ale = randint(0, 100)
   return num_ale


# Función para pedir que le jugador introduzca un número
def introducir_num():
    num_jugador = int(input("\nIntroduce un número: "))
    return num_jugador


# Función que inicializa el juego
def jugar():
    print("""\n
          Bienvenido!!!
          Soy tu nuevo amigo AGI.
          Averigua que numero estoy pensando (del 0 al 100)!
          Teienes 10 intentos!
          """)
    numero_agi = num_aleatorio()
    # print(numero_agi)
    
    contador = 10
    while True:
        numero_jugador = introducir_num()

        if numero_agi == numero_jugador:
            print(f"\nYEAH! Acertaste! Intentos {contador}")
            print("Has ganado el juego.")
            break
        elif not numero_agi == numero_jugador:
            print(f"HAHAHA! Has fallado! Intentos {contador}")
            print("Intenta con otro número.")
        contador -= 1
        if contador < 0:
            print("\nHAS PERDIDO!!\nYa no te quedan mas intentos.")
            print(f"\nEl número en el que estaba pensando era {numero_agi}")
            break
        
        
jugar()


# 3. Crear módulos para estas funciones
"""
Crea una carpeta en la misma carpeta de trabajo en la que estás. 
Crea dos archivos en ella y define las funciones anteriores.
Impórtalas desde este archivo y úsalas.
"""

# Con la primera parte del código creo un directorio
import os

# Nombre del directorio que voy a crear 
directorio = "ejercicio_importando_funciones"
  
# Ruta del directorio padre 
directorio_padre = "Z:/___AI-BIG-DATA/01-programacion-de-IA/01-intro-PYTHON/teoria/"

# Path 
ruta = os.path.join(directorio_padre, directorio) 
  
# Creamos el directorio
os.mkdir(ruta)


# Los siguientes imports deberían de ir al principio del ejercicio
from teoria.ejercicio_importando_funciones.conversor_temperatura import convertir_temperatura
from teoria.ejercicio_importando_funciones.juego import jugar

convertir_temperatura()

jugar()










