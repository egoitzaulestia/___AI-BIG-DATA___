#!/usr/bin/env python
# coding: utf-8


############################
#        Numpy             #
############################
# 

"""
NumPy (o Numpy) es una librería muy importante dentro del ecosistema Data Science en Python.  

La mayoría de las librerías del ecosistema PyData, dependen o se apoyan en NumPy.

Numpy es muy rápido (usa librerías C).
"""

#_____________
# Instalación
# ------------

"""
Si la instalación de Python se ha ejecutado a través de Anaconda, Numpy ya viene instalado.  
Los siguientes pasos nos ayudarían a instalar Numpy en caso de no tenerlo instalado.  

A través de un terminal ejecutar:
"""
#
#     source intro_python/bin/activate
#     pip install numpy
#     

##### Usando NumPy
"""
Una vez instalado NumPy, lo importamos como librería:
""" 

import numpy as np

"""Numpy tiene muchas funciones y opciones.  
No podremos cubrir todas ellas, pero nos vamos a centrar en algunos de los 
aspectos más importantes de Numpy: vectores, arrays (conjunto de datos del mismo 
tipo), matrices, y generación de números.
"""
############################
# Arrays Numpy (Arreglos)  #
############################
#
"""
Los arrays en Numpy son esencialmente vectores y matrices. 
Los vectores son arrays de una dimensión y las matrices de 2 dimensiones 
(aunque podemos tener matrices de 1 fila o columna).  

Son de tipado **estático** y **homogéneo** para mejor uso de la memoria.  

Las funciones matemáticas complejas y computacionalmente costosas 
(p.ej: multiplicación de matrices) están implementadas en lenguajes compilados 
como C o Fortran).
"""
#___________________________ 
# Creación Arrays en Numpy
#___________________________

#### Desde una lista

"""
Podemos generar un array directamente convirtiendo una lista o lista de listas:
"""
my_list = [1,2,3]
type(my_list)

np.array(my_list)

arr = np.array(my_list)
type(arr)

my_matrix = [[1,2,3],[4,5,6],[7,8,9]]
my_matrix

arr_matr = np.array(my_matrix)
type(arr_matr)
print(arr_matr)

"""
Es una práctica familiar en matemáticas referirse a elementos de una matriz 
por el índice de fila primero y el índice de columna segundo. 
Esto se cumple para matrices bidimensionales, pero un mejor modelo mental es 
pensar que el índice de columnas viene último y el índice de filas como penúltimo. 
Esto se generaliza a los arrays con cualquier número de dimensiones.
"""


### Métodos incluidos para la generación de Arrays
#__________
#  arange #
#__________
"""
Genera un rango de datos a partir de un intervalo definido. (start, stop, step)
"""
range(0,11)
np.arange(0,11)

np.arange(0,11,2)

np.arange(10,-1,-2)

# Comparación con **range()**, visto previamente.
# np.arange genera los valores al crearse
a = np.arange(0,11)
# range es un generador
b = range(11)
print(type(a))
print(type(b))
print(a)
print(*b) # El asterisco es para generar los elementos a partir del generador

#________________
#  Ceros y unos
# _______________
"""
Generar arrays repletos de unos y ceros. Sólo debemos ocuparnos de las dimensiones.
"""
np.zeros(30)

np.zeros((5,5)) # Una foto negra

np.ones(3)
np.ones((3,3)) 

7*np.ones((3,3))

#____________
#  linspace
#____________
"""
Devuelve números espaciados uniformemente en un intervalo especificado.
"""

np.linspace(0, 10, 4)  #El intervalo viene definido por el número 4. /// El último número no es el step sino el CORTE 
# En este caso, divide el intervalo [0-10] en 4 partes iguales.

np.linspace(0, 10, 5)


np.linspace(0, 10, 51)

#________
#  eye
#________
"""
Crea una matriz identidad (sólo unos en la diagonal y el resto ceros)
"""
np.eye(5)

#__________
#  Random 
#__________
"""
Numpy tiene muchas maneras de generar arrays con números aleatorios:
    Se encuentran ordenadas en el submódulo np.random
    https://numpy.org/doc/stable/reference/random/index.html
"""
# rand
"""
Crea un array con la estructura elegida y lo rellena con datos aleatorios 
obtenidos a partir de una distribución uniforme.
"""
np.random.rand(2)

