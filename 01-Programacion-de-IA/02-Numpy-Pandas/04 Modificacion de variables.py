# -*- coding: utf-8 -*-
"""
Created on Thu Dec 27 12:07:30 2018

@author: Usuario
"""


#import numpy as np
import pandas as pd
import os


# Establecemos el directorio de trabajo
mi_directorio = "datos"
os.chdir(mi_directorio)


# Cargamos los datos
consumo = pd.read_csv("consumoelectricov1.csv", sep=";", encoding='latin-1')

consumo = pd.read_csv("consumoelectricov1.csv", sep=";",
                      skiprows=33, encoding='latin-1')

# Es interesante conocer la tipologia de los datos con los que vamos a trabajar

consumo.dtypes


"""
Podemos ver como hay variables que no toma en formato numerico, cuando debiera hacerlo.
Se corregirá mas adelante

Por otro lado, si abrimos el data frame, observamos que el separador de decimal en Python
es el punto y aqui tenemos ","
Tambien tenemos un separador de miles que es un punto.
"""

## Arreglar los separadores de miles y decimales ###

# 2 pasos:
# Borrar el punto de separador de miles
# Cambiar la coma por punto para el separador decimal

# Paso a Paso #

# Eliminamos el punto de una de las variables
consumo["2015"] = consumo["2015"].str.replace(".", "")
# Cambiamos la coma por el punto
consumo["2015"] = consumo["2015"].str.replace(",", ".")
consumo["2015"]

# Todo a la vez #
consumo["2014"] = (consumo["2014"].str.replace(".", "")).str.replace(",", ".")
consumo["2014"]

# Automatizar para todas las columnas que esten mal
# Seleccion de las columnas a corregir
trozo = consumo.iloc[:, range(4, 16, 3)]
datos_anuales = consumo.loc[:, "2013":"2002"]

# Eliminar una columna
datos_anuales = datos_anuales.drop(5, axis=0)
consumo.loc[:, ['2013', "2006", '2002']]


# Correccion masiva #

for columna in consumo.loc[:, '2013':'2002']:
    print(columna)
    # Eliminamos el punto
    consumo[columna] = consumo[columna].str.replace(".", "")
    # Cambiamos la coma por el punto
    consumo[columna] = consumo[columna].str.replace(",", ".")

# ¿Puedo mejorar los datos con la informacion que tengo?
# ¿El codigo de municipio me sirve para algo?
# Puedo saber a traves del codigo a que provincia pertenece?

# Podriamos convertirlos uno a uno
consumo['2015'] = consumo['2015'].astype(float)
consumo['2014'] = consumo['2014'].astype(float)
consumo.dtypes

# Todo a la vez
consumo.loc[:, '2015':'2002'] = consumo.loc[:, '2015':'2002'].astype(float)

