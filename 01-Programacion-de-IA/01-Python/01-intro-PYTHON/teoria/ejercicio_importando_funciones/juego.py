# -*- coding: utf-8 -*-
"""
Created on Thu Sep 12 12:36:23 2024

@author: 2425BIGDATA401
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