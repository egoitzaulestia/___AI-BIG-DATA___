# Regresión Logística
# En un estudio realizado para comparar las características físicas entre hombres y mujeres, 
# se seleccionaron al azar 200 personas con una edad comprendida entre 20 y 40 años 
# y en las que se recogieron los siguientes datos:

# - NIF: Número de identificación fiscal
# - sexo: 0 = hombre; 1 = mujer
# - edad: edad en años
# - estatura: estatura en centímetros
# - calorias: consumo medio diario de calorías
# - tiempo: tempo en minutos dedicados a la actividad física por semana
# - peso: peso en kilogramos

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


# PASO 1
# Cargar datos
# Tenemos que hayar las variables categóricas y pasarlas a números


packages <- c("class","SDMTools","ggplot2","reshape2","clusterSim")
new <- packages[!(packages %in% installed.packages()[,"Package"])]
if(length(new)) install.packages(new)
a=lapply(packages, require, character.only=TRUE)

rm(list=ls())

datos = Peso1

datos$sexo2[datos$sexo== 0]=0
datos$sexo2[datos$sexo== 1]=1

datos$sexo2 = as.factor(datos$sexo)
datos$sexo=NULL
datos$NIF=NULL
aciertolog=c()
indice = createMultiFolds(datos$sexo, k = 5, times = 1) # Cogemos nuestra variable a elegir
for (i in 1:length(indice)){
  datostrain = datos[ indice[[i]],]
  datostst = datos[-indice[[i]],]
  regresionlog = glm(sexo2~., data=datostrain,family=binomial)
  prediccionlog <- predict(regresionlog,datostst,type = "response")
  datostst$prediccionlog=0
  datostst$prediccionlog[prediccionlog>0.5]=1
  datostst$prediccionlog=as.factor(datostst$prediccionlog)
  resultadoslog=cbind.data.frame(datostst$sexo2,datostst$prediccionlog,prediccionlog)
  #confusionMatrix(datostst$prediccionlog, datostst$Churn2)
  resultado  = confusionMatrix(datostst$prediccionlog, datostst$sexo2)$overall[1]
  aciertolog = rbind(aciertolog,c(resultado))
  
}

regresionlog
summary(regresionlog)
confusionMatrix(datostst$prediccionlog, datostst$sexo2) 
aciertolog # Nos devuelve los 5 accuracies de cada fold de la VALIDACIÓN CRUZADA
mean(aciertolog)

table(datos$Churn2)
sum((datos$Churn2=="0"))/nrow(datos)
