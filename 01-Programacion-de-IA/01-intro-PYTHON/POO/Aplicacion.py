# -*- coding: utf-8 -*-
"""
Created on Fri Sep 20 08:51:19 2024

@author: Egoitz Aulestia Padilla
"""

#############
# Ejercicio #
#___________#
# Crear la clase empleado
# y a partir de ella crear clases herederas según cargo.


# Las clases "hijo" serán Directivo, Oficinista, Peon

# El directivo, tiene coche de empresa, y métodos asociados a él.
# El oficinista tiene bonuses
# El peón tiene guardias... etc # El único que trabajará por la noche



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



import time
from datetime import datetime, timedelta

from abc import ABC, abstractmethod

class Empleado:
    def __init__(self, nombre, apellidos, dni):
        self.nombre       = nombre.title() # title() capitaliza las distintas palabras 
        self.apellidos    = apellidos.title() # title() capitaliza las distintas palabras 
        if self.verifica_dni(dni):
            self.dni = dni
        else:
            raise ValueError("DNI inválido")
        # self.dni          = dni
        self.cargo        = ""
        self.telefono     = ""
        self.direccion    = ""
        self.ubicacion    = ""
        self.fichajes     = []
        self.__sueldo_hora  = 20
        
        
    @staticmethod   
    def verifica_dni(dni):
        """Comprovación de la letra del DNI"""
        digito_control = "TRWAGMYFPDXBNJZSQVHLCKE"
        dni_num = int(dni[:-1])
        dni_letra = dni[-1]
        return dni_letra == digito_control[dni_num % 23]

    # def __str__(self):
    #     return f"{self.nombre} {self.apellidos}{' es ' + self.cargo if self.cargo else ''}"

    def __str__(self):
        return f"{self.nombre} {self.apellidos} {self.__class__.__name__}"

        
    def __del__(self):
        print(f"Se a eliminado a {self.nombre} {self.apellidos} de la base de datos")
            
    def traslado(self, nueva_ubicacion):
        ubicacion_anterio = self.ubicacion
        self.ubicacion = nueva_ubicacion
        print(f"{self.nombre} {self.apellidos} ha sido trasladado desde {ubicacion_anterio} a {self.ubicacion}")
    
    def fichar(self):
        self.fichajes.append(datetime.now())
        print("Bip, bip...")
        
    # Método encapsulado
    def __calcula_tiempo(self):
        # fichajes = self.fichajes
        entradas = self.fichajes[0::2]
        salidas = self.fichajes[1::2]
        tiempo_jornadas = [s - e for s, e in zip(salidas, entradas)]
        tiempo_transcurrido = sum(tiempo_jornadas, start=timedelta(0))
        return tiempo_transcurrido

    # def calcula_sueldo(self):
    #     tiempo_transcurrido = self.__calcula_tiempo()
    #     pago_total = round(((self.__sueldo_hora * tiempo_transcurrido.total_seconds()) / 3600), 2)
    #     return pago_total
    
    # Esto es un método de ab
    @abstractmethod
    def calcula_sueldo(self):
        tiempo_transcurrido = self.__calcula_tiempo()
        pago_total = round(((self.__sueldo_hora * tiempo_transcurrido.total_seconds()) / 3600), 2)
        return pago_total

    # Metodo getter
    @property
    def sueldo_hora(self):
        if input("Escribe password: ") == "1234":
            return self.__sueldo_hora
        else:
            return "No te doy la información"
        
     # Metodo setter
    @sueldo_hora.setter
    def sueldo_hora(self, nuevo_sueldo_hora):
        self.__sueldo_hora = nuevo_sueldo_hora 



class Directivo(Empleado):
    def __init__(self, nombre, apellidos, dni):
        super().__init__(nombre, apellidos, dni)
        self.sueldo_hora    = 80
        self.coche_empresa  = True
        self.reunido        = False
        
    def entrar_en_reunion(self):
        self.reunido = True
    
    def salir_de_reunion(self):
        self.reunido = False
        


directivo_1 = Directivo("Mac", "Davilson Suer", "36345676H")
directivo_1.sueldo_hora


def calcular_letra_dni(num_dni):
    return "TRWAGMYFPDXBNJZSQVHLCKE"[num_dni%23]
    
calcular_letra_dni(44556677)
directivo_1 = Directivo("Mac", "Davilson Suer", "36345676H")

print(directivo_1)

directivo_1.sueldo

directivo_1.get_sueldo()

directivo_1.reunido
directivo_1.entrar_en_reunion()
directivo_1.reunido

directivo_1.fichar()
time.sleep(3)
directivo_1.fichar()
directivo_1.calcula_sueldo()



    
class Oficinista(Empleado):
    def __init__(self, nombre, apellidos, dni):
        super().__init__(nombre, apellidos, dni)
        self.__sueldo_hora = 40
        self.bonus = 0
        
    # IMPORTANTE - > encapsular extra_bonus
    # Crear setter y getter
    def extra_bonus(self, cantidad):
        self.bonus += cantidad 
    
    # def calcula_sueldo(self):
    #     tiempo_transcurrido = self.calcula_tiempo()
    #     pago_total = round(((self.sueldo_hora * tiempo_transcurrido.total_seconds()) / 3600), 2)
    #     return pago_total
    
    def calcula_sueldo(self): 
        pago_total = super().calcula_sueldo() # Polimorfismo: Heredamos método del padre, y lo modificamos
        pago_total += self.bonus 
        return pago_total
    
    def __str__(self):
        return f"{super().__str__()}, tiene {self.bonus}€ de bonus acumulado"
    
oficinista_1 = Oficinista("Alaitz", "Guirador Padil", "44556677L")
oficinista_1.extra_bonus(500)

oficinista_1.bonus

print(oficinista_1)

oficinista_1.fichar()
time.sleep(4)
time.sleep(4)

oficinista_1.fichar()

# oficinista_1.cobrar()
oficinista_1.calcula_sueldo()
oficinista_1.calcula_tiempo()


timedelta(seconds=12)



# El empleado teiene un sueldo_hora = 20, heredado de Empleado
class Peon(Empleado):
    def __init__(self, nombre, apellidos, dni):
        super().__init__(nombre, apellidos, dni)
        self.guardias = 0
    
    def ingresar_horas_guardia(self):
        horas_guardia = int(input("Introduce horas de guardia: "))
        self.guardias += horas_guardia
        
    def calcula_sueldo(self): 
        pago_guardias = self.guardias * 10
        pago_total = super().calcula_sueldo() # Polimorfismo: Heredamos método del padre, y lo modificamos
        pago_total += pago_guardias
        return pago_total

    def __str__(self):
        return f"{super().__str__()}, tiene {self.guardias} horas de guardia equivalente a {self.guardias * 10}€"

peon_1 = Peon("Unai", "Meri Azak", "23664789C")

print(peon_1)

peon_1.fichar()
time.sleep(4)
time.sleep(4)
peon_1.fichar()

peon_1.calcula_sueldo()

peon_1.ingresar_horas_guardia()


class Coche:
    def __init__(self):
        pass



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
    


