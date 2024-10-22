# -*- coding: utf-8 -*-
"""
Created on Tue Sep 10 09:40:42 2024

@author: 2425BIGDATA401
"""

from math import sqrt


# --------------------------
# 01 . Operaciones básicas
# --------------------------


# 1. Sumar 22,8 y 35,3

22.8 + 35.3

# 2. Restar 25-10

25 - 10

# 3. Multiplicar 3,14 por 5.

3.14 * 5

# 4. Dividir 50 entre 4.

50 / 4

# 5. Calcular de dos maneras la raíz cuadrada de 125.

125**0.5  # opción aritmética

sqrt(125) # opción fución sqrt() importada de la librería math



# ------------------------------------
# 02 . Creación de variables simples
# ------------------------------------

# 1. Crear variables con las operaciones anteriores.

suma = 22.8 + 35.3
suma

resta = 25 - 10
resta

mult = 3.14 * 5
mult

div = 50 / 4
div

raiz1 = 125**0.5
raiz1

raiz2 = sqrt(125)
raiz2



# -------------------------------
# 03 . Comprobación de la clase
# -------------------------------

# 1. Comprobar la clase de las variables creadas

type(suma)

type(resta)

type(mult)

type(div)

type(raiz1)

type(raiz2)



# -------------------------------
# 04 . Creación de cadenas
# -------------------------------


# 1. Crear tres cadenas: Nombre y apellidos, lugar de nacimiento 
# y lugar de residencia.

nombre_apellidos = "Egoitz Aulestia Padilla"
lugar_nacimiento = "Andoain"
lugar_residencia = "Donostia"


# 2. Comprobar el tipo de dato cada una de las cadenas.

type(nombre_apellidos)
type(lugar_nacimiento)
type(lugar_residencia)



# -------------------------------
# 05 . Concatenación de cadenas
# -------------------------------

# 1. Crear la frase “Me llamo ” “, nací en “ “ pero vivo en “ 
# con vuestros datos concatenando frases.

datos_personales = f"Me llamo {nombre_apellidos}, nací en {lugar_nacimiento} pero vivo en {lugar_residencia}"

print(datos_personales)

# 2. Medir la longitud de la cadena creada

len(datos_personales)

inicio_lugar_nacimiento = datos_personales.find("nací en ") + len("nací en ")
inicio_lugar_nacimiento
fin_lugar_nacimiento = datos_personales.find(" pero vivo en")
fin_lugar_nacimiento



# ----------------------------------------
# 06 . Extracción elementos de la cadena
# ----------------------------------------

# 1. Extraer la ciudad en la que vivís.

inicio_lugar_residencia = datos_personales.find("vivo en ") + len("vivo en ")
extracion_lugar_nacimiento = datos_personales[inicio_lugar_residencia:]

extracion_lugar_nacimiento

# 2. Extraer vuestras iniciales.

inicio_nombre_apellidos = datos_personales.find("Me llamo ") + len("Me llamo ")
fin_nombre_apellidos = datos_personales.find(", nací en")
extracion_nombre_apellidos = datos_personales[inicio_nombre_apellidos:fin_nombre_apellidos]

extracion_nombre_apellidos

nom_ape_list = extracion_nombre_apellidos.split(" ")
nom_ape_list

initials = "" # Iniciamos una cadena (str) vacía

for cap in nom_ape_list:
    cap = cap[0]
    initials += cap # sumamos cada inicial extrida a la cadena "initials"

print(initials)



# -------------------------------------------
# 07 . Transformar en minúsculas/mayúsculas
# -------------------------------------------

# 1. Poner todo con minúsculas.

datos_personales_lower = datos_personales.lower()
datos_personales_lower

# 2. Poner todo con minúsculas.

datos_personales_upper = datos_personales.upper()
datos_personales_upper



# --------------------------------------------
# 08 . Comprobar si existen ciertos elementos
# --------------------------------------------


# 1. Comprobar si existe vuestro nombre.

nombre_apellidos = "Egoitz Aulestia Padilla"
lugar_nacimiento = "Andoain"
lugar_residencia = "Donostia"
datos_personales = f"Me llamo {nombre_apellidos}, nací en {lugar_nacimiento} pero vivo en {lugar_residencia}"

my_name = "Egoitz"

if my_name in datos_personales:
    print(f"Mi nombre \"{my_name}\" esta en la frase.")
else:
    print("Mi nombre no esta en la frase.")

# 2. Comprobar el número de veces que aparece la letra “a”

num_letra_a = datos_personales.count("a")

num_letra_a



# -------------------------
# 09 . Separar una cadena
# -------------------------

# 1. Separar vuestra cadena por espacios obteniendo una lista 
#    con las palabras utilizadas.

lista_datos_personales = datos_personales.split(" ")
lista_datos_personales 

# 2. Averiguar el número de palabras distintas que hay  
len(set(lista_datos_personales))  



# -----------------------------
# 10 . Transformar una cadena
# -----------------------------

# 1. Poner vuestros datos en mayúsculas.
datos_personales_trans = datos_personales.replace(nombre_apellidos, nombre_apellidos.upper())

datos_personales_trans = datos_personales_trans.replace(lugar_nacimiento, lugar_nacimiento.upper())
datos_personales_trans = datos_personales_trans.replace(lugar_residencia, lugar_residencia.upper())
datos_personales_trans



# -------------------------
# 11 . Creación de listas
# -------------------------

# 1. Crear dos listas con los días de la semana y los días del mes del curso.

dias_semana = ["Lunes", "Martes", "Miércoles", "Jueves", "Viernes"]

dias_mes_curso = [9, 10, 11, 12, 13]


