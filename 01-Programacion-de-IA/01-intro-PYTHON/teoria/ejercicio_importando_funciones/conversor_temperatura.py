# -*- coding: utf-8 -*-
"""
Created on Thu Sep 12 12:35:31 2024

@author: 2425BIGDATA401
"""

def farenheit_to_celsius(grados):
    result = round((grados - 32) * (5 / 9), 1)
    return result

# farenheit_to_celsius(104)



def celsius_to_farenheit(grados):
    result = round(grados * 1.8 + 32, 1)
    return result

def pedir_grados():
    grados = float(input("Ingrese los grados: "))
    return grados


# celsius_to_farenheit(40)

def convertir_temperatura():
    opcion = input("""
                   CONVERSOR DE TEMPERATURA
                   ------------------------
                   
                   1 para convertir de Farenheit a Celsius
                   2 para convertir de Celsius a Farenheit
                   
                   Introduzca su opción: """)
                     
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
    
# # Llamamos a la función principal
# conversor_temperatura()

#  Mejorar el mensaje de salida final !!!!!!!!!!!!!