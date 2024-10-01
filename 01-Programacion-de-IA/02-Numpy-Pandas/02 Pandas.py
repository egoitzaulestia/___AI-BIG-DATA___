
# coding: utf-8

# # Introducción a Pandas
# 
# Aprenderemos a utilizar pandas para el análisis de datos:
# 
# * Introducción a Pandas
# * Series
# * DataFrames
# * Valores perdidos
# * GroupBy
# * Fusionado, Unión y Concatenación
# * Operaciones habituales
# * Entrada y salida de datos

# ___

import numpy as np
import pandas as pd

###############
#   Series    #
###############

#________________
# Creando Series
#________________
# Conversión de una lista, Array Numpy o diccionario a Series:

labels = ['a','b','c']
my_list = [10,20,30]
arr = np.array([10,20,30])
d = {'a':10,'b':20,'c':30}

print(labels)
print(my_list)
print(arr)
print(d)

#________________
# Usando listas
#________________

serie = pd.Series(data=my_list)
print(serie)
serie[1]
# Asignamos etiquetas a la serie
serie_con_labels = pd.Series(data=my_list, index=labels)
serie_con_labels["b"]

serie_con_labels2 = pd.Series(my_list, labels)
serie_con_labels2["a"]

# Importante: Cuando comparo series devuelve la comparación elemento a elemento
# Me he ahorrado un for. Eso significa mayor eficiencia en código
serie_con_labels == serie_con_labels2

serie_con_labels["a"] = 15

#________________
# Usando Arrays
#________________
serie_con_labels3 = pd.Series(arr, labels)
serie_con_labels2 == serie_con_labels3

#______________________
# Usando Diccionarios
#______________________
serie_con_labels4 = pd.Series(d)
serie_con_labels2 == serie_con_labels4

#______________________
# ### Usando índices
#______________________
# La clave para usar Series, es entender sus índices. 
# Pandas usa los índices en formato numéricos o texto. 
ser1 = pd.Series([1,2,3,4], index = ['USA', 'Germany','USSR', 'Japan'])
ser2 = pd.Series([1,2,5,4], index = ['Germany','Italy', 'Japan','USA'])
ser1 == ser2  # Esto da error

print(ser1)
print(ser2)

print(ser1['USA'])
print(ser1[['USSR','USA']]) # Si pedimos más de uno hay que poner una lista
print(ser1[['USSR','USA', 'Japan']])

a = "a"
b = "b"
print(a+b)

# Las operaciones se realizan en función del índice
ser1 * ser2

###################
#   DataFrames    #
###################
# Los DataFrames están directamente inspirados del lenguaje de programación R.  
# Podemos ver un DataFrame como un conjunto de objetos Series unidos.

import pandas as pd
import numpy as np

from numpy.random import randn
np.random.seed(123)

# df = pd.DataFrame(randn(5,4), index='A B C D E'.split(), columns='W X Y Z'.split())
df = pd.DataFrame(randn(5,4),index=['A','B','C','D','E'], columns=['W', 'X', 'Y', 'Z'])
df

#__________________________
# Selección e indexación
#__________________________
df['W']


type(df)
# ¿Qué tipo de dato hay en la columna W?
type(df['W'])
# Como vemos la columna W es simplemente una Serie

# Selección de varias columnas por su nombre
df[['W','Z']]
type(df[['W','Z']])

# Pandas también permite sintaxis tipo SQL, no obstante no se recomienda su uso.
df.W


# Creando una nueva columna:
df['clase'] = 0
df

# Nueva columna a partir de un cálculo con otras
df['nueva'] = df['W'] + df['Y']
df


# ** Eliminar columnas **
# Ojo al axis=1 -> columnas
df.drop('nueva', axis=1)
# Devuelve otro Dataframe con el resultado de la operación
# A menos que lo especifiquemos con inplace, no se elimina nada en el original
df

df.drop('nueva', axis=1, inplace=True)
df

