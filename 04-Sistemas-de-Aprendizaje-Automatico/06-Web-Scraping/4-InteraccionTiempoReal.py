# -*- coding: utf-8 -*-
"""
Created on Thu Jan 14 11:28:44 2021

@author: Usuario
"""

    
## Interactuar con paginas web en tiempo real ##
    
    
# Se quiere scrapear una web en la que se simula la tirada de un dado
import mechanicalsoup

# En primer lugar hay que determinar que elemento de la pagina
# contiene el resultado de la tirada (Codigo fuente de la web) 
#    <h2 id="result">1</h2>


# Creamos el objeto Browser
browser = mechanicalsoup.Browser()

# Solicitud de la URL deseada
page = browser.get("http://olympus.realpython.org/dice")

# Buscamos el elemento con id=result. 
# En este caso utilizamos el selector de ID de CSS (#) para indicar que
# lo que queremos es el valor del id.
tag = page.soup.select("#result")[0]
#tag = page.soup.select("h2")

result = tag.text

print(f"The result of your dice roll is: {result}")    

# Para obtener resultados continuamente hay que crear un bucle 
# que cargue la pagina en cada caso. Añadimos un tiempo de espera entre tiradas


# Ejemplo modulo .sleep()
import time

print("I'm about to wait for five seconds...")
time.sleep(5)
print("Done waiting!")



import time
import mechanicalsoup

browser = mechanicalsoup.Browser()

for i in range(4):
    page = browser.get("http://olympus.realpython.org/dice")
    tag = page.soup.select("#result")[0]
    result = tag.text
    print(f"The result of your dice roll is: {result}")
    time.sleep(10) # Tiempo espera
    
# Optimizamos el codigo para no tener que esperar 10seg en la tirada 4    
    
import time
import mechanicalsoup

browser = mechanicalsoup.Browser()

for i in range(4):
    page = browser.get("http://olympus.realpython.org/dice")
    tag = page.soup.select("#result")[0]
    result = tag.text
    print(f"The result of your dice roll is: {result}")

    # Esperamos 10seg siempre que no sea la ultima tirada
    if i < 3:
        time.sleep(10)    