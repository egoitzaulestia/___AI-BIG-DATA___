# -*- coding: utf-8 -*-
"""
Created on Thu Feb  2 10:17:20 2023

@author: borja
"""
import pandas as pd
import os

os.chdir(r"C:\Users\borja\OneDrive\Documents\Formacion_Python\17-Modelos\SeriesTemporales\Teoria")
# Cargamos los datos
datos = pd.read_csv("Teoria/DatosCreditosPersonales.csv")


del (datos["Unnamed: 0"])
# Pasamos la fecha a formato fecha
datos["Month-Year"] = pd.to_datetime(datos["Month-Year"], format="%b-%y")

# Pasamos la fecha al indice
datos.index = datos["Month-Year"]
del (datos["Month-Year"])


import numpy as np

datos["Creditos_Personales"] = datos["Creditos_Personales"].astype(float)
Log_Datos = pd.DataFrame(np.log(datos["Creditos_Personales"]))

# Dividimos en train y test
train = Log_Datos.loc[:"2010-12-01 00:00:00"]
test = Log_Datos["2011-01-01 00:00:00":]

# Pasamos a utilizar el AutoArima  (No lo hace bien)
import pmdarima

ArimaModel = pmdarima.auto_arima(train, error_action='ignore', seasonal=True, m=12)

ArimaModel.summary()

# Sacamos las predicciones del modelo.
test["Predicciones"] = Predicciones = ArimaModel.predict(len(test))


# Estas predicciones son logaritmos por lo que hay que invertir el proceso
test["Creditos_Personales"]  = np.exp(test["Creditos_Personales"])
test["Predicciones"]  = np.exp(test["Predicciones"])

# Graficamos los datos de test.
import matplotlib.pyplot as plt

plt.plot(test)


# Analizamos los residuos del modelo.
plt.plot(ArimaModel.resid())

# Comprobamos que los residuos iniciales son altos

# Analizamos el correlograma y el correlograma parcial de los errores
from statsmodels.graphics.tsaplots import plot_acf, plot_pacf


plot_acf(ArimaModel.resid())
plot_pacf(ArimaModel.resid())

ECM = (sum((test["Creditos_Personales"] - test["Predicciones"])**2))/len(test)
ECM