# Sin el inplace, podemos sobreescribir df
df = df.drop('clase', axis=1)
df

# Otra forma:
df['nueva'] = df['W'] + df['Y']
df
# `del` sí que elimina la columna en el original
del df['nueva']
df

# ** Eliminar filas **
# axis=0 -> filas
df.shape
df # Tampoco se borra sin el inplace
df.drop('A', inplace=True)
df

# ** Selección de filas **
# Esto da eror...
df["B"]
# ...porque las filas no son claves (keys). Sólo los nombres de columna son "keys"

# Se usan localizaciones (por nombre)
df.loc['B']

# o "integer-localizadores" por posición
df.iloc[0]

# Ojo, que los localizadores por nombre no se usan con las claves (las columnas)
# Esto dará error
df.loc['W']
# Pero esto sí lo puedo hacer
df.loc[:,'W']

# ** Selección de un subset de datos **
# sintaxis : dataframe.loc[lista_de_FILAS, lista_de_COLUMNAS]
df.loc[['B','D'],['W','Y']]

# Selección de 2 filas y todas las columnas.
df.loc[['B','D'],:]


# También podríamos haberlo hecho así:
# Las dos primeras filas
df.iloc[:2]
# Las filas con índices del 1 al 4 y columnas del 1 al 3
df.iloc[1:4, 1:3]


# ESTA ES LA ÁS HABITUAL
# De manera mixta (columnas por nombre, filas por iloc, lo más habitual)
df.iloc[1:3][['X', 'Z', 'clase']]

# De manera mixta (columnas por orden, filas por nombre, poco habitual)
# Podemos acceder a los nombres de las columnas
df.columns
# Y filtrar esos nombres por posición
df.loc[['A','B'],df.columns[2:]]

#__________________________
# Selección condicional
#__________________________

# Una importante característica de Pandas es la selección condicional de manera muy similar a Numpy:
df > 0

df < 0

df[df>0]


print(df['W']>0)

# Puedo considerar esa serie como un filtro
filtro = df['W'] > 0

df[filtro]
# El resultado es un dataframe
type(df[filtro])

# Al ser un dataframe, puedo seleccionar datos con las mismas reglas de selección que hemos visto
df[filtro]['Y']
type(df[filtro]['Y'])
df[filtro][['Y','X']]

# Normalmente no se crea el objeto "filtro" sino que se introduce su creación de forma anidada.
df[df['W'] > 0]

df[df['W'] > 0]['Y']

df[df['W']>0][['Y','X']] # "edad mayor de 18 y las columans Y e X


# Podemos concatenar condiciones con operadores lógicos `|` y `&`.  
# Deberemos encerrar entre paréntesis cada una de las condiciones:
df

df[(df['W']<0) & (df['Y'] < 1)]

# Lo contrario de una condición usando ~ = VIRGULILLA para negar.
df[(df['W']>0) & ~(df['Y'] > 1)]

filtro
~filtro

df[(df['W']>0) | (df['Y'] > 1)]

#__________________________
# Más sobre índices
#__________________________

df = pd.DataFrame(randn(5,4),index=['A','B','C','D','E'], columns=['W', 'X', 'Y', 'Z'])


df

# Reseteamos el índice a una secuencia de 0 a n
df2 = df.reset_index()
# Al resetear un índice, el viejo índice se convierte en columna y se crea otro basado en las posiciones
# Conviene hacer reset_index antes de set_index si quiero guardar la información de un índice.
# Si no pongo "inplace=True" no se modifica el original

df = pd.DataFrame(randn(5,4),index=['A','B','C','D','E'], columns=['W', 'X', 'Y', 'Z'])


nuevo_indice = 'CA NY WY OR CO'.split()
print(nuevo_indice)

df2
df2['Estados'] = nuevo_indice
df2

# Utilizamos la columna Estados como índice en el dataset
df2.set_index('Estados')
df2

# Tenemos que tener en cuenta que si no usamos el argumento inplace, no se aplican los cambios
df2.set_index('Estados', inplace=True)
df2

