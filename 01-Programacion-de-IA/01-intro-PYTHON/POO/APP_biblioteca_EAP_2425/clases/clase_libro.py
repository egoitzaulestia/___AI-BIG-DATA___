# -*- coding: utf-8 -*-
"""
Created on Tue Sep 24 09:14:18 2024

@author: Egoitz Aulestia Padilla
"""

"""
Sistema de biblioteca de gestión de recursos de biblioteca basado en POO
"""


import time
from datetime import datetime, timedelta

from abc import ABC, abstractmethod

from POO.func.funciones_decoradoras import pedir_password



# Clase Libro
class Libro(Objeto):
    def __init__(self, identificador, titulo, autor, paginas, anio, idioma, editorial, genero, seccion):
        super().__init__(identificador, titulo, anio, idioma, genero, seccion)
        self.autor               = autor       # Nombre del autor del libro
        self.isbn                = ""          # Número ISBN del libro
        self.editorial           = editorial   # Editorial que publicó el libro
        self.paginas             = paginas     # Número total de páginas del libro
        self.edicion             = ""          # Edición del libro
        self.idioma              = idioma      # Idioma en el que está escrito el libro
        self._precio_alquiler    = 3           # Pasamos __precio_alquiler (protegido) a _precio_alquiles (privado)

        
    # Método para mostrar información detallada del libro
    def mostrar_info_detallada(self):
        info_det_sup = super().mostrar_info_detallada()
        print(f"{info_det_sup}\n"
              f"Autor: {self.autor}\n"
              f"ISBN: {self.isbn}\n"
              f"Editorial: {self.editorial}\n"
              f"Edición: {self.edicion}\n"
              f"Número de páginas: {self.paginas}\n")


    # Método para mostrar info resumida del libro
    def __str__(self):
        return f"El libro '{self.titulo}' escrito por {self.autor} es un {self.genero} publicado por {self.editorial} en el año {self.anio}."

    def __len__(self):
        return self.paginas
    
    def __lt__(self, otro):
        return self.paginas < otro.paginas
    
    def __le__(self, otro):
        return self.paginas >= otro.paginas
    
    def __gt__(self, otro):
        return self.paginas > otro.paginas
    
    def __ge__(self, otro):
        return self.paginas >= otro.paginas
    
    def __eq__(self, otro):
        return self.paginas == otro.paginas


    # Método que devuelve el número total de páginas
    def obtener_paginas(self):
        return self.paginas
    
    # Getter para el precio de alquiler
    @property
    def precio_alquiler(self):
        return self._precio_alquiler
    
    # Setter para el precio de alquiler
    @precio_alquiler.setter
    def precio_alquiler(self, valor):
        self._precio_alquiler += valor
    
    
    
