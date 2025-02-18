# -*- coding: utf-8 -*-
"""
Created on Mon Feb  1 15:11:59 2021

@author: borja
"""

import requests
from bs4 import BeautifulSoup

url = "https://jarroba.com/"

# Realizamos la petición a la web
req = requests.get(url)


# Extraemos el Status Code
statusCode = req.status_code
htmlText = req.text
print(htmlText)


status_code = req.status_code
if status_code == 200:

    # Pasamos el contenido HTML de la web a un objeto BeautifulSoup()
    html = BeautifulSoup(req.text, "html.parser")

    # Obtenemos todos los divs donde están las entradas
    entradas = html.find_all('div', {'class': 'col-md-4 col-xs-12'})

    # Recorremos todas las entradas para extraer el título, autor y fecha
    for i, entrada in enumerate(entradas):
        # Con el método "getText()" no nos devuelve el HTML
        titulo = entrada.find('span', {'class': 'tituloPost'}).getText()
        # Sino llamamos al método "getText()" nos devuelve también el HTML
        autor = entrada.find('span', {'class': 'autor'})
        fecha = entrada.find('span', {'class': 'fecha'}).getText()

        # Imprimo el Título, Autor y Fecha de las entradas
        print ("%d - %s  |  %s  |  %s" , (i + 1, titulo, autor, fecha))

else:
    print ("Status Code %d",  status_code)
    
    
# Pasamos el contenido HTML de la web a un objeto BeautifulSoup()
html = BeautifulSoup(req.text, "html.parser")

# Obtenemos todos los divs donde estan las entradas
entradas = html.find_all('div',{'class':'col-md-4 col-xs-12'})



# Recorremos todas las entradas para extraer el título, autor y fecha
for i,entrada in enumerate(entradas):
    # Con el método "getText()" no nos devuelve el HTML
    titulo = entrada.find('span', {'class' : 'tituloPost'}).getText()
    # Sino llamamos al método "getText()" nos devuelve también el HTML
    autor = entrada.find('span', {'class' : 'autor'})
    fecha = entrada.find('span', {'class' : 'fecha'}).getText()

    # Imprimo el Título, Autor y Fecha de las entradas
    print ("%d - %s  |  %s  |  %s", (i+1,titulo,autor,fecha))



# Sacamos informacion de todas las paginas.
from bs4 import BeautifulSoup
import requests
import pandas as pd

URL_BASE = "http://jarroba.com/"
MAX_PAGES = 20
counter = 0
curso2 = pd.DataFrame(columns = ["Titulo","Autor","Fecha"])
for i in range(1, MAX_PAGES):

    # Construyo la URL
    if i > 1:
        url = "%spage/%d/" % (URL_BASE, i)
    else:
        url = URL_BASE

    # Realizamos la petición a la web
    req = requests.get(url)
    # Comprobamos que la petición nos devuelve un Status Code = 200
    statusCode = req.status_code
    if statusCode == 200:

        # Pasamos el contenido HTML de la web a un objeto BeautifulSoup()
        html = BeautifulSoup(req.text, "html.parser")

        # Obtenemos todos los divs donde estan las entradas
        entradas = html.find_all('div', {'class': 'col-md-4 col-xs-12'})

        # Recorremos todas las entradas para extraer el título, autor y fecha
        for entrada in entradas:
            counter += 1
            titulo = entrada.find('span', {'class': 'tituloPost'}).getText()
            autor = entrada.find('span', {'class': 'autor'}).getText()
            fecha = entrada.find('span', {'class': 'fecha'}).getText()

            # Imprimo el Título, Autor y Fecha de las entradas
            print ("%d - %s  |  %s  |  %s" % (counter, titulo, autor, fecha))
            
            curso = pd.DataFrame([titulo,autor,fecha]).T
            curso.columns = ["Titulo","Autor","Fecha"]
            curso2 = pd.concat([curso2,curso])
          
    else:
        # Si ya no existe la página y me da un 400
        break
    

curso2["Autor"] = curso2["Autor"].str.replace("\t"," ")