df2.loc["NY"]
df2["W"]["NY"]

#__________________________________________________
# Índices múltiples y jerarquía en los índices
#__________________________________________________

# Creamos diferentes 'índices'
outside = ['G1','G1','G1','G2','G2','G2']
inside = [1,2,3,1,2,3]
hier_index = list(zip(outside,inside))

print(outside)
print(inside)
print(hier_index)

hier_index = pd.MultiIndex.from_tuples(hier_index)

df = pd.DataFrame(np.random.randn(6,3),index=hier_index,columns=['A','B', "c"])
df


# ¿Cómo extraemos los datos en base a este índice doble?

# Haciendo uso de .loc
df.loc['G1']


df.loc['G2'].loc[1]
df.loc['G2'].loc[1]["A"]

# Podemos entender G1 y G2 como una columna extra que se usa para el filtrado.
# Además a los índices podemos asignarles nombres
df.index.names


df.index.names = ['Grupo','Número']
df


# Supongamos que queremos obtener aquellos datos cuyo grupo es G1 y su número es 1
# https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.xs.html
df.xs(('G1',1))

####################
# Valores perdidos #
####################
import numpy as np
import pandas as pd

df = pd.DataFrame({'A':[7,2,np.nan],
                'B':[5,np.nan,np.nan],
                'C':[1,2,3]})
df

# Por defecto dropna nos devuelve las filas "íntegras"
df.dropna()

# Si queremos columnas "íntegras"
df.dropna(axis=1)

df.dropna(thresh=2) # Elimina a partir de 2 valores nan

# Relleno de valores perdidos
df.fillna(value='Valor Rellenado')

# Una caso más elaborado (y habitual), sería el de imputar la media de su columna a los NA
df['A'].fillna(value=df['A'].mean(), inplace=True)
df

# Puedo rellenar con el contenido de otra columna u operación de columnas
df['A'].fillna(value=df['C'], inplace=True)
df

#___________
# Groupby
#___________
# El método groupby permite agrupar filas en base a un criterio y ejecutar operaciones de agregación sobre las mismas.
import pandas as pd
# Generación del dataframe
data = {'Compañía':['GOOG','GOOG','MSFT','MSFT','FB','FB'],
        'Trabajador':['Ana','Carlos','Rosa','Vanesa','Carlos','Sara'],
        'Ventas':[200,120,340,124,243,350]}
df = pd.DataFrame(data)

df

# Agrupamos los datos en base a la columna Compañía
df.groupby('Compañía')


# Guardamos el resultado en una variable
grupo = df.groupby('Compañía')


# Ahora podemos aplicar funciones sobre la agrupación.
grupo.sum()

# Ejecutado todo de una vez
df.groupby('Compañía').sum()


# Una función numérica sólo funcionará con números
df.groupby('Compañía')["Ventas"].mean()
df.groupby('Compañía')["Ventas"].std()

# Más ejemplos de agregaciones
df.groupby('Compañía').count()

# Podemos hacer un 'describe' para ver las características de nuestra agrupación de datos
grupo.describe(include="all")

# describe puede mostrar información de variables no numéricas en los dataframes, NO EN LOS GRUPOS
df.describe(include="all")

# Si no nos gusta como se muestra la información podemos usar el método transpose
grupo.describe().transpose()


# Descripción de la compañía FB
grupo.describe().loc['FB']

####################################
# Fusionado, Unión y Concatenación #
####################################
import pandas as pd

# Generación de los sets de datos a utilizar
df1 = pd.DataFrame({'A': ['A0', 'A1', 'A2', 'A3'],
                        'B': ['B0', 'B1', 'B2', 'B3'],
                        'C': ['C0', 'C1', 'C2', 'C3'],
                        'D': ['D0', 'D1', 'D2', 'D3']},
                        index=[0, 1, 2, 3])

