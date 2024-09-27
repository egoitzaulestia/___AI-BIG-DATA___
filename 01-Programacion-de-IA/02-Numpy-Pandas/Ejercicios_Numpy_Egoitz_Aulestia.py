#!/usr/bin/env python
# coding: utf-8

# # Ejercicios NumPy

# #### Importar NumPy como np

import numpy as np

# #### Generar un array de 10 ceros

np.zeros(10)



# #### Generar un array con 10 unos

np.ones(10)



# #### Generar un array con 10 seises

# Opción A
6 * np.ones(10)

# Opción B
np.full(10, 6)



# #### Generar un array de números enteros entre el 20 y el 40 (incluidos ambos)

np.arange(20, 41)



# #### Generar un array con todos los números pares desde el 15 al 59

np.arange(15, 60, 2) # (start, stop, step)



# #### Generar una matriz de 4x3 cuyos valores estén comprendidos entre el 0 y el 11

arr = np.arange(0, 12)

my_matrix = arr.reshape(4, 3)

my_matrix



# #### Generar una matriz identidad de 4x4

np.eye(4)



# #### Generar un número aleatorio entre 0 y 1

np.random.rand(1)



# #### Generar un número aleatorio entre 0 y 2

np.random.uniform(0, 2, 1)



# #### Usar NumPy para generar un array de 25 números aleatorios extraídos de 
# una distribución normal.

np.random.randn(25)



# #### Generar una matriz de 10x10 cuyos valores estén comprendidos 
# entre 0.01 y 1, en incrementos de 0.01:

arr_2 = np.linspace(0.01, 1, 100)

arr_2.reshape(10, 10)



# #### Generar un array de 20 elementos comprendidos entre el 0 y 1.

np.linspace(0, 1, 20)



# ## Indexación y selección en Numpy

# #### Generar un matriz de 5x5, con valores correlativos entre 1 y 25.  
# Guardar dicho array en el objeto "mat"

arr_4 = np.arange(1, 26)
mat = arr_4.reshape(5, 5)
mat



# #### Mostrar los datos contenidos en mat, a partir de la fila 3 y la columna 2 
# (tened en cuenta que existen la fila 0 y la columna 0).

mat
mat[2:, 1:]



# #### Extraer el valor de la celda que situado entre la cuarta fila y la quinta columna

mat[3, 4]



# #### Extraer los valores comprendidos en las 2 primeras filas y las columnas 2 y 3

mat
mat[:2, 1:3]



# #### Extraer los elementos de la quinta fila

# Opción A
mat[:, 4]

# Opción B
mat[:, -1]



# #### Extraer los elementos de las filas 4 y 5

mat
mat[3:,:]


# #### Sumar todos los elementos existentes en mat

# Opción A
mat.sum()

# Opción B
sum(sum(mat))


# #### Calcular la desviación estándar del array mat

mat.std()


# #### Calcular la suma de cada columna en mat

# Opción A
mat.sum(axis = 0)

# Opción B
sum(mat)


# #### Calcular la suma de cada fila en mat

mat.sum(axis = 1)