np.random.rand(5,5)
(np.random.rand(5,5)) * 100 -50

10*np.random.rand(5,5)
"""
¿Hemos obtenido todos los mismos resultados? ¿Porqué obtenemos diferentes arrays?

Ello se debe a que no estamos usando la misma 'semilla' para generar los números 
aleatorios.
"""
np.random.seed(30)
np.random.rand(5,5)


np.random.seed(30)
np.random.rand(5,5)


# randn
"""
Devuelve una muestra (o muestras) de una distribución estándar normal, 
al contrario que **rand** que es uniforme:
"""
np.random.randn(2)

np.random.randn(5,5)


# randint
"""
Devuelve enteros aleatorios entre un rango inferior (incluido) y otro superior (no incluido).  El rango inferior, debe ser menor que el rango superior.
"""
np.random.randint(1,100)  # El rango estaría comprendido entre 1 y 99

np.random.randint(1,100,10)  # Con el tercer argumento, nos devuelve 10 números aleatorios.

#_______________________________
# Atributos y métodos en Arrays
# ______________________________
"""
Creamos un array con números ordenados del 0 al 24 y otro de 10 números enteros 
aleatorios entre 0 y 50.

Probaremos distintos métodos y atributos de la librería Numpy con ellos
"""

arr = np.arange(25)
ranarr = np.random.randint(0,50,10) 

arr

ranarr

# Reshape
"""
Devuelve un array que contiene los mismos datos, pero con una distribución 
diferente.
"""
arr.shape
ranarr.shape
# array.reshape(num_de_filas, num_de_columnas)
arr.reshape(5,5)
# ranarr.reshape(5,5)

arr.reshape(25,1)




# max,min,argmax,argmin
"""
Métodos prácticos para obtener los valores máximos y mínimos, o para encontrar 
su índice (la posición que ocupan) a través de argmin o argmax
"""
ranarr

ranarr.max()

ranarr.argmax()

ranarr.min()

ranarr.argmin()


# Shape
"""
Shape es un atributo que devuelve una tupla con las dimensiones del array
"""
# Vector
arr = np.arange(25)
variable_shape= arr.shape
arr

# Matriz columna
# Atención a los 2 sets de corchetes
mat_col = arr.reshape(25,1)
variable_shape = mat_col.shape
mat_col.shape

# Matriz fila
mat_fila = arr.reshape(1,25)
mat_fila.shape
mat_fila

arr
"""
En el primer caso tenemos un array unidimensional con 25 elementos,  
mientras que en el segundo caso tenemos un array de 2 dimensiones
(1x25, 1 fila)
"""
print(arr.ndim)
print(mat_col.ndim)
print(mat_fila.ndim)


# dtype
"""
El método dtype devuelve el tipo de dato en el array. (tipo de los elementos)
"""
arr.dtype
mat_col.dtype

#-------------------------
# NumPy Indexación y Selección

"""
Veremos cómo seleccionar elementos o grupos de elementos de un array.
"""
# Generamos un array de muestra
import numpy as np
arr = np.arange(0,11)

arr
"""
La Indexación y selección a través de "Corchetes" es la manera más sencilla de 
seleccionar uno o varios elementos de un array.  
Se parece mucho a las listas de python:
"""

#Devuelve el valor existente en la 9ª posición del array
arr[8]

#Devuelve los valores existentes en un rango
arr[1:5]

#Devuelve los valores existentes en un rango
arr[:5]

# Difusión
"""
Los arrays en numpy tienen la propiedad de "difusión":
"""
#Asignar un valor a través de un rango en el índice (difusión)
arr[0:5] = 100
arr

# Resetear el array (vemos en un momento porqué)
arr = np.arange(0,11)
arr

#Extraemos una "porción" de los datos
slice_of_arr = arr[0:6]
slice_of_arr


# Cambiamos de una vez los valores existentes en la "porción" extraída
slice_of_arr[:] = 99
slice_of_arr

# ¿Qué ha pasado con el array original?. 
arr
"""
slice_of_arr es un alias de arr (ocupan el mismo espacio de memoria) y cualquier 
cambio en slice_of_arr se refleja en arr
"""
# Para generar una copia del array, debemos hacerlo explícitamente.
arr_copy = arr.copy()
arr_copy

arr_copy[:]=100
print (arr_copy) # La copia ha cambiado
print (arr)      # El original, no