df2 = pd.DataFrame({'A': ['A4', 'A5', 'A6', 'A7'],
                        'B': ['B4', 'B5', 'B6', 'B7'],
                        'C': ['C4', 'C5', 'C6', 'C7'],
                        'D': ['D4', 'D5', 'D6', 'D7']},
                        index=[4, 5, 6, 7]) 

df3 = pd.DataFrame({'A': ['A8', 'A9', 'A10', 'A11'],
                        'B': ['B8', 'B9', 'B10', 'B11'],
                        'C': ['C8', 'C9', 'C10', 'C11'],
                        'E': ['D8', 'D9', 'D10', 'D11']},
                        index=[7, 8, 9, 10])

print (df1)
print (df2)
print (df3)

# Observar que se solapa el index 7 en df2 y df3 y que df3 tiene columna E

#________________
# Concatenacion
#________________

"""
La concatenación, básicamente une diferentes DataFrames. 
Repite índices y nombres de columna
"""

pd.concat([df1,df2,df3])

pd.concat([df1,df2,df3], axis=1)


#____________
# Fusionado
#____________
# Permite la unión de diferentes DataFrames usando una lógica similar a la SQL a la hora de fusionar tablas.

# Creamos dos tablas para hacer pruebas:
izquierda = pd.DataFrame({'key': ['K0', 'K1', 'K2', 'K3'],
                    'A': ['A0', 'A1', 'A2', 'A3'],
                    'B': ['B0', 'B1', 'B2', 'B3']})

derecha = pd.DataFrame({'key': ['K0', 'K1', 'K2', 'K4'],
                        'B': ['C0', 'C1', 'C2', 'C3'],
                        'D': ['D0', 'D1', 'D2', 'D3']})    

izquierda
derecha

# 4 diferentes tipos de fusionado: inner, left, rigth, outer
# Este es el caso más fácil en que las claves coinciden

pd.merge(izquierda, derecha, on='key')  # Esto es INNER join

pd.merge(izquierda, derecha, how='left', on='key')


# Con más de una clave
izquierda = pd.DataFrame({'key1': ['K0', 'K0', 'K1', 'K2'],
                        'key2': ['K0', 'K1', 'K0', 'K1'],
                        'A': ['A0', 'A1', 'A2', 'A3'],
                        'B': ['B0', 'B1', 'B2', 'B3']})
    
derecha = pd.DataFrame({'key1': ['K0', 'K1', 'K1', 'K2'],
                        'key2': ['K0', 'K0', 'K0', 'K0'],
                        'C': ['C0', 'C1', 'C2', 'C3'],
                        'D': ['D0', 'D1', 'D2', 'D3']})

izquierda
derecha

# Podemos fusionar las tablas en base a más de una key (columna)
pd.merge(izquierda, derecha, on=['key1', 'key2'])

pd.merge(izquierda, derecha, how='outer', on=['key1', 'key2'])

pd.merge(izquierda, derecha, how='right', on=['key1', 'key2'])

pd.merge(izquierda, derecha, how='left', on=['key1', 'key2'])


# Unos casos algo más complicados
izquierda = pd.DataFrame({'coche': ['Audi', 'Audi', 'Renault', 'Mercedes'],
                        'color': ['Blanco', 'Negro', 'Blanco', 'Negro'],
                        'Motor': ['Diesel', 'Gasolina', 'Híbrido', 'Eléctrico'],
                        'Potencia': ['120cv', '135cv', '100cv30kW', '45kW']})
    
derecha = pd.DataFrame({'coche': ['Audi', 'Renault', 'Renault', 'Mercedes'],
                        'color': ['Blanco', 'Blanco', 'Blanco', 'Blanco'],
                        'Asientos': ['Tela', 'Cuero', 'Terciopelo', 'Cuero Calefactado'],
                        'Puertas': ['3', '4', '5', '2']})

izquierda
derecha

# Podemos fusionar las tablas en base a más de una key (columna)

pd.merge(izquierda, derecha, how='outer', on=['coche', 'color'])

