# -*- coding: utf-8 -*-
"""
Created on Thu Sep 12 12:36:23 2024

@author: 2425BIGDATA401
"""

import random

def num_aleatorio():
   num_ale = random.randint(0, 100)
   return num_ale

# num_aleatorio()   
    
def introducir_num():
    num_jugador = int(input("Introduce un número: "))
    return num_jugador


# num_aleatorio()

def jugar():
    print("""
          Bienvenido!!!
          Soy tu nuevo amigo AGI.
          Averigua que numero estoy pensando (del 0 al 100)!
          """)
    numero_agi = num_aleatorio()
    # print(numero_agi)
    
    contador = 0
    while True:
        numero_jugador = introducir_num()

        if numero_agi == numero_jugador:
            print(f"YEAH! Acertaste! Intentos {contador}")
            break
        elif not numero_agi == numero_jugador:
            print(f"HAHAHA! Has fallado! Intentos {contador}")
        contador += 1

# # Llamamos a la función principal
# juega()