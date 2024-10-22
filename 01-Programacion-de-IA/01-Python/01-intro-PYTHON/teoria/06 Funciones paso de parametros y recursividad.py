# -*- coding: utf-8 -*-
"""
Created on Fri Mar  2 10:03:25 2023

@author: Aitor Donado
"""

###############################
# Paso por valor y referencia #
###############################
"""
Dependiendo del tipo de dato enviado a la función, veremos dos comportamientos:

Paso por valor: Se crea una copia local de la variable dentro de la función.
Paso por referencia: Se maneja directamente la variable, los cambios realizados 
    dentro de la función le afectarán también fuera.

Los tipos simples se pasan por valor: Enteros, flotantes, cadenas, lógicos...
Los tipos compuestos se pasan por referencia: Listas, diccionarios, conjuntos...
"""
#___________________________
# Ejemplo de paso por valor
#___________________________
"""
Los números se pasan por valor y crean una copia dentro de la función, 
por eso no les afecta externamente lo que hagamos con ellos:
"""

def doblar_valor(numero):
    numero = numero * 2
    print("El valor de 'numero' dentro de la función es", numero)


numero = 10
doblar_valor(numero)
print("El valor de 'numero' fuera de la función es", numero)

#________________________________
# Ejemplo de paso por referencia
#________________________________
"""
Sin embargo las listas u otras colecciones, al ser tipos compuestos se pasan 
por referencia, y si las modificamos dentro de la función estaremos 
modificándolas también fuera:
"""

def doblar_valores(numeros):
    for i, n in enumerate(numeros):
        numeros[i] = 2 * numeros[i]
    print("El valor de 'numeros' dentro de la función es", numeros)


numeros = [10, 50, 100]
doblar_valores(numeros)
print("El valor de 'numeros' fuera de la función es", numeros)


num_ls_1 = [2, 4, 6]
num_ls_2 = [10, 20, 30]

num_ls_mix = [a * b for a, b in zip(num_ls_1, num_ls_2)]


# ___________________________
# ¿Si necesito lo contrario?
# ___________________________

# Para modificar los tipos simples podemos devolverlos modificados y reasignarlos:
def doblar_valor(numero):
    numero = numero * 2
    print("Valor dentro de la función", numero)
    return numero

numero = 10
numero = doblar_valor(numero)
print("El valor de 'numero' fuera de la función es", numero)


# Y en el caso de los tipos compuestos, podemos evitar la modificación enviando 
# una copia:
def doblar_valores(numeros):
    for i, n in enumerate(numeros):
        numeros[i] *= 2
    print("El valor de 'numeros' dentro de la función es", numeros)


numeros = [10, 50, 100]
doblar_valores(numeros[:])  # Una copia al vuelo de una lista con [:]
doblar_valores(numeros.copy()) # o con la función copy
print("El valor de 'numeros' fuera de la función es", numeros)

# Podemos hacer la copia antes de enviar el valor o dentro de la función
# En este caso la hago dentro usando la comprensión de listas
def doblar_valores(numeros):
    """
    Comprensión de lista (List comprehension)
    """
    copia_numeros = [n * 2 for n in numeros]
    
    #copia_numeros = numeros[:]
    #copia_numeros = numeros.copy()
    print("El valor de 'numeros' dentro de la función es", copia_numeros)

doblar_valores(numeros)
print("El valor de 'numeros' fuera de la función es", numeros)


copia_numeros = [n * 2 for n in numeros if n > 10]

copia_numeros= []
for n in numeros:
    if n > 10:
        copia_numeros.append(2*n)
        

telefono = [corrige_telefono(telefono) for telefono in telefonos]


################
# Recursividad #
################

"""
Las funciones recursivas en Python tienen varias ventajas, entre las que se incluyen:

1. Claridad de código: Las funciones recursivas pueden hacer que el código sea 
    más fácil de leer y entender, especialmente para problemas que implican una 
    estructura de árbol o una división en subproblemas más pequeños. 
    En algunos casos, el uso de funciones recursivas puede ser más sencillo y más 
    claro que el uso de bucles iterativos.

2. Eficiencia en la programación de algoritmos complejos: 
    Las funciones recursivas son especialmente útiles para problemas que 
    implican la división en subproblemas más pequeños, como los algoritmos de 
    búsqueda y ordenación. Estos algoritmos pueden ser difíciles de implementar 
    de forma iterativa, pero se pueden escribir de manera más sencilla y 
    eficiente mediante funciones recursivas.

3. Ahorro de espacio de memoria: En algunos casos, las funciones recursivas 
    pueden ahorrar espacio de memoria, ya que pueden evitar la necesidad de 
    almacenar datos en estructuras de datos temporales.

4. Mayor flexibilidad: Las funciones recursivas pueden ser utilizadas en 
    una amplia variedad de situaciones, lo que las hace más flexibles que las 
    funciones iterativas.

Sin embargo, es importante tener en cuenta que las funciones recursivas también 
pueden tener algunas desventajas, como la sobrecarga de la pila de llamadas y 
la posibilidad de causar un bucle infinito si no se implementan correctamente. 
Es importante diseñar y probar cuidadosamente las funciones recursivas antes 
de utilizarlas en proyectos importantes.
"""

# Cálculo de un número factorial con recursividad:
def factorial(n):
    # Caso base: Si n es 0 o 1, el factorial es 1.
    if n == 0 or n == 1:
        return 1
    # Caso recursivo: El factorial de n es n multiplicado por el factorial de n-1.
    else:
        return n * factorial(n - 1)

# Ejemplo de uso
resultado = factorial(5)
print("El factorial de 5 es:", resultado)

# Función que calcula el término n de la serie fibonacci
def fib_recur(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib_recur(n-1) + fib_recur(n-2)

fib_recur(3)
