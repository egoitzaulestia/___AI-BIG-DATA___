rm(list = ls())


library(readr)
#PLANTILLA GENERAL:

getwd()

# 1. Creamos la tabla de datos: data.frame()
datos = read.csv("Salary_Data.csv")

# 2. Visualizar datos: ggplot{ggplot2} / plot()
library(ggplot2)
ggplot(datos) + 
  geom_point(aes(x = YearsExperience, y = Salary),
             colour = "red", size = 1) +
  ggtitle("Diagrama de dispersión") +
  xlab("Meses") +
  ylab("Centímetros")


# 3. División de datos TRAIN/TEST:
#     Como tenemos muy pocos datos vamos a coger:
#       train -> todos los datos 
#       test -> una sola observación
#   3.1 sample.split{caTools}
#   3.2 createMultiFolds{caret}
library(caTools)
split = sample.split(datos$Salary, SplitRatio = 0.8)
train = subset(datos,  split == TRUE)
test = subset(datos,  split == FALSE)


# 4. Ajustar el modelo a los datos de TRAIN: lm(formula, data)
reg_lin = lm(formula = Salary ~ YearsExperience, data = train)

# Obtener resumen del modelo de regresión lineal
resumen=summary(reg_lin)
resumen

# Obtener el R cuadrado ajustado
r_squared = round(summary(reg_lin)$r.square, digits = 4)
r_squared

# Obtener el R cuadrado ajustado
adjusted_r_squared = round(summary(reg_lin)$adj.r.squared, digits = 4)
adjusted_r_squared

# 5. Predecir sobre los datos de TEST: predict(object, newdata)
y_pred = predict(reg_lin, newdata = test)
print(y_pred)


# 6. Evaluar modelo comparando los resultados de predicción y de TEST:
#    6.1 TABLA DE ERRORES ABSOLUTOS Y RELATIVOS
#    6.2 CALCULAR R-square: summary(nombre_modelo)$r.square

resultados = cbind(test[2],y_pred)
resultados
abs = data.frame(abs(resultados[1]-resultados[2]))
abs
pro = 100*abs/test[2]
resultados = cbind(resultados,abs,pro)
colnames(resultados) <- c('cm','Predicción','Error (abs)','Error (prctj)')


# 7. Representación gráfica del modelo y los datos: ggplot{ggplot2}
#  ggplot() + geom_point + geom_line() + ggtitle() + xlab() + ylab()

coeficientes = summary(reg_lin)[["coefficients"]][,1]

library(ggplot2)
ggplot() + 
  geom_point(aes(x = datos$YearsExperience, y = datos$Salary), 
             colour = "red")+ 
  geom_abline(slope = coeficientes[2], intercept = coeficientes[1],
              col='blue')
