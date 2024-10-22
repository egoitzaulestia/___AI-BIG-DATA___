# -*- coding: utf-8 -*-
"""
Created on Fri Sep 20 08:51:19 2024

@author: 2425BIGDATA401
"""


"""

Clase Dirección
---------------
calle
numero
municipio

"""

class Direccion:
    def __init__(self, calle, numero, municipio, codigo_postal):
        self.calle         = calle
        self.numero        = numero
        self.municipio     = municipio
        self.codigo_postal = codigo_postal
        
        
        

# Crear la clase persona con datos personales de un tranajador

"""

Clase Persona
-------------
nombre
apellidos
cargo
dni
telefono

"""

from datetime import datetime, timedelta


class Persona:
    def __init__(self, nombre, apellidos, dni):
        self.nombre     = nombre.title() # title() capitaliza las distintas palabras 
        self.apellidos  = apellidos.title() # title() capitaliza las distintas palabras 
        # self.dni      = verifica_dni(dni)
        self.dni        = dni
        self.cargo      = ""
        self.telefono   = ""
        self.direccion  = ""
        self.ubicacion  = ""
        self.fichajes   = []
        self.sueldo     = 20
        
        

    def __str__(self):
        return f"{self.nombre} {self.apellidos}{' es ' + self.cargo if self.cargo else ''}"

        
    def __del__(self):
        print(f"Se a eliminado a {self.nombre} {self.apellidos} de la base de datos")
            
    def traslado(self, nueva_ubicacion):
        ubicacion_anterio = self.ubicacion
        self.ubicacion = nueva_ubicacion
        print(f"{self.nombre} {self.apellidos} ha sido trasladado desde {ubicacion_anterio} a {self.ubicacion}")
    
    def fichar(self):
        self.fichajes.append(datetime.now())
        print("Bip, bip...")
        
    # def calcular_tiempo_trabajo(self):
    #     for turno in self.fichajes:
    #         if turno % 2 == 0:
    #             inicio = self.fichajes
    #         else:
    #             final = self.fichajes
                
    #         horas_trabajadas = final - inicio 
            
    #         horas_trabajadas += horas_trabajadas

    def calcula_tiempo(self):
        # fichajes = self.fichajes
        entradas = self.fichajes[0::2]
        salidas = self.fichajes[1::2]
        tiempo_jornadas = [s - e for s, e in zip(salidas, entradas)]
        tiempo_transcurrido = sum(tiempo_jornadas, start=timedelta(0))
        return tiempo_transcurrido



if __name__ == "__main__":

    empleado_1 = Persona("Joxean", "Legarda blanco", "72478072N")

    empleado_1.cargo = "malabarista"
    
    #############
    
    dni = empleado_1.dni
    dni_num = int(dni[:-1])
    dni_letra = dni[-1]
    
    letras_dni = "TRWAGMYFPDXBNJZSQVHLCKE"
    
    dni_letra == letras_dni[dni_num % 23]
    
    ##############
            
    empleado_1.direccion = Direccion("Avenida Madrid", 22, "Donostia", 20011)
    
    empleado_1.direccion.calle
    
    ##############
    
    empleado_1.ubicacion = "Donostia"
    empleado_1.ubicacion
    
    empleado_1.traslado("San Francisco")
    empleado_1.ubicacion
    
    ##############
            
    empleado_1.fichar()
    
    empleado_1.fichajes
    print(empleado_1)
    


