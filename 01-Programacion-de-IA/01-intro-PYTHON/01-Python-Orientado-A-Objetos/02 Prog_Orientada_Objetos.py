#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Tue Mar  7 20:03:06 2023

@author: laptop
"""
#######################
# Atributos y métodos #
#######################

"""
El potencial de la POO se basa en gran medida en la capacidad de definir 
variables y funciones dentro de las clases, aunque aquí se conocen como 
atributos y métodos respectivamente.
"""

#############
# Atributos #
#############

"""
A efectos prácticos los atributos no son muy distintos de las variables, 
la diferencia fundamental es que sólo existen dentro del objeto.
"""

# ----------------------
# Atributos dinámicos
# ----------------------
"""
Los atributos pueden manejarse de distintas formas, por ejemplo 
se pueden crear dinámicamente (al vuelo) en los objetos.
"""

class Galleta:
    pass

pretzel = Galleta()
pretzel.sabor = "salado"
pretzel.color = "marrón"
pretzel.__setattr__("tamano", "grande")


dir(pretzel)

pretzel.__class__()

# Las siguentes dos instrucciones son lo mismo
pretzel.color
pretzel.__getattribute__("color")

print(f"El sabor del pretzel es {pretzel.sabor} y el color {pretzel.color}")

pretzel.__getattribute__("color")
pretzel.__getattribute__("sabor")

# Podemos obtener todos los atributos como un diccionario
pretzel.__dict__
dir(pretzel)

maria = Galleta()
maria.sabor
maria.sabor = "dulce"
maria.color = "marrón"

# Si no atribuyo los atributos, no existen
print(f"El sabor de esta la galleta Maria es {maria.sabor} y el color {maria.color}")

# --------------------
# Atributos de clase
# --------------------
"""
La flexibilidad de los atributos dinámicos puede llegar a ser muy útil, 
pero es más práctico definir unos atributos básicos en la clase. 
De esa manera todas las galletas podrían tener atributos por defecto:
"""

class Galleta:
    textura = "rígida"
    chocolate = False
    nata = False

principe = Galleta()
principe.chocolate
principe.textura

if principe.chocolate:
    print("La galleta tiene chocolate")
else:
    print("La galleta no tiene chocolate")

"""
La galleta principe no tiene chocolate
Luego podemos cambiar su valor en cualquier momento:
"""

principe.chocolate = True

if principe.chocolate:
    print("La galleta tiene chocolate")
else:
    print("La galleta no tiene chocolate")

principe.__dict__
dir(principe)
"""
Por lo menos de esta forma nos aseguraremos de que el atributo `chocolate` 
existe en todas las galletas desde el principio. 
Además es posible consultar el valor por defecto que deben tener las galletas 
haciendo referencia al atributo en la definición de la clase:
"""
print(Galleta.chocolate)
print(Galleta.textura)


"""
Si cambiamos ese atributo de clase (que no de objeto) a True, las siguientes 
galletas se crearán con chocolate, es decir, habremos modificado las 
instrucciones de creación de los objetos:
"""

class Galleta:
    chocolate = True

Galleta.chocolate = True

oreo = Galleta()
oreo.__dict__

dir(oreo)


if oreo.chocolate:
    print("La galleta tiene chocolate")
else:
    print("La galleta no tiene chocolate")


###########
# Métodos #
###########
"""
Si por un lado tenemos las "variables" de las clases, por otro tenemos sus "funciones", 
que evidentemente nos permiten definir funcionalidades para llamarlas desde las instancias.

