# Antes de hacer nada cargamos las librerias que vamos a necesitar

packages <- c("e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)


# El siguiente punto es limpiar el directorio de trabajo

rm(list=ls())

# Cargamos los datos.

datos = read.csv("churn.csv",stringsAsFactors = TRUE)

# Realizamos un resumen estadistico de los datos

summary(datos)

# Eliminamos las variables que no nos interesan.

datos$Phone = NULL
datos$State = NULL
datos$Area.Code = NULL

#Transformamos la variable objetivo en 0 y 1 (fuga)

datos$Churn2[datos$Churn=="False."]=0
datos$Churn2[datos$Churn=="True."]=1
datos$Churn=NULL
datos$Churn2=as.factor(datos$Churn2)
colnames(datos)[18]="Churn"

# Convertimos en numericas aquellas variables categoricas.
# Utlilizamos una forma mas rapida.

datos$Int.l.Plan=as.numeric(datos$Int.l.Plan=="yes")
datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")

# Establecemos una semilla para poder replicar el modelo

set.seed(123456)

# Separamos los datos en train y test.
# train para entrenar el modelo.
# test para evaluar los resultados obtenidos.

indice = createDataPartition(datos$Churn, p = 0.75, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]

# Realizamos un modelo simple.
# En este caso un arbol de decision.

tree = rpart(Churn ~ ., data = datostra,minsplit=10,maxdepth=2,cp=0)

# Realizamos la prediccion para los datos de test.

prediccion=predict(tree, datostst, type = "class")

# Evaluamos los resultados obtenidos.
# Primero realizamos la matriz de confusion.

matrixArbol = confusionMatrix(prediccion, datostst$Churn)
matrixArbol

# Analizamos numericamente los resultados.

ac_basicoArbol = matrixArbol$overall
ac_basicoArbol
ac_basicoArbol[1]


################
#BAGGING CASERO#
################

# Pasamos a realizar un modelo de bagging casero.
# Para entrenar cada uno de los modelos usamos una parte de los datos.
# Con cada modelo realizamos una prediccion sobre los datos de test.
# Establecemos un sistema de votacion para determinar el resultado final.

# Los grupos los podemos crear manualmente o de forma aleatoria.

# Primero lo realizamos manualmente.
# Creamos 5 grupos

datostra1=datostra[1:500,]
datostra2=datostra[501:1000,]
datostra3=datostra[1001:1500,]
datostra4=datostra[1501:2000,]
datostra5=datostra[2001:2501,]


# Entrenamos los 5 modelos.
# Cada uno con un grupo de datos.

tree1 = rpart(Churn ~ ., data = datostra1,minsplit=10,maxdepth=2,cp=0)
tree2 = rpart(Churn ~ ., data = datostra2,minsplit=10,maxdepth=2,cp=0)
tree3 = rpart(Churn ~ ., data = datostra3,minsplit=10,maxdepth=2,cp=0)
tree4 = rpart(Churn ~ ., data = datostra4,minsplit=10,maxdepth=2,cp=0)
tree5 = rpart(Churn ~ ., data = datostra5,minsplit=10,maxdepth=2,cp=0)


# Realizamos las 5 predicciones

prediccion1=predict(tree1, datostst, type = "class")
prediccion2=predict(tree2, datostst, type = "class")
prediccion3=predict(tree3, datostst, type = "class")
prediccion4=predict(tree4, datostst, type = "class")
prediccion5=predict(tree5, datostst, type = "class")


# Juntamos todas las predicciones en una misma tabla.

PrediccionFinal=cbind.data.frame(prediccion1,prediccion2,prediccion3,prediccion4,prediccion5)
colnames(PrediccionFinal)=c("Pred1","Pred2","Pred3","Pred4","Pred5")
PrediccionFinal

# Realizamos una suma de las predicciones.
PrediccionFinal=apply(PrediccionFinal,2,as.numeric)
PrediccionFinal=as.data.frame(PrediccionFinal)
PrediccionFinal$Suma=PrediccionFinal$Pred1+PrediccionFinal$Pred2+PrediccionFinal$Pred3+PrediccionFinal$Pred4+PrediccionFinal$Pred5


# Realizamos la prediccion final como una votacion de las predicciones individuales.
# Si 3 o mas modelos determinan que se fuga la respuesta es fuga.
# Si menos de tres modelos establecen que se fuga determinamos que NO se fuga.

PrediccionFinal$voto = 0
PrediccionFinal$voto[PrediccionFinal$Suma>2]=1

# Analizamos los resultados obtenidos.

PrediccionFinal$voto=as.factor(PrediccionFinal$voto)
matrixBagging1 = confusionMatrix(PrediccionFinal$voto, datostst$Churn)
matrixBagging1
ac_basicoBagging1 = matrixBagging1$overall

ac_basicoBagging1
ac_basicoBagging1[1]

# Lo comparamos con el acierto anterior
ac_basicoArbol[1]

####################################################################
# Pasamos a realizar una particion de los datos de train aleatoria.#
####################################################################

indices = createMultiFolds(datostra$Churn, k = 5, times = 1)

# Entrenamos cada modelo con una de las particiones.
# Graficamos cada uno de los modelos para comprender mejor que ocurre

datostra1   = datostra[-indices[[1]],]
modelo1     = rpart(Churn ~ ., data = datostra1,minsplit=10,maxdepth=2,cp=0)
rpart.plot(modelo1,cex=0.5);title("Arbol 1")

datostra2   = datostra[-indices[[2]],]
modelo2     = rpart(Churn ~ ., data = datostra2,minsplit=10,maxdepth=2,cp=0)
rpart.plot(modelo2,cex=0.5);title("Arbol 2")

datostra3   = datostra[-indices[[3]],]
modelo3     = rpart(Churn ~ ., data = datostra3,minsplit=10,maxdepth=2,cp=0)
rpart.plot(modelo3,cex=0.5);title("Arbol 3")

datostra4   = datostra[-indices[[4]],]
modelo4     = rpart(Churn ~ ., data = datostra4,minsplit=10,maxdepth=2,cp=0)
rpart.plot(modelo4,cex=0.5);title("Arbol 4")

datostra5   = datostra[-indices[[5]],]
modelo5     = rpart(Churn ~ ., data = datostra5,minsplit=10,maxdepth=2,cp=0)
rpart.plot(modelo5,cex=0.5);title("Arbol 5")


# Una vez que hemos realizado los 5 modelos realizamos la prediccion.

prediccion1=predict(modelo1, datostst, type = "class")
prediccion2=predict(modelo2, datostst, type = "class")
prediccion3=predict(modelo3, datostst, type = "class")
prediccion4=predict(modelo4, datostst, type = "class")
prediccion5=predict(modelo5, datostst, type = "class")


# Juntamos todas las predicciones en una misma tabla.

PrediccionFinal=cbind.data.frame(prediccion1,prediccion2,prediccion3,prediccion4,prediccion5)
colnames(PrediccionFinal)=c("Pred1","Pred2","Pred3","Pred4","Pred5")


# Realizamos una suma de las predicciones.
PrediccionFinal=apply(PrediccionFinal,2,as.numeric)
PrediccionFinal=as.data.frame(PrediccionFinal)
PrediccionFinal$Suma=PrediccionFinal$Pred1+PrediccionFinal$Pred2+PrediccionFinal$Pred3+PrediccionFinal$Pred4+PrediccionFinal$Pred5



# Realizamos la prediccion final como una votacion de las predicciones individuales.
# Si 3 o mas modelos determinan que se fuga la respuesta es fuga.
# Si menos de tres modelos establecen que se fuga determinamos que NO se fuga.

PrediccionFinal$voto = 0
PrediccionFinal$voto[PrediccionFinal$Suma>2]=1

# Analizamos los resultados obtenidos.

PrediccionFinal$voto=as.factor(PrediccionFinal$voto)
matrixBagging2 = confusionMatrix(PrediccionFinal$voto, datostst$Churn)
matrixBagging2

ac_basicoBagging2 = matrixBagging2$overall
ac_basicoBagging2
ac_basicoBagging2[1]


# Lo comparamos con el acierto anterior
ac_basicoBagging1[1]
ac_basicoArbol[1]


###############################
#Realizamos un BOOSTING casero#
###############################

# Los modelos de Boosting son modelos "consecutivos".
# Cada modelo aprende de los errores del modelo anterior.
# La "forma de aprender" es darle un mayor peso a las observaciones en la que el modelo anterior a fallado.
# Una vez creados los modelos se realizan las predicciones para los datos de train.
# Esto es necesario para ajustar los pesos.
# El siguiente paso es realizar las predicciones para test.
# Tras ello hay que crear un sistema de votacion para determinar la respuesta del modelo.
# En este caso entrenamos cada modelo, lo visualizamos y realizamos la prediccion.

pesos1         = matrix(1,nrow(datostra),1)
modelo1        = rpart(Churn ~ ., data = datostra,minsplit=10,maxdepth=2,cp=0,weights = pesos1)
rpart.plot(modelo1,cex=0.5);title("Arbol 1")
predicciontra1 = predict(modelo1, datostra, type = "class")
fallos1        = predicciontra1!=datostra$Churn
table(fallos1)

pesos2         = pesos1 + as.numeric(fallos1)*2
modelo2        = rpart(Churn ~ ., data = datostra,minsplit=10,maxdepth=2,cp=0,weights = pesos2)
rpart.plot(modelo2,cex=0.5);title("Arbol 2")
predicciontra2 = predict(modelo2, datostra, type = "class")
fallos2        = predicciontra2!=datostra$Churn
table(fallos2)

pesos3         = pesos2 + as.numeric(fallos2)*2
modelo3        = rpart(Churn ~ ., data = datostra,minsplit=10,maxdepth=2,cp=0,weights = pesos3)
rpart.plot(modelo3,cex=0.5);title("Arbol 3")
predicciontra3 = predict(modelo3, datostra, type = "class")
fallos3        = predicciontra3!=datostra$Churn
table(fallos3)

pesos4         = pesos3 + as.numeric(fallos3)*2
modelo4        = rpart(Churn ~ ., data = datostra,minsplit=10,maxdepth=2,cp=0,weights = pesos4)
rpart.plot(modelo4,cex=0.5);title("Arbol 4")
predicciontra4 = predict(modelo4, datostra, type = "class")
fallos4        = predicciontra4!=datostra$Churn
table(fallos4)

pesos5         = pesos4 + as.numeric(fallos4)*2
modelo5        = rpart(Churn ~ ., data = datostra,minsplit=10,maxdepth=2,cp=0,weights = pesos5)
rpart.plot(modelo5,cex=0.5);title("Arbol 5")
predicciontra5 = predict(modelo5, datostra, type = "class")
fallos5        = predicciontra5!=datostra$Churn
table(fallos5)


# Podriamos seguir hasta el infinito.
# Cuantos mas modelos realicemos mayor riesgo de overfiting.

# Realizamos las predicciones para los datos de test.

prediccion1 = predict(modelo1, datostst, type = "class")
prediccion2 = predict(modelo2, datostst, type = "class")
prediccion3 = predict(modelo3, datostst, type = "class")
prediccion4 = predict(modelo4, datostst, type = "class")
prediccion5 = predict(modelo5, datostst, type = "class")


# Una vez realizado esto establecemos un sistema de votacion.
# Esto es algo similar a lo realizado en los modelos anteriores.

PrediccionFinal=cbind.data.frame(prediccion1,prediccion2,prediccion3,prediccion4,prediccion5)
colnames(PrediccionFinal)=c("Pred1","Pred2","Pred3","Pred4","Pred5")

PrediccionFinal=apply(PrediccionFinal,2,as.numeric)
PrediccionFinal=as.data.frame(PrediccionFinal)

# Realizamos una suma de las predicciones.

PrediccionFinal$Suma=PrediccionFinal$Pred1+PrediccionFinal$Pred2+PrediccionFinal$Pred3+PrediccionFinal$Pred4+PrediccionFinal$Pred5



# Realizamos la prediccion final como una votacion de las predicciones individuales.
# Si 3 o mas modelos determinan que se fuga la respuesta es fuga.
# Si menos de tres modelos establecen que se fuga determinamos que NO se fuga.

PrediccionFinal$voto = 0
PrediccionFinal$voto[PrediccionFinal$Suma>2]=1


# Analizamos los resultados.
PrediccionFinal$voto=as.factor(PrediccionFinal$voto)
matrixBoosting = confusionMatrix(PrediccionFinal$voto, datostst$Churn)
matrixBoosting

ac_basicoBoosting = matrixBoosting$overall
ac_basicoBoosting
ac_basicoBoosting[1]

# Lo comparamos con el acierto anterior

ac_basicoBagging2[1]
ac_basicoBagging1[1]
ac_basicoArbol[1]
