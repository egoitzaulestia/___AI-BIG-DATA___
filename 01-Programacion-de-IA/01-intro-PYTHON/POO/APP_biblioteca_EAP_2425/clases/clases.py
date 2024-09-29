#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Sep 28 16:21:29 2024

@author: egoitzaulestiapadilla
"""


import time
from datetime import datetime, timedelta
from abc import ABC, abstractmethod
from funciones.funciones_decoradoras import pedir_password


# class Objeto
class Objeto(ABC):
    def __init__(self, identificador, titulo, anio, idioma, genero, seccion):
        self.identificador            = identificador
        self.titulo                   = titulo
        self.anio                     = anio
        self.__disponibilidad         = False  # Puede ser bool o available/not available
        self.tipo                     = self.__class__.__name__  # Tipo de objeto: libro, dvd, revista, etc.
        self.genero                   = genero  # género del objeto (categoría)
        self.seccion                  = seccion
        self.infraccion               = False
        self.__tiempo_alquiler        = []
        self.__copias                 = 0 
        self.__balance                = 0
        self.precio_compra            = 0
        self.__precio_alquiler        = 0
        self.estado_objeto            = False
    
    
    @abstractmethod
    def __str__(self):
        return f"Título: {self.titulo}\nAño Publicación: {self.anio}\nTipo de Objeto: {self.__class__.__name__}"

    def __del__(self):
        if hasattr(self, 'titulo'):
            print(f"Se ha eliminado el/la {self.__class__.__name__.lower()} \"{self.titulo}\" de la base de datos")
        else:
            print(f"Se ha eliminado el/la {self.__class__.__name__.lower()} de la base de datos")

    @abstractmethod
    def __len__(self):
        pass
    
    @abstractmethod
    def __lt__(self, otro):
        pass
    
    @abstractmethod
    def __le__(self, otro):
        pass
    @abstractmethod
    def __gt__(self, otro):
        pass
    
    @abstractmethod
    def __ge__(self, otro):
        pass
    
    @abstractmethod
    def __eq__(self, otro):
        pass

        
    @abstractmethod
    def mostrar_info_detallada(self):
        return (f"INFORMACIÓN DETALLADA SOBRE EL/LA {self.__class__.__name__.upper()}\n"
                f"Título: {self.titulo}\n"
                f"Idioma: {self.idioma}\n"
                f"Año de publicación: {self.anio}\n"
                f"Género: {self.genero}\n"
                f"Sección: {self.seccion}\n"
                f"Disponibilidad: {'Disponible' if self.disponibilidad else 'No disponible'}")


    def verificar_disponibilidad(self):
        return self.__disponibilidad
    
    
    def fichar(self):
        self.__tiempo_alquiler.append(datetime.now())
        print("Bip, bip...")
        
        
    def comprar(self, unidades, precio):
        self.__copias += unidades
        self.__balance -= (unidades * precio)
        self.__disponibilidad = True
    
    
    def alquilar_objeto(self):
        if self.__disponibilidad and self.__copias:
            
            self.__tiempo_alquiler.append(datetime.now())

            self.__copias -= 1
            self.__balance += self.precio_alquiler
            print("Bip, bip...")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(1)
            print(f"Has alquilado {self.titulo}")
        else:
            print(f"No puedes alquilar este/a {self.__class__.__name__} por que no nos quedan copias.")
    
    
    def devolver_objeto(self, estado):
        # self.__tiempo_alquiler.append(datetime.now())
        
        tiempo_alquiler_transcurrido = self.__calcula_tiempo()
        
        # Si el objeto está en buen estado
        if estado:
            print("Bip, bip...")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(1)
            self.__copias += 1
            self.__tiempo_alquiler.append(datetime.now())  # Registro de la devolución
            print(tiempo_alquiler_transcurrido)
            print(f"Has devuelto {self.titulo} en buenas condiciones.")
    
        # Si el tiempo de alquiler es mayor a un límite, aplicamos multa por retraso
        elif tiempo_alquiler_transcurrido > timedelta(seconds=10):
            print("Bip, bip...")
            time.sleep(2)
            multa_por_retraso = self.precio_alquiler + 2
            self.__balance += multa_por_retraso
            self.__copias += 1  # Devuelve el objeto, pero con multa
            self.__tiempo_alquiler.append(datetime.now())  # Registro de la devolución
            print(tiempo_alquiler_transcurrido)
            print(f"Has devuelto el/la {self.__class__.__name__} {self.titulo} con retraso. Multa: {multa_por_retraso}")
    
        # Si el tiempo de alquiler es mayor a un límite y el objeto está en mal estado
        elif tiempo_alquiler_transcurrido > timedelta(seconds=10) and estado == False:
            print("Bip, bip...")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(1)
            print(f"Verificando el estado del/a {self.__class__.__name__}")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(2)
            multa = self.precio_compra + self.precio_alquiler + 2 + 2
            self.__balance += multa
            self.__copias += 1  # Devuelve el objeto, pero con multa
            self.__tiempo_alquiler.append(datetime.now())  # Registro de la devolución
            print(f"Has devuelto el/la {self.__class__.__name__} {self.titulo} con retraso. Y además está en mal estado. Multa: {multa}")
    
        # Si el objeto está en mal estado
        else:
            print("Bip, bip...")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(1)
            print(f"Verificando el estado del/a {self.__class__.__name__}")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(1)
            print("Bip, bip...")
            time.sleep(2)
            self.estado_objeto = False  # Marcar objeto como dañado
            multa = self.precio_compra + self.precio_alquiler + 2
            self.__balance += multa
            print(f"Has devuelto el/la {self.__class__.__name__} {self.titulo} en mal estado. Multa: {multa}")
    
        # Actualizar la disponibilidad si hay copias disponibles
        if self.__copias > 0:
            self.__disponibilidad = True
    
    
    def verificar_estado_del_objeto(self):
        if self.estado_objeto:
            print(f"El/La {self.__class__.__name__} {self.titulo} está en buenas condiciones y puede ser alquilado/a.")
        else:
            print(f"El/La {self.__class__.__name__} {self.titulo} estaba en malas condiciones y Debería de ser ha enviado a reparar.")
          
    def reparar_objeto(self):
        self.estado_objeto = True
        self.__copias += 1  # Devuelve el objeto, pero con multa
        print(f"El/La {self.__class__.__name__} {self.titulo} ha sido reparado.")

    @property
    def precio_alquiler(self):
        return self.__precio_alquiler
    
    
    @precio_alquiler.setter
    def precio_alquiler(self, valor):
        self.__precio_alquiler += valor
    
    
    @pedir_password   
    def habilitar_objeto(self):
        self.__disponibilidad = True

    
    @pedir_password    
    def desablitar_objeto(self):
        self.__disponibilidad = False    
    
    @property
    @pedir_password    
    def disponibilidad(self):
        return self.__disponibilidad
    
    @disponibilidad.setter
    @pedir_password    
    def disponibilidad(self, estado_disponible):
        self.__disponibilidad = estado_disponible

    @property
    @pedir_password    
    def balance(self):
        return self.__balance
    
    @balance.setter
    @pedir_password
    def balance(self, valor):
        self.__balance += valor
    
    def __calcula_tiempo(self):
        entradas = self.__tiempo_alquiler[0::2]
        salidas = self.__tiempo_alquiler[1::2]
    
        # Asegúrate de que haya un par de entradas y salidas
        if len(salidas) < len(entradas):
            # Si hay más entradas que salidas, significa que el objeto sigue alquilado
            # Calcula el tiempo desde la última entrada hasta el presente momento
            salidas.append(datetime.now())
        
        # Calcula el tiempo total transcurrido
        tiempo_jornadas = [s - e for s, e in zip(salidas, entradas)]
        tiempo_transcurrido = sum(tiempo_jornadas, start=timedelta(0))
        return tiempo_transcurrido


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



