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



#####################
#Regresion Logistica#
#####################

packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

# Tenemos que hayar las variables categóricas y pasarlas a números
datos = read.csv("churn.csv",stringsAsFactors = TRUE)
datos$Churn2[datos$Churn=="False."]=0
datos$Churn2[datos$Churn=="True."]=1
datos$Churn=NULL
datos$Churn2=as.factor(datos$Churn2)

datos$Int.l.Plan2[datos$Int.l.Plan=="no"]=0
datos$Int.l.Plan2[datos$Int.l.Plan=="yes"]=1
datos$Int.l.Plan=NULL

datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")


datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL

# ###########################

cor(datos)
correlaciones = cor(datos[2:15])
correlaciones
hc = caret::findCorrelation(correlaciones, cutoff = .90)
hc
datos2 = datos[,-c(hc[1:length(hc)])]

VMail.Plan
Intl.Calls
CustServ.Calls
Int.l.Plan2

datosFinal1 = datos[, -c(2:12)]
library(dplyr)
datosFinal1 <- datosFinal1 %>% select(-Intl.Charge)

# ###########################

aciertolog=c()
indice = createMultiFolds(datosFinal1$Churn2, k = 5, times = 1) # Cogemos nuestra variable a elegir
for (i in 1:length(indice)){
  datostrain = datosFinal1[ indice[[i]],]
  datostst = datosFinal1[-indice[[i]],]
  regresionlog = glm(Churn2~., data=datostrain,family=binomial)
  prediccionlog <- predict(regresionlog,datostst,type = "response")
  datostst$prediccionlog=0
  datostst$prediccionlog[prediccionlog>0.5]=1
  datostst$prediccionlog=as.factor(datostst$prediccionlog)
  resultadoslog=cbind.data.frame(datostst$Churn2,datostst$prediccionlog,prediccionlog)
  #confusionMatrix(datostst$prediccionlog, datostst$Churn2)
  resultado   = confusionMatrix(datostst$prediccionlog, datostst$Churn2)$overall[1]
  aciertolog = rbind(aciertolog,c(resultado))
  
}

regresionlog
summary(regresionlog)
confusionMatrix(datostst$prediccionlog, datostst$Churn) 
aciertolog # Nos devuelve los 5 accuracies de cada fold de la VALIDACIÓN CRUZADA
mean(aciertolog)

table(datos$Churn2)
sum((datos$Churn2=="0"))/nrow(datos)



#################
#K-vecinos o KNN#
#################

packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

datos = read.csv("churn.csv",stringsAsFactors = FALSE)
datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL
datos$Int.l.Plan=as.numeric(datos$Int.l.Plan=="yes")
datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")

# Separamos los datos de la clase
label = datos[,17]
datos = datos[,-17]

# Primero, vamos a hacer una particion 80-20
indice = createDataPartition(label, p = 0.8, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]
labeltra = label[ indice]
labeltst = label[-indice]
labeltst=as.data.frame(labeltst)
colnames(labeltst)="Churn"
labeltst$Churn=as.factor(labeltst$Churn)

library(class)
prediccion=knn(datostra, datostst, labeltra, k = 5)
prediccion=as.factor(prediccion)
resultado = confusionMatrix(prediccion, labeltst$Churn)
resultado


# La funcion knn nos puede devolver tambien elementos en los que tiene duda (con un umbral)
prediccion=knn(datostra, datostst, labeltra, k = 10,l=7)
prediccion
resultado = confusionMatrix(prediccion,labeltst$Churn)
resultado

prediccion = as.character(prediccion)
prediccion[is.na(prediccion)]="DUDA"
matriz = table(prediccion, labeltst$Churn)
matriz

###################
#Arbol de decision#
###################


rm(list=ls())
datos = read.csv("churn.csv")
datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL
datos$Int.l.Plan=as.numeric(datos$Int.l.Plan=="yes")
datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")


library(caret)

set.seed(123456)
indice = createDataPartition(datos$Churn, p = 0.75, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]

library(rpart)
library(rpart.plot)
library(rattle)

tree = rpart(Churn ~ ., data = datostra,minsplit=1,maxdepth=3,cp=0)
out = predict(tree, datostst, type = "class")

testlabels = datostst$Churn

tab = table(out, testlabels) 
print(tab)

arbol_1 = sum(out==testlabels)/length(testlabels)

confusionMatrix(out,datostst$Churn)

prp(tree, cex=.5,main="Arbol")
rpart.plot(tree,cex=.5)

summary(tree)
tree


#############
#Naive-Bayes#
#############

packages <- c("e1071","caret","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

datos = read.csv("car.csv")

indice = createDataPartition(datos$evaluation, p = 0.8, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]

library(e1071)
modelo=naiveBayes(evaluation~.,datostra)
modelo
prediccion = predict(modelo, datostst, type="class")
resultado = confusionMatrix(prediccion, datostst$evaluation)
ac_basico = resultado$overall[1]
resultado


#Introducimos la correccion de Laplace

modelo=naiveBayes(evaluation~.,datostra,laplace = 1)
prediccion = predict(modelo, datostst, type="class")
resultado = confusionMatrix(prediccion, datostst$evaluation)
ac_laplace = resultado$overall[1]
resultado


#Volvemos a hacerlo con churn
rm(list=ls())
datos = read.csv("churn.csv",stringsAsFactors = TRUE)
datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL
datos$Int.l.Plan=as.numeric(datos$Int.l.Plan=="yes")
datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")


indice = createDataPartition(datos$Churn, p = 0.8, times = 1, list=FALSE)
datostra = datos[ indice,]
datostst = datos[-indice,]

modelo=naiveBayes(Churn~.,datostra,laplace = 1)
modelo
prediccion = predict(modelo, datostst, type="class")
resultado = confusionMatrix(prediccion, datostst$Churn)
ac_basico = resultado$overall[1]
resultado