Definir un método es bastante simple, sólo tenemos que añadirlo en la clase y 
luego llamarlo desde el objeto con los paréntesis, como si de una función se tratase:
"""

class Galleta:
    chocolate = False

    def saludar(): # !!!!!!!!! Esto nos dará error, por que no se esta referenciando
        print("Hola, soy una galleta muy sabrosa")

artiach = Galleta()

artiach.chocolate
# Sin embargo esto nos da error
artiach.saludar()

# ¿De dónde ha salido ese argumento que dice que hemos dado?

# Probamos a ejecutar el método llamando a la clase en lugar del objeto:
Galleta.saludar()


class Galleta:
    chocolate = False

    def saludar(self):
        print("Hola, soy una galleta muy sabrosa")

artiach = Galleta()

artiach.chocolate
# Ahora ya no nos dará error
artiach.saludar()




# CADA VEZ QUE UN OBJETO USA UN MÉTODO SE ENVÍA A SÍ MISMO COMO PARÁMETRO

class Galleta:
    chocolate = False

    def saludar(soy_el_propio_objeto):
        print("Hola, soy una galleta muy sabrosa")
        print("Referencia al objeto: ", soy_el_propio_objeto.chocolate)
        print(soy_el_propio_objeto)


campurriana = Galleta()
campurriana.saludar()
campurriana.chocolate = True
campurriana.saludar()

print(campurriana)

# como este argumento hace referencia al objeto en sí mismo por convención se le llama self.

# Poder acceder al propio objeto desde un método es muy útil, ya que nos permite
# acceder a sus atributos y modificarlos

# Por convención, el primer parámetro de los métodos que hace referencia al objeto se llama `self`

class Galleta:
    chocolate = False

    def chocolatear(self):
        self.chocolate = True


principe = Galleta()
# Por defecto, no tiene chocolate
print(principe.chocolate)
principe.chocolatear()
print(principe.chocolate)


######################
# Métodos especiales #
######################
# Se llaman especiales porque la mayoría ya existen de forma oculta y 
# sirven para tareas específicas.

dir(Galleta)

# _____________
# Constructor
# _____________

# El constructor es un método que se llama automáticamente al crear un objeto, se define con el nombre init:
class Galleta:
    def __init__(self):
        print("Soy una galleta acabada de hornear!")


cookie = Galleta()

# La finalidad del constructor es construir los objetos.
# Por eso permite sobreescribir el método que crea los objetos, permitiéndonos enviar
# datos desde el principio para construirlo:


class Galleta:
    chocolate = False
    sabor = "insipida"

    def __init__(self, sabor = "dulce", color = "marrón"):
        self.sabor = sabor
        self.color = color
        # Normalmente no se pone la siguiente linea, es solo modo debbuging
        print(f"Se acaba de crear una galleta {self.color} y {self.sabor}.")

pretzel = Galleta(color = "azul")
pretzel = Galleta(color = "marrón", sabor = "salada")
# Los atributos sabor y color se escriben al crear la galleta
pretzel.sabor
# El atributo chocolate está predefinido
pretzel.chocolate


# Como los métodos se comportan como funciones tienen sus mismas características,
# permitiéndonos definir valores nulos, valores por posición y clave,
# argumentos indeterminados, etc.
artiach = Galleta("dulce", "blanca")
artiach.sabor



# los atributos por defecto los imprimiremos  dentro del ___init___
class Galleta:

    def __init__(self, sabor = "dulce", color = "marrón"):
        self.chocolate = False
        self.sabor = sabor
        self.color = color
        # Normalmente no se pone la siguiente linea, es solo modo debbuging
        print(f"Se acaba de crear una galleta {self.color} y {self.sabor}.")



# ____________
# Destructor 
# ____________
"""
Si existe un constructor también debe existir un destructor que se llame al eliminar 
el objeto para que encargue de las tareas de limpieza y vaciar la memoria. 

Ese es el papel del método especial del. Es muy raro sobreescribir este método 
porque se maneja automáticamente, pero es interesante saber que existe.

En este ejemplo, simplemente escribimos un aviso

Todos los objetos se borran automáticamente de la memoria al finalizar el programa, 
aunque también podemos eliminarlos expresamente pasándolos a la función del():
"""

class Galleta:
    chocolate = False
    sabor = "insipida"

    def __init__(self, sabor, color):
        self.sabor = sabor
        self.color = color
        print(f"Se acaba de crear una galleta {self.color} y {self.sabor}.")

    def __del__(self):
        print(f"La galleta {self} se está borrando de la memoria")


pretzel = Galleta("marrón", "salada")
artiach = Galleta("blanca", "dulce")

del(pretzel)
del(artiach)



# Funciones como str() y len(), también son accesores de los métodos especiales
# __str__ y __len__ que tienen los objetos.

# _____
#  str 
# _____
"""
El método str es el que devuelve la representación de un objeto en forma de cadena. 
Un momento en que se llama automáticamente es cuando imprimimos una variable por pantalla.