consumo[['2015', '2014', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006', '2005', '2004', '2003', '2002']] = consumo[['2015', '2014', '2013', '2012', '2011', '2010', '2009', '2008', '2007', '2006', '2005', '2004', '2003', '2002']].astype(float)
consumo.dtypes

# Creamos una nueva variable
consumo['provincia'] = 'xxx'

# Establecemos condiciones para renombrar elementos
alava_bool = consumo["Codigo municipio"] < 15000
alaveses = consumo[consumo["Codigo municipio"] < 15000]


consumo['provincia'][consumo["Codigo municipio"] < 15000] = "Alava"

consumo['provincia'][consumo["Codigo municipio"] > 40000] = "Bizkaia"

consumo['provincia'][(consumo["Codigo municipio"] > 15000) &
                     (consumo["Codigo municipio"] < 40000)] = "Gipuzkoa"

consumo['provincia'].value_counts()


###  CALCULOS A PARTIR DE LA INFORMACION ORIGINAL ###

#### Gasto Medio Por Municipio  ###

# Convertimos a float (numerico) para poder trabajar con los datos


# Gasto medio por municipio

consumo['promedio'] = consumo.loc[:, '2015':'2002'].mean(axis=1)

# Podriamos crearlo en un data frame nuevo
consumopromedio = consumo.loc[:, '2015':'2002'].mean(axis=1)
consumo["promedio"] = consumopromedio

# Sumatorio del gasto por municipio

Sumgasto = consumo.loc[:, '2015':'2002'].sum(axis=1)
consumo["SumaGasto"] = Sumgasto

#### Pueblo o Ciudad  ####

# En este caso podemos poner el limite en 50.000 como ejemplo
consumo['pueblociudad'] = 'xxx'
consumo['pueblociudad'][consumo["2015"] < 50000] = "Pueblo"
consumo['pueblociudad'][consumo["2015"] > 50000] = "Ciudad"

consumo['pueblociudad'].value_counts()


#### Municipios con Menor/ Mayor Consumo  ####

municmenor = consumo.sort_values('2015')
municmenor10 = municmenor.head(n=10)

municmayor = consumo.sort_values('2015', ascending=False).head(10)

# Puede que solo queramos visualizar ciertas columnas

# Especificando las variables
municmenor.loc[:, 'Codigo municipio':'2015']
# Especificando las posiciones
municmenor.iloc[:, 0:3]
# Especificando posiciones salteadas
municmenor.iloc[:, [0, 3, 5, 8]]


#### Seleccion de las observaciones de una determinada Provincia  ####

# Para crear una nueva variable

datosBizkaia = consumo[consumo['provincia'] == "Bizkaia"]
datosAlava = consumo[consumo['provincia'] == "Alava"]
datosGipuzkoa = consumo[consumo['provincia'] == "Gipuzkoa"]

#### Consumo Maximo/Minimo   #####

menorconsumo = min(consumo['promedio'])
mayorconsumo = max(consumo['promedio'])

menorconsumo
mayorconsumo

# ¿No os falta algo en este ultimo dato?
# Tambien podemos pedir el nombre del municipio con mayor/menor consumo

#####  CONSULTA CRUZADA  #####


munimenorconsumo = consumo['Municipio'][consumo['promedio'] == consumo['promedio'].min()]

munimenorconsumo.values[0]


consumo['Municipio'][consumo['promedio'] == consumo['promedio'].min()]

munimayorconsumo = consumo['Municipio'][consumo['promedio'] == consumo['promedio'].max()]

consumo['Municipio'][consumo['promedio'] == consumo['promedio'].max()]

# O el nombre de la provincia donde esta el municipio con mayor/menor consumo
provmenorconsumo = consumo['provincia'][consumo['promedio'] == consumo['promedio'].min()]

consumo['provincia'][consumo['promedio'] == consumo['promedio'].min()]

provmayorconsumo = consumo['provincia'][consumo['promedio'] == consumo['promedio'].max()]

consumo['provincia'][consumo['promedio'] == consumo['promedio'].max()]


#### Consumo Alto/Medio/Bajo  ####

# Otra opcion es clasificar los municipios en consumo alto/medio/bajo segun sus percentiles

#####  AGGREGATE  #####


# Divide los datos en subconjuntos, calcula estadísticas de resumen para cada uno y
# devuelve el resultado.
# Agrega la informacion en funcion de una o varias variables.

consumo.groupby(['provincia'])
# Consumo medio por provincia
del consumo["Municipio"]
del consumo["pueblociudad"]
consmedioprov = consumo.groupby(['provincia']).agg("mean").reset_index()
consmedioprov = consmedioprov.loc[:, ('provincia', 'promedio')]

# Consumo  total por provincia
constotprov = consumo.groupby(['provincia']).agg("sum").reset_index()
constotprov = constotprov.loc[:, ('provincia', 'promedio')]


#### Consumo Alto/Medio/Bajo  ####

# Otra opcion es clasificar los municipios en consumo alto/medio/bajo segun
# sus percentiles


consumo_p33_prov = consumo["promedio"].groupby(
    consumo['provincia']).quantile(q=0.33).reset_index()
# consumo_p33_prov=consumo_p33_prov.loc[:,('provincia','promedio')]

consumo_p66_prov = consumo["promedio"].groupby(
    consumo['provincia']).quantile(q=0.66).reset_index()
# consumo_p66_prov=consumo_p66_prov.loc[:,('provincia','promedio')]

# Unimos los resultados obtenidos en una unica tabla

# Los unimos utilizando la columna comun 'provincia'

consum_33_66 = pd.merge(consumo_p33_prov, consumo_p66_prov, on='provincia')

# Hay que cambiar el nombre a las variables para saber cual es cual

consum_33_66 = consum_33_66.rename(
    {'promedio_x': 'p33', 'promedio_y': 'p66'}, axis=1)

# consum_33_66.columns=["a","b","c"]

# Ahora lo unimos con el dataset
consumo = pd.merge(consumo, consum_33_66, on='provincia')


# Una vez que tenemos los valores, podemos realizar la clasificacion
consumo['consumoProvincia'] = 'xxx'

consumo['consumoProvincia'][consumo["promedio"] < consumo['p33']] = "Bajo"
consumo['consumoProvincia'][(consumo["promedio"] > consumo['p33']) &
                            (consumo["promedio"] < consumo['p66'])] = "Medio"
consumo['consumoProvincia'][consumo["promedio"] > consumo['p66']] = "Alto"

consumo["consumoProvincia"].value_counts()

# Diferencias a lo largo del periodo
consumo['dif1502'] = consumo['2015']-consumo['2002']

# Y ordenarlos segun esas diferencias
consumo2 = consumo.sort_values('dif1502')

# Y mostrar los 10 en los que mas/menos se ha incrementado el consumo
consumo2.head(n=10)
consumo2.tail(n=10)

# Podemos mostrar las columnas que nos interese
consumo2.iloc[:, [0, 2, -1]].head(n=10)
consumo2.iloc[:, [0, 2, -1]].tail(n=10)


# Guardar un CSV
consumo2.to_csv('prueba.csv')
