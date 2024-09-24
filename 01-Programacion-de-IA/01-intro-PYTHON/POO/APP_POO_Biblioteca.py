# -*- coding: utf-8 -*-
"""
Created on Tue Sep 24 09:14:18 2024

@author: Egoitz Aulestia Padilla
"""

"""
Sistema de biblioteca de gestión de recursos de biblioteca basado en POO
"""


from abc import ABC, abstractmethod


class Biblioteca():
    pass


class Objeto:
    def __init__(self, identificador, titulo, anio, genero, seccion):
        self.identificador = identificador
        self.titulo = titulo
        self.anio = anio
        self.disponibilidad = True  # Puede ser bool o available/not available
        # self.fecha_publicacion = fecha_publicacion 
        self.tipo = self.__class__.__name__  # Tipo de objeto: libro, dvd, revista, etc.
        self.genero = genero  # género del objeto (categoría)
        self.seccion = seccion
        self.infraccion = False
        
    def __str__(self):
        # Cambiado a self.anio ya que self.fecha_publicacion no está definido
        return f"Título: {self.titulo}\nFecha Publicación: {self.anio}\nTipo de Objeto: {self.__class__.__name__}"

    def mostrar_info_detallada(self):
        pass
    
    def cambiar_disponibilidad(self, estado):
        if self.disponibilidad:
            self.disponibilidad = estado
        else:
            self.disponibilidad = estado
    
    def actualizar_info(self, nuevos_datos):
        pass
    
    def verificar_disponibilidad(self):
        return self.disponibilidad

        
        
    
objeto_1 = Objeto(1, "Matrix", "1999", "Ciencia Ficción", "libros")

print(objeto_1)



class Libro(Objeto):
    def __init__(self, identificador, titulo, autor, isbn, editorial, paginas, edicion, idioma, anio, genero, seccion):
        super().__init__(identificador, titulo, anio, genero, seccion)
        self.autor = autor                   # Nombre del autor del libro
        self.isbn = isbn                     # Número ISBN del libro
        self.editorial = editorial           # Editorial que publicó el libro
        self.paginas = paginas               # Número total de páginas del libro
        self.edicion = edicion               # Edición del libro
        self.idioma = idioma                 # Idioma en el que está escrito el libro
        
    # Método para mostrar información detallada del libro
    def mostrar_info_detallada(self):
        return (f"Título: {self.titulo}\n"
                f"Autor: {self.autor}\n"
                f"ISBN: {self.isbn}\n"
                f"Editorial: {self.editorial}\n"
                f"Edición: {self.edicion}\n"
                f"Idioma: {self.idioma}\n"
                f"Número de páginas: {self.paginas}\n"
                f"Año de publicación: {self.anio}\n"
                f"Género: {self.genero}\n"
                f"Sección: {self.seccion}\n"
                f"Disponibilidad: {'Disponible' if self.disponibilidad else 'No disponible'}")

    # Método para mostrar el resumen o sinopsis del libro
    def __str__(self):
        return f"El libro '{self.titulo}' escrito por {self.autor} es un {self.genero} publicado por {self.editorial} en el año {self.anio}."

    # Método que devuelve el número total de páginas
    def obtener_paginas(self):
        return self.paginas

    # Método para comprobar si el autor es famoso o relevante (esto puede ser extendido)
    def es_autor_conocido(self, autor_famoso):
        return self.autor == autor_famoso



libro_1 = Libro(11, "Matrix", "Watchowsky bro", "44332", "Casas", 800, 1, "Inglés", "2000", "Ciencia Ficción", "libros")

print(libro_1)

libro_1.disponibilidad
libro_1.tipo
libro_1.verificar_disponibilidad()
libro_1.cambiar_disponibilidad(False)
libro_1.verificar_disponibilidad()
libro_1.cambiar_disponibilidad(True)
libro_1.consultar_resumen()
libro_1.paginas



