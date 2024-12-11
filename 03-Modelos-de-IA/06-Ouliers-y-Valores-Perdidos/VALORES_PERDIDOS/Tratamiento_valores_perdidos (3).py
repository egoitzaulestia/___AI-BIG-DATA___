# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")


# Visualizar un numero determinado de filas
data.head(n=10)


# Resumen estadístico de variables numéricas 
data.describe()


# Una vez conocidos nuestros datos procedemos a analizar los valores perdidos tomar una decision sobre como proceder.

# Cantidad por cada variable 
v_perdidos = data.isnull().sum()
v_perdidos
v_perdidos.sum()

# Porcentaje por cada variable (siempre es más representativo)
data.isnull().sum()/len(data.index)

# Valores perdidos por fila 
data.isnull().sum(axis=1)
max(data.isnull().sum(axis=1))

# Selección filas con una condición  
data = data.loc[data.isnull().sum(axis = 1) < len(data.columns)/2, :]




# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")


# Elimnamos las columnas que tengan más de un porcentaje de datos perdidos.
data.shape
data = data.loc[:, data.isnull().sum() < 0.1*data.shape[0]]
data.head(n=10)




# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")



# Borrar todas las filas que contengan algún valor perdido.
# Esta es la opción menos adecuada ya que supone una importante pérdida de infomación
datoscomp = data.dropna()
# Visualizamos 
datoscomp.head(n = 10)
# Comprobamos 
datoscomp.isnull().any().any()

# Si quisiéramos los datos no completos 
datosNoComp = data[data.isna().any(axis=1)]
datosNoComp.head(n = 10)





# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")

# La alternativa a eliminar los valores perdidos es imputarlos 

# Comprobamos si existen valores perdidos
data.isnull().any().any()

# El método de imputación mas sencillo es la media 
data.mean()
data = data.fillna(data.mean())

# Pocedemos a comprobar que ya no existen valores perdidos
data.isnull().any().any()




# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")


# Comprobamos que hay valores perdidos
data.isnull().any().any()


# Otra forma de imputar la MEDIA es la siguiente:
#   1. Seleccionar los datos numéricos y los no numéricos
#   2. Imputamos la media de los numéricos 
#   3. Unimos los dos conjuntos 

import pandas as pd
import numpy as np
import sklearn.preprocessing as sk
from sklearn.impute import SimpleImputer

datoNum = data.iloc[:,1:10]
fecha = data.iloc[:,0]
 
imp = SimpleImputer(missing_values=np.nan, strategy="mean", verbose=0, copy=False)
imp = imp.fit(datoNum)
imputed_data = imp.transform(datoNum.values)

datos_completos= pd.concat([fecha, datoNum], axis=1)

# Comprobamos 
datos_completos.isnull().any().any()




# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")


# Imputar la MEDIANA 
#   1. Seleccionar los datos numéricos y los no numéricos
#   2. Imputamos la mediana de los numéricos 
#   3. Unimos los dos conjuntos 

import pandas as pd
import numpy as np
import sklearn.preprocessing as sk
from sklearn.impute import SimpleImputer

datoNum=data.iloc[:,1:10]
fecha=data.iloc[:,0]

imp = SimpleImputer(missing_values=np.nan, strategy="median", verbose=0, copy=False)
imp = imp.fit(datoNum)
imputed_data = imp.transform(datoNum.values)

datos_completos= pd.concat([fecha, datoNum], axis=1)

# Comprobamos 
datos_completos.isnull().any().any()





# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")


# Imputación por valores fijos: moda (valor mas frecuente)
# Esto se usa especialmete para variables categóricas.

import pandas as pd
import numpy as np
import sklearn.preprocessing as sk
from sklearn.impute import SimpleImputer


datoNum = data.iloc[:,1:10]
fecha = data.iloc[:,0]
imp = SimpleImputer(missing_values=np.nan, strategy="most_frequent", verbose=0, copy=False)
imp = imp.fit(datoNum)
imputed_data = imp.transform(datoNum.values)

datos_completos= pd.concat([fecha, datoNum], axis=1)
datos_completos

# Comprobamos 
datos_completos.isnull().any().any()




# Estos son las formas que existen para estimar los valores perdidos basándonos en valores estadísticos.
# En ocasiones es mas acertado utilizar otros métodos, especialmente si las variables están relacionadas entre sí.



# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")



# Al tratarse de una serie temporal se puede sustituir por el valor anterior de dicha serie
# Solo sustituye el valor siguiente, si faltan dos seguidos no lo imputa bien.

# 1. MÉTODO bfill: utiliza la siguiente observación válida para rellenar la anterior NaN
data1 = data.fillna(method = 'bfill')
data.head(n=5)
data1.head(n=5)

# Comprobamos 
data1.isnull().any().any()

# 2. MÉTODO ffill: propaga la última observación válida hacia adelante a la siguiente válida.
data2 = data.fillna(method = 'ffill')
data.head(n=5)
data2.head(n=5)

data2.isnull().any().any()





# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")


# Otre opcion es realizar una imputacion multiple.
# Este procedimiento es adecuado cuando las variables explicativas estan relacionadas entre si.

# Para este caso necesitamos saber el tipo de dato que hay en cada columna.
data.dtypes

# Previamente realizaremos una matriz de correlacion.
cor_matrix = data.corr()

# Se puede observar que existe cierta correlación entre las variables dependientes.
# Esto es un indicador de que puede ser adecuado utilizar métodos de imputación múltiple.

# Hasta ahora hemos separado las columnas manualmente porque estamos trabajando con pocos datos.
# Con grandes bases de datos es conveniente separar los datos en función de su tipología.
import pandas as pd
import numpy as np
datosNum = data.select_dtypes(include = [np.float])
fecha = data.select_dtypes(include = [np.object])

datosNum = pd.DataFrame(datosNum)
fecha = pd.DataFrame(fecha)

# MICE realiza una regresión múltiple sobre los datos de muestra y toma promedios de ellos

import fancyimpute 

from fancyimpute import IterativeImputer
# calling the  MICE class
mice_imputer = IterativeImputer()
# imputing the missing value with mice imputer
df = mice_imputer.fit_transform(datosNum)
df = pd.DataFrame(df)

datos_completos = pd.concat([fecha, df], axis=1)


datos_completos.columns = data.columns
datos_completos.index = data.index

datos_completos.isnull().any().any()







# Cargamos los datos
import os
import pandas as pd
os.chdir(r"C:\Users\iratxe\Desktop\DVM\DATA VALUE MANAGEMENT\python\PythonAvanzadoGipuzkoa2022-20230427T132306Z-001\PythonAvanzadoGipuzkoa2022\8- ValoresPerdidos\Teoria")
data = pd.read_csv("Ejemplo_1.csv")


import numpy as np

datoNum = data.select_dtypes(include=[float])
fecha = data.select_dtypes(include=[object])

datoNum = pd.DataFrame(datoNum)
fecha = pd.DataFrame(fecha)

# Para completar los valores que faltan, KNN encuentra los puntos de datos similares entre todas
# las características. Luego tomó el promedio de todos los puntos para completar los valores faltantes.

import fancyimpute 
from fancyimpute import KNN 

my_imputer =  KNN(k=3)
datoNumcomp = my_imputer.fit_transform(datoNum)

datoNumcomp = pd.DataFrame(datoNumcomp)

datos_completos = pd.concat([fecha, datoNumcomp], axis=1)

datos_completos.columns = data.columns
datos_completos.index = data.index

datos_completos.isnull().any().any()





