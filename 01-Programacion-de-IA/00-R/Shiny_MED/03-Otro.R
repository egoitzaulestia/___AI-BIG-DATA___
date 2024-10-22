# Fijar la semilla para reproducibilidad
set.seed(123)

# Generar 1000 números aleatorios con media 5 y desviación estándar 2
random_numbers <- rnorm(1000, mean = 5, sd = 2)

# Crear un histograma
hist(random_numbers, breaks = 5, main = "Histograma de Números Aleatorios de una Distribución Normal",
     xlab = "Valores", ylab = "Frecuencia")

# Calcular y mostrar la media y la desviación estándar de los números generados
generated_mean <- mean(random_numbers)
generated_sd <- sd(random_numbers)
cat("Media generada:", generated_mean, "\n")
cat("Desviación estándar generada:", generated_sd, "\n")
