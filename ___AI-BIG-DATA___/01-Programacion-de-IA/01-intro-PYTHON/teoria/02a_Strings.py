
# -*- coding: utf-8 -*-
"""
Created on Fri Feb 24 18:34:31 2023

@author: Aitor Donado
"""

###################################
# TRABAJANDO CON CADENAS DE TEXTO #
###################################
# Mediante comillas simples o dobles
alfabeto = "abcdefghi"
numeros = "123456"
numeros + numeros

# Las variables que almacenan constantes suelen ir en mayúsculas
# Es habitual almacenar usuarios y contraseñas en mayúsculas.
PI = 22/7
PASSWORD = 'sgkhgrmjdsbvmj'
PASSWORD = ""

saludo1 = "Hola \"Mundo"
saludo2 = 'Hola "Mundo'
saludo1 == saludo2

# Cadenas de texto multilínea
varias_lineas = """
Texto
en varias
líneas
"""
print(varias_lineas)

varias_lineas2 = '''
También con
comillas simples
'''

# "Escape" de comillas (cuando tenemos comillas dentro de un string)
str_con_comillas = "Estas comillas: \" y esta: \' se interpretan literalmente gracias a la barra inclinada"
print(str_con_comillas)

# COMPROBACION DEL TIPO DE VARIABLE
type(saludo1)
type(saludo2)
type(alfabeto)
type(numeros)


# Concatenación y repetición de cadenas
saludo_alfabeto = saludo1 + alfabeto
saludo_sp_alfabeto = saludo1 + " " + alfabeto
" ".join([saludo1, alfabeto, numeros])
saludo_repe = 5 * saludo1
saludo_repe

# Longitud de las cadenas
len(saludo1)
len(saludo_alfabeto)
len(saludo_repe)


# Extracción de los elementos de una cadena
saludo1[0]
saludo1[6:9]
saludo1[:]
# inicio : fin
saludo1[3:]
saludo1[1:-1]
# inicio : fin : salto
saludo1[:10:3]     # Devuelve las posiciones 0,3,6,9
saludo1[0:7:2]      # Devuelve las posiciones 0,2,4,6
# De atrás a adelante
saludo1[7:0:-2]     # Devuelve las posiciones 7,5,3,1

saludo1[::3]
saludo1[::-2]

saludo1.islower()

# CONVERTIR EN MAYUSCULAS/MINUSCULAS
saludo1mays = saludo1.upper()
saludo1mays.isupper()
saludo1.isupper()

saludo1minus = saludo1.lower()
saludo1minus.islower()

alfabeto.capitalize()
nombre_propio = "antonio fernández lópez"
nombre_propio_corregido = nombre_propio.title()
nombre_propio.find("toni")

# Otros métodos de los strings:
# https://www.w3schools.com/python/python_ref_string.asp
"""
Todos estos métodos devuelven otro string modificado. No modifican el original.
Por tanto, la sintaxis es:
`nuevo_string = string_original.metodo_modificador(posibles_parametros)`
"""

# Prestamos especial atención al método format por tener diferentes sintaxis.
formateado1 = "Mi nombre es {nombre}, vivo en {ciudad}".format(nombre="Aitor", ciudad="Burgos")

nombre = "María"
ciudad = "Barcelona"
formateado2 = "Mi nombre es {1}, vivo en {0}".format(ciudad, nombre)

formateado3 = f"Mi nombre es {nombre}, vivo en {ciudad}"

reemplazado = formateado3.replace("María", "Antonio")


# COMPROBAR SI EXISTE UN ELEMENTO EN UNA CADENA
# (Operadores de pertenencia)
"H" in saludo1
"m" in saludo1
"Ma" in saludo1
"Ho" in saludo1
"W" not in saludo1

# Comprobar el número de veces que aparece un elemento.
saludo_repe = 8 * saludo1
saludo_repe.count("Mundo")

# Si le quito el último hola mundo, son 7 veces
saludo_repe = saludo_repe[:-10]
saludo_repe.count("Mundo")


# SEPARAR UNA CADENA.
lista_separada = saludo_repe.split("o", maxsplit=10)
# Devuelve una LISTA

#######################################
# TRANSFORMAR EL FORMATO DE LOS DATOS #
#######################################
# CONVERTIR NUMERO A TEXTO
# Imaginemos que alguien introduce un código postal con separador de miles
cp_float = 01.250
type(cp_float)
# Automáticamente se ha interpretado como un número decimal (float)
# Lo podemos convertir en string
cp = str(cp_float)
# Pero a veces no basta con eso, nos falta el cero a la izquierda y el cero a la derecha
print(cp)

# Usamos los métodos de los strings para obtener un formateado uniforme para todos los CPs
miles, unidades = cp.split(".")

unidades = unidades.ljust(3, '0')
miles = miles.rjust(2,'0')

cp = miles + unidades
# Ya tenemos el formato deseado del Código Postal
print(cp)
type(cp)

# CONVERTIR TEXTO A NUMERO
b = "8"
b1 = int(b)
b2 = float(b)
b + b
b1 + b1
b2 + b2

# Sin embargo, int y float nos causarán errores si hay algo distinto de un número
correcto = float("12.6")
print(2*correcto)
incorrecto = float("12,6")
correccion = float("12,6".replace(',', '.'))
print(2*correccion)
