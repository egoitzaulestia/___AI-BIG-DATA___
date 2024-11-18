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

######
#C5.0#
######



packages <- c("tibble","e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())
datos = read.csv("churn.csv",stringsAsFactors = TRUE)
datos$Churn=as.factor(datos$Churn)
datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL
datos$Int.l.Plan=as.numeric(datos$Int.l.Plan=="yes")
datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")

aciertoc50=c()

indice = createMultiFolds(datos$Churn, k = 5, times = 1)
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  modeloc50       = C5.0(datostrain[,-17],datostrain[,17],trials=50)
  prediccionc50   = predict(modeloc50, datostst, type="class")
  probabilidadc50 = predict(modeloc50, datostst, type="prob")
  resultado = confusionMatrix(prediccionc50, datostst$Churn)$overall[[1]]
  aciertoc50 = rbind(aciertoc50,c(resultado))
}

aciertoc50
importanciac50=as.data.frame(C5imp(modeloc50))
confusionMatrix(prediccionc50, datostst$Churn)


###########################
#C5.0 con matriz de costes#
###########################

packages <- c("tibble","e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())
datos = read.csv("churn.csv",stringsAsFactors = TRUE)
datos$Churn=as.factor(datos$Churn)
datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL
datos$Int.l.Plan=as.numeric(datos$Int.l.Plan=="yes")
datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")

aciertoc50=c()
costes = matrix(c(0,6,1,0),nrow=2)

#indice = createMultiFolds(datos$Churn, k = 5, times = 1)
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  modeloc50       = C5.0(datostrain[,-17],datostrain[,17],trials=50, cost=costes)
  prediccionc50   = predict(modeloc50, datostst, type="class")
  resultado = confusionMatrix(prediccionc50, datostst$Churn)$overall[[1]]
  aciertoc50 = rbind(aciertoc50,c(resultado))
}

aciertoc50
importanciac50=as.data.frame(C5imp(modeloc50))
confusionMatrix(prediccionc50, datostst$Churn)



###############
#Random Forest#
###############

packages <- c("tibble","e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())
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



#########
#xgboost#
#########

packages <- c("tibble","e1071","rpart","rpart.plot","class","SDMTools","ggplot2","reshape2","clusterSim","caret","C50","randomForest","xgboost")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

datos = read.csv("churn.csv",stringsAsFactors = TRUE)
datos$Churn2[datos$Churn=="False."]=0
datos$Churn2[datos$Churn=="True."]=1
datos$Churn=NULL


datos$Int.l.Plan2[datos$Int.l.Plan=="no"]=0
datos$Int.l.Plan2[datos$Int.l.Plan=="yes"]=1
datos$Int.l.Plan=NULL

datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")

datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL


indice = createMultiFolds(datos$Churn2, k = 5, times = 1)
aciertoxgboost=c()
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  train_y=datostrain[,16]
  train_x=datostrain[,-16]
  test_x=datostst[,-16]
  test_y=datostst[,16]
  
  dtrain <- xgb.DMatrix(as.matrix(train_x),label = train_y)
  dtest <- xgb.DMatrix(as.matrix(test_x))
  
  xgb_params <- list(booster = "gbtree",
                     silent = 0,
                     nthread = 1,
                     eta=  0.3,
                     gamma = 0,
                     max_depth = 9,
                     min_child_weight = 1,
                     max_delta_step = 0,
                     subsample = 1,
                     colsample_bytree = 1,
                     colsample_bylevel = 1,
                     reg_lambda = 1,
                     reg_alpha = 0,
                     tree_method = "auto",
                     sketch_eps = 0.03,
                     scale_pos_weight = 1,
                     updater = "grow_colmaker",
                     refresh_leaf = 1,
                     process_type = "default",
                     grow_policy = "depthwise",
                     max_leaves = 0,
                     max_bin = 256,
                     predictor = "cpu_predictor",
                     objective = "reg:logistic",
                     base_score = 0.5,
                     eval_metric = "error")
  
  gb_dt <- xgb.train(xgb_params,dtrain,nfold=8,nrounds = 3000)
  prediccionxgb <- predict(gb_dt,dtest)
  datostst$prediccionxgb=0
  datostst$prediccionxgb[prediccionxgb>0.5]=1
  resultadosxgb=cbind.data.frame(datostst$Churn2,datostst$prediccionxgb,prediccionxgb)
  datostst$Churn2=as.factor(datostst$Churn2)
  datostst$prediccionxgb=as.factor(datostst$prediccionxgb)
  resultado   = confusionMatrix(datostst$prediccionxgb, datostst$Churn2)$overall[1]
  aciertoxgboost = rbind(aciertoxgboost,c(resultado))
}
aciertoxgboost
confusionMatrix(datostst$prediccionxgb, datostst$Churn2)
imp_matrix = as.tibble(xgb.importance(feature_names = colnames(train_x), model = gb_dt))


save(gb_dt, file = "my_model1.rda")


##################
#Redes neuronales#
##################

packages <- c("ggplot2","caret","neuralnet","NeuralNetTools")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)
library(nnet)

rm(list=ls())

datos = read.csv("churn.csv",stringsAsFactors = TRUE)
datosa = read.csv("churn.csv",stringsAsFactors = TRUE)

datos$State=NULL
datos$Area.Code=NULL
datos$Phone=NULL
datos$Account.Length=NULL
datos$Int.l.Plan=as.numeric(datos$Int.l.Plan=="yes")
datos$VMail.Plan=as.numeric(datos$VMail.Plan=="yes")


label = class.ind(datos$Churn)
library(clusterSim)
minimos = as.numeric(apply(datos[,-17],2,min))
maximos = as.numeric(apply(datos[,-17],2,max))
datos = data.Normalization(datos[,-17],type = "n4",normalization="column")
datos=cbind(datos,datosa$Churn)
colnames(datos)[17]= "Churn"



indice = createDataPartition(datos$Churn, p = 0.8, times = 1, list=FALSE)
datostra = datos[ indice,]
labeltra = label[ indice,]
datostst = datos[-indice,]
labeltst = label[-indice,]
datos$Churn=NULL
datostra$Churn = NULL
datostst$Churn = NULL


formula=paste(paste(colnames(label),collapse=" + "),' ~ ',paste(colnames(datos),collapse=" + "))
set.seed(12345)
modelo = neuralnet(formula, data=cbind(datostra,labeltra), hidden=c(10,9),linear.output = FALSE,lifesign="full",stepmax=20000,rep=7,algorithm = "rprop+",threshold = 0.05)
prediccion = compute(modelo,datostst)
prediccion$net.result


prediccion=as.data.frame(prediccion)
labeltst=as.data.frame(labeltst)
labeltst$respuesta=0
labeltst$respuesta[prediccion$net.result.1<0.5]=1
labeltst=as.data.frame(labeltst)
labeltst$respuesta=as.factor(labeltst$respuesta)
labeltst$True.=as.factor(labeltst$True.)
resultado = confusionMatrix(labeltst$respuesta, labeltst$True.)$overall[[1]]

summary(labeltst$True.)
summary(labeltst$respuesta)
confusionMatrix(labeltst$respuesta, labeltst$True.)