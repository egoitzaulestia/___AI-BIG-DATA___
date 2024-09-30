#!/usr/bin/env python
# coding: utf-8

# # Pandas 2
# ---


import os
import pandas as pd
#import seaborn as sns
#import matplotlib.pyplot as plt


# ## Carga de datos 
# ---

df = pd.read_csv("./Numpy_Pandas/datos/data2.csv", sep="|", encoding="UTF-8")

df = pd.read_csv("/home/laptop/Proyectos Python/Introduccion_Python/Numpy_Pandas/datos/data2.csv", sep="|", encoding="UTF-8")

df.head()


#Otra forma más elegante de cargar los datos...
import os

# Cambiar por carpeta donde se encuentren los datos
data_dir = '/home/laptop/Proyectos Python/Introduccion_Python/Numpy_Pandas/datos/'

path = os.path.join(data_dir, 'data2.csv')
try:
    df = pd.read_csv(path, sep="|")  # para cargar csv tabulados, usar sep="\t"
except Exception as e:
    print(e)


# ### Corregimos los errores
# Si hay errores en la carga de un csv, comprobamos los siguiente:
# * Caracter separador.
# * Caracter decimal.
# * Codificación.
df.head()
df.tail()

#######################
# Exploración inicial #
#######################

df.info()
# ### Corregimos los tipos de datos
# Modificamos la carga de datos definiendo:
# * Columnas que utilizar.
# * Columnas que parsear a fecha.
# * Tipo del resto de columnas.
# * Eliminar columna 0

df['Catastro'] = df['Catastro'].astype('string')
df['IdCliente'] = df['IdCliente'].astype('string')
df['Catastro'].str.lower()

df["Producto"].unique()
df['Producto'] = df['Producto'].astype('category')
df['Producto'].cat.categories

df['TipoProducto'].unique()
df['TipoProducto'] = df['TipoProducto'].astype('category')



# ### Corregimos el resto de errores
# Si alguna columna no se ha modificado su tipo, puede ser porque contenga errores. Modificamos el tipo indicando que se ignoren los errores.
df['Fecha'] = pd.to_datetime(df['Fecha'], errors='coerce', format = "%Y-%m-%d")


df.info()

df['Fecha'].dt.day_name()

df = df.drop('Unnamed: 0', axis=1)

##############################
# Exploración y modificación #
##############################
df.head()

# Renombramos columnas
# Catastro renombrar a CatastroMax
# ReferenciaCP renombrar a CPReferenciado
df = df.rename(columns={'Catastro':'CatastroMax','ReferenciaCP':'CPReferenciado'})

df.columns
# Otra forma de dar nombre a las columnas
# df.columns = ['CatMax', 'CPReferenciado', 'Id', 'Producto', 'Fecha', 'TProducto', 'AltaCliente']
df.head()

# Generar variables dummies
df["Producto"].unique()
df_dummies_Producto = pd.get_dummies(df, columns=['Producto'])
df_dummies_Producto.head(15)

# Los Dummies son booleanos
df_dummies_Producto.info()

#_______________
# Agrupaciones #
#_______________
# Voy a generar una columna con supuestos datos de facturación
df_dummies_Producto['Facturacion'] = df_dummies_Producto['IdCliente'].astype('int') / 40 * 1.3

df_dummies_Producto.head()

df_productos_cliente = df_dummies_Producto.groupby(['IdCliente', 'Fecha'])['Facturacion'].sum().reset_index()
df_productos_cliente.info()

df_total_producto_diario = df_dummies_Producto.groupby(['TipoProducto', 'Fecha'])['Facturacion'].mean().reset_index()
df_total_producto_diario.info()

df_total_producto_diario.head(10)

#__________________________________
# Consultas a dataframes con query
#__________________________________
"""
En Pandas, la función query() permite realizar consultas a DataFrames de manera similar a la escritura de consultas SQL. 
Esta función permite filtrar los datos de un DataFrame utilizando una expresión booleana como cadena de texto.
"""
# Contrataciones del mes de mayo
df.info()
filtro_mayo = df["Fecha"].dt.month == 5
df[df["Fecha"].dt.month == 5]["Fecha"]
df[filtro_mayo]


df.query('Fecha.dt.month == 5 and not TipoProducto == "Servicio sin cuota"')

"""
Puedes usar nombres de columnas directamente en la expresión.
Utiliza operadores lógicos como and, or, not y paréntesis para combinar condiciones.
Operadores de comparación como ==, !=, <, >, <=, >= también se pueden usar.
"""

# Esto da error
df.query('AltaCliente.dt.month <= 5')

# No funciona pq AltaCliente no es de tipo datetime
df['AltaCliente'] = pd.to_datetime(df['AltaCliente'], errors='coerce')

df.info()
df['IdCliente'] = df['IdCliente'].astype('int')

df.query('AltaCliente.dt.day <= 10 and IdCliente<100000')["IdCliente"]

# ### Consultas más complejas
# Podemos usar el contenido de una variable añadiendo su nombre tras el carácter @

productos = ['N01', 'N06']
for producto in productos:
    df.query('AltaCliente.dt.day <= 10 and Producto in @producto')

producto = 'N01'
tipoprod = 'Servicio sin cuota'
filtrado = df.query('AltaCliente.dt.day <= 10 and (Producto == @producto or TipoProducto == @tipoprod)')
filtrado[["Producto", "TipoProducto", "AltaCliente"]]

# Extraemos del CatastroMax el código de área
# Para ello eliminamos primero todos los espacios y posteriormente extraemos el texto de las posiciones 3 a 4
#df['Provincia'] = df['CatastroMax'].str.replace(" ","")
df['Provincia'] = df['CatastroMax'].str.slice(4,6)
df.head(20)


# ### Clientes dados de alta en el mes de abril
df.query('AltaCliente.dt.month == 4')


# ### Facturación media del mes de abril del 2020
df ['Facturacion'] = df['IdCliente'].astype('int') / 40 * 1.3
df.query('Fecha.dt.month == 4')['Facturacion'].sum()


# ### Facturación maxima y minima para Producto N06 de los clientes que no pertenezcan a Bizkaia
df.info()
df['Provincia'] = df['Provincia'].astype('string')

no_vizcainos = df.query('Provincia != "48"')
no_vizcainos['Facturacion'].max()
no_vizcainos['Facturacion'].min()

