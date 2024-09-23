#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Fri Sep 20 08:51:01 2024

@author: laptop
"""

# Crear la clase persona con datos personales de un trabajador
"""
nombre
apellidos
cargo
dni
telefono

"""
from datetime import datetime, timedelta


class Direccion:
    def __init__(self, calle, numero, municipio, codigo_postal):
        self.calle =calle
        self.numero = numero
        self.municipio = municipio
        self.codigo_postal = codigo_postal

class Persona:
    cargo = []
    
    def __init__(self, nombre, apellidos, dni, direccion = Direccion("","","",""), telefono = ""):
        self.nombre = nombre.title()
        self.apellidos = apellidos.title()
        self.dni = dni
        self.telefono = telefono
        self.direccion = direccion
        self.ubicacion = ""
        self.fichajes = []
               
    def __str__(self):
        return f"{self.nombre} {self.apellidos} {self.cargo if self.cargo else ''}"
    
    
    def traslado(self, nueva_ubicacion):
        mensaje = f"{self.cargo}: {self.ubicacion} --> {nueva_ubicacion}"
        self.ubicacion = nueva_ubicacion
        print(mensaje)

    def ficha(self):
        self.fichajes.append(datetime.now())
        print("Bip, bip...")
        
    def calcula_tiempo(self):
        fichajes = self.fichajes
        entradas = self.fichajes[0::2]
        salidas = self.fichajes[1::2]
        tiempo_jornadas = [s - e for s, e in zip(salidas, entradas)]
        tiempo_transcurrido = sum(tiempo_jornadas, start=timedelta(0))
        return tiempo_transcurrido

if __name__ == "__main__":

    empleado1 = Persona("Juan", "Pérez lópez", "12345678A", direccion = Direccion("Iturribide", 20, "Bilbao", 48006))
    
    """
    #Comprobación de la letra del dni
    dni = empleado1.dni
    dni_num = int(dni[:-1])
    dni_letra = dni[-1]
    
    
    letras_desordenadas = "WRADTHBK"
    
    dni_letra == letras_desordenadas[dni_num % 23]
    """
    empleado1.nombre
    
    empleado1.telefono = 944567754
    
    empleado1.cargo = "Director"
    empleado1.direccion.calle
    
    empleado1.direccion = Direccion("Iturribide", 20, "Bilbao", 48006)
    
    print(empleado1)
    
    empleado1.traslado("Rentería")
    empleado1.traslado("San Sebastián")







