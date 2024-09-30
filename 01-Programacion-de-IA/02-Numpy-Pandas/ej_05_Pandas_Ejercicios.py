#!/usr/bin/env python
# coding: utf-8

# # Ejercicio Pandas 4
import pandas as pd
import numpy as np

import warnings
warnings.filterwarnings('ignore')

import os
os.getcwd()
# #### Cargar el conjunto de datos dimension_cliente.csv.  
# Guardar el conjunto de datos en un dataframe llamado cliente. 
# Haz un preview de los primeros registros.  
# Extrae las dimensiones del dataset y la información (por columnas) de los datos 
# (nombre, tipo de variable, completitud)

cliente = pd.read_csv("datos/dimension_cliente.csv", sep="\t", encoding="UTF-8")

cliente.head()

cliente.shape

cliente.ndim

cliente.size

cliente.info()

cliente.describe(include = "all")


# VERSIÓN PROFE


# #### Crea un subset de los datos que incluya sólo datos de las columnas 1 a la 4 (ambas incluidas).  
# Llama a ese dataset seleccion.  Comprueba el resultado obtenido
#  Nota:  La columna 0 es la de idCliente

cliente[1:5]

seleccion = cliente.iloc[:,1:5]
seleccion

# VERSIÓN PROFE
cliente.iloc[:,1:5]
# clinete[cliente.columns[1:5]]


# #### Crea un subset de los datos que incluya sólo datos de las columnas 1, 2 y 4 y 
# los datos de las filas 1 a la 9 (ambas incluidas).  
# Llama a ese dataset 'seleccion'.  Comprueba el resultado obtenido
# 

seleccion = cliente.iloc[1:10, [1, 2, 4]]

# VERSIÓN PROFE
cliente.iloc[1:10, [1, 2, 4]]

# #### Mostrar el valor de la última celda del dataframe
seleccion.iloc[-1][-1]




# #### Crea un subset de datos que incluya únicamente aquellas columnas que empiezan por la letra 'C'.  
# Llama al subset 'seleccion'.  Comprueba el resultado obtenido

filtrar_col = [col for col in cliente if col.startswith('C')]

seleccion = cliente[filtrar_col]
seleccion


# PROFE:
columnas_deseadas = list(filter(lambda x: x.lower().startswith("c"), cliente.columns))
seleccion = cliente[columnas_deseadas]

seleccion = cliente.iloc[:, cliente.columns.str.lower().str.startswith("c")]

seleccion = cliente[cliente.columns[cliente.columns.str.lower().str.startswith("c")]]


# #### Filtra el dataset original y crea un subset de datos que incluya sólo aquellos registros que sean Mujer.  
# Guarda el resultado en un dataset llamado 'seleccion', comprueba además que efectivamente no tenemos 
# registros de Hombres en 'seleccion'


seleccion = cliente[cliente["Sexo"] == "M"]
seleccion



# #### Filtrar el dataset 'cliente' y quédate con aquellos registros cuyo idCliente sea menor a 50.  
# Guarda el resultado en un dataset llamado 'seleccion'.  
# Comprueba que efectivamente los idCliente en 'seleccion' sean los buscados.






# #### En la tabla 'cliente' crea una nueva columna llamada 'nuevacolumna' y que contenga 'Mujer' 
# sí la columna Sexo es M u 'Hombre' si la columna Sexo es H.  Comprueba el resultado obtenido.






# #### Crea una nueva columna en 'cliente' llamada 'Apellidos' con este formato Apellidos = Apellido1, Apellido2. 
# Ejemplo: 
# Apellido1: XXXXXX
# Apellido2: YYYYYY
# Resultado -> Apellidos: XXXXXX, YYYYYY






# Utilizar métodos str para corregir los errores de formato en las columnas Telefono y Movil




#### Utilizar una función que se pueda aplicar con apply) a las columnas de Telefono y Movil que corrija el formato