class DVD(Objeto):
    def __init__(self, identificador, titulo, director, duracion, clasificacion_edad, formato_video, idiomas_disponibles, anio, genero, seccion):
        super().__init__(identificador, titulo, anio, genero, seccion)
        self.director = director
        self.duracion = duracion  # en minutos
        self.clasificacion_edad = clasificacion_edad  # Ej. +18, PG-13, etc.
        self.formato_video = formato_video  # Blu-Ray, DVD estándar, etc.
        self.idiomas_disponibles = idiomas_disponibles  # Lista de idiomas disponibles

    # Método para mostrar la información detallada del DVD
    def mostrar_info_detallada(self):
        return (f"Título: {self.titulo}\n"
                f"Director: {self.director}\n"
                f"Duración: {self.duracion} minutos\n"
                f"Clasificación por edad: {self.clasificacion_edad}\n"
                f"Formato de video: {self.formato_video}\n"
                f"Idiomas disponibles: {', '.join(self.idiomas_disponibles)}\n"
                f"Año de publicación: {self.anio}\n"
                f"Género: {self.genero}\n"
                f"Sección: {self.seccion}\n"
                f"Disponibilidad: {'Disponible' if self.disponibilidad else 'No disponible'}")

    # Método para obtener la duración del DVD
    def obtener_duracion(self):
        return self.duracion

    # Método para comprobar si la edad del usuario es adecuada para ver el DVD
    def comprobar_clasificacion(self, edad_usuario):
        return edad_usuario >= int(self.clasificacion_edad.replace('+', ''))  # Ej. Si es +18 y el usuario tiene 19 años, devuelve True

    # Método para consultar los subtítulos disponibles
    def consultar_subtitulos(self):
        return self.idiomas_disponibles  # Devuelve la lista de idiomas como subtítulos disponibles




class Revista(Objeto):
    def __init__(self, identificador, titulo, volumen, numero, editor, tema_principal, periodicidad, anio, genero, seccion):
        super().__init__(identificador, titulo, anio, genero, seccion)
        self.volumen = volumen
        self.numero = numero
        self.editor = editor
        self.tema_principal = tema_principal  # Tema central de la edición
        self.periodicidad = periodicidad  # Mensual, semanal, trimestral, etc.

    # Método para mostrar información detallada de la revista
    def mostrar_info_detallada(self):
        return (f"Título: {self.titulo}\n"
                f"Volumen: {self.volumen}\n"
                f"Número: {self.numero}\n"
                f"Editor: {self.editor}\n"
                f"Tema principal: {self.tema_principal}\n"
                f"Periodicidad: {self.periodicidad}\n"
                f"Año de publicación: {self.anio}\n"
                f"Género: {self.genero}\n"
                f"Sección: {self.seccion}\n"
                f"Disponibilidad: {'Disponible' si self.disponibilidad else 'No disponible'}")

    # Método para obtener el tema principal de la revista
    def obtener_tema(self):
        return self.tema_principal

    # Método para consultar el índice de la revista (los artículos, secciones, etc.)
    def consultar_indice(self):
        return f"Revista {self.titulo} (Vol. {self.volumen}, Núm. {self.numero})"

    # Método para verificar si la edición actual es especial (puedes definir tu lógica para esto)
    def es_edicion_especial(self):
        return self.numero % 10 == 0  # Ejemplo: cada décima edición es una edición especial












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
        
        
        
        
        

