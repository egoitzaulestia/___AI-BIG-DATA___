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

class Empleado:
    def __init__(self, nombre, apellidos, dni, direccion = Direccion("","","",""), telefono = ""):
        self.nombre = nombre.title()
        self.apellidos = apellidos.title()
        if self.verifica_dni(dni):
            self.dni = dni
        else:
            raise ValueError("DNI inválido")
        self.telefono = telefono
        self.direccion = direccion
        self.ubicacion = ""
        self.fichajes = []
        self.__sueldo_hora = 20
        self.cargo = ""
    
    @staticmethod    
    def verifica_dni(dni):
        """Comprobación de la letra del dni"""
        digito_control = "TRWAGMYFPDXBNJZSQVHLCKE"
        dni_num = int(dni[:-1])
        dni_letra = dni[-1]
        return dni_letra == digito_control[dni_num % 23]
               
    def __str__(self):
        return f"{self.nombre} {self.apellidos} {self.__class__.__name__}"
    
    @property
    def sueldo_hora(self):
        if input("Escribe password: ") == "password":
            return self.__sueldo_hora
        else:
            print("No tienes permiso para ver esto")
    
    @sueldo_hora.setter
    def sueldo_hora(self, nuevo_sueldo_hora):
        self.__sueldo_hora = nuevo_sueldo_hora
    
    
    def traslado(self, nueva_ubicacion):
        mensaje = f"{self.cargo}: {self.ubicacion} --> {nueva_ubicacion}"
        self.ubicacion = nueva_ubicacion
        print(mensaje)

    def ficha(self):
        self.fichajes.append(datetime.now())
        print("Bip, bip...")
        
    def __calcula_tiempo(self) -> timedelta:
        entradas = self.fichajes[0::2]
        salidas = self.fichajes[1::2]
        tiempo_jornadas = [s - e for s, e in zip(salidas, entradas)]
        tiempo_transcurrido = sum(tiempo_jornadas, start=timedelta(0))
        return tiempo_transcurrido

    def calcula_sueldo(self):
        tiempo_trabajado = self.__calcula_tiempo()
        sueldo = self.__sueldo_hora * tiempo_trabajado.total_seconds() / 3600
        return sueldo


class Directivo(Empleado):
    pass

class Oficinista(Empleado):
    def __init__(self, nombre, apellidos, dni, direccion = Direccion("","","",""), telefono = ""):
        super().__init__(nombre, apellidos, dni, direccion, telefono)
        self.sueldo_hora = 80
        self.bonus = 0
   
    def dar_bonus(self, dinero):
        self.bonus += dinero
    
    
    def calcula_sueldo(self):
        sueldo = super().calcula_sueldo()
        sueldo+= self.bonus
        return sueldo
    
    def __str__(self):
        return f"{super().__str__()}, tiene {self.bonus}€ de bonus acumulado"
        
    
class Peon(Empleado):
    pass


if __name__ == "__main__":

    empleado1 = Oficinista("Juan", "Pérez lópez", "12345654J", direccion = Direccion("Iturribide", 20, "Bilbao", 48006))
    print(empleado1) 
    
    empleado1.sueldo_hora
    
    empleado1.ficha()
    empleado1.ficha()
    
    empleado1.calcula_sueldo()
    
    empleado1.dar_bonus(100)
    empleado1.calcula_sueldo()
    """
    #Comprobación de la letra del dni
    dni = empleado1.dni
    dni_num = int(dni[:-1])
    dni_letra = dni[-1]
    
    
    digito_control = "TRWAGMYFPDXBNJZSQVHLCKE"
    dni_letra == digito_control[dni_num % 23]
    """
    empleado1.nombre
    
    empleado1.telefono = 944567754
    
    empleado1.cargo = "Director"
    empleado1.direccion.calle
    
    empleado1.direccion = Direccion("Iturribide", 20, "Bilbao", 48006)
    
    print(empleado1)
    
    empleado1.traslado("Rentería")
    empleado1.traslado("San Sebastián")







