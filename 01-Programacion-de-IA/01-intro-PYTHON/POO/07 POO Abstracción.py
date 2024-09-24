#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar 14 19:00:57 2023

@author: laptop
"""
from abc import ABC, abstractmethod
# abstractmethod es un decorador que impide utilizar un método

class Animales(ABC):
    
    def __init__(self, nombre):
        self.nombre = nombre

    def hacer_sonido(self):
        print("Este animal hace...")
    
    # Aquí estoy obligando a que el método moverse se defina
    # en todas las clases herederas.
    @abstractmethod
    def moverse(self):
        pass

    def comer(self, comida):
        print(f"{self.nombre} está comiendo su {comida}")



class Perro(Animales):
    def __init__(self, nombre):
        super().__init__(nombre)

    def hacer_sonido(self):
        super().hacer_sonido()
        print("El perro hace 'guau guau'")

    def moverse(self):
        print("El perro corre")


lassie = Animales("Lassie")
lassie.hacer_sonido()



lassie = Perro('Lassie')
pluto = Perro("Pluto")

lassie.comer("Whiskas")
pluto.comer("Salchichas")

pluto.hacer_sonido()


#############
# Ejercicio #
#___________#

# Abstraemos la clase Persona del ejercicio.

# Sólo se podrán instanciar, directivos, oficinistas y peones
