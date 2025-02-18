# -*- coding: utf-8 -*-
"""
Created on Tue Jan 12 17:43:43 2021

@author: borja
"""

# 
from urllib.request import urlopen

# Lo primero que vamos a hacer es abrir una pagina
# http://olympus.realpython.org/profiles/aphrodite

url = "http://olympus.realpython.org/profiles/aphrodite"

page = urlopen(url)

page


# A continuacion sacamos la estructura del HTML
html_bytes = page.read()
html = html_bytes.decode("utf-8")

print(html)


# Procedemos a extraer diferentes partes
# Buscamos el titulo
title_index = html.find("<title>")
title_index

# Seleccionamos donde comienza el contenido del titulo
start_index = title_index + len("<title>")
start_index

# Y el final con la barra ("/")
end_index = html.find("</title>")
end_index


# Sacamos el titulo
title = html[start_index:end_index]
title


# Si intentos repetir lo mismo para Poseidon hay problemas
url = "http://olympus.realpython.org/profiles/poseidon"
page = urlopen(url)
html = page.read().decode("utf-8")
start_index = html.find("<title>") + len("<title>")
end_index = html.find("</title>")
title = html[start_index:end_index]
title

# Vemos que el titulo sale mal.

# Pasamos a ver la pagina
print(html)
# Vemos que despues del titulo aparece un espacio.

html.find ("<title>")
# Cuando buscamos el titulo devuelve un -1 porque no existe.
# El principio es 6
start_index

"""El carácter en el índice 6 de la cadena html es un carácter de nueva 
línea (\ n) justo antes del corchete de ángulo de apertura (<) de 
la etiqueta <head>. Esto significa que html [start_index: end_index] 
devuelve todo el HTML comenzando con esa nueva línea y terminando justo antes
de la etiqueta </title>."""

# Este tipo de cosas hay que evitarlas para lo que utilizamos expresiones regulares

# Importamos la libreria
import re

# Vamos a ver un ejemplo.
# Utilizamos findall() para buscar cualquier texto dentro de una cadena 
#que coincida con una expresión regular determinada

re.findall("ab*c", "ac")

# En esta funcion el primer argumento es la expresion que se desea hacer coincidir.
# El asterisco (*) representa cero o más de lo que viene justo antes del asterisco.
# El segundo argumento es la ccadena a probar.
# Aqui se busca "ab*c en la cadena c

# Mas ejemplos
re.findall("ab*c", "abcd")

re.findall("ab*c", "acc")

re.findall("ab*c", "acd")

re.findall("ab*c", "adc")

re.findall("ab*c", "abcac")

re.findall("ab*c", "abdc")


# Si no indicamos nada diferencia mayusculas
re.findall("ab*c", "ABC")

# Pero podemos evitarlo
re.findall("ab*c", "ABC", re.IGNORECASE)


"""
El patrón. * Dentro de una expresión regular representa cualquier carácter repetido 
cualquier número de veces. 
Por ejemplo, "a. * C" se puede usar para encontrar cada subcadena que comience con "a" 
y termine con "c", independientemente de la letra o letras que se encuentren entre ellas:
"""
re.findall("a.*c", "abc")

re.findall("a.*c", "abbc")

re.findall("a.*c", "ac")

re.findall("a.*c", "acc")


"""
A menudo, usa re.search () para buscar un patrón particular dentro de una cadena. 
Esta función es algo más complicada que re.findall () porque devuelve un objeto 
llamado MatchObject que almacena diferentes grupos de datos. 
Esto se debe a que puede haber coincidencias dentro de otras coincidencias
y re.search () devuelve todos los resultados posibles.
"""

match_results = re.search("ab*c", "ABC", re.IGNORECASE)
match_results.group()

# .group () en un MatchObject devolverá el primer y más inclusivo resultado


# re.sub () permite reemplazar texto en una cadena que coincide con una 
# expresión regular con texto nuevo.
string = "Everything is <replaced> if it's in <tags>."
string = re.sub("<.*>", "ELEPHANTS", string)
string

# En este caso solo cambia el string que mas se le parezca.
# Vemos que ocurre cambiando la palabra.
string = "Everything is <replaced> if it's in <tags>."
string = re.sub("<.*>", "tac", string)
string

# Si queremos cambiar todas añadismos la interrogacion.
# Esto provoca que no busque el macheo
string = "Everything is <replaced> if it's in <tags>."
string = re.sub("<.*?>", "ELEPHANTS", string)
string


# Una vez visto esto vamos a probar la siguiente pagina.
# http://olympus.realpython.org/profiles/dionysus

import re
from urllib.request import urlopen

# Cargamos la pagina.
url = "http://olympus.realpython.org/profiles/dionysus"
page = urlopen(url)
html = page.read().decode("utf-8")

print(html)

# Vemos que presenta el mismo problema.
# Lo solucionamos con lo visto
pattern = "<title.*?>.*?</title.*?>"
match_results = re.search(pattern, html, re.IGNORECASE)
title = match_results.group()

# Visualizamos el titulo
print(title)

# Eliminamos los marcadores
title = re.sub("<.*?>", "", title)
# Visualizamos el titulo
print(title)


# EJERCICIO 1
# Escriba un programa que tome el HTML completo de la siguiente URL
# url = "http://olympus.realpython.org/profiles/dionysus"
