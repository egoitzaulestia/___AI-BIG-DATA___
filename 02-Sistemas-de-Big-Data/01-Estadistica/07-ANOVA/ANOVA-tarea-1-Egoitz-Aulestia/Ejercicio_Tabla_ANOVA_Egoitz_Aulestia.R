rm(list=ls())

# EJERCICIOS TABLA ANOVA

# (utilizar la función aggregate) 

# 1. Cargar los datos de “trainmod”.
data = read.csv("trainmod.csv")

# 2. Determinar cuál es el MSZONING más caro
library(dplyr)

# Opción A
# 2A.1 Calcular el precio promedio por cada tipo de MSZONING
average_prices = aggregate(SalePrice ~ MSZoning, data = data, FUN = mean)

# 2A.2 Ordenar los resultados en orden descendente de precio promedio
sorted_data = average_prices[order(-average_prices$SalePrice), ]

# 2A.3 Seleccionar el primer elemento (MSZONING con el precio promedio más alto)
most_expensive_zoning <- sorted_data[1, ]

# 2A.4 Imprimir el resultado
print(most_expensive_zoning)

# Opción B
max_price_zoning = data %>%
  group_by(MSZoning) %>%
  summarise(AveragePrice = mean(SalePrice, na.rm = TRUE)) %>%
  arrange(desc(AveragePrice)) %>%
  slice(1)

print(max_price_zoning)

ggplot(data, aes(x=MSZoning, y=SalePrice, 
       fill=MSZoning))+
       geom_boxplot()

# 3. Analizar si las diferencias son estadísticamente significativas.

# Realizamo ANOVA para analizar las diferencias en SalePrice según MSZoning
anova_result = aov(SalePrice ~ MSZoning, data = data)
summary(anova_result)


# 4. Comprobar si todas las zonas son significativamente diferentes.
TukeyHSD(anova_result)


# 5. En caso de que no sean todas significativamente diferentes determinar cuáles no lo son.

# Realizar la prueba de Tukey
tukey_result = TukeyHSD(anova_result)

# Extraer el resultado del análisis de Tukey para MSZoning
tukey_zones = tukey_result$MSZoning

# Convertir el resultado en un data frame para facilitar el filtrado
tukey_df = as.data.frame(tukey_zones)

# Filtrar las comparaciones con un valor p ajustado mayor que 0.05
tukey_non_significant = subset(tukey_df, `p adj` > 0.05)

# Mostrar los resultados filtrados
print("Zonas que no son significativamente diferentes (p > 0.05):")
print(tukey_non_significant)



# 6. Determinar si en promedio las casas valían más antes de la crisis.

# Crear una nueva columna que clasifique las ventas antes y después de la crisis
data$CrisisPeriod = ifelse(data$YrSold < 2008, "Antes de la crisis", "Después de la crisis")

# Calcular el precio promedio de las casas en cada período
library(dplyr)
average_prices = data %>%
  group_by(CrisisPeriod) %>%
  summarise(AveragePrice = mean(SalePrice, na.rm = TRUE))

# Imprimir los resultados de los precios promedio
print("Precios promedio en cada período:")
print(average_prices)


# 7. Analizar si esta diferencia es estadísticamente significativa.

# Dividir los precios en dos grupos: antes y después de la crisis
before_crisis = data$SalePrice[data$CrisisPeriod == "Antes de la crisis"]
after_crisis = data$SalePrice[data$CrisisPeriod == "Después de la crisis"]

# Realizar la prueba t para evaluar si la diferencia es significativa
t_test_result = t.test(before_crisis, after_crisis)

# Imprimir el resultado de la prueba t
print("Resultados de la prueba t:")
print(t_test_result)

# Imprimir solo el valor p
p_value = t_test_result$p.value
print(p_value)

# Interpretación del valor p
if (t_test_result$p.value < 0.05) {
  print("El valor p es menor que 0.05, lo que indica una diferencia estadísticamente significativa entre los precios antes y después de la crisis.")
} else {
  print("El valor p es mayor que 0.05, lo que indica que no hay suficiente evidencia para afirmar que los precios de las casas son diferentes entre los dos períodos.")
}

# 8. Estudiar si existen diferencias en algún barrio.

# Realizar el ANOVA para comparar los precios en diferentes barrios
anova_result = aov(SalePrice ~ Neighborhood, data = data)
summary(anova_result)

# Realizar el análisis de Tukey
tukey_result = TukeyHSD(anova_result)

# Extraer el resultado del análisis de Tukey para la variable Neighborhood
tukey_neighborhood <- tukey_result$Neighborhood

# Convertir el resultado en un data frame para facilitar el filtrado
tukey_df = as.data.frame(tukey_neighborhood)

# Filtrar los barrios con un valor p ajustado menor que 0.05
tukey_filtered = subset(tukey_df, `p adj` < 0.05)

# Mostrar los resultados filtrados
print("Barrios con diferencias significativas (p < 0.05):")
print(tukey_filtered)
nrow(tukey_filtered)


