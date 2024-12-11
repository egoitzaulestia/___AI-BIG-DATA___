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




#################
# Random Forest #
#################

packages <- c("tibble","e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

rm(list=ls())

# Importamos datos Ventas.RData
load("Ventas.RData")
datos = datos

# Preparación de datos
datos$ventas_altas2[datos$ventas_altas=="Si"] = 1
datos$ventas_altas2[datos$ventas_altas=="No"] = 0
datos$ventas_altas = NULL
datos$ventas_altas2 = as.factor(datos$ventas_altas2)

datos$US2[datos$US=="Yes"] = 1
datos$US2[datos$US=="No"] = 0
datos$US = NULL

datos$Urban2 = as.numeric(datos$Urban == "Yes")
datos$Urban = NULL

# Convertir ShelveLoc en una variable ordinal y luego a numérico
datos$ShelveLoc <- factor(datos$ShelveLoc, levels = c("Bad", "Medium", "Good"), ordered = TRUE)
datos$ShelveLoc <- as.numeric(datos$ShelveLoc)

# Escalamos los datos
datos[, c(1,2,3,4,5,6,7,8,10,11)] = scale(datos[, c(1,2,3,4,5,6,7,8,10,11)])


pram = expand.grid(egoitz=1:3, imanol=2:6)


datos = read.csv("churn.csv")
datos$Churn=as.factor(datos$Churn)
datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL
aciertoRF=c()

indice = createMultiFolds(datos$Churn, k = 5, times = 1)
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  modeloRF  = randomForest(Churn~., data=datostrain, ntree=3000,mtry=8,replace = TRUE, strata = TRUE, nodesize = 1, maxnodes = 50, importance = TRUE, localImp = FALSE, proximity = FALSE, oob.prox = FALSE, norm.votes = TRUE)
  prediccionRF   = predict(modeloRF, datostst, type="class")
  probabilidadRF = predict(modeloRF, datostst, type="prob")
  resultado = confusionMatrix(prediccionRF, datostst$Churn)$overall[[1]]
  aciertoRF = rbind(aciertoRF,c(resultado))
}

aciertoRF
confusionMatrix(prediccionRF, datostst$Churn)
importanciaclasicrf=as.data.frame(importance(modeloRF))
