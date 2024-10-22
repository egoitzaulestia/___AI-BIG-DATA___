# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 13:32:59 2024

@author: 2425BIGDATA401
"""

"""
Implementa una función para generar los primeros n números 
de la secuancia de Fibonacci. Pide al usuario que ingrese el valor de n
"""

"Inserte la cantidad de números fibonnaci que quieres visualizar: "


# --------------------------------------------------------
#   RECURSIVIDAD: Ejercicio creado mediante recursividad
# --------------------------------------------------------

# Función recursiva para calcular el término n de la secuencia de Fibonacci
def fib_recur(n):
    if n == 0:
        return 0
    elif n == 1:
        return 1
    else:
        return fib_recur(n-1) + fib_recur(n-2)

# Función para generar los primeros n números de la secuencia Fibonacci usando recursividad
def generate_fib_recur(n):
    fib_list = []
    for i in range(n):
        fib_list.append(fib_recur(i))
    return fib_list

# Solicitar al usuario que ingrese el valor de n
n = int(input("Inserte la cantidad de números Fibonacci que quieres visualizar: "))

# Generar y mostrar los primeros n números de Fibonacci
fibonacci_list = generate_fib_recur(n)
print(f"Los primeros {n} números de la secuencia Fibonacci son: {fibonacci_list}")



# ---------------------------------------------------------------------------
#   ITERACIÓN: Ejercicio creado mediante iteración
#   Parece que la iteración es más eficaz que la recursividad,
#   ya que la recursividad recalcula las variables cada vez que se ejecuta,
#   en cambio la iteración NO
# ---------------------------------------------------------------------------


# Función para generar los primeros n números de la secuencia Fibonacci
def fib_sequence(n):
    fib_list = []
    a, b = 0, 1
    for i in range(n):
        fib_list.append(a)
        a, b = b, a + b
    return fib_list

# Solicitar al usuario que ingrese el valor de n
n = int(input("Inserte la cantidad de números Fibonacci que quieres visualizar: "))

# Generar y mostrar los primeros n números de Fibonacci
fibonacci_list = fib_sequence(n)
print(f"Los primeros {n} números de la secuencia Fibonacci son: {fibonacci_list}")