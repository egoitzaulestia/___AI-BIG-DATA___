#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Mon Mar 13 17:46:48 2023

@author: laptop
"""

###################
# Encapsulamiento #
###################

"""Al utilizar el encapsulamiento, se evita que los atributos privados de una clase sean 
manipulados directamente desde fuera de la clase, lo que garantiza la integridad de los 
datos internos de la clase. """


class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.__edad = edad

    def get_edad(self):
        return self.__edad

    def set_edad(self, edad):
        if edad < 0 or edad > 120:
            raise ValueError("La edad no puede ser negativa ni mayor que 120")
        self.__edad = edad

    def saludar(self):
        print(f'Hola, mi nombre es {self.nombre} y tengo {self.__edad} años')


"""El atributo nombre es público, mientras que el atributo __edad es privado. 
Además, la clase tiene dos métodos públicos: get_edad() y set_edad(). 
El método get_edad() devuelve el valor del atributo privado __edad, 
mientras que el método set_edad() establece el valor del atributo privado __edad 
después de validar que el valor de edad es válido."""

vigilante = Persona("Pedro", 50)
vigilante.__edad

vigilante.__edad = 25

dir(vigilante)
vigilante.saludar()

vigilante.set_edad(51)
vigilante.get_edad()

vigilante.__edad

vigilante.saludar()

# Decoradores property y setter
class Persona:
    def __init__(self, nombre, edad):
        self.nombre = nombre
        self.__edad = edad
    
    @property
    def edad(self):
        if input("Escribe password: ") == "password":
            return self.__edad
        else:
            return "No te doy la información"


    @edad.setter
    def edad(self, edad):    
        if edad < 0 or edad > 120:
            raise ValueError("La edad no puede ser negativa ni mayor que 120")
        elif input("Escribe password: ") == "password": 
            self.__edad = edad


    def saludar(self):
        print(f'Hola, mi nombre es {self.nombre} y tengo {self.__edad} años')


vigilante = Persona("Pedro", 50)
vigilante.edad
vigilante.edad = 130
vigilante.edad = -3
vigilante.edad = 51
vigilante.edad

vigilante.saludar()

class Persona:
    def __init__(self, nombre, apellido1, apellido2):
        # Características
        self.nombre = nombre
        self.apellido1 = apellido1
        self.apellido2 = apellido2
        # Estados
        self.trabajando = False
        self.__ubicacion = "Rentería"

    # Los métodos son funciones con "self"
    def presentarse(self):
        print(
            f'Hola, mi nombre es {self.nombre} {self.apellido1} {self.apellido2}')

    def ficha(self):
        self.trabajando = not self.trabajando

    def sale_de_viaje(self, nueva_ubicacion):
        print(f"{self.__ubicacion} -----> {nueva_ubicacion}")
        self.__ubicacion = nueva_ubicacion
        print(self.__esta_en())

    def __esta_en(self):
        return self.__ubicacion



director = Persona('Juan', 'Pérez', 'López')
secretario = Persona('Juanito', 'Pérez', 'García')

director.presentarse()
secretario.presentarse()
secretario.sale_de_viaje("Bilbao")


print(f"¿Está trabajando {director.nombre}? {director.trabajando}")
print(f"¿Está trabajando {secretario.nombre}? {secretario.trabajando}")

secretario.ficha()

print(f"¿Está trabajando {director.nombre}? {director.trabajando}")
# print(f"¿Dónde está el director? {director.__ubicacion}") # Ya no funciona
print(f"¿Dónde está el director? {director.esta_en()}")
print(f"¿Está trabajando {secretario.nombre}? {secretario.trabajando}")
# print(f"¿Dónde está el secretario? {secretario.__ubicacion}") # Ya no funciona
print(f"¿Dónde está el secretario? {secretario.esta_en()}")

# director.__ubicacion = "Oyarzun" # Ya no funciona
director.sale_de_viaje("Oyarzun")

director.__ubicacion = "Bilbao"
dir(director)
print(f"¿Está trabajando {director.nombre}? {director.trabajando}")
# print(f"¿Dónde está el director? {director.__ubicacion}") # Ya no funciona
print(f"¿Dónde está el director? {director.esta_en()}")
print(f"¿Está trabajando {secretario.nombre}? {secretario.trabajando}")
# print(f"¿Dónde está el secretario? {secretario.__ubicacion}") # Ya no funciona
print(f"¿Dónde está el secretario? {secretario.esta_en()}")


# También pueden encapsularse métodos que no quiero que se activen desde fuera
# (Seguramente porque requieren de operaciones previas)

#############
# Ejercicio #
#___________#

# Vamos a encapsular "asignar_coche", "sueldo_hora"... en el ejercicio del personal
