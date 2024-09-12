# -*- coding: utf-8 -*-
"""
Created on Fri Mar  2 10:03:25 2023

@author: Aitor Donado.
"""
##################
#  Módulo pickle #
##################

"""
Este módulo nos permite almacenar fácilmente colecciones y objetos en ficheros 
binarios abstrayendo toda la parte de escritura y lectura binaria.
"""
# __________________________
# Escritura de colecciones (tipos agregados)

# Podemos guardar lo que queramos, listas, diccionarios, tuplas...
import pickle

reyes_espana = {
    "Godos": ["Ataulfo", "Sigerico", "Teodorico", "Eurico", "Leovigildo", "Recaredo", "Suintila", "Sisenando", "Chintila", "Tulga", "Witerico", "Gundemaro", "Sisebuto", "Suintila II", "Recesvinto", "Wamba", "Ervigio", "Witiza", "Rodrigo"],
    "Austrias": ["Felipe I", "Carlos I", "Felipe II", "Felipe III", "Felipe IV", "Carlos II"],
    "Borbones": ["Felipe V", "Luis I", "Fernando VI", "Carlos III", "Carlos IV", "Fernando VII", "Isabel II", "Alfonso XII", "Alfonso XIII", "Juan Carlos I"]
}

type(reyes_espana)

# Escritura en modo binario, vacía el fichero si existe
fichero = open('teoria/datos/diccionario.pckl', 'wb')

# Escribe la colección en el fichero
pickle.dump(reyes_espana, fichero)

fichero.close()

# __________________________
# Lectura de colecciones

# Lectura en modo binario
fichero = open('teoria/datos/diccionario.pckl', 'rb')

# Cargamos los datos del fichero
diccionario_fichero = pickle.load(fichero)

fichero.close()

print(diccionario_fichero)
type(diccionario_fichero)

diccionario_fichero.keys()
diccionario_fichero.values()
diccionario_fichero["Godos"]


for clave, valor in diccionario_fichero.items():
    print(clave, valor)

type(diccionario_fichero)


godos = diccionario_fichero["Godos"]
austrias = diccionario_fichero["Austrias"]

for clave in diccionario_fichero:
    print(clave)

reyes_espana == diccionario_fichero

# __________________________
# Persistencia de objetos
"""
Para guardar objetos lo haremos dentro de una colección. 
La lógica sería la siguiente:

    Crear una colección.
    Introducir los objetos en la colección.
    Guardar la colección haciendo un dump.
    Recuperar la colección haciendo un load.
    Seguir trabajando con nuestros objetos.
"""
# Creamos una clase de prueba


class Persona:
    def __init__(self, nombre):
        self.nombre = nombre

    def __str__(self):
        return self.nombre


# Creamos la lista con los objetos
nombres = ["Héctor", "Mario", "Marta"]
personas = []

for n in nombres:
    p = Persona(n)
    personas.append(p)

# Escribimos la lista en el fichero con pickle
f = open('personas.pckl', 'wb')
pickle.dump(personas, f)
f.close()

# Leemos la lista del fichero con pickle
f = open('personas.pckl', 'rb')
personas = pickle.load(f)
f.close()

for p in personas:
    print(p)


# __________________________
# Ejemplo catálogo de películas


class Pelicula:

    # Constructor de clase
    def __init__(self, titulo, duracion, lanzamiento):
        self.titulo = titulo
        self.duracion = duracion
        self.lanzamiento = lanzamiento
        print('Se ha creado la película:', self.titulo)

    def __str__(self):
        return '{} ({})'.format(self.titulo, self.lanzamiento)


class Catalogo:

    peliculas = []

    # Constructor de clase
    def __init__(self):
        self.cargar()

    def agregar(self, p):
        self.peliculas.append(p)
        self.guardar()

    def mostrar(self):
        if len(self.peliculas) == 0:
            print("El catálogo está vacío")
            return
        for p in self.peliculas:
            print(p)

    def cargar(self):
        fichero = open('catalogo.pckl', 'ab+')
        fichero.seek(0)
        try:
            self.peliculas = pickle.load(fichero)
        except:
            print("El fichero está vacío")
        finally:
            fichero.close()
            print("Se han cargado {} películas".format(len(self.peliculas)))

    def guardar(self):
        fichero = open('catalogo.pckl', 'wb')
        pickle.dump(self.peliculas, fichero)
        fichero.close()


# Creamos un catálogo
c = Catalogo()

# Mostramos el contenido
c.mostrar()

# Agregamos unas películas
c.agregar(Pelicula("El Padrino", 175, 1972))
c.agregar(Pelicula("El Padrino: Parte 2", 202, 1974))

# Mostramos el catálogo de nuevo
c.mostrar()

# Borramos el catálogo de la memoria ram (persistirá el fichero)
del(c)


# Ahora al crear de nuevo un catálogo se recuperarán los datos del fichero y
# podríamos seguir trabajando con él:


# Creamos un catálogo
c = Catalogo()

# Mostramos el contenido
c.mostrar()

# Agregamos una película
c.agregar(Pelicula("Prueba", 100, 2005))

# Mostramos el catálogo de nuevo
c.mostrar()
