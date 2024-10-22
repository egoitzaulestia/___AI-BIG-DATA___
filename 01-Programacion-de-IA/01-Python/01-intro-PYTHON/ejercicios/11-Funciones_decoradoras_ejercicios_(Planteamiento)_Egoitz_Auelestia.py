#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Wed Sep 18 10:20:40 2024

@author: Egoitz Aulestia Padilla
"""



"""
NOTA: Este documento contiene varias versiones por ejercicio.

      He comentado las primeras versiones de cada ejercicio,
      dejando la última versión lista para ejecutar.
      
      Pero todas las versiones funcionan.
"""



############################################################################################################
# Ejercicio 1: Decorador de Validación de Parámetros                                                       #
############################################################################################################


"""
Crea un decorador llamado validar_parametros que tome una función y verifique si los parámetros 
cumplen ciertas condiciones antes de llamar a la función. 

Por ejemplo, puedes implementar una validación que asegure que los números ingresados son positivos.
"""


# # Ejercicio 1 -> VERSIÓN 1:
# # ------------------------

# #Función decoradora validar_parametros() -> valida paramatros individuales de un número entero
# def validar_parametros(func):
#     # Función que se ejecuta antes que la función original
#     def wrapper(entrada):
#         # Verificar si la entrada NO es un número entero
#         if not isinstance(entrada, int):
#             raise TypeError("Debes introducir un número entero")
#         # Verificar si la entrada es un número negativo
#         elif entrada < 0:
#             raise ValueError("fEl número {entrada} es negativo, debe ser positivo")
#         salida = func(entrada)
#         return salida
#     return wrapper


# # Función num_enteros() con la el decorador @validar_parametros
# @validar_parametros
# def num_entero(x):
#     return x # Solo devuelve el número o la lista sin hacer nada especial


# # Pruebas con ejemplos:

# num_entero(5)
# num_entero(-32)
# num_entero("Thales of Miletus")


# # --------------------------------------------------------------------------------------------------------------


# # Ejercicio 1 -> VERSIÓN 2:
# # ------------------------

# # Función decoradora validar_parametros -> valida tanto paramatros individuales y listas de números enteros
# def validar_parametros(func):
#     # Función que se ejecuta antes que la función original
#     def wrapper(entrada):
#         # Verificar si la entrada es un número entero
#         if isinstance(entrada, int):
#             if entrada < 0:
#                 raise ValueError(f"El número {entrada} es negativo, debe ser positivo")
#         # Verificar si es una lista de números enteros
#         elif isinstance(entrada, list):
#             for i, x in enumerate(entrada):
#                 if not isinstance(x, int):
#                     raise TypeError("Todos los elementos de la lista deben ser números enteros")
#                 if x < 0:
#                     raise ValueError(f"El número {x} situado en la posición {i} de la lista es negativo, debe ser positivo")
#         # Si no es ni un número ni una lista de números
#         else:
#             raise TypeError("El parámetro introducido debe ser un número entero o una lista de números enteros")
#         return func(entrada)
#     return wrapper


# # Función num_enteros() con la el decorador @validar_parametros
# @validar_parametros
# def num_enteros(x):
#     return x # Solo devuelve el número o la lista sin hacer nada especial


# # Pruebas con ejemplos:

# num_enteros(1)                  # 1

# num_enteros(-2)                 # ValueError: El número -2 es negativo, debe ser positivo
# num_enteros("boom")             # TypeError: El parámetro introducido debe ser un número entero o una lista de números enteros

# num_enteros([3, 5, 8])          # [3, 5, 8]

# num_enteros([13, "21", 34])     # TypeError: Todos los elementos de la lista deben ser números enteros
# num_enteros([55, -89, 144])     # ValueError: El número -89 situado en la posición 1 de la lista es negativo, debe ser positivo


# # --------------------------------------------------------------------------------------------------------------


# Ejercicio 1 -> VERSIÓN 3:
# ------------------------

# Función decoradora validar_parametros -> Versión dos más compacta de la segunda opción mostrada anteriormente
def validar_parametros(func):
    def wrapper(entrada):
        # Verificar si es un número entero
        if isinstance(entrada, int):
            if entrada < 0:
                raise ValueError(f"El número {entrada} es negativo, debe ser positivo")
        # Verificar si es una lista de números enteros
        elif isinstance(entrada, list):
            # Verficar que todos los elementos de la lista sean enteros. Si alguno no lo es, la condición será False y se lanzará un TypeError
            if not all(isinstance(x, int) for x in entrada):
                raise TypeError("Todos los elementos en la lista deben ser números enteros")
            # Verificar que al menos un elemento de la lista NO sea positivo. Si es así, la condición será True y se lanzará un ValueError.
            if any(x < 0 for x in entrada):
                raise ValueError("Todos los números en la lista deben ser positivos")
        else:
            raise TypeError("El parámetro debe ser un número entero o una lista de números enteros")
        return func(entrada)
    return wrapper


# Función num_enteros() con la el decorador @validar_parametros
@validar_parametros
def num_enteros_final(x):
    return x    


# Pruebas con ejemplos:

num_enteros_final(1)                  # 1

num_enteros_final(-2)                 # ValueError: El número -2 es negativo, debe ser positivo
num_enteros_final("boom")             # TypeError: El parámetro introducido debe ser un número entero o una lista de números enteros

num_enteros_final([3, 5, 8])          # [3, 5, 8]

num_enteros_final([13, "21", 34])     # TypeError: Todos los elementos de la lista deben ser números enteros
num_enteros_final([55, -89, 144])     # ValueError: Todos los números en la lista deben ser positivos


# --------------------------------------------------------------------------------------------------------------




############################################################################################################
# Ejercicio 2: Decorador(es) para la función lista primos                                                  #
############################################################################################################


"""
Crea una función decoradora para la función lista primos que verifique que el 
tatvalor del parámetro de entrada limite es correcto y filtre la salida eliminando 
los valores de la lista de primos terminados en 7, por ejemplo, el 17.
"""


# # Ejercicio 2 -> VERSIÓN 1
# # ------------------------

# def es_primo(numero):
#     es_primo = True
#     factor = 2
    
#     # Buscamos factores menores que el número
#     while factor <= int(numero**0.5):
#         if numero % factor == 0:
#             es_primo = False
#             break
#         factor += 1
        
#     return es_primo


# def validar_entrada(func):
#     def wrapper(entrada):
#         try:
#             if not isinstance(entrada, int):
#                 raise TypeError(f"\"{entrada}\" no es un número entero")
#             if entrada < 2:  # Cambiamos a < 2
#                 raise ValueError(f"{entrada} no es un número válido, debe ser un entero mayor que 1")
#             return func(entrada)
#         except (TypeError, ValueError) as e:
#             print(f"Error: {e}")  # Personaliza el manejo del error
#             raise e  # Re-lanza el error para que siga siendo manejable
#     return wrapper


# def filtrar_salida(func):
#     def wrapper(limite):
#         salida = func(limite) 
#         salida = list(filter(lambda num: num % 10 != 7, salida))
#         return salida
#     return wrapper


# @filtrar_salida
# @validar_entrada
# def lista_primos(limite): 
#     """
#     lista_primos = []\n
#     for i in range(2, limite):
#         \tif es_primo(i):\n
#             \t\tlista_primos.append(i)\n
#     return lista_primos
#     """
#     return [i for i in range(2, limite) if es_primo(i)]


