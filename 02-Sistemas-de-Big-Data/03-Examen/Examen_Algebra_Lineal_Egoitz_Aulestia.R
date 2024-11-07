########################## EXAMEN DE ÁLGEBRA ########################

rm(list=ls())

###############
# Ejercicio 1 #
###############
# Dar un número complejo con la parte real positiva(tiene que ser > 0, 
# no esta permitido usar el 0 como parte real), la parte imaginaria negativa y de módulo 7.

# Elegimos un argumento en el cuarto cuadrante, -pi/4 (45 grados negativos)
theta = -pi/4  # Ángulo en radianes

# Definimos el número complejo utilizando la forma polar
z = complex(modulus = 7, argument = theta)

# Mostramos el número complejo
print(z)

# Verificación de las condiciones

# Parte real > 0
real_positiva = Re(z) > 0
print(paste("¿Es la parte real positiva? :", real_positiva))

# Parte imaginaria < 0
imaginaria_negativa = Im(z) < 0
print(paste("¿Es la parte imaginaria negativa? :", imaginaria_negativa))

# Módulo == 7
modulo_correcto = round(Mod(z), 2) == 7  # Redondeamos para evitar errores de precisión
print(paste("¿Es el módulo igual a 7? :", modulo_correcto))



###############
# Ejercicio 2 #
###############
# Comprobar si las siguientes matrices son invertibles. Comprobar
# cada una de ellas de una diferente forma (hemos visto tres formas: mediante
# las 2 equivalencias del teorema de caracterización y con el determinante).
# Si son invertibles, calcular la inversa. Finalmente, comprobar haciendo la
# multiplicación entre la matriz y la inversa que se obtiene la matriz identidad.

rm(list=ls())

# Opción 1
#  Verificar la invertibilidad de A mediante el rango y, si es invertible, calcular su inversa

# Definimos la matriz A
A = matrix(c(1, 2, 3, 4,
              2, 4, 6, 8,
              1, 3, 2, 5,
              0, 0, 0, 0), nrow = 4, byrow = TRUE)

# Calculamos el rango
library(Matrix)
rango_A = rankMatrix(A)[1]

# Verificamos si el rango es igual al número de filas/columnas
es_invertible_A = rango_A == nrow(A)

if (es_invertible_A) {
  inversa_A = solve(A)
  print("Inversa de A:")
  print(inversa_A)
  
  # Verificamos multiplicando A por su inversa para obtener la identidad
  identidad_A = A %*% inversa_A
  print("Verificación (A * A⁻¹):")
  print(identidad_A)
} else {
  print("La matriz A no es invertible.")
}


# Opción 2
# Verificar la invertibilidad de B mediante la forma escalonada por filas y, si es invertible, calcular su inversa

# Definimos la matriz B
B = matrix(c(2, 0, 1,
              1, 1, -4,
              3, 7, -3), nrow = 3, byrow = TRUE)

# Usamos el paquete pracma para obtener la forma escalonada
library(pracma)
escalonada_B = rref(B)

# Verificamos si la matriz escalonada es la identidad
es_invertible_B <- all(escalonada_B == diag(nrow(B)))

if (es_invertible_B) {
  inversa_B <- solve(B)
  print("Inversa de B:")
  print(inversa_B)
  
  # Verificamos multiplicando B por su inversa para obtener la identidad
  identidad_B <- B %*% inversa_B
  print("Verificación (B * B⁻¹):")
  print(identidad_B)
} else {
  print("La matriz B no es invertible.")
}



# Opción 3
# Verificar la invertibilidad de C mediante el determinante y, si es invertible, calcular su inversa

# Definimos la matriz C
C <- matrix(c(0, 1, 2,
              1, 3, 4,
              4, 3, 2), nrow = 3, byrow = TRUE)

# Calculamos el determinante
determinante_C <- det(C)
es_invertible_C <- determinante_C != 0

if (es_invertible_C) {
  inversa_C <- solve(C)
  print("Inversa de C:")
  print(inversa_C)
  
  # Verificamos multiplicando C por su inversa para obtener la identidad
  identidad_C <- C %*% inversa_C
  print("Verificación (C * C⁻¹):")
  print(identidad_C)
} else {
  print("La matriz C no es invertible.")
}



