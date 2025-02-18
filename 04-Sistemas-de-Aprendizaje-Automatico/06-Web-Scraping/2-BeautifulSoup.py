# -*- coding: utf-8 -*-
"""
Created on Tue Jan 12 19:40:03 2021

@author: Usuario
"""


# Para instalar la libreria BeautifulSoup, abrimos Anaconda prompt y escribimos:
## pip install beautifulsoup4

# Importamos las librerias necesarias

from bs4 import BeautifulSoup
from bs4 import BeautifulSoup
from urllib.request import urlopen

# Crear un objeto BeautifulSoup

# Podemos acceder a la url para ver como es la web que queremos scrapear

url = "http://olympus.realpython.org/profiles/dionysus"
# Abrimos la URL
page = urlopen(url)
# Leemos y decodificamos
html = page.read().decode("utf-8")
print(html)
# Crear objeto BeautifulSoup
soup = BeautifulSoup(html, "html.parser")

soup

## CUIDADO :
# Puede que la varieable soup, no aparezca en el explorador.
# Esquina superior derecha -- Desmarcar: Excluir objetos llamables y modulos



##### Utilizando el objeto BeautifulSoup creado ####


# Mediante los metodos contenidos dentro de los objetos BeautifulSoup,
# se pueden llevar a cabo diferentes acciones


# Extraemos todo el texto eliminando las etiquetas HTML
print(soup.get_text())

# Podriamos eliminar las lineas en blanco

noblanklines=soup.get_text().replace("\n","")
print(noblanklines)

# O realizar busquedas en el texto

findtext=soup.get_text().find('Wine')
findtext # Devuelve la posicion de la primera ocurrencia



# A veces interesa mantener las etiquetas HTML para poder realizar
# busquedas de elementos especifios, como imagenes

soup.find_all("img")
# Devuelve una lista con los elementos contenidos en esa etiqueta


# Podemos extraer el contenido de cada etiqueta en una variable
image1, image2 = soup.find_all("img")
# Dentro de las variables creadas, podemos observar los metodos o propiedades


# Podemos pedir que nos diga el tipo de eqtiqueta HTML del objeto
# con la propiedad .name
image1.name


# Se podria acceder a los atributos HTML de las etiquetas
# especificando su nombre entre corchetes. (Como en un diccionario)

## Etiqueta con un solo atributo
# <img src="/static/dionysus.jpg"/>

## Etiqueta con dos atributos
# <a href="https://realpython.com" target="_blank">


# Podemos obtener la fuente de las imagenes contenidas en la URL
image1["src"]

image2["src"]


# Se puede acceder a determinadas etiquetas mediante sus propiedades 
   # Por ejemplo, sacamos el titulo de la etiqueta mediante la propiedad .title

soup.title 

# Si accedemos al codigo fuente de la url, podremos observar como la etiqueta
    # <title> está escrita de la misma manera.


# Con la propiedad .string, visualizamos unicamente el contenido de la etiqueta
     
soup.title.string


# Se pueden realizar busquedas para localizar atributos concretos
     
soup.find_all("img", src="/static/dionysus.jpg")
# Devuelve los elementos contenidos en las etiquetas 'img' 
# cuyos atributos 'src' coinciden con el valor especificado. 



"""
Esta herramienta es util sobre todo cuando queremos scrapear
 partes concretas o elementos contenidos en etiquetas. 

Si pasamos algún tiempo navegando por sitios web y viendo los codigos
 fuente, notamos que muchos tienen estructuras HTML extremadamente complicadas.


A menudo nos pueden interesar partes concretas de una página.
 Dedicando un tiempo a examinar el documento HTML, podremos identificar 
 que etiquetas con atributos únicos poder utilizar para extraer los datos.

 """
 
 ## Ejercicio: Programa que saque el HTML completo de una URL
 # URL: http://olympus.realpython.org/profiles
 # Imprimir una lista de todos los enlaces buscando las etiquetas <a>,
 # y recuperando el valor tomado por el atributo 'href'
 
 
 

 