# Indexado de matrices 2D
"""
El formato general es **arr_2d[filas][columnas]** o **arr_2d[filas,columnas]**. 

La notación a través de comas, suele ser más clara.
"""
arr_2d = np.array(([5,10,15],[20,25,30],[35,40,45]))
arr_2d

"""
Indexado de fila 1.
Ojo, la fila 1 es la segunda fila del array.  
La primera fila es la 0.
"""
arr_2d[1]

"""Indexado de la columna 1, es decir, la segunda columna"""
arr_2d[:,1]

# Extrayendo un elemento individual
arr_2d[1][0]

# Extrayendo un elemento individual
arr_2d[1,0]

# Extracción de las 2 primeras filas excluyendo la primera columna.
arr_2d[:2,1:]

#Extracción de la última fila
len(arr_2d) # Averiguo cuántas filas tengo
arr_2d[len(arr_2d)-1]

# Si sé el índice de la fila que quiero.
arr_2d[2]

# Que es la primera desde el final (si no sé cuantas tengo)
arr_2d[-1]

#Otra forma de extraer la última fila
arr_2d[2,:]


#Generamos un nuevo array de ejemplo
arr_2d = np.arange(50).reshape(5,10)
arr_2d

# Extraemos las filas 2 y 3 y las columnas 4 y 5.  
# Recordad que la primera fila y columna es la 0
arr_2d[1:3,3:5]

#______________________________________________________
# Selección de elementos en un array por su contenido
#______________________________________________________

arr = np.arange(1,11)
arr

#Devuelve un lógico con los elementos que cumplen o no la condición a evaluar.
arr > 4

# Guardo el resultado
bool_arr = arr>4

bool_arr

# PODEMOS CREAR FILTROS
# Podemos usar el lógico creado, para seleccionar los elementos que cumplen la 
# condición en el array (los que coinciden con True)
arr[bool_arr]

# Puede ser que ahora me convenga lo contrario. Los False
# La virguliya 
~bool_arr
arr[~bool_arr]


#De manera directa
arr[arr>2]
arr[arr<=2]

# Filtrar los elementos de un array que son mayores que el valor de una variable
x = 3
arr[arr>x]

#____________________________________
# Operaciones matemáticas con arrays
#____________________________________
import numpy as np
arr = np.arange(0,11)
arr

#Suma de elementos de un array
arr + arr

#Multiplicación
arr * arr

#Sustracción
arr - arr

# Mensaje de advertencia de división entre 0. RuntimeWarning No es un error.  
# Reemplaza la advertencia por nan.  0/0 = nan
arr/arr

# Nos muestra otra advertencia, pero no error.  1/0 = infinito
1/arr

arr**3

#____________________________________
# Funciones universales en arrays
#____________________________________
"""
son funciones que operan elemento por elemento en arrays de NumPy, 
lo que significa que aplican una operación específica a cada elemento individual 
del array sin necesidad de utilizar bucles explícitos. 

Estas funciones son una parte fundamental de NumPy y proporcionan una forma 
eficiente y rápida de realizar operaciones matemáticas y aritméticas en arrays 
multidimensionales.

El listado completo de funciones disponibles en numpy puede consultarse aquí: 
    http://docs.scipy.org/doc/numpy/reference/ufuncs.html

Veremos algunos ejemplos:
"""
np.add(arr, arr)  
np.add(arr, arr) == arr + arr

np.subtract(arr, arr) == arr - arr

np.multiply(arr, arr) == arr * arr

np.divide(arr, arr) == arr / arr


#Raíces cuadradas
np.sqrt(arr)

#Exponenciales (e^)
np.exp(arr)

# Dos maneras distintas
np.max(arr) #Se obtiene el mismo resultado a través de arr.max()
arr.max()

arr32 = arr.astype('int8')
dir(arr32)
arr.dtype
arr32.dtype

np.sin(arr) #Cálculo del seno (radianes)

np.log(arr) #Cálculo del logaritmo

np.log2(arr) #Cálculo del logaritmo en base 2


"""
El uso de ufuncs en lugar de bucles explícitos en Python suele ser más 
eficiente y permite aprovechar al máximo la velocidad de NumPy, que está 
optimizado para operaciones con arrays. 

Esto es especialmente útil cuando se trabaja con grandes conjuntos de datos y 
se necesitan cálculos rápidos y eficientes.
"""