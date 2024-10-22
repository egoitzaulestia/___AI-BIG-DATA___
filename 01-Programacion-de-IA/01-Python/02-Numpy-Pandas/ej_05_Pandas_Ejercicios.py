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

# Otra opción
cliente[cliente.columns[1:5]]


# #### Crea un subset de los datos que incluya sólo datos de las columnas 1, 2 y 4 y 
# los datos de las filas 1 a la 9 (ambas incluidas).  
# Llama a ese dataset 'seleccion'.  Comprueba el resultado obtenido
# 

seleccion = cliente.iloc[1:10, [1, 2, 4]]
seleccion


# #### Mostrar el valor de la última celda del dataframe
seleccion.iloc[-1][-1]




# #### Crea un subset de datos que incluya únicamente aquellas columnas que empiezan por la letra 'C'.  
# Llama al subset 'seleccion'.  Comprueba el resultado obtenido

filtrar_col = [col for col in cliente if col.startswith('C')]

seleccion = cliente[filtrar_col]
seleccion

# Otra opción:
columnas_deseadas = list(filter(lambda x: x.lower().startswith("c"), cliente.columns))
seleccion = cliente[columnas_deseadas]
seleccion

# Otra opción:
seleccion = cliente.iloc[:, cliente.columns.str.lower().str.startswith("c")]
seleccion

# Otra opción:
seleccion = cliente[cliente.columns[cliente.columns.str.lower().str.startswith("c")]]
seleccion


# #### Filtra el dataset original y crea un subset de datos que incluya sólo aquellos registros que sean Mujer.  
# Guarda el resultado en un dataset llamado 'seleccion', comprueba además que efectivamente no tenemos 
# registros de Hombres en 'seleccion'

filtro_es_mujer = cliente["Sexo"] == "M"
mujeres = cliente[filtro_es_mujer]
mujeres


# Otra opción 
seleccion_M = cliente[cliente["Sexo"] == "M"]
seleccion_M


seleccion_M["Sexo"].unique()
seleccion_M["Sexo"].value_counts()  # 82 Mujeres
seleccion_M

# Checkeamos los hombre
seleccion_H = cliente[cliente["Sexo"] == "H"]
seleccion_H["Sexo"].unique()
seleccion_H["Sexo"].value_counts()  # 118 Hombres


# Otra opción, esta vez con una query
seleccion = cliente.query("Sexo == 'M'")
seleccion


# #### Filtrar el dataset 'cliente' y quédate con aquellos registros cuyo idCliente 
# sea menor a 50.  
# Guarda el resultado en un dataset llamado 'seleccion'.  
# Comprueba que efectivamente los idCliente en 'seleccion' sean los buscados.


cliente_filtrado = cliente[cliente["idCliente"] < 50]

# Comprobar los idCliente en el dataset filtrado
cliente_filtrado["idCliente"].unique()
cliente_filtrado["idCliente"].max()

# Guardar un CSV
cliente_filtrado.to_csv('seleccion.csv')



# #### En la tabla 'cliente' crea una nueva columna llamada 'nuevacolumna'
# y que contenga 'Mujer' sí la columna Sexo es M u 'Hombre' 
# si la columna Sexo es H.  Comprueba el resultado obtenido.


cliente["nuevacolumna"] = "xxx"

cliente["nuevacolumna"][cliente["Sexo"] == "M"] = "Mujer"
cliente["nuevacolumna"][cliente["Sexo"] == "H"] = "Hombre"


# Otra opción usando .loc
cliente["nuevacolumna2"] = "xxx"
cliente.loc[cliente["Sexo"] == "M", "nuevacolumna2"] = "Mujer"
cliente.loc[cliente["Sexo"] == "H", "nuevacolumna2"] = "Hombre"


# Otra opción con np.where
cliente["nuevacolumnaWhere"] = np.where(cliente["Sexo"] == "H", "Hombre", "Mujer")


# Otra manera 
cliente["nuevacolumna3"] = cliente["Sexo"]

# Reemplazamos "M" por "Mujer" y "H" por "Hombre" en la nueva columna
cliente["nuevacolumna3"] = cliente["nuevacolumna3"].replace({"M": "Mujer", "H": "Hombre"})

# Mostrar el resultado para verificar
cliente[["Sexo", "nuevacolumna3"]].head()



# #### Crea una nueva columna en 'cliente' llamada 'Apellidos' con este formato 
# Apellidos = Apellido1, Apellido2. 
# Ejemplo: 
# Apellido1: XXXXXX
# Apellido2: YYYYYY
# Resultado -> Apellidos: XXXXXX, YYYYYY

cliente["Apellidos"] = cliente[["Apellido1", "Apellido2"]].agg(", ".join, axis=1)

