library(RcmdrMisc)
library(car)
library(pROC)
library(caret)
library(ggplot2)

load("E:/Algebra DVM/AlgebraLineal/7.RregresiónLinealSimple/clase/EE1.RData")

# ANTES DE APLICAR LA SIGUIENTE INFORMACIÓN, HACERLO MANUALMENTE INCORPORANDO VARIABLES Y COMPARANDO EL R CUADRADO AJUSTADO
# Y LOS P-VALORES (para ver si las variables independeitnes son estadísticamente significativas)

#UNA VEZ HECHO ESTO, USAMOS LOS MÉTODOS DE SELECCIÓN DE VARIABLES EN BASE A LOS CRITERIOS AIC Y BIC:
#primero analizamos regresiones lineales univariantes para ver cuales son  estadísticamente significativas individualmente
lineal1 <- lm(EE~superficie, data=EE1)
summary(lineal1)
#la variable superficie es estadísticamente significativa individualmente en el modelo (p-valor<0.01)
#tiene un impacto significativo en la variable dependiente EE.
lineal2 <- lm(EE~s.tabiques, data=EE1)
summary(lineal2) #la variable s.tabiques es estadisticamente significativa
lineal3 <- lm(EE~altura, data=EE1)
summary(lineal3) #la variable altura es estadisticamente significativa
lineal4 <- lm(EE~orientacion, data=EE1)
summary(lineal4) #la variable orientacion no es estadísticamente significativa (p-valores>0.01)(0.402, 0.285, 0.577)
lineal5 <- lm(EE~s.cristales, data=EE1)
summary(lineal5) #la variable s.cristales no es estadisticamente significativa (p-valor=0.775)
lineal6 <- lm(EE~g.aislamiento, data=EE1)
summary(lineal6) #la variable g.aislamiento es estadisticamente significativa
lineal7 <- lm(EE~n.personas, data=EE1)
summary(lineal7) #la variable n.personas es estadisticamente significativa
lineal8 <- lm(EE~edad, data=EE1)
summary(lineal8) #la variable edad no es estadisticamente significativa (p-valor=0.02)
lineal9 <- lm(EE~VPO, data=EE1)
summary(lineal9) #la variable VPO no es estadisticamente significativa (p-valor=0.903)

#creamos primero un modelo multivariable con todas aquellas variables significativas en el univariante además
#de aquellas con p-valor<0.25
reg_lin<-lm(EE~superficie+s.tabiques+altura+orientacion+s.cristales+g.aislamiento+n.personas+edad+VPO,data=EE1)
RegModel.1 <- lm(EE~superficie+s.tabiques+altura+g.aislamiento+n.personas+edad, data=EE1)
summary(RegModel.1)
summary(RegModel.1)$coefficients
stepwise(RegModel.1, direction="forward/backward", criterion="AIC")
stepwise(RegModel.1, direction="backward/forward", criterion="AIC")
stepwise(RegModel.1, direction="forward/backward", criterion="BIC")
stepwise(RegModel.1, direction="backward/forward", criterion="BIC")
#cogiendo solo las variables individualmente significativas, el proceso stepwise nos dice que el mejor modelo es
# EE ~ g.aislamiento + altura + s.tabiques
RegModel.2 <- lm(EE~g.aislamiento+altura+s.tabiques, data=EE1)
summary(RegModel.2) #los coeficientes de las tres variables son diferentes de cero (p-valores muy pequeños)
AIC(RegModel.2) #4236.315 (recordar que cuanto menos AIC mejor)
BIC(RegModel.2) #4259.534 (recordar que cuanto menor BIC mejor)

#ahora creamos un nuevo modelo con todas las variables disponibles en la base de datos
RegModel.3 <- lm(EE~superficie+s.tabiques+altura+orientacion+s.cristales+g.aislamiento+n.personas+edad+VPO, data=EE1)
summary(RegModel.3) 
stepwise(RegModel.3, direction="forward/backward", criterion="AIC")
stepwise(RegModel.3, direction="backward/forward", criterion="AIC")
s<-stepwise(RegModel.3, direction="forward/backward", criterion="AIC")
lm(EE~s)
stepwise(RegModel.3, direction="forward/backward", criterion="BIC")
stepwise(RegModel.3, direction="backward/forward", criterion="BIC")
#cogiendo todas las variables de la base de datos, el proceso stepwise nos dice que el mejor modelo es
# EE ~ g.aislamiento + altura + s.tabiques + s.cristales
RegModel.4 <- lm(EE~g.aislamiento+altura+s.tabiques+s.cristales, data=EE1)
summary(RegModel.4) #los coeficientes de las cuatro variables son diferentes de cero
AIC(RegModel.4) #4221.29
BIC(RegModel.4) #4249.152

#viendo los AIC y BIC, parece que es mejor modelo el Regmodel.4 respecto al Regmodel.2
#vamos a confirmar si la variable explicativa individualmente no significativa s.cristales es significativa en el multivariante
#mediante el test de la razón de verosimilitud
anova(RegModel.4,RegModel.2) #p-valor<0.01
#la variable s.cristales parece contribuir significativamente a la explicación de la variabilidad 
#en la variable dependiente EE

#nos quedamos con el modelo RegModel.4