# # Pruebas con ejemplos:

# lista_primos(80)        # [2, 3, 5, 11, 13, 19, 23, 29, 31, 41, 43, 53, 59, 61, 71, 73, 79]

# lista_primos(1)         # ValueError: 1 no es un número válido, debe ser un entero mayor que 1
# lista_primos(-34)       # ValueError: -34 no es un número válido, debe ser un entero mayor que 1
# lista_primos("Neo")     # TypeError: "Neo" no es un número entero


# # --------------------------------------------------------------------------------------------------------------


# Ejercicio 2 -> VERSIÓN 2
# ------------------------

"""
He creado un decorador `filtrar_salida` personalizable, que permite introducir el dígito 
que se desea filtrar de los números generados.

En esta función, opté por usar una lista por comprensión en lugar de `filter()` con una lambda, 
ya que las listas por comprensión son más concisas, más legibles y, en algunos casos, más rápidas.

La diferencia de rendimiento entre ambas es mínima, pero las listas por comprensión tienden a ser 
más eficientes, ya que `filter()` debe llamar a la función lambda en cada iteración, 
lo que agrega una pequeña sobrecarga.
"""

def es_primo(numero):
    es_primo = True
    factor = 2
    
    # Buscamos factores menores que el número
    while factor <= int(numero**0.5):
        if numero % factor == 0:
            es_primo = False
            break
        factor += 1
        
    return es_primo