# Clase DVD 
class DVD(Objeto):
    def __init__(self, identificador, titulo, director, duracion, clasificacion_edad, formato_video, idioma, idiomas_disponibles, anio, genero, seccion):
        super().__init__(identificador, titulo, anio, idioma, genero, seccion)
        self.director            = director
        self.idioma              = idioma
        self.duracion            = duracion  # en minutos
        self.clasificacion_edad  = clasificacion_edad  # Ej. +18, PG-13, etc.
        self.formato_video       = formato_video  # Blu-Ray, DVD estándar, etc.
        self.idiomas_disponibles = idiomas_disponibles  # Lista de idiomas disponibles
        self._precio_alquiler    = 4  # Pasamos __precio_alquiler (protegido) a _precio_alquiles (privado)


    # Método para mostrar una breve información del DVD
    def __str__(self):
        return f"El DVD '{self.titulo}', dirigido por {self.director}, con una duración de {self.duracion} minutos, fue lanzado en el año {self.anio} y pertenece al género de {self.genero}."

    def __len__(self):
        print(self.duracion)
    
    def __lt__(self, otro):
        return self.duracion < otro.duracion
    
    def __le__(self, otro):
        return self.duracion >= otro.duracion
    
    def __gt__(self, otro):
        return self.duracion > otro.duracion
    
    def __ge__(self, otro):
        return self.duracion >= otro.duracion
    
    def __eq__(self, otro):
        return self.duracion == otro.duracion


    # Método para mostrar la información detallada del DVD
    def mostrar_info_detallada(self):
        info_det_sup = super().mostrar_info_detallada()
        print(f"{info_det_sup}\n"
              f"Director: {self.director}\n"
              f"Duración: {self.duracion} minutos\n"
              f"Idiomas disponibles: {', '.join(self.idiomas_disponibles)}\n"
              f"Clasificación por edad: +{self.clasificacion_edad}\n"
              f"Formato de video: {self.formato_video}\n")
              

    # Método para obtener la duración del DVD
    def obtener_duracion(self):
        return self.duracion

    # Método para comprobar si la edad del usuario es adecuada para ver el DVD
    def comprobar_clasificacion(self, edad_usuario):
        return edad_usuario >= int(self.clasificacion_edad)  # Ej. Si es +18 y el usuario tiene 19 años, devuelve True

    # Método para consultar los subtítulos disponibles
    def consultar_subtitulos(self):
        return self.idiomas_disponibles  # Devuelve la lista de idiomas como subtítulos disponibles
    
    # Getter para el precio de alquiler
    @property
    def precio_alquiler(self):
        return self._precio_alquiler
    
    # Setter para el precio de alquiler
    @precio_alquiler.setter
    def precio_alquiler(self, valor):
        self._precio_alquiler += valor
    


# Clase Revista
class Revista(Objeto):
    def __init__(self, identificador, titulo, numero, editorial, paginas, tema_principal, periodicidad, anio, idioma, mes, genero, seccion):
        super().__init__(identificador, titulo, anio, idioma, genero, seccion)
        self.numero            = numero
        self.idioma            = idioma
        self.mes               = mes
        self.editorial         = editorial
        self.paginas           = paginas
        self.tema_principal    = tema_principal  # Tema central de la edición
        self.periodicidad      = periodicidad  # Mensual, semanal, trimestral, etc.
        self._precio_alquiler  = 1  # Pasamos __precio_alquiler (protegido) a _precio_alquiles (privado)

    
    # Método para mostrar una breve información de la revista
    def __str__(self):
        return f"Número {self.numero} de la revista '{self.titulo}' de la editorial {self.editorial} publicado en {self.mes} del año {self.anio} y está con el tema central de {self.tema_principal}."

    def __len__(self):
        return self.paginas
    
    def __lt__(self, otro):
        return self.paginas < otro.paginas
    
    def __le__(self, otro):
        return self.paginas >= otro.paginas
    
    def __gt__(self, otro):
        return self.paginas > otro.paginas
    
    def __ge__(self, otro):
        return self.paginas >= otro.paginas
    
    def __eq__(self, otro):
        return self.paginas == otro.paginas

    # Método para mostrar información detallada de la revista
    def mostrar_info_detallada(self):
        info_det_sup = super().mostrar_info_detallada()
        print(f"{info_det_sup}\n"
              f"Volumen: {self.numero}\n"
              f"Mes: {self.mes}\n"
              f"Editor: {self.editorial}\n"
              f"Tema principal: {self.tema_principal}\n"
              f"Periodicidad: {self.periodicidad}\n")

    # Método para obtener el tema principal de la revista
    def obtener_tema(self):
        return self.tema_principal

    # Método para consultar el índice de la revista (los artículos, secciones, etc.)
    def consultar_numeo_revista(self):
        return f"Revista {self.titulo} (Vol. {self.numero})"

    # Método para verificar si la edición actual es especial (puedes definir tu lógica para esto)
    def es_edicion_especial(self):
        return self.numero % 10 == 0  # Cada décima edición es una edición especial

    # Getter para el precio de alquiler
    @property
    def precio_alquiler(self):
        return self._precio_alquiler
    
    # Setter para el precio de alquiler
    @precio_alquiler.setter
    def precio_alquiler(self, valor):
        self._precio_alquiler += valor



