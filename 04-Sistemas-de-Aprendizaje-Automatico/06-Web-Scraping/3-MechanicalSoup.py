# -*- coding: utf-8 -*-
"""
Created on Tue Jan 12 20:11:10 2021

@author: Usuario
"""

## MechanicalSoup ##

## pip install MechanicalSoup

import mechanicalsoup

# Creamos un objeto Browser
browser = mechanicalsoup.Browser()

# Podemos solicitar una pagina de internet 
url = "http://olympus.realpython.org/login"
page = browser.get(url)

# Obtenemos un objeto que almacena la respuesta de la URL solicitada
page

"""
En este caso el numero 200 representa el codigo de estado devuelto por la solicitud.
 Significa que la solicitud se ha realizado correctamente
Otros codigos habituales:
    404: La URL no existe
    500: Ha ocurrido un error en el servidor al realizar la solicitud
"""

# MechanicalSoup puede usar la libreria BeautifulSoup para analizar el HTML obtenido 

type(page.soup)

# Podemos ver el HTML mediante el atributo .soup
page.soup
# Observamos como esta pagina tiene un <form> con elementos <input>
# que servirá para un nombre de usuario y contraseña


# Enviar un formulario con MechanicalSoup
"""
Si accedemos a la URl, vemos un formulario con id y contraseña.
Credenciales: User: zeus /// password: ThunderDude
Si accedemos, nos redirige a la pagina /profiles

"""
# Completar y enviar  formularios #

"""
La seccion importante del codigo HTML es el formulario de inicio de sesion
 el cual queda dentro de las etiquetas <form>. Este está dividido en 
 3 elementos <input>. Uno contiene el 'user', otro 'pwd' y el ultimo es el boton para enviar
 
"""
import mechanicalsoup

# Creamos el objeto
browser = mechanicalsoup.Browser()
# Establecemos las URL
url = "http://olympus.realpython.org/login"
# Solicitud
login_page = browser.get(url)
# Observamos el HTML
login_html = login_page.soup

# Seleccionamos la etiqueta <form>
# .select devuelve una lista de los elementos <form> de la pagina
form = login_html.select("form")[0]
# Establecemos el 'user'
form.select("input")[0]["value"] = "zeus"
# Establecemos la 'password'
form.select("input")[1]["value"] = "ThunderDude"

# Enviamos la peticion con dos argumentos. (Objeto form , URL)
profiles_page = browser.submit(form, login_page.url)
# Comprobamos el estado de la peticion
profiles_page

# Podemos ver cual es la URL una vez enviado el formulario
profiles_page.url

"""
Los hackers utilizan automatizaciones de este tipo de codigos 
para poder probar muchas combinaciones de user y pwd para entrar por la fuerza
Muchas paginas web evitan esto con contadores de intentos de entrada
"""


# Obtencion del link de cada perfil de la URL #

# Primero conviene mirar la estructura del HTML 
 
profiles_page.soup

# Observamos que los 'perfiles' están dentro de elementos de anclaje <a>
links = profiles_page.soup.select("a")

# Iteracion sobre cada link e impresion de los atributos 'href'
for link in links:
    address = link["href"]
    text = link.text
    print(f"{text}: {address}")
    
#Las URL contenidas en cada atributo href son URL relativas   
# Podemos establecer la URL completa utilizando la URL base y las relativas    
    
base_url = "http://olympus.realpython.org"
for link in links:
    address = base_url + link["href"]
    text = link.text
    print(f"{text}: {address}")    
    
    
# Ejercicio
# Usar MechanicalSoup para rellenar el formulario de la URL
    # http://olympus.realpython.org/login   
# Una vez enviado el formulario, mostrar el titulo de la pagina actual, 
    # para comprobar que nos han redirigido  
    


