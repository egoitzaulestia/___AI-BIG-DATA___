# -*- coding: utf-8 -*-
"""
Created on Tue Sep 10 12:58:06 2024

@author: 2425BIGDATA401
"""

"""
Crea un programa que solicite al usuario un número y utilice un bucle
while para sumar todos los números primos menores o iguales al número
ingresado.
"""



# Versión profe: Aitor
# Vamos a crear el ejercicio de manera desglosada

numero = ""
while not numero.isnumeric():
    numero = input("Introduce un número: ")

numero = int(numero)


# -------------------

numero = 17

es_primo = True
factor = 2
# 3 Buscamos factores menores que el número
while factor < int(numero ** 0.5): # Aquí podía ser " while j < num ", pero hemos puesto una versión más optimizada 
    if numero % factor == 0:
        # Al encontrar el factor no es primo y paramos
        es_primo = False
        print(i)
        break
    factor += 1

print(es_primo)


# -------------------

numero = 93
suma = 1
lista_primos = [1]
candidato_a_primo = 2
while candidato_a_primo <= numero:
    es_primo = True
    factor = 2
    # 3 Buscamos factores menores que el número
    while factor <= int(candidato_a_primo ** 0.5): # Aquí podía ser " while j < num ", pero hemos puesto una versión más optimizada 
        if candidato_a_primo % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(i)
            break
        factor += 1
        
    # print(candidato_a_primo)
    # print(es_primo)

    if es_primo: 
        suma = suma + candidato_a_primo
        lista_primos.append(candidato_a_primo)
    candidato_a_primo += 1
    # print(suma)

print(suma)
print(lista_primos)


# -------------------

numero = ""
while not numero.isnumeric():
    numero = input("Introduce un número: ")

numero = int(numero)

suma = 1
lista_primos = [1]
candidato_a_primo = 2
while candidato_a_primo <= numero:
    es_primo = True
    factor = 2
    # 3 Buscamos factores menores que el número
    while factor <= int(candidato_a_primo ** 0.5): # Aquí podía ser " while j < num ", pero hemos puesto una versión más optimizada 
        if candidato_a_primo % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(i)
            break
        factor += 1
        
    # print(candidato_a_primo)
    # print(es_primo)

    if es_primo: 
        suma = suma + candidato_a_primo
        lista_primos.append(candidato_a_primo)
    candidato_a_primo += 1
    # print(suma)

print(suma)
print(lista_primos)


# -------------------

numero = ""
while not numero.isnumeric():
    numero = input("Introduce un número: ")

numero = int(numero)

suma = 1
lista_primos = [1]
candidato_a_primo = 2
while candidato_a_primo <= numero:
    es_primo = True
    factor = 2
    # 3 Buscamos factores menores que el número
    while factor <= int(candidato_a_primo ** 0.5): # Aquí podía ser " while j < num ", pero hemos puesto una versión más optimizada 
        if candidato_a_primo % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(i)
            break
        factor += 1
        
    # print(candidato_a_primo)
    # print(es_primo)

    if es_primo: 
        # suma = suma + candidato_a_primo
        lista_primos.append(candidato_a_primo)
    candidato_a_primo += 1
    # print(suma)

print(suma)
print(lista_primos)






# -------------------
# -------------------
#      FUNCIÓN 
# -------------------
# -------------------


# MI VERSIÓN

# ----------------------------

# Función para pedir el número
def pedir_numero():
    numero = ""
    while not numero.isnumeric():
        numero = input("Introduce un número: ")

    return int(numero)

# ----------------------------

def es_primo(candidato_a_primo):
    factor = 2
    while factor <= int(candidato_a_primo ** 0.5):
        if candidato_a_primo % factor == 0:
            return False
        factor += 1
    return True

# ----------------------------

def generar_primos(hasta_numero):
    lista_primos = [1]
    candidato_a_primo = 2
    while candidato_a_primo <= hasta_numero:
        if es_primo(candidato_a_primo):
            lista_primos.append(candidato_a_primo)
        candidato_a_primo += 1
    return lista_primos

# ----------------------------

def sumar_primos(lista_primos):
    return sum(lista_primos)

# ----------------------------


def procesar_primos():
    # 1. Pedir el número al usuario
    numero = pedir_numero()

    # 2. Generar la lista de números primos hasta el número dado
    lista_primos = generar_primos(numero)

    # 3. Sumar los números primos
    suma = sumar_primos(lista_primos)

    # 4. Imprimir los resultados
    print(f"Lista de primos hasta {numero}: {lista_primos}")
    print(f"Suma de los números primos: {suma}")

