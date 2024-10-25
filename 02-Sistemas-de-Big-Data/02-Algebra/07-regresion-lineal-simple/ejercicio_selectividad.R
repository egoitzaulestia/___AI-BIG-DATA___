rm(list = ls())

# EJERCICIO:
############
# Construir un modelo de regresión lineal que permita predecir la nota de selectividad, 
# teniendo en cuenta el resto de variables (ciencias, lengua y matemáticas) y explicar 
# el significado del modelo. Primero construir un modelo teniendo en cuenta todos los datos, 
# y posteriormente, construir un modelo cogiendo como datos de entrenamiento el 80% de los datos, 
# y como test el restante 20%. Entregar los dos modelos.

library(readr)

#PLANTILLA GENERAL:

getwd()

# REGRESIÓN LINEAL MULTIPLE (CON TODOS LOS DATOS)
# 1. Creamos la tabla de datos: data.frame()
datos = N1.1

# 2. Visualizar datos: ggplot{ggplot2} / plot()
# No podemos graficarlo por que tenemos más de dos dimensiones a analizar

# 3. División de datos TRAIN/TEST:
#     Como tenemos muy pocos datos vamos a coger:
#       train -> todos los datos 
#       test -> una sola observación
#   3.1 sample.split{caTools}
#   3.2 createMultiFolds{caret}
library(caTools)
# split = sample.split(datos$Selectividad, SplitRatio = 0.8)
train = subset(datos) # metemos el 100% de los datos


# 4. Ajustar el modelo a los datos de TRAIN: lm(formula, data)
reg_lin = lm(formula = Selectividad ~ Ciencias+Lengua+Matematicas, data = train)

# Obtener resumen del modelo de regresión lineal
resumen=summary(reg_lin)
resumen

# Obtener el R cuadrado ajustado
r_squared = round(summary(reg_lin)$r.square, digits = 4)
r_squared

# Obtener el R cuadrado ajustado
adjusted_r_squared = round(summary(reg_lin)$adj.r.squared, digits = 4)
adjusted_r_squared

coeficientes = summary(reg_lin)[["coefficients"]][,1]
coeficientes[1]
coeficientes[2]
coeficientes[3]
coeficientes[4]



# REGRESIÓN LINEAL MULTIPLE (CON 80-20 DE TRAINTES, CON CIENCIAS, LENGUA Y MATEMÁTICAS) 

# 1. Creamos la tabla de datos: data.frame()
datos = N1.1

# 2. Visualizar datos: ggplot{ggplot2} / plot()
# No podemos graficarlo por que tenemos más de dos dimensiones a analizar

# 3. División de datos TRAIN/TEST:
#     Como tenemos muy pocos datos vamos a coger:
#       train -> todos los datos 
#       test -> una sola observación
#   3.1 sample.split{caTools}
#   3.2 createMultiFolds{caret}
library(caTools)
split = sample.split(datos$Selectividad, SplitRatio = 0.8)
train = subset(datos,  split == TRUE)
test = subset(datos,  split == FALSE)


# 4. Ajustar el modelo a los datos de TRAIN: lm(formula, data)
reg_lin = lm(formula = Selectividad ~ Ciencias+Lengua+Matematicas, data = train)

# Obtener resumen del modelo de regresión lineal
resumen=summary(reg_lin)
resumen

coeficientes = summary(reg_lin)[["coefficients"]][,1]
coeficientes[1] 
coeficientes[2]
coeficientes[3]
coeficientes[4]

# Obtener el R cuadrado ajustado
r_squared = round(summary(reg_lin)$r.square, digits = 4)
r_squared

# Obtener el R cuadrado ajustado
adjusted_r_squared = round(summary(reg_lin)$adj.r.squared, digits = 4)
adjusted_r_squared

# 5. Predecir sobre los datos de TEST: predict(object, newdata)
y_pred = round(predict(reg_lin, newdata = test), digits = 1)
print(y_pred)


# 6. Evaluar modelo comparando los resultados de predicción y de TEST:
#    6.1 TABLA DE ERRORES ABSOLUTOS Y RELATIVOS
#    6.2 CALCULAR R-square: summary(nombre_modelo)$r.square

resultados = cbind(test[4],y_pred)
resultados
abs = data.frame(abs(resultados[1]-resultados[2]))
abs
pro = 100*abs/test[4]
pro # Error en porcentaje
resultados = cbind(resultados,abs,pro)
colnames(resultados) <- c('Selectividad','Predicción','Error (abs)','Error (prctj)')

resultados


# REGRESIÓN LINEAL MULTIPLE (CON 80-20 DE TRAINTES, CON CIENCIAS Y LENGUA) 

# 1. Creamos la tabla de datos: data.frame()
datos = N1.1

# 2. Visualizar datos: ggplot{ggplot2} / plot()
# No podemos graficarlo por que tenemos más de dos dimensiones a analizar

# 3. División de datos TRAIN/TEST:
#     Como tenemos muy pocos datos vamos a coger:
#       train -> todos los datos 
#       test -> una sola observación
#   3.1 sample.split{caTools}
#   3.2 createMultiFolds{caret}
library(caTools)
split = sample.split(datos$Selectividad, SplitRatio = 0.8)
train = subset(datos,  split == TRUE)
test = subset(datos,  split == FALSE)


# 4. Ajustar el modelo a los datos de TRAIN: lm(formula, data)
reg_lin = lm(formula = Selectividad ~ Ciencias+Lengua, data = train)

# Obtener resumen del modelo de regresión lineal
resumen=summary(reg_lin)
resumen

coeficientes = summary(reg_lin)[["coefficients"]][,1]
coeficientes[1] 
coeficientes[2]
coeficientes[3]

# Obtener el R cuadrado ajustado
r_squared = round(summary(reg_lin)$r.square, digits = 4)
r_squared

# Obtener el R cuadrado ajustado
adjusted_r_squared = round(summary(reg_lin)$adj.r.squared, digits = 4)
adjusted_r_squared

# 5. Predecir sobre los datos de TEST: predict(object, newdata)
y_pred = round(predict(reg_lin, newdata = test), digits = 1)
print(y_pred)


# 6. Evaluar modelo comparando los resultados de predicción y de TEST:
#    6.1 TABLA DE ERRORES ABSOLUTOS Y RELATIVOS
#    6.2 CALCULAR R-square: summary(nombre_modelo)$r.square

resultados = cbind(test[4],y_pred)
resultados
abs = data.frame(abs(resultados[1]-resultados[2]))
abs
pro = 100*abs/test[4]
pro # Error en porcentaje
resultados = cbind(resultados,abs,pro)
colnames(resultados) <- c('Selectividad','Predicción','Error (abs)','Error (prctj)')

resultados