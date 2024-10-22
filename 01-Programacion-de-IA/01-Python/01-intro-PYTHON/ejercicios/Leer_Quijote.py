# -*- coding: utf-8 -*-
"""
Created on Thu Sep 12 13:05:16 2024

@author: 2425BIGDATA401
"""

"""
Función que devuelva una lista que devuelva 
todas las lineas que se mencione al Quijote
"""

# Opcion separada

with open(r"teoria/datos/quijote.txt", encoding = "utf8") as archivo:
    lineas = archivo.readlines()
    
lineas_quijote_1 = [linea for linea in lineas if "Quijote" in linea]
lineas_quijote_1


# Opcion Todo junto --> CUIDADO en "with open" hay que usar seek, 
# para volver a apuntar al comienzzo

with open(r"teoria/datos/quijote.txt", encoding = "utf8") as archivo:
    lineas = archivo.readlines()
    archivo.seek(0)
    lineas_quijote_1 = [linea for linea in archivo if "Quijote" in linea]

lineas_quijote_1





lineas_quijote = []

fichero = open(r"teoria/datos/quijote.txt", encoding = "utf8")

for linea in fichero:
    if "Quijote" in linea:
        lineas_quijote.append(linea)
fichero.close()


len(lineas_quijote)


lineas_quijote2 = [linea for linea in fichero if "Quijote" in linea]
lineas_quijote2




import time

time.sleep(0.001)

def buscador_palabras(ubicacion_libro, personaje):
    with open(ubicacion_libro, "r", encoding = "utf8") as archivo:
        lineas = archivo.readlines()
        # Hemos puesto .lower() de esta manera podemos buscar cualquier palabra 
        # que empiece por minúscula o mayúscula
    """
    lineas_seleccionadas = []
    for linea in lineas:
        if palabra.lower() in linea.lower():
            lineas_seleccionadas.append(linea)
    """
    lineas_seleccionadas = [linea for linea in lineas if personaje.lower() in linea.lower()]
    return lineas_seleccionadas

ubicacion_libro = r"teoria/datos/quijote.txt"

personaje = "Casa"

lineas_quijote_def = buscador_palabras(ubicacion_libro, personaje)