###############
# Ejercicio 3 #
###############
# Decidir la compatibilidad de los siguientes sistemas (los dos primeros utilizando el Teorema de Rouche-Frobenius, 
# y los dos siguientes mediante el Método de Gauss-Jordan), y en caso de que el sistema sea compatible determinado 
# calcular su solución. En caso de que el sistema sea compatible indeterminado calcular un par de soluciones.

rm(list=ls())

# Primer sistema
# Definimos la matriz de coeficientes y el vector de términos independientes
A1 = matrix(c(3, 6, -2, 9,
               -5, 4, 5, -6,
               -3, 8, 2, -3,
               -4, 10, 3, 9), nrow = 4, byrow = TRUE)
b1 = c(6, 5, 3, 9)

# Calculamos el rango de la matriz de coeficientes y de la matriz ampliada
library(Matrix)
rango_A1 = rankMatrix(A1)[1]
rango_Ampliada1 = rankMatrix(cbind(A1, b1))[1]

# Verificamos compatibilidad
if (rango_A1 == rango_Ampliada1) {
  if (rango_A1 == ncol(A1)) {
    # Sistema compatible determinado
    solucion <- solve(A1, b1)
    print("El sistema es compatible determinado. Solución:")
    print(solucion)
  } else {
    # Sistema compatible indeterminado
    print("El sistema es compatible indeterminado. Existen infinitas soluciones.")
  }
} else {
  print("El sistema es incompatible. No tiene solución.")
}


# Segundo sistema
# Definimos la matriz de coeficientes y el vector de términos independientes
A2 = matrix(c(1, 1, 1,
               1, 2, 4,
               -3, 1, -3), nrow = 3, byrow = TRUE)
b2 = c(144, 312, 0)

# Calculamos el rango de la matriz de coeficientes y de la matriz ampliada
library(Matrix)
rango_A2 = rankMatrix(A2)[1]
rango_Ampliada2 = rankMatrix(cbind(A2, b2))[1]

# Verificamos compatibilidad
if (rango_A2 == rango_Ampliada2) {
  if (rango_A2 == ncol(A2)) {
    # Sistema compatible determinado
    solucion <- solve(A2, b2)
    print("El sistema es compatible determinado. Solución:")
    print(solucion)
  } else {
    # Sistema compatible indeterminado
    print("El sistema es compatible indeterminado. Existen infinitas soluciones.")
  }
} else {
  print("El sistema es incompatible. No tiene solución.")
}


# Tercer sistema
# Definimos la matriz de coeficientes y el vector de términos independientes
A3 <- matrix(c(1, 1, -1,
               0, 2, 1), nrow = 2, byrow = TRUE)
b3 <- c(1, 1)

# Creamos la matriz ampliada
A3_ampliada <- cbind(A3, b3)

# Realizamos la reducción Gauss-Jordan
library(pracma)
escalonada_A3 <- rref(A3_ampliada)

# Mostramos la matriz escalonada
print("Forma escalonada del sistema 3:")
print(escalonada_A3)

# Cuarto sistema
# Definimos la matriz de coeficientes y el vector de términos independientes
A4 <- matrix(c(-2, 1,
               -4, 2), nrow = 2, byrow = TRUE)
b4 <- c(3, 5)

# Creamos la matriz ampliada
A4_ampliada <- cbind(A4, b4)

# Realizamos la reducción Gauss-Jordan
library(pracma)
escalonada_A4 <- rref(A4_ampliada)

# Mostramos la matriz escalonada
print("Forma escalonada del sistema 4:")
print(escalonada_A4)



###############
# Ejercicio 4 #
###############
# Es el vector (-1,5,3) combinación lineal de los vectores (1,3,-1),
# (2,-3,-2) y (0,-2,1)? Si es así, conseguir los coeficientes con los que se consiga
# poner el vector como combinación lineal del resto.
# Forman una base los tres vectores anteriores (1,3,-1), (2,-3,-2) y (0,-2,1)??
# Si es así, justificarlo. Sino, ajustar el conjunto a una base del espacio.

rm(list = ls())