pd.merge(izquierda, derecha, how='right', on=['coche', 'color'])

pd.merge(izquierda, derecha, how='left', on=['coche', 'color'])
# El caso por defecto es el más conservador, inner
pd.merge(izquierda, derecha, on=['coche', 'color'])
pd.merge(izquierda, derecha, how='inner', on=['coche', 'color'])

#___________
#  Unión
#___________
# De 2 DataFrames, con índices iguales o no, en uno sólo,
# Es como merge pero sólo puede usar el index como clave

izquierda = pd.DataFrame({'A': ['A0', 'A1', 'A2'],
                    'B': ['B0', 'B1', 'B2']},
                    index=['K0', 'K1', 'K2']) 

derecha = pd.DataFrame({'C': ['C0', 'C2', 'C3'],
                    'D': ['D0', 'D2', 'D3']},
                    index=['K0', 'K2', 'K3'])
izquierda
derecha

# Observamos que el registro 2 (K1), al no existir en derecha, no se completa a nivel de columnas C y D
izquierda.join(derecha)
derecha.join(izquierda)

izquierda.join(derecha, how='outer')


izquierda = pd.DataFrame({'color': ['Blanco', 'Negro', 'Blanco', 'Negro'],
                        'Motor': ['Diesel', 'Gasolina', 'Híbrido', 'Eléctrico'],
                        'Potencia': ['120cv', '135cv', '100cv30kW', '45kW']},
                        index =  ['Audi', 'Mercedes', 'Renault', 'Tesla']
                        )
    
derecha = pd.DataFrame({'color': ['Blanco', 'Blanco', 'Blanco', 'Blanco'],
                        'Asientos': ['Tela', 'Cuero', 'Terciopelo', 'Cuero Calefactado'],
                        'Puertas': ['3', '4', '5', '2']},
                        index = ['Audi', 'Hyundai', 'Dacia', 'Mercedes'])

# Esto me da error ya que hay dos columnas con el mismo nombre
izquierda.join(derecha)
izquierda.join(derecha, lsuffix='_izquierda', rsuffix='_derecha')


#__________________________
# Otras operaciones habituales
#__________________________

import pandas as pd
df = pd.DataFrame({'col1':[1,2,3,4],'col2':[444,555,666,444],'col3':['abc','def','ghi','xyz']})
df.tail(2)
df.head(2)

# ### Información sobre los valores únicos de una columna
df['col2'].unique()


# Total de elementos únicos 
df['col2'].nunique()


df['col2'].value_counts()


# ### Selección de datos
#Selección de un DataFrame filtrando en base a valores de columnas
nuevodf = df[(df['col1']>2) & (df['col2']==444)]
nuevodf

#__________________________
# ### Funciones Apply
#__________________________
# https://pandas.pydata.org/docs/reference/api/pandas.DataFrame.apply.html

def doble(x):
    return x*2


doble(6)

# Aplicamos la función cuadrado A TODOS los elementos de col1.  Es una operación columnar, por tanto no hace falta iterar registro a registro
df['col1'] = df['col1'].apply(doble)

df['col1'] = 2*df['col1']

# Mismo resultado de diferente manera
df['col1'].apply(lambda x: x**2)

def anade_h(string):
    if len(string)!=0:
        return string + "h"
    else:
        return string

# Obtener el tamaño de las diferentes filas
df['col3'].apply(anade_h)


# Eliminar columnas (ojo, hasta no usar inplace no se eliminan del set original)
df.drop('col1',axis=1)

df.columns
df.index

df['col1'].sum()


# **Eliminar permanentemente una columna**
del df['col1']
df


# **Ordenar los DataFrames:**
df.sort_values(by='col2', ascending=True) #inplace=False por defecto
# Nota, observad como el índice no varía.  Cada registro sigue manteniendo el índice original.

df.sort_values(by=['col2','col3'], ascending=False) #inplace=False por defecto

df.sort_values(by=['col2','col3'], ascending=[False, True])