def validar_entrada(func):
    def wrapper(entrada):
        try:
            if not isinstance(entrada, int):
                raise TypeError(f"\"{entrada}\" no es un número entero")
            if entrada < 2:  # Cambiamos a < 2
                raise ValueError(f"{entrada} no es un número válido, debe ser un entero mayor que 1")
            return func(entrada)
        except (TypeError, ValueError) as e:
            print(f"Error: {e}")  # Personaliza el manejo del error
            raise e  # Re-lanza el error para que siga siendo manejable
    return wrapper



# Decorador personalizable para filtrar números que terminan en el dígito especificado
def filtrar_salida(digito=7):  # Puedes elegir que número quieres filtrar
    def decorador(func):
        def wrapper(limite):
            salida = func(limite)
            # # Opción filter con lambda (comentado por el motivo especificado de que list comprehension es más eficiente)
            # salida = list(filter(lambda num: num % 10 != digito, salida))
            # Filtro mediante lista de comprensión para eliminar números que terminan en el dígito especificado
            salida = [num for num in salida if num % 10 != digito]
            return salida
        return wrapper
    return decorador


"""
Debemos invocar `filtrar_salida` como una función, es decir, con paréntesis `()`, 
incluso si ya hemos asignado un valor por defecto (en este caso, 7).
"""
@filtrar_salida()  # Los paréntesis son necesarios para invocar el decorador, incluso cuando se usa el valor por defecto.
@validar_entrada
def lista_primos(limite): 
    """
    lista_primos = []\n
    for i in range(2, limite):
        \tif es_primo(i):\n
            \t\tlista_primos.append(i)\n
    return lista_primos

    """
    return [i for i in range(2, limite) if es_primo(i)]  # Devolvemos resultado de la lista mediante list comprehension


# Pruebas con ejemplos:

lista_primos(80)        # [2, 3, 5, 11, 13, 19, 23, 29, 31, 41, 43, 53, 59, 61, 71, 73, 79]

lista_primos(1)         # ValueError: 1 no es un número válido, debe ser un entero mayor que 1
lista_primos(-34)       # ValueError: -34 no es un número válido, debe ser un entero mayor que 1
lista_primos("Neo")     # TypeError: "Neo" no es un número entero







############################################################################################################
# Ejercicio 3: Decorador para Logs                                                                         #
############################################################################################################


"""
Implementa un decorador llamado registro que registre información sobre la llamada
a la función, como el nombre de la función, los argumentos y el resultado.
Imprime esta información en la consola cada vez que la función decorada se ejecuta.

Que en vez de imprimir en consola guarde la hora actual y la información
en un archivo txt.

En este ejercicio puedes usar ChatGPT, pero entonces tendrás que explicar el código
a tus compañeros.
"""


# Ejercicio 3 -> VERSIÓN 1
# ------------------------


# import os
# import time
# from datetime import datetime


# def verificar_entrada(func):
#     def wrapper(*args, **kwargs):
#         try: 
#             # Verificar que todos los argumentos posicionales sean números
#             for arg in args:
#                 if not isinstance(arg, (int, float)):
#                     raise TypeError(f"El argumento '{arg}' no es un número. Debes ingresar un número valido.")
            
#             # Verificar que los argumentos por clave también sean números
#             for kwarg, valor in kwargs.items():
#                 if not isinstance(valor, (int, float)):
#                     raise TypeError(f"El argumento '{kwarg}' con valor {valor} no es un número. Debes ingresar un número valido.")
            
#             # Si todo está bien, ejecutar la función
#             return func(*args, **kwargs)
#         except (TypeError, ValueError) as e:
#             print(f"Error: {e}\n")  # Personaliza el manejo del error
#             raise e  # Re-lanza el error para que siga siendo manejable
#     return wrapper



