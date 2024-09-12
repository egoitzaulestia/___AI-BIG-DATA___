import time

"""
Las funciones devuelven un valor con return,
la preculiaridad de los generadores es que van cediendo valores 
sobre la marcha, en tiempo de ejecución.
"""

def es_primo(numero):
    """Función que devuelve True si el número introducido es primo"""
    es_primo = True
    factor = 2
    while factor < numero:
        if numero % factor == 0:
            es_primo = False
            return es_primo
        factor += 1
    return es_primo

def primos(n, m):
    for numero in range(n, m+1):
        # Simulamos la ejecución de código lento con una parada de 1 segundo
        time.sleep(1)
        if es_primo(numero):
            yield numero

"""
La función range(0,11), empieza cediendo el 0, 
    luego se procesa el for comprobando si es primo y lo añade a la lista, 
    en la siguiente iteración se cede el 1, en la siguiente se cede el 2, etc.

Con esto se logra 
    ocupar el mínimo de espacio en la memoria al poder generar listas de 
    millones de elementos sin necesidad de almacenarlos previamente.
"""

generador_de_primos = primos(0,20)

next(generador_de_primos)
next(generador_de_primos)
next(generador_de_primos)

for primo in generador_de_primos:
    # Al llamar a la función en cada tacada del bucle 
    # se genera el valor primo y se imprime
    print(primo)

# El for ha continuado a partir del siguiente valor que obtuvimos con next

# El generador ahora está agotado
next(generador_de_primos)

generador_de_primos = primos(0,20)

# Si guardo el generador en una lista, tengo que esperar a que se ejecute toda la lista
# por tanto, pierdo la ventaja de usar el generador.
lista_pares = list(generador_de_primos)

for numero in primos(5, 10):
    print(numero)


# Es posible convertir una lista en un iterable
lista = [1, 2, 54, 3, 23, 6, "Hola", 6, 69, 6, 78, 5]
lista_iterable = iter(lista)

next(lista_iterable)
next(lista_iterable)
next(lista_iterable)

# List Comprenhension
generador_de_primos = primos(7,100)
[numero for numero in generador_de_primos if str(numero)[-1] == "7"]

# Ejercicio:
#___________#
# Ejercicio #
#-----------#
# Crear un generador que busca en un archivo cualquiera, líneas que contengan una subcadena coincidente:
# Usar ese generador para leer El Quijote, cuando el generador encuentre la palabra Quijote,
# imprime la línea y para hasta que el usuario le da a "intro" (con un input vacío)


#__________#
# Solución #
#----------#
# Vamos paso a paso