# -----------------------------
# Parte 1: Combinación Lineal
# -----------------------------

# Definir los vectores
u1 = c(1, 3, -1)
u2 = c(2, -3, -2)
u3 = c(0, -2, 1)
v  = c(-1, 5, 3)

# Crear la matriz A con los vectores u1, u2, u3 como columnas
A = matrix(c(u1, u2, u3), nrow = 3, byrow = FALSE)
print("Matriz A:")
print(A)

# Resolver el sistema A * c = v
coeficientes <- solve(A, v)
print("Coeficientes (c1, c2, c3):")
print(coeficientes)

# Verificar la solución
v_calculado <- A %*% coeficientes
print("v calculado (A * coeficientes):")
print(v_calculado)

# Confirmar si la solución es correcta
es_combinacion_lineal <- all(abs(v_calculado - v) < 1e-8)
print(paste("¿Es v una combinación lineal de u1, u2, u3?", es_combinacion_lineal))

# -----------------------------
# Parte 2: Base del Espacio R^3
# -----------------------------

# Calcular el determinante de A
det_A <- det(A)
print(paste("Determinante de A:", det_A))

# Verificar si A es invertible
if(det_A != 0){
  print("Los vectores u1, u2, u3 son linealmente independientes y forman una base para R^3.")
} else {
  print("Los vectores u1, u2, u3 son linealmente dependientes y no forman una base para R^3.")
  
  # Ajustar el conjunto a una base
  # Seleccionar un subconjunto de vectores linealmente independientes
  # Por ejemplo, u1 y u2 ya que en la parte 1 son independientes
  # Añadir un nuevo vector u4
  u4 <- c(1, 0, 0)  # Elegir un vector que no sea combinación de u1 y u2
  A_new_base <- cbind(u1, u2, u4)
  print("Nueva Matriz A (Base):")
  print(A_new_base)
  
  # Calcular el determinante de la nueva base
  det_A_new_base <- det(A_new_base)
  print(paste("Determinante de la nueva base:", det_A_new_base))
  
  if(det_A_new_base != 0){
    print("Los vectores u1, u2, u4 son linealmente independientes y forman una base para R^3.")
  } else {
    print("Los vectores seleccionados aún son linealmente dependientes. Seleccionar otro vector.")
  }
}



###############
# Ejercicio 5 #
###############
# Regresión lineal múltiple.
# Generar un modelo de regresión lineal que permita predecir la esperanza
# de vida media de los habitantes de una ciudad en función de diferentes variables. 
# Se dispone de informaci´on sobre: esperanza de vida, habitantes, área,
# ingresos, asesinatos, universitarios y heladas. Generar un modelo sobre el
# conjunto de datos entero (es decir, sobre las 50 observaciones, sin separar
# entre conjunto de entrenamiento y test). Explicar el significado del modelo final óptimo que conseguís , 
# y comentar todo lo que sepáis del modelo obtenido (coeficientes del modelo para cada variable, el estadístico t para
# cada variable, los p-valores de cada una de las variables independiente, 
# R cuadrado ajustado, el valor estadístico de la F...).

# Finalmente, predecir la esperanza de vida con el modelo de regresión
# lineal obtenido de 3 ciudades.

rm(list = ls())

# REGRESIÓN LINEAL (CON TODOS LOS DATOS)

# 1. Creamos la tabla de datos:
datos = datos

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

names(datos)
# 4. Ajustar el modelo a los datos de TRAIN: lm(formula, data)
reg_lin = lm(formula = esp_vida ~ habitantes+area+ingresos+asesinatos+universitarios+heladas, data = train)

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
coeficientes[5]
coeficientes[6]
coeficientes[7]


###############################


# Optimizamos el modelo de regresión lineal eliminando las variables menos significativas o que no aportan

# Limpiar el entorno
rm(list = ls())

# 1. Creamos la tabla de datos:
datos <- datos

# 2. Visualizar datos: ggplot{ggplot2} / plot()
# No podemos graficarlo porque tenemos más de dos dimensiones a analizar

