

# ·MODELO MATEMÁTICO DE REGRESIÓN LINEAL POLINÓMICA.

# Polinomio de grado n: y = b_0 + b_1*x+ b_2*x^2 + ... + b_n*x^n 
    # y -> v. dependiente
    # x -> v. independiente
    # b_i -> coeficientes  -> incógnitas que definen nuestro modelo


# ·OBJETIVO: Encontrar los coeficientes b_i que determinan el modelo 


# ·EJEMPLO:

rm(list=ls())
# setwd("E:/Algebra DVM/AlgebraLineal/8.RegresiónPolinómica")

#cargar datos
dataset = read.csv("Position_Salaries.csv")

#Viendo el conjunto de datos nos quedaremos solo con level y salary
#porque la primera columna es 'igual' que la de level
dataset = dataset[,2:3]

#DIVISION de datos train/test ? NO.
# No hacemos la división de los datos porque tenemos muy pocos 


# Hacemos dos modelos de predicción y vemos la diferencia:

# 1. Modelo de Regresión Lineal 
datos_lineal = dataset 
modelo_lineal = lm(formula = Salary ~ ., data = datos_lineal)
summary(modelo_lineal)
# b_0 = -195333 (en el nivel 0 el empleado paga a la empresa -195333$)
# b_1 = 80879 (cada vez que subimos un nivel el empleado gana 80879$ más)     


# VISUALIZACIÓN: DATOS Y MODELO LINEAL
library(ggplot2)
ggplot()+
  geom_point(aes(x = datos_lineal$Level ,y = datos_lineal$Salary),
             color = "red") +
  geom_line(aes(x = datos_lineal$Level,y = predict(modelo_lineal, newdata = datos_lineal)),
            color = "blue") +
  ggtitle("Predicción del sueldo según el modelo lineal") + 
  xlab("Nivel del empleado") + ylab("Sueldo (en $)")

# Vemos que la recta no se aproxima muy bien a la realidad (puntos)
# En general nuestro modelo le daría al empleado mucho más dinero de lo que cobra
# y la empresa saldría perdiendo




#2.Modelo de Regresión Polinómica con el conjunto de datos

#Hay que construir los términos del polinomio de forma explícita.
#Se puede hacer directamente en la fórmula o definiéndolo anteriormente.

datos_poli = dataset
datos_poli$Level2 = datos_poli$Level^2  #columna con valores de Level elevados al cuadrado
datos_poli$Level3 = datos_poli$Level^3  #columna al cubo

modelo_poli = lm(formula = Salary ~ ., data = datos_poli)
summary(modelo_poli)



# VISUALIZACIÓN: DATOS Y MODELO POLINÓMICO
ggplot()+
  geom_point(aes(x = datos_poli$Level ,y = datos_poli$Salary),
             color = "red") +
  geom_line(aes(x = datos_poli$Level,y = predict(modelo_poli, newdata = datos_poli)),
            color = "blue") +
  ggtitle("Predicción del sueldo según el modelo polinómico") + 
  xlab("Nivel del empleado") +
  ylab("Sueldo (en $)")

# Vemos que este modelo ajusta mucho mejor la realidad



# 3.Modelo de Regresión Polinómica de grado 4:

datos_poli_4 = dataset
datos_poli_4$Level2 = datos_poli_4$Level^2  
datos_poli_4$Level3 = datos_poli_4$Level^3  
datos_poli_4$Level4 = datos_poli_4$Level^4  

modelo_poli4 = lm(formula = Salary ~ ., data = datos_poli_4)
summary(modelo_poli4)


x_grid = seq(min(datos_poli_4$Level),max(datos_poli_4$Level),0.1)
ggplot()+
  geom_point(aes(x = datos_poli_4$Level, y = datos_poli_4$Salary),
             color = "red") +
  geom_line(aes(x = x_grid, y = predict(modelo_poli4, newdata = data.frame(Level = x_grid,
                                                                      Level2 = x_grid^2,
                                                                      Level3 = x_grid^3,
                                                                      Level4 = x_grid^4))),
            color = "blue") +
  ggtitle("Predicción del sueldo según el modelo polinómico") + 
  xlab("Nivel del empleado") + ylab("Sueldo (en $)")

# Vemos que se aproxima todavía mejor que con el de grado 3



#Predicciones del nivel 6 para cada modelo:

# MODELO LINEAL
y_pred_lin = predict(modelo_lineal, 
                     newdata = data.frame(Level = 6))
y_pred_lin


# MODELO POLINÓMICO 
y_pred_pol = predict(modelo_poli, 
                     newdata = data.frame(Level = 6,
                                          Level2 = 6^2,
                                          Level3 = 6^3))
y_pred_pol


# MODELO POLINÓMICO GRADO 4
y_pred_pol4 = predict(modelo_poli4, newdata = data.frame(Level = 6, Level2 = 6^2,Level3 = 6^3, Level4 = 6^4))
y_pred_pol4


# Valor real del nivel 6
dataset$Salary[dataset$Level == 6]


