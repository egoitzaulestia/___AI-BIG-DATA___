# Importamos los datos

#%reset

import os
import pandas as pd
#os.chdir(r"C:\Users\borja\OneDrive\Documents\Formacion_Python\17-Modelos\Modelos_Regresion")
os.chdir(r"E:/dias 2-3 diciembre/17-Modelos/Modelos_Regresion")
data = pd.read_csv("hormigon.csv")

# El primer paso es conocer nuestros datos.
# Realizamos una primera visualizacion.
# EL objetivo es precedir la probabilidad de fuga de un cliente.

print(data)

# Visualizamos los 10 primero datos, de una manera mas comoda.
data.head(n=10)

# Realizamos un resumen estadistico de las variables.
a=data.describe()


# Comprobamos que no hay valores perdidos.
data.isnull().sum()


# Con esta funcion nos vemos si existen (TRUE) o no (FALSE) datos perdidos
data.isnull().any().any()



# Una vez que comprobamos que los datos son correctos pasamos a la modelizacion, utilizando tecnicas de machine learning.
# Cuando realizamos un modelo predictivo es necesario conocer la fiabilidad esperada con datos futuros.
# Para ello podemos hacer una particion y utilizar unos datos para entrenar el modelo (train) y otros para comprobar la fiabilidad (test).

# Modelo de regresion #



# Realizamos una particion simple de los datos.
# 800 datos para entrenar el modelo y 230 para comprobar su fiabilidad.


train_data = data[:800]
test_data = data[800:]


from sklearn import linear_model
import pandas as pd


# Separamos las vaariables explicativas y la variable a predecir en train

train_data_X = train_data.drop(['strength'], axis = 1)
train_data_y = train_data['strength']

# Separamos las vaariables explicativas y la variable a predecir en test

test_data_X = test_data.drop(['strength'], axis = 1)
test_data_y = test_data['strength']

# Creamos el modelo

regr = linear_model.LinearRegression()

# Entrenamos y evaluamos con los datos de train

regr.fit(train_data_X, train_data_y)
regr.score(train_data_X,train_data_y)


# Realizamos la prediccion
# Evaluamos en los datos de test.

prediccion = regr.predict(test_data_X)
regr.score(test_data_X,test_data_y)

regr.get_params(deep=True)
regr.coef_
regr.rank_
regr.singular_
regr.n_features_in_
regr.feature_names_in_

# Visualizamos el modelo para una mejor comprension.
# Para esto realizamos otra regresion

import statsmodels.api as sm
from statsmodels.sandbox.regression.predstd import wls_prediction_std

modelo=sm.OLS(train_data_y, train_data_X)
result=modelo.fit()
result.summary()


# Con Constante
train_data_X = sm.add_constant(train_data_X)
modelo=sm.OLS(train_data_y, train_data_X)
result=modelo.fit()
result.summary()


# Predicciones  
test_data_X = sm.add_constant(test_data_X)

result.predict(test_data_X)


#######################
##                   ##
## Arbol de decision ##
##                   ##
#######################

# En el anterior ejemplo hemos realizado una particion de los datos en "orden".
# Otra opcion es realizar una particion aleatoria.
# En este caso tendremos train y test separados aleatoriamente.


# El primer paso es eliminar todo lo creado en el modelo anterior para evitar problemas.
#%reset


# Volvemos a cargar los datos iniciales.

data = pd.read_csv("hormigon.csv")

# El siguiente paso es realizar la particion de forma aleatoria.
# Primero separamos la variable dependiente del resto.

y=data['strength']

# Importamos la funcion necesaria.
from sklearn.model_selection import train_test_split

# Realizamos la particion dejando un 75% para entrenar y un 25% de test.
X_train, X_test, y_train, y_test = train_test_split(data, y, test_size=0.2)

train_data_X = X_train.drop(['strength'], axis = 1)
train_data_y = X_train['strength']

test_data_X = X_test.drop(['strength'], axis = 1)
test_data_y = X_test['strength']


# Creamos el modelo.
# Importamos la libreria necesaria.

from sklearn.tree import DecisionTreeRegressor

# Definimos el modelo y el numero maximo de ramas del arbol.

arbol = DecisionTreeRegressor(criterion='squared_error', max_depth=8, max_features=None, max_leaf_nodes=None,min_impurity_decrease=0.0,min_samples_leaf=10, min_samples_split=2, min_weight_fraction_leaf=0.0, random_state=None, splitter='best')

# Entrenamos y evaluamos con los datos de train

arbol=arbol.fit(train_data_X, train_data_y)
arbol.score(train_data_X, train_data_y)

# Realizamos la prediccion
# Evaluamos en los datos de test.
# Lo evaluamos con el R-cuadrado

prediccionarbol = arbol.predict(test_data_X)
arbol.score(test_data_X, test_data_y)



###############################
# Random Forest #

# Hasta ahora hemos hecho una sola particion para realizar comprobaciones.
# Esto puede provocar que la fiabilidad del modelo se vea condicionada por la aleatoriedad en la particion.
# Por ello realizamos validacion cruzada ("Cross Validation").
# Esto implica realizar varias particiones y utilizar n-1 para train y la restante para test.ç
# HAciendo una media podemos tener un dato mas ajustado de la fiablididad esperada del modelo.

# Lo primero es borrar todo lo existente para evitar problemas.

data = pd.read_csv("hormigon.csv")