# def registro(func):
#     def wrapper(*args, **kwargs):
#         inicio_ejecucion = time.time()
#         salida = func(*args, **kwargs) # Aquí activamos en la función
#         final_ejecución = time.time()
#         tiempo_ejecucion = final_ejecución - inicio_ejecucion
#         hora_actual = datetime.now()
#         # Variable que a la que le asignamos la valirables de cada columna de nuestro archivo de registro
#         variables_log = "Time\tFuncion\tTiempoDeEjecucion\tArgumentosPosicionales\tArgumentosClave\tResultado\n"
#         log_info = f"{hora_actual}\t{func.__name__}()\t{tiempo_ejecucion}\t{args}\t{kwargs}\t{salida}\n"
#         n_archivo = "registro.text"
#         variables_establecidas = False
#         segunda_linea_txt = False
#         ruta_archivo = f"teoria/datos/{n_archivo}"
#         if os.path.exists(ruta_archivo):           
#             # Abrir en modo lectura para verificar si la primera línea está vacía
#             with open(ruta_archivo, "r") as archivo:
#                 primera_linea_txt = archivo.readline().strip()  # Lee la primera línea para verificar si está vacía
#                 segunda_linea_txt = archivo.readline().strip()  # Lee la primera línea para verificar si está vacía
#                 if primera_linea_txt == variables_log:
#                     variables_establecidas = True    
#                 else:
#                     variables_establecidas = False
#                 if segunda_linea_txt:
#                     segunda_linea_txt = True
#         if variables_establecidas:      
#             with open(ruta_archivo, "a") as archivo:
#                 # Insertamos la información de registro en el archivo
#                 if not segunda_linea_txt:
#                     archivo.write(f"\n{log_info}")
#                 else:
#                     archivo.write(log_info)
#         else:
#             with open(ruta_archivo, "a") as archivo:
#                 # Creamos el encabezado insertando con las variables de registro en el archivo
#                 archivo.write(variables_log)
#                 # Insertamos la información de registro en el archivo
#                 archivo.write(log_info)
#         # Información para imprimir por consola
#         debug_info = f"{hora_actual}\tFunción: {func.__name__}()\tTiempo de ejecución: {tiempo_ejecucion} segundos\tArgumentos posicionales : {args}\tArgumentos por clave {kwargs}\tResultado: {salida}\n"
#         print(debug_info)
#         return salida
#     return wrapper



# @registro
# @verificar_entrada
# def multiplicar_parametros(*args, **kwargs):
#     resultado = 0
#     for x in args:
#         resultado += x * 2
#     for key, valor in kwargs.items():
#         resultado += valor * 2
#     time.sleep(1)
#     return resultado



# multiplicar_parametros(34, 789)

# multiplicar_parametros("architect")

# --------------------------------------------------------------------------------------------------------------


# Ejercicio 3 -> VERSIÓN 2
# ------------------------

"""
NOTA: Elimana el archivo registro.txt sí lo tienes creado (habiendo usado la VERSIÓN 1 de este ejercicio 3)

      Este nuevo ejercicio crea un log más elaborado con control de errores impresos en nuestro registro
      Por lo tanto, si has credo un archivo de registro con la VERSIÓN 1 del ejercicio 3, elimínalo por favor,
      para que esta versión cree un nuevo documento más optimizado.
"""

import time
from datetime import datetime


def verificar_entrada(func):
    def wrapper(*args, **kwargs):
        try: 
            # Verificar que todos los argumentos posicionales sean números
            for arg in args:
                if not isinstance(arg, (int, float)):
                    raise TypeError(f"El argumento {arg} no es un número. Debes ingresar un número valido.")
            
            # Verificar que los argumentos por clave también sean números
            for kwarg, valor in kwargs.items():
                if not isinstance(valor, (int, float)):
                    raise TypeError(f"El argumento '{kwarg}' con valor {valor} no es un número. Debes ingresar un número valido.")
            
            # Si todo está bien, ejecutar la función
            return func(*args, **kwargs)
        except (TypeError, ValueError) as e:
            print(f"Error: {e}\n")  # Personaliza el manejo del error
            raise e  # Re-lanza el error para que siga siendo manejable
    return wrapper