Por defecto los objetos imprimen su clase y una dirección de memoria, pero eso puede cambiarse 
sobreescribiendo el comportamiento:
"""

class Galleta:
    chocolate = False
    sabor = "insipida"

    def __init__(self, sabor, color):
        self.sabor = sabor
        self.color = color
        print(f"Se acaba de crear una galleta {self.color} y {self.sabor}.")

    def __str__(self):
        return f"Soy una galleta {self.color} y {self.sabor}."

    def __del__(self):
        print(f"La galleta {self} se está borrando de la memoria")


artiach = Galleta("dulce", "blanca")

print(artiach)
str(artiach)
artiach.__str__()


"""
Hay que tener en cuenta que este método debe devolver la cadena en lugar de 
mostrar algo por pantalla, ese es el funcionamiento que se espera de él.
"""

# _______
#   len 
# _______
# Normalmente está ligado a colecciones, pero nada impide definirlo en una clase.
# Por defecto no existe en los objetos aunque es el que se ejecuta al pasarlos 
# a la función len().

# LEN SÓLO PUEDE DEVOLVER NÚMEROS ENTEROS

class Cancion:
    def __init__(self, autor, titulo, duracion):  # en segundos
        self.duracion = duracion
        self.autor = autor
        self.titulo = titulo

    def __len__(self): # No puedes 
        if self.duracion == float:
            return float(self.duracion)
        else:
            return self.duracion

    def __eq__(self, otro):
        return self.titulo == otro.titulo


cancion = Cancion("Queen", "Don't Stop Me Now", 210)
cancion.autor
cancion.titulo
cancion.duracion

print(len(cancion))
print(cancion.__len__())


"""
Otros métodos especiales:
__repr__: Este método define la representación de cadena de texto del objeto 
    cuando se utiliza la función repr().

__eq__: Este método define la igualdad entre dos objetos de la clase. 
    Se utiliza para comparar objetos mediante el operador ==.
"""
cancion2 =  Cancion("Otro grupo", "Don't Stop Me Now", 250)

cancion == cancion2
cancion.__eq__(cancion2)

"""
__lt__: Este método define el orden entre dos objetos de la clase. Se utiliza 
    para comparar objetos mediante el operador <.

__getattr__: Este método se llama cuando se intenta acceder a un atributo que 
    no existe en el objeto. Permite definir un comportamiento personalizado para este caso.

__setattr__: Este método se llama cuando se intenta asignar un valor a un atributo del objeto. 
    Permite definir un comportamiento personalizado para este caso.


"""


#############
# Ejercicio #
#___________#

# Crear la clase coche que incluya los atributos 
# "marca", "modelo", "longitud" (centimetro) y "precio"

class Coche():
    def __init__(self, marca, modelo, longitud, precio):
        self.ruedas = 4
        self.marca = marca
        self.modelo = modelo
        self.longitud = longitud
        self.precio = precio
    
    def __str__(self):
        return f"Este coche es un {self.marca} {self.modelo}"

    def __len__(self):
        return self.longitud
    
    def __lt__(self, otro):
        return self.precio < otro.precio
    
    def __le__(self, otro):
        return self.precio >= otro.precio
    
    def __gt__(self, otro):
        return self.precio > otro.precio
    
    def __ge__(self, otro):
        return self.precio >= otro.precio
    
    def __eq__(self, otro):
        return self.precio == otro.precio
    
    def __del__(self):
        print(f"El coche {self.marca} {self.modelo} ha sido eliminado")
        
    def rebaja_precio(self, porcentaje_descuento):
        descuento = self.precio * (porcentaje_descuento / 100)
        precio_final = self.precio - descuento
        self.precio = precio_final
        # return precio_final
        
        # Este metodo es MEJOR que el anterior
    def rebaja_precio_1(self, porcentaje_descuento):
        self.precio -= self.precio*(porcentaje_descuento / 100)
        # return precio_final

        


# Crear objetos de la clase coche
# Atribuirles características que se creen al inicializar, basadas en datos
# introducidos al crear los objetos

coche_1 = Coche("Peugeot", "206", 383, 15000)
coche_2 = Coche("Nissan", "Primera", 456, 21000)

# Probamos un descuento
coche_1.precio
coche_1.rebaja_precio_1(10)
coche_1.precio


# Atribuirles métodos que permitan imprimir en la pantalla:
# Un mensaje al borrar el objeto
#del(coche1)

#del(coche_2) # Comentamos esta linea para que no nos ponga un error

# un valor de longitud
# len(coche1)

coche_1.longitud

# un valor al hacer print()
# print(coche2)

print(coche_1)

# Crear métodos que permitan comparar los coches por el precio:
# if coche1 > coche2:
#   pass


coche_1.__eq__(coche_2)

lista_coches = list([coche_1, coche_2])

