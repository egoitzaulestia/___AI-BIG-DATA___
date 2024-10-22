# -*- coding: utf-8 -*-
"""
Created on Fri Sep 13 12:05:42 2024

@author: 2425BIGDATA401
"""

# # Función para pedir el número
# def pedir_numero():
#     while(True):
#             try:
#                 numero = ""
#                 while not numero.isnumeric():
#                     numero = input("Introduce un número: ")
#             except:
#                 print("ERROR: Debes de introducir un número")
    
#         # return int(numero)

# pedir_numero()


while True:
    try:
        num = float(input("Introduce número: "))
        num_final = num + 1
        print(num_final)

    except:
        print("No puedes sumar un str con in integer")
    else:
        print("Todo ha funcionado correctamente")
        break  # Importante romper la iteración while si todo ha salido bien
    finally:
        print("Fin de la iteración")  # Siempre se ejecuta





while True:
    try:
        num = float(input("Introduce número: "))
        num_final = num + 1
        print(num_final)

    except Exception as e:
        print("ERROR: ", type(e).__name__)
    else:
        print("Todo ha funcionado correctamente")
        break  # Importante romper la iteración while si todo ha salido bien
    finally:
        print("Fin de la iteración")  # Siempre se ejecuta