# 2. Analizar el tipo de dato del primer elemento de cada lista.
type(dias_semana[0])
type(dias_mes_curso[0])


# 3. Concatenar las dos listas.

lista_concat_1 = dias_semana + dias_mes_curso
lista_concat_1

# Trabajarlo en casa:
# Tengo que hacer un for para convertir los días en "str"
# ------------------ 
# lista_concat = dias_semana.copy()
# dias_mes_curso_str = str(dia)
# lista_concat_final = " ".join(dias_mes_curso)

# dias_semana = "".join(str(dias_mes_curso))


# 4. Crear una lista encadenando los elementos de la lista 1

dias_semana_concat = ", ".join(dias_semana) # .join() genera un string
dias_semana_concat


# 5. Comprobar si existe el lunes y el día 18 en la lista concatenada.

"Lunes" in lista_concat_1 # True
18 in lista_concat_1      # False


# 6. Eliminar el viernes y su correspondiente día del mes.

lista_concat_1.remove("Viernes")
lista_concat_1
lista_concat_1.remove(13)
lista_concat_1


# 7. Añadir el fin de semana y sus días del mes correspondientes en su lugar.

lista_concat_1.insert(4, "Viernes")
lista_concat_1.insert(5, "Sábado")
lista_concat_1.insert(6, "Domingo")
lista_concat_1.append(13)
lista_concat_1.append(14)
lista_concat_1.append(15)
lista_concat_1




# ----------------------------------------------------
#   12 . Ejercicios control de flujo y condicionales
# ----------------------------------------------------

# 1. Crear una lista con 10 elementos numéricos.

lista_elementos = [1, 2, 3, 5, 8, 13, 21, 34, 55, 89]

lista_elementos_2 = range(10) # Otra manera de crear la lista


# 2. Comprobar si el tercer elemento es mayor que el séptimo y crear una frase
#    que muestre por escrito si el número es mayor o menor y el valor que 
#    toma el tercer elemento.

if lista_elementos[2] > lista_elementos[6]:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes mayor que el elemento número 7, con valor {lista_elementos[6]}")
else:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes menor que el elemento número 7, con valor {lista_elementos[6]}")


# 3. Invertir el orden de la lista y realizar la misma comprobación.

lista_elementos = lista_elementos[::-1]
lista_elementos

lista_elementos.reverse()

if lista_elementos[2] > lista_elementos[6]:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes mayor que el elemento número 7, con valor {lista_elementos[6]}")
else:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes menor que el elemento número 7, con valor {lista_elementos[6]}")


# 4. Añadir la posibilidad de que sea igual.

if lista_elementos[2] > lista_elementos[6]:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes mayor que el elemento número 7, con valor {lista_elementos[6]}")
elif lista_elementos[2] < lista_elementos[6]:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes menor que el elemento número 7, con valor {lista_elementos[6]}")
else:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\ny el elemento número 7, con valor {lista_elementos[6]},\nson iguales.")


# 5. Transformar el séptimo número para que se satisfaga la igualdad.

lista_elementos[6] = lista_elementos[2]


# 6. Realizar la comprobación.

if lista_elementos[2] > lista_elementos[6]:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes mayor que el elemento número 7, con valor {lista_elementos[6]}")
elif lista_elementos[2] < lista_elementos[6]:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\nes menor que el elemento número 7, con valor {lista_elementos[6]}")
else:
    print(f"El elmento número 3, con valor {lista_elementos[2]},\ny el elemento número 7, con valor {lista_elementos[6]},\nson iguales.")



# ----------------------------------------------------
#   13 . Ejercicios de Iteraciones
# ----------------------------------------------------


# 1. Crear y mostrar una secuencia numérica con un valor incremental de 5, 
# hasta el valor 150. Realizarlo de tres maneras diferentes.

rango_con_salto_1 = range(0, 150, 5)
rango_con_salto_1 = list(rango_con_salto)
rango_con_salto_1

rango_con_salto_2 = []

for num in range(0, 150, 5):
    rango_con_salto_2.append(num)
    print(num)
    
rango_con_salto_2 # Lista del rango creado con "for"


rango_con_salto_3 = []

for num in range(150):
    if num % 5 == 0:
        rango_con_salto_3.append(num)
        print(num)
        
rango_con_salto_3


rango_con_salto_4 = []

num_w = 0
while num_w < 150:
    print(num_w)
    rango_con_salto_4.append(num_w)
    num_w += 5

rango_con_salto_4


# 2. Crear un función que diga si un numero es par o impar.

def num_par(num):
    if num % 2 == 0:
        print(f"{num} es un número par")
    else:
        print(f"{num} es un número impar")
        
num_par(28)


# 3. Utilizando la función “for” crear un valor “a” y uno “b” de forma que b sea 
# igual al cuadrado de “a”, del 1 al 50.

b = 0
for a in range(50):
    b = a ** 2
    print(f"a = {a}, b = {b}")


# 4. Crea un frase y analiza si existe la letra “a” y la “o”

# Opción a
frase = input("Introduce la frase:")

vocal_a = "a"
vocal_o = "o"

num_a = 0 
num_o = 0

for vocal in frase:
    if vocal == vocal_a:
        print(f"La frase \"{frase}\", contiene la \"a\"")
        num_a += 1
    elif vocal == vocal_o:
        print(f"La frase \"{frase}\", contiene la \"o\"")
        num_o += 1
    else:
        print("No hay vocales")

print(f"La frase tiene {num_a} \"a\" y {num_o} \"o\"")


# Opción b
vocales = "ao"

for letra in frase:
    if letra in vocales:
        print(f"La frase \"{frase}\", contiene la vocal {letra}")