class Biblioteca:
    def __init__(self):
        self.catalogo = []  # Lista de todos los objetos disponibles en la biblioteca
        self.usuarios_registrados = []  # Lista de usuarios registrados en la biblioteca
        self.prestamos_activos = {}  # Diccionario con el id del objeto prestado y el usuario que lo tiene
        self.multas_pendientes = {}  # Diccionario con el id del usuario y el monto de las multas

    # Método para añadir un objeto al catálogo de la biblioteca
    def añadir_objeto(self, objeto):
        self.catalogo.append(objeto)
        print(f"Objeto '{objeto.titulo}' añadido a la biblioteca.")

    # Método para remover un objeto del catálogo
    def remover_objeto(self, identificador):
        for obj in self.catalogo:
            if obj.identificador == identificador:
                self.catalogo.remove(obj)
                print(f"Objeto '{obj.titulo}' removido de la biblioteca.")
                return
        print(f"Objeto con id {identificador} no encontrado.")

    # Método para buscar un objeto por su identificador
    def buscar_objeto(self, identificador):
        for obj in self.catalogo:
            if obj.identificador == identificador:
                return obj
        print(f"Objeto con id {identificador} no encontrado.")
        return None

    # Método para registrar un usuario en la biblioteca
    def registrar_usuario(self, usuario):
        self.usuarios_registrados.append(usuario)
        print(f"Usuario '{usuario.nombre}' registrado en la biblioteca.")

    # Método para buscar un usuario por su identificador
    def buscar_usuario(self, id_usuario):
        for usuario in self.usuarios_registrados:
            if usuario.id_usuario == id_usuario:
                return usuario
        print(f"Usuario con id {id_usuario} no encontrado.")
        return None

    # Método para gestionar un préstamo
    def gestionar_prestamo(self, id_usuario, id_objeto):
        usuario = self.buscar_usuario(id_usuario)
        objeto = self.buscar_objeto(id_objeto)
        
        if usuario and objeto:
            if objeto.verificar_disponibilidad():
                self.prestamos_activos[id_objeto] = usuario
                objeto.cambiar_disponibilidad(False)
                usuario.objetos_prestados.append(objeto)
                print(f"Objeto '{objeto.titulo}' prestado a {usuario.nombre}.")
            else:
                print(f"El objeto '{objeto.titulo}' no está disponible.")
        else:
            print("Préstamo no completado: usuario u objeto no encontrado.")

    # Método para gestionar la devolución de un objeto
    def gestionar_devolucion(self, id_usuario, id_objeto):
        usuario = self.buscar_usuario(id_usuario)
        objeto = self.buscar_objeto(id_objeto)

        if usuario and objeto and id_objeto in self.prestamos_activos:
            objeto.cambiar_disponibilidad(True)
            usuario.objetos_prestados.remove(objeto)
            del self.prestamos_activos[id_objeto]
            print(f"Objeto '{objeto.titulo}' devuelto por {usuario.nombre}.")
        else:
            print("Devolución no completada: usuario u objeto no encontrado o no prestado.")

    # Método para aplicar una multa a un usuario
    def aplicar_multa(self, id_usuario, monto):
        usuario = self.buscar_usuario(id_usuario)
        if usuario:
            if id_usuario in self.multas_pendientes:
                self.multas_pendientes[id_usuario] += monto
            else:
                self.multas_pendientes[id_usuario] = monto
            print(f"Multa de {monto} aplicada a {usuario.nombre}.")
        else:
            print(f"Usuario con id {id_usuario} no encontrado.")

    # Método para consultar la disponibilidad de un objeto
    def consultar_disponibilidad_objeto(self, id_objeto):
        objeto = self.buscar_objeto(id_objeto)
        if objeto:
            return objeto.verificar_disponibilidad()
        else:
            print("Objeto no encontrado.")
            return False

    # Método para generar un informe de préstamos activos
    def generar_informe_prestamos(self):
        if not self.prestamos_activos:
            print("No hay préstamos activos en este momento.")
        else:
            print("Préstamos activos:")
            for id_objeto, usuario in self.prestamos_activos.items():
                objeto = self.buscar_objeto(id_objeto)
                print(f"- Objeto: {objeto.titulo}, Usuario: {usuario.nombre}")

    # Método para generar un informe de usuarios con multas pendientes
    def generar_informe_multas(self):
        if not self.multas_pendientes:
            print("No hay usuarios con multas pendientes.")
        else:
            print("Multas pendientes:")
            for id_usuario, monto in self.multas_pendientes.items():
                usuario = self.buscar_usuario(id_usuario)
                print(f"- Usuario: {usuario.nombre}, Multa: {monto}")

        