# Llamada a la función principal que usa todas las demás
procesar_primos()






# VERSIÓN PROFE


def es_primo_P():
    pass


numero = ""
while not numero.isnumeric():
    numero = input("Introduce un número: ")

numero = int(numero)

suma = 1
lista_primos = [1]
candidato_a_primo = 2
while candidato_a_primo <= numero:
    es_primo = True
    factor = 2
    # 3 Buscamos factores menores que el número
    while factor <= int(candidato_a_primo ** 0.5): # Aquí podía ser " while j < num ", pero hemos puesto una versión más optimizada 
        if candidato_a_primo % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(i)
            break
        factor += 1
        
    # print(candidato_a_primo)
    # print(es_primo)

    if es_primo: 
        # suma = suma + candidato_a_primo
        lista_primos.append(candidato_a_primo)
    candidato_a_primo += 1
    # print(suma)

print(suma)
print(lista_primos)



















numero = 17

es_primo = True
factor = 2
# 3 Buscamos factores menores que el número
while factor < int(numero ** 0.5): # Aquí podía ser " while j < num ", pero hemos puesto una versión más optimizada 
    if numero % factor == 0:
        # Al encontrar el factor no es primo y paramos
        es_primo = False
        print(i)
        break
    factor += 1

print(es_primo)





suma = 1
lista_primos = [1]
candidato_a_primo = 2

while candidato_a_primo <= numero:
    es_primo = True
    factor = 2
    # 3 Buscamos factores menores que el número
    while factor <= int(candidato_a_primo ** 0.5): # Aquí podía ser " while j < num ", pero hemos puesto una versión más optimizada 
        if candidato_a_primo % factor == 0:
            # Al encontrar el factor no es primo y paramos
            es_primo = False
            # print(i)
            break
        factor += 1
        
    # print(candidato_a_primo)
    # print(es_primo)

    if es_primo: 
        # suma = suma + candidato_a_primo
        lista_primos.append(candidato_a_primo)
    candidato_a_primo += 1
    # print(suma)

print(suma)
print(lista_primos)




# Función para determinar si un número es primo
def es_primo(numero):
    if numero < 2:
        return False
    i = 2
    while i <= numero ** 0.5:  # Se revisan divisores hasta la raíz cuadrada del número
        if numero % i == 0:
            return False  # Si se encuentra un divisor, no es primo
        i += 1
    return True












# Función para determinar si un número es primo
def es_primo(numero):
    if numero < 2:
        return False
    i = 2
    while i <= numero ** 0.5:  # Se revisan divisores hasta la raíz cuadrada del número
        if numero % i == 0:
            return False  # Si se encuentra un divisor, no es primo
        i += 1
    return True

# Solicitar al usuario un número
num_introducido = int(input("Introduce un número: "))

# Inicializar variables
suma_primos = 0
numero_actual = 2  # Comenzamos desde el número 2, ya que es el primer número primo

# Bucle while para sumar los primos menores o iguales al número introducido
while numero_actual <= num_introducido:
    if es_primo(numero_actual):
        suma_primos += numero_actual  # Sumar el número primo a la suma total
    numero_actual += 1  # Pasar al siguiente número

# Mostrar el resultado final
print(f"La suma de los números primos menores o iguales a {num_introducido} es: {suma_primos}")



# --------------------


# Función para determinar si un número es primo
def es_primo(numero):
    if numero < 2:
        return False
    i = 2
    while i <= numero ** 0.5:  # Se revisan divisores hasta la raíz cuadrada del número
        if numero % i == 0:
            return False  # Si se encuentra un divisor, no es primo
        i += 1
    return True

# Solicitar al usuario un número
num_introducido = int(input("Introduce un número: "))

# Inicializar variables
suma_primos = 0
numero_actual = 2  # Comenzamos desde el número 2, ya que es el primer número primo

# Bucle while para sumar los primos menores o iguales al número introducido
print(f"Números primos menores o iguales a {num_introducido}:")
while numero_actual <= num_introducido:
    if es_primo(numero_actual):
        suma_primos += numero_actual  # Sumar el número primo a la suma total
        print(f"Primo: {numero_actual} | Suma acumulada: {suma_primos}")
    numero_actual += 1  # Pasar al siguiente número

# Mostrar el resultado final
print(f"\nLa suma total de los números primos menores o iguales a {num_introducido} es: {suma_primos}")