# 3. División de datos TRAIN/TEST:
#     Como tenemos muy pocos datos vamos a coger:
#       train -> todos los datos 
#       test -> una sola observación
#   3.1 sample.split{caTools}
#   3.2 createMultiFolds{caret}
library(caTools)
train <- subset(datos) # metemos el 100% de los datos

names(datos)

# 4. Ajustar el modelo a los datos de TRAIN: lm(formula, data)
# Ajustamos el modelo con solo las variables significativas
reg_lin <- lm(formula = esp_vida ~ asesinatos + universitarios + heladas, data = train)

# Obtener y mostrar resumen del modelo de regresión lineal
resumen <- summary(reg_lin)
print("Resumen del modelo de regresión lineal con variables significativas:")
print(resumen)

print("Observamos que tenemos practicamente el mismo Adjusted R-squared que con más variables. Esto significa que hemos optimizado el modelo.")

# Obtener el R cuadrado
r_squared <- summary(reg_lin)$r.squared
print("R cuadrado (R²): Indica el porcentaje de variabilidad de la esperanza de vida explicada por el modelo.")
print(r_squared)

# Obtener el R cuadrado ajustado
adjusted_r_squared <- summary(reg_lin)$adj.r.squared
print("R cuadrado ajustado (R² ajustado): Ajusta el R cuadrado considerando el número de predictores en el modelo, lo que evita sobreajuste.")
print(adjusted_r_squared)

# Obtener los coeficientes, valores t y valores p
coeficientes <- summary(reg_lin)[["coefficients"]][, "Estimate"]
valores_t <- summary(reg_lin)[["coefficients"]][, "t value"]
valores_p <- summary(reg_lin)[["coefficients"]][, "Pr(>|t|)"]

print("Coeficientes: Representan el efecto de cada variable independiente en la esperanza de vida.")
print(coeficientes)
print("Valores t: Indican la relación de cada variable con el modelo; valores altos sugieren significancia estadística.")
print(valores_t)
print("Valores p: Miden la significancia estadística de cada variable. Valores bajos sugieren que la variable es relevante.")
print(valores_p)

# Obtener el estadístico F y su p-valor
f_statistic <- summary(reg_lin)$fstatistic[1]
p_value_f <- pf(f_statistic, df1 = summary(reg_lin)$fstatistic[2], df2 = summary(reg_lin)$fstatistic[3], lower.tail = FALSE)
print("Estadístico F: Evalúa la significancia global del modelo. Valores altos indican que el modelo tiene sentido globalmente.")
print(f_statistic)
print("p-valor del estadístico F: Indica la probabilidad de obtener un estadístico F tan alto solo por azar. Valores bajos sugieren un modelo significativo.")
print(p_value_f)

# Predicciones para las nuevas ciudades
ciudades_nuevas <- data.frame(
  habitantes = c(500, 2000, 10000),
  area = c(70735, 78009, 80900),
  ingresos = c(4440, 4500, 5100),
  asesinatos = c(4, 12, 15),
  universitarios = c(60, 40, 20),
  heladas = c(150, 100, 50)
)

# 5. Predecir sobre los datos de TEST: predict(object, newdata)
y_pred <- round(predict(reg_lin, newdata = ciudades_nuevas), digits = 1)
print("Predicciones para las nuevas ciudades:")
print(y_pred)

# 6. Evaluar modelo comparando los resultados de predicción y de TEST:
#    6.1 TABLA DE ERRORES ABSOLUTOS Y RELATIVOS
#    6.2 CALCULAR R-square: summary(nombre_modelo)$r.square

# Usamos la primera ciudad en 'ciudades_nuevas' como observación de prueba
test <- data.frame(esp_vida = c(70))  # Cambia este valor a la esperanza de vida real de la primera ciudad si la conoces

# Creación de la tabla de resultados
resultados <- cbind(test$esp_vida, y_pred[1])
colnames(resultados) <- c("Esperanza de Vida Real", "Predicción")
resultados

# Calcular error absoluto y relativo (porcentaje) para la primera ciudad
abs_error <- abs(resultados[1] - resultados[2])
pro_error <- 100 * abs_error / resultados[1]

# Añadir los errores a la tabla de resultados
resultados <- cbind(resultados, abs_error, pro_error)
colnames(resultados) <- c("Esperanza de Vida Real", "Predicción", "Error (abs)", "Error (%)")

