# -*- coding: utf-8 -*-
"""
Created on Sun Jan 17 17:34:52 2021

@author: borja
"""

## Solucion
from urllib.request import urlopen
from bs4 import BeautifulSoup

base_url = "http://olympus.realpython.org"
# Abrir URL
html_page = urlopen(base_url + "/profiles")
# Leer y decodificar el HTML
html_text = html_page.read().decode("utf-8")
# Objeto BeautifulSoup
soup = BeautifulSoup(html_text, "html.parser")

print(soup)

# Obtenemos los link mediante la busqueda de los elementos y su iteracion
for link in soup.find_all("a"):
    link_url = base_url + link["href"]
    print(link_url)