# Separamos la variable dependiente ("y") de las explicativas ("X").

y=data['strength']
X = data.drop(['strength'], axis = 1)

# Definimos el modelo con todos sus parametros

from sklearn.ensemble import RandomForestRegressor

RF= RandomForestRegressor(n_estimators=500, criterion='squared_error' ,max_features=8 ,max_depth=500, min_samples_split=5, min_samples_leaf=3, max_leaf_nodes=None,min_impurity_decrease=0, bootstrap=True, oob_score=True, n_jobs=1, random_state=None, verbose=0, warm_start=False)

clf = RF.fit(X,y)

# Analizamos la fiabilidad sobre los datos utilizados para crear el modelo.

RF.score(X,y)


# Procedemos a realizar validacion cruzada

from sklearn.model_selection import cross_val_score


scores = cross_val_score(RF, X, y, cv=10)
scores

print(scores.mean())

# El ultimo paso es determinar la importancia de cada una de las variables

importancias=pd.DataFrame(clf.feature_importances_)
importancias.index=(X.columns)
importancias



# XGBoost #

# En este caso tambien utilizamos validacion cruzada.

# Lo primero es borrar todo lo existente para evitar problemas.


# En este caso tambien utilizamos validacion cruzada.


# A continuacion volvemos a cargar los datos.

data = pd.read_csv("hormigon.csv")

# Separamos la variable dependiente ("y") de las explicativas ("X").

y=data['strength']
X = data.drop(['strength'], axis = 1)


# Transformamos los datos en una matriz "xgb" para poder realizar el modelo.

# Para instalar el xgboost:
# Abrir Anaconda Prompt
# Escribir: anaconda search -t conda xgboost
# Escribir: conda install -c mndrake xgboost

# Si la opcion anterior no funciona correctamente, existe la siguiente opcion:
# conda install -c anaconda py-xgboost
# Es normal que tarde un buen rato.

import xgboost as xgb
from sklearn.model_selection import cross_val_score

datos = xgb.DMatrix(X, label=y)

xgb_model = xgb.XGBRegressor(base_score=1, colsample_bylevel=0.8, colsample_bytree=0.8, gamma=0, learning_rate=0.1, max_delta_step=0, max_depth=3, min_child_weight=1, missing=1, n_estimators=200, objective='reg:linear', reg_alpha=0, reg_lambda=1, scale_pos_weight=1, seed=0, silent=True, subsample=1)
xgb_model

modeloxgb = xgb_model.fit(X,y)
modeloxgb

xgb_model.score(X,y)

scores = cross_val_score(xgb_model, X, y, cv=5)
scores
scores.mean()


from xgboost import plot_importance


#importancias=pd.DataFrame(modeloxgb.feature_importances_)
#importancias.index=(X.columns)


#import pandas as pd
#importacia=pd.concat(X.columns,importancias)

plot_importance(modeloxgb)




#######################################
# Analisis de Componentes Principales #
#######################################

data = pd.read_csv("hormigon.csv")

# Separamos la variable dependiente ("y") de las explicativas ("X").

y=data['strength']
X = data.drop(['strength'], axis = 1)


import numpy as np
from sklearn.decomposition import PCA

pca = PCA(n_components=4, svd_solver='full')
pca.fit(X,y) 

#Extraemos la variacion explicada por cada componente.
print(pca.explained_variance_ratio_) 

# Tambien podemos ver la suma total
sum(pca.explained_variance_ratio_)

# Tambien podemos mirar los numeros 
print(pca.singular_values_)

print(pca.feature_names_in_)
print(pca.n_components_)
pca.components_

# Otras opciones
pca = PCA(n_components=8, svd_solver='arpack')
pca.fit(X,y) 

#Extraemos la variacion explicada por cada componente.
print(pca.explained_variance_ratio_) 

# Tambien podemos ver la suma total
sum(pca.explained_variance_ratio_)

# Tambien podemos mirar los numeros 
print(pca.singular_values_)



pca = PCA(n_components=5, svd_solver='auto')
pca.fit(X,y) 

#Extraemos la variacion explicada por cada componente.
print(pca.explained_variance_ratio_) 

# Tambien podemos ver la suma total
sum(pca.explained_variance_ratio_)

# Tambien podemos mirar los numeros 
print(pca.singular_values_)


# Preprocesado y modelado
# ==============================================================================
# Preprocesado y modelado
# ==============================================================================
from sklearn.decomposition import PCA
from sklearn.pipeline import make_pipeline
from sklearn.preprocessing import StandardScaler
from sklearn.model_selection import KFold
from sklearn.model_selection import GridSearchCV
from sklearn.linear_model import LinearRegression
from sklearn.model_selection import train_test_split
from sklearn.metrics import mean_squared_error
from sklearn.preprocessing import scale
import multiprocessing
pipe_modelado = make_pipeline(StandardScaler(), PCA(n_components=9), LinearRegression())


pipe_modelado.fit(X=train_data_X, y=train_data_y)
predicciones = pipe_modelado.predict(X=test_data_X)
predicciones = predicciones.flatten()
predicciones
pipe_modelado.score(test_data_X,test_data_y)

pipe_modelado.get_params(deep=True)
pipe_modelado.named_steps["pca"].explained_variance_ratio_
pipe_modelado.named_steps["pca"].components_

pipe_modelado.feature_names_in_