####################
# Clases y objetos #
####################
# Hasta ahora hemos usado los tipos de datos nativos de Python
numero = 10
type(numero)
dir(numero)
numero.to_bytes(20, byteorder="little")

# …y en este, `cadena` es un objeto de la clase `string`. 
cadena = "abcd"
type(cadena)
dir(cadena)
cadena.upper()

# En este caso numero es un objeto de la clase int

lista = list((1,2,3))
type(lista)
dir(lista)
lista.append("e")

type(type(lista))

# Incluso las funciones en Python son instancias del tipo function:
def hola():
    pass

type(hola)


#######################
# Definición de clase #
#######################
# Las clases son un nuevo tipo de dato que fabrico de manera personalizada
# cuya definición viene dada en una estructura llamada clase.

# Los nombres de los tipos empiezan siempre en mayúscula
# La clase más sencilla
class Galleta:
    pass


type(Galleta)

type(list)

#--------------------
# Instancias de clase
#--------------------
"""
Para entender bien los objetos debemos tener claras dos cuestiones fundamentales:

¿Cuándo y dónde existen los objetos?

Los objetos "existen" sólo durante la ejecución del programa y 
se almacenan en la memoria del sistema operativo.

Es decir, mientras las clases están ahí en el código haciendo su papel de instrucciones, 
los objetos no existen hasta que el programa se ejecuta y se crean en la memoria.

Este proceso de "crear" los objetos en la memoria se denomina instanciación y para 
realizarlo es tan fácil como llamar a la clase como si fuera una función.
"""

oreo = Galleta()
maria = Galleta()

type(maria)

# Cada una de las galletas es distinta y ocupa un lugar distinto en la memoria (at 0x...)
# - Por convenio las clases se denominan en mayúscula y los objetos en minúscula

print(oreo)
print(maria)
dir(oreo)


# En cambio la clase no tiene una referencia porque es sólo un guión de instrucciones:
print(Galleta)

# Es posible consultar la clase de un objeto con la función type(),
# pero también se puede consultar a través de su atributo especial class:
print(Galleta)
print(type(oreo))
print(oreo.__class__)

# A su vez las clases tienen el atributo especial name que nos devuelve
# su nombre en forma de cadena sin adornos
print(Galleta.__name__)
print(type(oreo).__name__)
print(maria.__class__.__name__)

# Resumiendo: los objetos son instancias de una clase.
isinstance(oreo, Galleta)
isinstance(maria, Galleta)
isinstance(numero, int)
isinstance(lista, list)
