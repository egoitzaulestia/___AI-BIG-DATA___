# Clusterizacion

import os
import pandas as pd
os.chdir(r"E:\dias 2-3 diciembre\17-Modelos\NoSupervisados")
data = pd.read_csv("wholesale.csv")



# El primer paso es normalizar los datos.

from sklearn import preprocessing
datosNorm1=preprocessing.scale(data)
datosNorm1=pd.DataFrame(datosNorm1)
datosNorm1.columns=data.columns

from sklearn.preprocessing import StandardScaler
scaler = StandardScaler()
scaler.fit(data)
datosNorm=scaler.transform(data)
datosNorm =pd.DataFrame(datosNorm)

# Eliminamos las variables que no interesan

datosNorm1 = datosNorm1.drop(['Channel'], axis = 1)
datosNorm1 = datosNorm1.drop(['Region'], axis = 1)
  

from sklearn.cluster import KMeans

KNN = KMeans(algorithm='lloyd', copy_x=True, init='k-means++', max_iter=300,n_clusters=4, n_init=10,random_state=None, tol=0.0001, verbose=0)

KNN.fit(datosNorm1)

centros = KNN.cluster_centers_
centros=pd.DataFrame(centros)
centros.columns=datosNorm1.columns

data["cluster"] = KNN.fit_predict(data)
datosNorm1["cluster"] = KNN.fit(datosNorm1)




# Reglas de asociacion.
 
 

data = [['Milk', 'Onion', 'Nutmeg', 'Kidney Beans', 'Eggs', 'Yogurt'], ['Dill', 'Onion', 'Nutmeg', 'Kidney Beans', 'Eggs', 'Yogurt'], ['Milk', 'Apple', 'Kidney Beans', 'Eggs'], ['Milk', 'Unicorn', 'Corn', 'Kidney Beans', 'Yogurt'], ['Corn', 'Onion', 'Onion', 'Kidney Beans', 'Ice cream', 'Eggs']]


import pandas as pd
from mlxtend.preprocessing import TransactionEncoder
from mlxtend.frequent_patterns import apriori

te = TransactionEncoder()
te_ary = te.fit(data).transform(data)

df = pd.DataFrame(te_ary, columns=te.columns_)
frequent_itemsets = apriori(df, min_support=0.6, use_colnames=True)

from mlxtend.frequent_patterns import association_rules

reglas = association_rules(frequent_itemsets, metric="confidence", min_threshold=0.7)