cliente["ApellidosEasy"] = cliente["Apellido1"] + ", " + cliente["Apellido2"]


# Utilizar métodos str para corregir los errores de formato en las columnas Telefono y Movil

cliente["Telefono"].to_list()

cliente["Telefono"] = cliente["Telefono"].astype("str")

cliente["Telefono"] = cliente["Telefono"].replace(" ", '',  regex=True)
cliente["Telefono"] = cliente["Telefono"].replace("-", '',  regex=True)
cliente["Telefono"] = cliente["Telefono"].replace(",0", '',  regex=True)
cliente["Telefono"] = cliente["Telefono"].replace("\(", '',  regex=True)
cliente["Telefono"] = cliente["Telefono"].replace("\)", '',  regex=True)

cliente["Telefono"] = cliente["Telefono"].replace("nan", '0',  regex=True)


cliente["Movil"] = cliente["Movil"].astype("str")

cliente["Movil"] = cliente["Movil"].replace(" ", '',  regex=True)
cliente["Movil"] = cliente["Movil"].replace("-", '',  regex=True)
cliente["Movil"] = cliente["Movil"].replace(",0", '',  regex=True)

cliente["Movil"] = cliente["Movil"].replace("nan", '0',  regex=True)


# Otra forma -> Dara error si no corremos de nuevo el datasat
cliente["Movil"] = cliente["Movil"].replace(" ", '',  regex=True)\
                                   .replace("-", '',  regex=True)\
                                   .replace(",0", '',  regex=True)\
                                   .replace("\(", '',  regex=True)\
                                   .replace("\)", '',  regex=True)\
                                   .replace("nan", '0',  regex=True)


# Otra forma
cliente["Telefono"] = cliente["Telefono"].astype(str)
cliente["Movil"] = cliente["Movil"].astype(str)

cliente["Telefono"] = cliente["Telefono"].str.replace(" ", "", regex=True)\
                                         .str.replace("-", "", regex=True)\
                                         .str.replace(",0", "", regex=True)\
                                         .str.replace(r"\(|\)", "", regex=True)\
                                         .str.replace("nan", "0", regex=True)

# Limpiar los valores de la columna Movil
cliente["Movil"] = cliente["Movil"].str.replace(" ", "", regex=True)\
                                   .str.replace("-", "", regex=True)\
                                   .str.replace(",0", "", regex=True)\
                                   .str.replace("nan", "0", regex=True)

# Comprobamos el resultado
print(cliente[["Telefono", "Movil"]].head())


#### Utilizar una función que se pueda aplicar con apply) a las columnas de Telefono y Movil que corrija el formato

cliente = pd.read_csv("datos/dimension_cliente.csv", sep="\t", encoding="UTF-8")

def corregir_telefono(telefono):
    # Verifica si el valor es NaN 
    if pd.isna(telefono):
        return "0"
    else:
        # Realiza las correcciones en el string del teléfono
        string = str(telefono).replace(" ", '').replace("-", '').replace(",0", '').replace("(", '').replace(")", '')
        return string


cliente["Telefono"] = cliente["Telefono"].apply(corregir_telefono)
cliente["Movil"] = cliente["Movil"].apply(corregir_telefono)


# Otra opción utilizando regex
import re

cliente = pd.read_csv("datos/dimension_cliente.csv", sep="\t", encoding="UTF-8")


# Función optimizada utilizando expresiones regulares
def corregir_telefono(telefono):
    if pd.isna(telefono):
        return "0"
    else:
        # Eliminar espacios, guiones, paréntesis y ",0" en una sola expresión
        return re.sub(r"[ \-,()]", "", str(telefono).replace(",0", ""))


cliente["Telefono"] = cliente["Telefono"].apply(corregir_telefono)
cliente["Movil"] = cliente["Movil"].apply(corregir_telefono)


# Otra opción pero manteniendo los NaN
cliente = pd.read_csv("datos/dimension_cliente.csv", sep="\t", encoding="UTF-8")

def corregir_telefono(telefono):
    # Verifica si el valor es np.nan
    if pd.notna(telefono):
        if isinstance(telefono, float):
            telefono = str(telefono)
        telefono = telefono.replace(" ", "")
        telefono = telefono.replace("-", '')
        telefono = telefono.replace(",0", '')
        telefono = telefono.replace("\(", '')
        telefono = telefono.replace("\)", '')
        telefono = telefono.replace("nan", '0')
    return telefono


cliente["Telefono"] = cliente["Telefono"].apply(corregir_telefono)
cliente["Movil"] = cliente["Movil"].apply(corregir_telefono)



# Obtener el tamaño de las diferentes filas
cliente['Tamaño'] = cliente['Telefono'].apply(lambda x: len(x) if pd.notna(x) else 0)
cliente['Tamaño']