# Mostrar resultados finales
print("Resultados de predicción y error para la primera ciudad:")
print(resultados)

# Ecuación del modelo final
print("Ecuación del modelo final:")
cat("y =", coeficientes[1], "+", coeficientes[2], "* x1(asesinatos) +", coeficientes[3], "* x2(universitarios) +", coeficientes[4], "* x3(heladas)\n")






###############
# Ejercicio 5 #
###############
# ANOVA de un factor. En este ejercicio se va a usar el dataset PlantGrowth en R. 
# En este dataset tenemos los resultados de un experimento para comparar los rendimientos 
# (medidos por el peso seco de las 2 plantas) obtenidos bajo un control y dos condiciones de tratamiento diferentes. 

# Con estos datos realiza un ANOVA, interpreta y, en caso de rechazar Ho (comentar también cúal es la hipótesis nula 
# en este caso) , explica qué parejas son estadísticamente diferentes mediante el test de Tukey.


# Cargar el dataset PlantGrowth
data("PlantGrowth")

# Visualizar los primeros datos
head(PlantGrowth)

# Realizar el ANOVA
modelo_anova <- aov(weight ~ group, data = PlantGrowth)

# Ver el resumen del ANOVA
print("Resultado del ANOVA:")
summary(modelo_anova)

# Realizar el test de Tukey si rechazamos la hipótesis nula
tukey_resultados <- TukeyHSD(modelo_anova)

# Mostrar los resultados del test de Tukey
print("Resultados del test de Tukey:")
print(tukey_resultados)

# Conclusión final basada en los resultados del ANOVA y el test de Tukey
cat("\nConclusión final:\n")

# Hipótesis nula
cat("Hipótesis nula (H0): No hay diferencias significativas en el peso seco promedio entre los tres grupos (ctrl, trt1 y trt2).\n")

# Hipótesis alternativa
cat("Hipótesis alternativa (H1): Existe al menos una diferencia significativa en el peso seco promedio entre los tres grupos (ctrl, trt1 y trt2).\n")

# Interpretación de los resultados del ANOVA
cat("Resultados del ANOVA: El análisis ANOVA mostró diferencias significativas entre los grupos, por lo que hemos procediso con el test de Tukey para identificar qué pares de grupos difieren.\n\n")

# Interpretación del test de Tukey para cada par
cat("Interpretación del test de Tukey:\n")

# Interpretación para trt1 vs ctrl
if (tukey_resultados$group["trt1-ctrl", "p adj"] > 0.05) {
  cat("- No hay diferencia significativa entre 'trt1' y 'ctrl' (p =", round(tukey_resultados$group["trt1-ctrl", "p adj"], 4), ").\n")
} else {
  cat("- Hay una diferencia significativa entre 'trt1' y 'ctrl' (p =", round(tukey_resultados$group["trt1-ctrl", "p adj"], 4), ").\n")
}

# Interpretación para trt2 vs ctrl
if (tukey_resultados$group["trt2-ctrl", "p adj"] > 0.05) {
  cat("- No hay diferencia significativa entre 'trt2' y 'ctrl' (p =", round(tukey_resultados$group["trt2-ctrl", "p adj"], 4), ").\n")
} else {
  cat("- Hay una diferencia significativa entre 'trt2' y 'ctrl' (p =", round(tukey_resultados$group["trt2-ctrl", "p adj"], 4), ").\n")
}

# Interpretación para trt2 vs trt1
if (tukey_resultados$group["trt2-trt1", "p adj"] < 0.05) {
  cat("- Hay una diferencia significativa entre 'trt2' y 'trt1' (p =", round(tukey_resultados$group["trt2-trt1", "p adj"], 4), ").\n")
} else {
  cat("- No hay diferencia significativa entre 'trt2' y 'trt1' (p =", round(tukey_resultados$group["trt2-trt1", "p adj"], 4), ").\n")
}

# Conclusión general
cat("\nConclusión general:\n")
cat("Existe una diferencia significativa en el peso seco promedio entre 'trt2' y 'trt1', mientras que no se observan diferencias significativas entre los otros pares de grupos.\n")

