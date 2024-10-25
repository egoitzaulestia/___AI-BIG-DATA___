rm(list=ls())


#1. Creamos la tabla de datos
datos = data.frame(meses = c(0:4), cm = c(50,66.5,75,81,86.5))


#2. Visualizar datos 
library(ggplot2)
ggplot(datos) + 
  geom_point(aes(x = meses, y = cm),
             colour = "red", size = 1) +
  ggtitle("Diagrama de dispersión") +
  xlab("Meses") +
  ylab("Centímetros")

ggplot() + 
  geom_point(aes(x = datos$meses, y = datos$cm),
             colour = "red", size = 1) +
  ggtitle("Diagrama de dispersión") +
  xlab("Meses") +
  ylab("Centímetros")
  

#3. Division de datos en train/test 
library(caTools)
split = sample.split(datos$cm, SplitRatio = 0.8)
train = subset(datos,  split == TRUE)
test = subset(datos,  split == FALSE)
#test = data.frame(meses = c(3), cm = c(81))

#4. Ajustar el modelo con el conjunto de entreamiento
reg_lin = lm(formula = cm ~ meses, data = train)


#5. Resumen estadistico (summary) para obtener info sobre el modelo
resumen=summary(reg_lin)
summary(reg_lin)$r.square


#6. Predecir resultados con el conjunto de test 
y_pred = predict(reg_lin, newdata = test)


#7. Comparacion de los datos reales y las predicciones:
resultados = cbind(test[2],y_pred)
resultados
abs = data.frame(abs(resultados[1]-resultados[2]))
abs
pro = 100*abs/test[2]
resultados = cbind(resultados,abs,pro)
colnames(resultados) <- c('cm','Predicción','Error (abs)','Error (prctj)')



#8. Visualizacion de los resultados 
coeficientes = summary(reg_lin)[["coefficients"]][,1]

library(ggplot2)
ggplot() + 
  geom_point(aes(x = datos$meses, y = datos$cm), 
             colour = "red")+ 
  geom_abline(slope = coeficientes[2], intercept = coeficientes[1],
              col='blue')