def registro(func):
    def wrapper(*args, **kwargs):
        inicio_ejecucion = time.time()
        hora_actual = datetime.now()
        mensaje = "Proceso completado correctamente" # Indica en la variable mensaje de log_info que el proceso ha ido bein
        error_ocurrido = False # Variable booleana para registrar si ha habido un error
        
        try:
            salida = func(*args, **kwargs)  # Llamada a la función original
        except Exception as e:
            # Capturar cualquier excepción y registrar el mensaje de error
            salida = None
            error_tipo = type(e).__name__  # Captura el tipo de error
            mensaje = f"{error_tipo}: {str(e)}"  # Añade el tipo de error a la variable mensaje de log_info
            error_ocurrido = True
        
        final_ejecucion = time.time()
        tiempo_ejecucion = final_ejecucion - inicio_ejecucion

        # Encabezado del log
        variables_log = "Time\tFuncion\tTiempoDeEjecucion\tArgumentosPosicionales\tArgumentosClave\tResultado\tError\tMensaje"
        # Toda la información del proceso de registro que imprimiremos en el documento de registro.txt  
        log_info = f"{hora_actual}\t{func.__name__}()\t{tiempo_ejecucion}\t{args}\t{kwargs}\t{salida}\t{error_ocurrido}\t{mensaje}\n"
        ruta_archivo = "teoria/datos/registro.text" # Ruta del archivo

        # Abrimos el archivo en modo lectura y escritura con "a+"
        # El modo "a+" significa que:
        # 1. Si el archivo no existe, será creado.
        # 2. Si el archivo existe, el puntero se coloca al final, permitiendo agregar contenido sin sobreescribir.
        # 3. También nos permite leer el archivo, aunque en este caso, se requiere mover manualmente el puntero
        #    usando archivo.seek(0) para leer desde el principio del archivo.
        # Este modo es útil cuando queremos leer el archivo para verificar el contenido
        # existente, pero también agregar nueva información sin perder los datos previos.
        with open(ruta_archivo, "a+") as archivo:
            archivo.seek(0)  # Mover el puntero al inicio para leer
            primera_linea = archivo.readline().strip()  # Leer la primera línea
            segunda_linea = archivo.readline().strip()  # Leer la segunda línea

            # Si el encabezado no existe, lo escribimos
            if primera_linea != variables_log:
                archivo.write(variables_log + "\n")
            # Si existe encabezado pero no la segunda línea está vacía, agregamos un salto de línea para separar encabezado y registro
            elif (primera_linea == variables_log) and (segunda_linea == ""): 
                archivo.write("\n")

            archivo.write(log_info)  # Hacemos el registro

        # Información para imprimir por consola
        # debug_info = f"{hora_actual}\tFunción: {func.__name__}()\tTiempo de ejecución: {tiempo_ejecucion} segundos\tArgumentos posicionales: {args}\tArgumentos por clave: {kwargs}\tResultado: {salida}\tMensaje: {mensaje}\n"
        debug_info = f"{hora_actual}\nFunción: {func.__name__}()\nTiempo de ejecución: {tiempo_ejecucion} segundos\nArgumentos posicionales: {args}\nArgumentos por clave: {kwargs}\nResultado: {salida}\nError: {error_ocurrido}\nMensaje: {mensaje}\n"
        print(debug_info)

        return salida
    return wrapper


@registro
@verificar_entrada 
def multiplicar_parametros(*args, **kwargs):
    resultado = 0
    for x in args:
        resultado += x * 2
    for key, valor in kwargs.items():
        resultado += valor * 2
    time.sleep(1.25)
    return resultado


# Pruebas con ejemplos:
# NOTA: puedes hacer la prueba de correr todas las lineas de las pruebas seguidas. 
#       El programa registrara tanto los procesos validos como los erroneos.

multiplicar_parametros(13)                          # Correcto
multiplicar_parametros(-55)                         # Correcto, el program acepta números negativos
multiplicar_parametros(9.8)                         # Correcto
multiplicar_parametros(3, 4, 5)                     # Correcto

multiplicar_parametros("fsociety")                  # "TypeError" que se registra el archivo registro.txt

multiplicar_parametros(2, 56, 43, x = 300, y = 20)  # Correcto
multiplicar_parametros(5, 3, 2, x=10, y="20")       # "TypeError" que se registra el archivo registro.txt


