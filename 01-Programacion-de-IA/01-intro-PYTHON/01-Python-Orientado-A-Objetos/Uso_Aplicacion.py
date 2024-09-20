# -*- coding: utf-8 -*-
"""
Created on Fri Sep 20 12:56:35 2024

@author: 2425BIGDATA401
"""

from datetime import timedelta
from Aplicacion import Persona, Direccion

empleado_1 = Persona("Egoitz", "Aulestia Padilla", "12345678N")

lista_horas_trabajadas = []

empleado_1.fichar()

fichajes = empleado_1.fichajes

inicio = fichajes[::2]
fin = fichajes[1::2]

total = fin - inicio

total_horas_trabajadas = [a - b for a, b in zip(fin, inicio)]
total_horas_trabajadas[0] + total_horas_trabajadas[1]

total = sum(total_horas_trabajadas, timedelta(0))

print(f"{total.seconds}")

lista_timedeltas = [
    timedelta(hours=2),
    timedelta(minutes=30),
    timedelta(days=1),
    timedelta(seconds=45)
]

# Sumar los objetos timedelta
suma_total = sum(lista_timedeltas, timedelta())


entradas_A = []
salidas_A = []
for posicion, fichaje in enumerate(fichajes):
    if posicion % 2 == 0:
        entradas_A.append(fichaje)
    else:
        salidas_A.append(fichaje)





def calcular_tiempo_trabajado(self):
    horas_totales = []
    for turno in self.fichajes:
        if turno % 2 == 0:
            inicio = self.fichajes
        else:
            final = self.fichajes
            
        horas_trabajadas = final - inicio 
        
        horas_totales.append(horas_trabajadas)



# def calcular_tiempo_trabajado(self):
#     horas_totales = []
#     for turno in self.fichajes:
#         if turno % 2 == 0:
#             inicio = self.fichajes
#         else:
#             final = self.fichajes
            
#         horas_trabajadas = final - inicio 
        
#         horas_totales.append(horas_trabajadas)
