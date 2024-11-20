rm(list=ls())
packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

packages <- c("e1071","caret","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

packages <- c("tibble","e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

##################
#Regresión lineal#
##################

rm(list=ls())
datos = read.csv("hormigon.csv")
acierto=c()
indice = createMultiFolds(datos$strength, k = 5, times = 1)
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  regresion = lm(strength ~ ., data=datostrain)
  prediccion = predict(regresion,datostst)
  #Calculamos el R cuadrado manualmente:
  resultado = 1-(sum((datostst[,9]-prediccion)^2)/sum((datostst[,9]-mean(datostst[,9]))^2))
  #O mediante la libreria caret:
  #resultado=postResample(obs=datostst[,9],pred=prediccion)["Rsquared"]
  
  acierto = rbind(acierto,c(resultado))
}
mean(acierto)
acierto
regresion = lm(strength~., data=datos)
summary(regresion)



#####################
#Árboles de decisión#
#####################

rm(list=ls())
datos = read.csv("hormigon.csv")
aciertoarbol=c()
indice = createMultiFolds(datos$strength, k = 5, times = 1)
for (vector in indice){
  datostrain = datos[vector,]
  datostst = datos[-vector,]
  arbol = rpart(strength ~ ., data = datostrain,
                maxdepth = 4)
  prediccion = predict(arbol,datostst)
  resultado = 1-(sum((datostst[,9]-prediccion)^2)/
                   sum((datostst[,9]-mean(datostst[,9]))^2))
  aciertoarbol = rbind(aciertoarbol,c(resultado))
}
aciertoarbol


aciertoarbol2=c()
indice = createMultiFolds(datos$strength, k = 5, times = 1)
i = 1
while (i <= 5){
  datostrain = datos[ indice[i],]
  datostst = datos[-indice[[i]],]
  #i = i+1
  arbol = rpart(strength ~ ., data = datostrain, maxdepth = 4)
  prediccion = predict(arbol,datostst)
  resultado = 1-(sum((datostst[,9]-prediccion)^2)/
                   sum((datostst[,9]-mean(datostst[,9]))^2))
  aciertoarbol2 = rbind(aciertoarbol2,c(resultado))
  i = i+1
} 
aciertoarbol2



# Graficamos 
prp(arbol, cex=.4, main="Arbol")
rpart.plot(arbol, cex=0.5, )

# Acierto
mean(aciertoarbol)

# Nodos terminales
length(unique(prediccion))
length(unique(datostst$strength))

# Error  
ver = cbind.data.frame(datostst$strength,prediccion)
ver$Error = ver$`datostst$strength`-ver$prediccion
mean(abs(ver$Error))
quantile(ver$Error,probs = c(0.05,0.95))
quantile(abs(ver$Error),probs = c(0.05,0.95))
hist(ver$Error,main = 'Histograma del error', xlab = 'Error' )
hist(abs(ver$Error),main = 'Histograma del error', xlab = 'Error' )
plot(ver$`datostst$strength`,ver$prediccion, xlab = 'Reealidad (strength)',
     ylab = 'Predicción (strength)')



###############
#Random Forest#
###############

# Parámetros:

# ·ntree:
# Number of trees to grow. This should not be set to too small a number, 
# to ensure that every input row gets predicted at least a few times.

# ·mtry:	
# Number of variables randomly sampled as candidates at each split.
# Note that the default values are different for classification
# (sqrt(p) where p is number of variables in x) and regression (p/3)

#El parámetro mtry controla el número de características (o variables) que se consideran 
#al momento de dividir un nodo en un árbol de decisión. Esto se hace aleatoriamente en cada árbol, 
#lo que es una de las características clave que diferencia a un Random Forest de un árbol de decisión 
#tradicional (que evalúa todas las características disponibles en cada división).

rm(list=ls())
datos = read.csv("hormigon.csv")
aciertoRF=c()
aciertoRFtrain=c()
indice = createMultiFolds(datos$strength, k = 5, times = 1)
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  modeloRF = randomForest(strength ~ ., data=datostrain,
                          ntree=1000, mtry=3)
  predicciontrain = predict(modeloRF,datostrain)
  prediccion = predict(modeloRF,datostst)
  resultado = 1-(sum((datostst[,9]-prediccion)^2)/sum((datostst[,9]-mean(datostst[,9]))^2))
  resultadotrain = 1-(sum((datostrain[,9]-predicciontrain)^2)/sum((datostrain[,9]-mean(datostrain[,9]))^2))
  aciertoRF = rbind(aciertoRF,c(resultado))
  aciertoRFtrain = rbind(aciertoRFtrain,c(resultadotrain))
}

# Acierto
aciertoRF
mean(aciertoRF)
mean(aciertoRFtrain)
aciertototal = cbind(aciertoRF,aciertoRFtrain)
aciertototal

# Error
ver = cbind.data.frame(datostst$strength, prediccion)
ver$Error = ver$`datostst$strength`-ver$prediccion
mean(abs(ver$Error))
quantile(ver$Error,probs = c(0.05,0.95))
quantile(abs(ver$Error),probs = c(0.05,0.95))

# Importancia de variables 
importanciarf = as.data.frame(importance(modeloRF))
importanciarf

# Nodos terminales 
length(unique(prediccion))
length(unique(datostst$strength))

plot(ver$`datostst$strength`,ver$prediccion)



#########
#XGBoost#
#########

rm(list=ls())
datos = read.csv("hormigon.csv")
aciertoXGBoost = c()
indice = createMultiFolds(datos$strength, k = 5, times = 1)

for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  train_y=datostrain[,9]
  train_x=datostrain[,-9]
  test_x=datostst[,-9]
  test_y=datostst[,9]
  
  dtrain <- xgb.DMatrix(as.matrix(train_x),label = train_y)
  dtest <- xgb.DMatrix(as.matrix(test_x))
  
  xgb_params <- list(colsample_bytree = 1, #how many variables to consider for each tree
                     subsample = 1, #how much of the data to use for each tree
                     booster = "gbtree",
                     max_depth = 9, #how many levels in the tree
                     min_child_weight=1.5,
                     reg_alpha=0.8,
                     reg_lambda=0.6,
                     seed=42,
                     eta = 0.03, #shrinkage rate to control overfitting through conservative approach
                     eval_metric = "rmse", 
                     objective = "reg:squarederror",
                     gamma = 0)
  
  gb_dt <- xgb.train(xgb_params,dtrain,nfold = 12,nrounds = 1000)
  prediccionxgb <- predict(gb_dt,dtest)
  resultado=1-(sum((datostst[,9]-prediccionxgb)^2)/sum((datostst[,9]-mean(datostst[,9]))^2))
  aciertoXGBoost = rbind(aciertoXGBoost,c(resultado))
}

# Acierto
aciertoXGBoost
mean(aciertoXGBoost)

# Importancia de las variables 
imp_matrix <- as.tibble(xgb.importance(feature_names = colnames(test_x), model = gb_dt))

# Nodos terminales 
length(unique(prediccionxgb))
length(unique(datostst$strength))

# Error
ver = cbind.data.frame(datostst$strength,prediccionxgb)
ver$Error = ver$`datostst$strength`-ver$prediccionxgb
mean(abs(ver$Error))
quantile(ver$Error,probs = c(0.05,0.95))
plot(ver$`datostst$strength`,ver$prediccion)


'ce' %in% colnames(datos)
library(stringr)
str_detect('cement',colnames(datos))
v =grepl('ce',colnames(datos))
colname(datos)colnames(datos)[v]

which(v)






