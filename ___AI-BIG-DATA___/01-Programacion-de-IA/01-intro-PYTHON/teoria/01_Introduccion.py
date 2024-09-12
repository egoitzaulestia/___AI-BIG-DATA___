#!/usr/bin/env python3
# -*- coding: utf-8 -*-

##########################
# Operadores Aritméticos #
##########################

3 + 2 - 10
3.8 + 2.5 - 2.65
3 * 2
# División decimal
10 / 3
(1 + 3) / 4
1 + 3 / 4
# División entera
21 // 5  # Devuelve el cociente sin decimales
23 % 5  # Devuelve el resto
# Potencia
2**2
3**2
# Raíz
25**0.5
27**(1/3)


############################
# Operadores relacionales  #
############################
# Devuelve True si el operador de la izquierda es mayor que el operador de la derecha
12 > 3
# Devuelve True si el operador de la derecha es mayor que el operador de la izquierda
12 < 3
# Devuelve True si ambos operandos son iguales
12 == 3
# Devuelve True si el operador de la izquierda es mayor o igual que el operador de la derecha
12 >= 3
# Devuelve True si el operador de la derecha es mayor o igual que el operador de la izquierda
12 <= 3
# Devuelve True si ambos operandos no son iguales
12 != 3

#######################
# Operadores lógicos  #
#######################
a = False
b = True

# and 	Devuelve True si ambos operandos son True
a and b
# or 	Devuelve True si alguno de los operandos es True
a or b
# not 	Lo contrario del valor lógico introducido
not a

#################################
# CREACION DE VARIABLES SIMPLES #
#################################
a = 3 + 2 - 10
b = 3.8 + 2.5 - 2.65
c = 3 * 2
d = 10 / 3
e = (1 + 3) // 4
f = 2**2
g = 3**2
i = 25 ** 0.5

# Desempaquetamiento
i, j, k = 2+7, "hola", 3

del(j)

num = 7
num = num + 1
num += 5

# ---------------------------------
# Otras operaciones de asignación
# ---------------------------------
# += 	 es equivalente a a = a + 5
a += 5
# -= 	 es equivalente a a = a - 5
a -= 5
# *= 	a *= 3 es equivalente a a = a * 3
# /= 	a /= 3 es equivalente a a = a / 3
# %= 	a %= 3 es equivalente a a = a % 3
# **= 	a **= 3 es equivalente a a = a ** 3
# //= 	a //= 3 es equivalente a a = a // 3
a //= 5
a = a//5


# Obtención de la clase (tipo) de una variable
a = "abc"
type(a)
type(b)
type(c)
type(d)
type(e)
type(f)
type(g)
type(i)

#####################################################
# Los tipos PRIMITIVOS en Python que usaremos son 4 #
#####################################################
# Enteros
positivos = 1
negativos = -30
type(negativos)
treinta_mil = 30_000
cincuenta_mil = 50_000
treinta_mil + cincuenta_mil

# Flotantes
positivos = 2.3
negativos = -5.

# Booleanos
cierto = True
falso = False

cierto + falso
cierto * falso
falso - cierto
type(cierto + falso)
type(cierto * falso)
type(falso - cierto)
(cierto + falso) == True
1 == True

type(cierto)

# Cadenas (strings)
letra = "a"
type(letra)
palabra = "cañón"
palabra = 'cañon'
numero = "12"
otro_numero = "0.4"
# ¡Cuidado! No devuelve un error.
numero + otro_numero
#12 * otro_numero
int(numero)
numero
# Existe el tipo bytes pero no trabajaremos con él
texto = b'texto'
type(b'texto')
palabra_b = bytes(palabra, "utf-8")
type(palabra_b)
# La ñ y la o acentuada se han transformado en caracteres no imprimibles
print(palabra_b)
# A menos que informemos de la codificación y transformemos en string
print(str(palabra_b, "utf-8"))
print(str(palabra_b, "cyrillic"))

# Cuando algo no es nada es en realidad algo de tipo "None"
nada = None
# Va a aparecer cuando cometamos errores
type(nada)

