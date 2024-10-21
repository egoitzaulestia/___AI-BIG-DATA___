#1. Operación Interna
# Comprobamos si la suma y la multiplicación de dos números naturales siguen siendo números naturales.

# Demostración de que los números naturales no forman un cuerpo

# Verificar si los números naturales tienen inverso aditivo
# Para cualquier número natural mayor que 0, no hay inverso aditivo en los números naturales.
inverso_aditivo <- function(a) {
  return(a + (-a) == 0 && (-a) >= 0)
}

# Verificar si los números naturales tienen inverso multiplicativo
# Para cualquier número natural mayor que 1, no hay inverso multiplicativo en los números naturales.
inverso_multiplicativo <- function(a) {
  if (a == 0) {
    return(FALSE)  # No se puede dividir por 0
  } else {
    return(a * (1/a) == 1 && (1/a) %% 1 == 0)  # Verificar si el inverso es un número natural
  }
}

# Ejemplo con un número natural
a <- 2

# Verificación de inverso aditivo
if (!inverso_aditivo(a)) {
  cat("El número", a, "no tiene un inverso aditivo en los números naturales.\n")
}

# Verificación de inverso multiplicativo
if (!inverso_multiplicativo(a)) {
  cat("El número", a, "no tiene un inverso multiplicativo en los números naturales.\n")
}

