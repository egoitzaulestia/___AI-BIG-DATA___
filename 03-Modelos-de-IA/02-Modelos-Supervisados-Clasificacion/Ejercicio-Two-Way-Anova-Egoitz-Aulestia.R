############# Ejercicio ANOVA de dos factores ///// Egoitz Aulestia ###############

#################################
# Los datos GTL.csv presentan los resultados de un experimento realizado para estudiar 
# la influencia de la temperatura de operación (100˚C, 125˚C y 150˚C) y tres tipos de vidrio 
# de placa frontal (A, B y C) en la salida de luz de un tubo de osciloscopio.

# Aplicar ANOVA y Tukey sobre los datos y escribir las conclusiones.
#################################

rm(list = ls())

# Cargar librerías necesarias
library(readxl)
library(ggplot2)
library(ggpubr)
library(dplyr)
library(car)

# Leer los datos
datos <- read.csv("GTL.csv")

# Convertir las variables en factores
datos$Glass <- as.factor(datos$Glass)
datos$Temp <- as.factor(datos$Temp)


# Visualización de datos: 

# Boxplot de 'Light' por 'Temp' y 'Glass'
ggplot(datos, aes(x=Temp, y=Light, fill=Glass)) + geom_boxplot()

# Observaciones sobre el gráfico de boxplot
cat("Observaciones del gráfico de boxplot:\n")
cat("1. El gráfico de boxplot muestra la dispersión de la variable Light para cada nivel de Temp, separado por los tipos de vidrio (Glass).\n")
cat("2. En la temperatura de 100, los valores de Light son bastante similares entre los tipos de vidrio, aunque el vidrio A tiene un rango levemente más alto.\n")
cat("3. A medida que la temperatura aumenta a 125, todos los tipos de vidrio muestran un incremento en los valores de Light, con el vidrio A alcanzando valores superiores en comparación con B y C.\n")
cat("4. En la temperatura de 150, el vidrio tipo A sigue mostrando los valores más altos de Light, mientras que el vidrio tipo C muestra una disminución en comparación con sus valores en 125, lo cual es un comportamiento diferente al de los vidrios A y B.\n")
cat("5. La dispersión de los datos parece menor en temperaturas más altas, especialmente para los tipos de vidrio A y B, lo que sugiere una mayor consistencia en los valores de Light en estos casos.\n\n")

# Línea de medias y desviaciones estándar por grupo
ggline(datos, x = "Temp", y = "Light", color = "Glass", add = c("mean_se", "dotplot"))
# Observaciones sobre el gráfico de línea
cat("Observaciones del gráfico de línea:\n")
cat("1. El gráfico de línea muestra la tendencia de la salida de Light con respecto a los cambios en Temp, separado por cada tipo de vidrio (Glass).\n")
cat("2. Se observa una tendencia ascendente en Light para los vidrios tipo A y B cuando la temperatura aumenta de 100 a 125.\n")
cat("3. Para el vidrio tipo C, aunque Light aumenta de 100 a 125, disminuye significativamente cuando la temperatura llega a 150.\n")
cat("4. Estas tendencias sugieren que la interacción entre Temp y Glass es importante para explicar la variabilidad en la salida de Light.\n")

# Realizar el ANOVA
res.aov2 <- aov(Light ~ Glass + Temp + Glass:Temp, data = datos)
summary_res <- summary(res.aov2)

# Imprimir el resultado del ANOVA con explicación y conclusión
cat("Resultados del ANOVA:\n")
cat("El ANOVA evalúa si existen diferencias significativas en la salida de luz ('Light') basadas en el tipo de vidrio ('Glass'),\n",
    "la temperatura de operación ('Temp') y la interacción entre ambos.\n")
print(summary_res)
cat("Conclusión: Según los resultados del ANOVA, todos los factores ('Glass', 'Temp' y 'Glass:Temp') son significativos (p < 0.001),\n",
    "lo que indica que tanto el tipo de vidrio, la temperatura, como su interacción afectan significativamente la salida de luz.\n\n")

# Realizar el test de Tukey para analizar diferencias específicas entre grupos de 'Glass'
tukey_res <- TukeyHSD(res.aov2, which = "Glass")
cat("\nPrueba de Tukey para el factor 'Glass':\n")
cat("La prueba de Tukey permite identificar entre qué tipos de vidrio existen diferencias significativas.\n")
print(tukey_res)
cat("Conclusión: Los resultados muestran diferencias significativas entre todos los pares de tipos de vidrio ('A', 'B' y 'C') con p < 0.05.\n\n")

# Test de homocedasticidad con Levene
levene_res <- leveneTest(Light ~ Glass * Temp, data = datos)
cat("\nPrueba de Levene para Homogeneidad de Varianzas:\n")
cat("La prueba de Levene verifica si las varianzas son homogéneas entre los grupos.\n",
    "Un p-valor alto sugiere que no hay diferencias significativas entre las varianzas de los grupos.\n")
print(levene_res)
cat("Conclusión: En este caso, el p-valor es 0.3253, indicando que no se rechaza la hipótesis de homocedasticidad,\n",
    "por lo que asumimos que las varianzas son homogéneas.\n\n")

# Evaluar los supuestos del ANOVA
# 1. Gráfico de residuos vs valores ajustados
cat("\nGráfico: Residuos vs Valores Ajustados\n")
cat("Este gráfico ayuda a identificar patrones en los residuos que puedan sugerir problemas con el modelo.\n")
plot(res.aov2, 1)
cat("Conclusión: El gráfico Residuals vs Fitted muestra los residuos en función de los valores ajustados.\n",
    "La línea roja representa la tendencia promedio de los residuos, que se mantiene cerca de cero, lo cual es deseable.\n",
    "Aunque algunos puntos se alejan considerablemente de la línea, la dispersión de los residuos parece ser\n",
    "aproximadamente constante a lo largo de los valores ajustados, lo que sugiere que se cumple la suposición de homocedasticidad.\n",
    "Sin embargo, algunos valores atípicos podrían indicar posibles anomalías en los datos o una ligera falta de ajuste del modelo en ciertos casos.\n\n")


# 2. Gráfico Q-Q de los residuos
cat("\nGráfico: Q-Q de Residuos\n")
cat("El gráfico Q-Q permite verificar si los residuos siguen una distribución normal.\n")
plot(res.aov2, 2)
cat("Conclusión: La mayoría de los puntos en el gráfico Q-Q se alinean bien con la línea teórica, sugiriendo que los residuos\n",
    "aproximadamente siguen una distribución normal. Aunque hay algunas desviaciones menores, estas son generalmente\n",
    "aceptables en el contexto del ANOVA y no deberían afectar significativamente los resultados.\n\n")