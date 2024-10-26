rm(list=ls())

###############
# Ejercicio 1 #
###############
# 1. Operación Interna
# Comprobamos si la suma y la multiplicación de dos números naturales siguen siendo números naturales.

# Demostración de que los números naturales no forman un cuerpo

# Verificar si los números naturales tienen inverso aditivo
# Para cualquier número natural mayor que 0, no hay inverso aditivo en los números naturales.
inverso_aditivo = function(a) {
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
a = 2

# Verificación de inverso aditivo
if (!inverso_aditivo(a)) {
  cat("El número", a, "no tiene un inverso aditivo en los números naturales.\n")
}

# Verificación de inverso multiplicativo
if (!inverso_multiplicativo(a)) {
  cat("El número", a, "no tiene un inverso multiplicativo en los números naturales.\n")
}


###############
# Ejercicio 2 #
###############
# Sabiendo que los numeros reales sí forman un cuerpo, demostrar mediante ejemplos 
# que para los elementos del conjunto se cumplen las respectivas condiciones.

rm(list=ls())

# 1. Operaciones internas sobre𝐾

# Cerradura en la suma
a = 2
b = 3
suma = a + b
cat("Suma de", a, "y", b, "es:", suma, "\n")

# Cerradura en el producto
producto <- a * b
cat("Producto de", a, "y", b, "es:", producto, "\n")

# 2. Operaciones conmutativas:
# Conmutatividad en la suma y multiplicación
cat("Suma de", a, "y", b, "es:", a + b, "y suma de", b, "y", a, "es:", b + a, "\n")
cat("Producto de", a, "y", b, "es:", a * b, "y producto de", b, "y", a, "es:", b * a, "\n")

# 3. Operaciones asociativas:
# Asociatividad en la suma y el producto
c = 4
cat("Suma asociativa: (a + b) + c =", (a + b) + c, "y a + (b + c) =", a + (b + c), "\n")
cat("Producto asociativa: (a * b) * c =", (a * b) * c, "y a * (b * c) =", a * (b * c), "\n")

# 4. Elemento neutro para la adición:
# Elemento neutro aditivo = 0
cat("Suma de", a, "y 0 es:", a + 0, "\n")

# 5. Elemento neutro para la multiplicación:
# Elemento neutro multiplicativo = 1
cat("Producto de", a, "y 1 es:", a * 1, "\n")

# 6. Elemento opuesto (Inverso aditivo):
# Inverso aditivo
inverso_aditivo = -a
cat("Inverso aditivo de", a, "es:", inverso_aditivo, "y su suma da:", a + inverso_aditivo, "\n")

# 7. Elemento inverso (Inverso multiplicativo):
# Inverso multiplicativo (excepto cuando a es 0)
if (a != 0) {
  inverso_multiplicativo = 1 / a
  cat("Inverso multiplicativo de", a, "es:", inverso_multiplicativo, "y su producto da:", a * inverso_multiplicativo, "\n")
} else {
  cat("El inverso multiplicativo no existe para 0.\n")
}

# 8. Distributividad:
# Distributividad de la multiplicación sobre la suma
cat("Distribución: a * (b + c) =", a * (b + c), "y a * b + a * c =", a * b + a * c, "\n")


###############
# Ejercicio 3 #
###############

rm(list=ls())

# 1
# Definir el número complejo
z1 = 2 + 2i

# Calcular el argumento en radianes y convertir a grados
arg_z1 = Arg(z1)
arg_z1_deg = arg_z1 * (180 / pi)
cat("Arg(2 + 2i) en grados es:", arg_z1_deg, "\n")

# 2
# Definir el número complejo
z2 = (sqrt(3) + 1i)^6

# Calcular el argumento en radianes y convertir a grados
arg_z2 = Arg(z2)
arg_z2_deg = arg_z2 * (180 / pi)
cat("Arg((sqrt(3) + i)^6) en grados es:", arg_z2_deg, "\n")

# 3
# Definir el número complejo
z3 = (1 + 3i) / 2

# Calcular el argumento en radianes y convertir a grados
arg_z3 = Arg(z3)
arg_z3_deg = round(arg_z3 * (180 / pi), digits = 2)
cat("Arg((1 + 3i)/2) en grados es:", arg_z3_deg, "\n")

# 4
# Definir el número complejo
z4 = 2 - 1i

# Calcular el argumento en radianes y convertir a grados
arg_z4 = Arg(z4)
arg_z4_deg = round(arg_z4 * (180 / pi), digits = 2)
cat("Arg(2 - i) en grados es:", arg_z4_deg, "\n")

# 5
# Definir el argumento en radianes
arg_z5 = pi

# Convertir a grados
arg_z5_deg = arg_z5 * (180 / pi)
cat("Arg(mod = 1/2, arg = pi) en grados es:", arg_z5_deg, "\n")



###############
# Ejercicio 4 #
###############

rm(list=ls())

# 1. Número complejo con parte real positiva y parte imaginaria negativa
z1 = 3 - 4i  # Ejemplo: parte real positiva (3) y parte imaginaria negativa (-4)
cat("Número complejo con parte real positiva y parte imaginaria negativa:", z1, "\n")

# 2. Número complejo con longitud 1 y parte imaginaria positiva
z2 = complex(modulus = 1, argument = pi / 4)  # Parte imaginaria positiva, ángulo de pi/4
cat("Número complejo de longitud 1 con parte imaginaria positiva:", z2, "\n")

# Verificar longitud (módulo)
mod_z2 = Mod(z2)
cat("Longitud del número complejo:", mod_z2, "\n")

# 3. Número complejo con longitud 3 y parte imaginaria negativa
z3 = complex(modulus = 3, argument = -pi / 3)  # Parte imaginaria negativa, ángulo -pi/3
cat("Número complejo de longitud 3 con parte imaginaria negativa:", z3, "\n")

# Verificar longitud (módulo)
mod_z3 = Mod(z3)
cat("Longitud del número complejo:", mod_z3, "\n")


###############
# Ejercicio 5 #
###############

rm(list=ls())

# 1. Número complejo con parte real positiva y parte imaginaria negativa
z1 = 3 - 4i
cat("Número complejo original:", z1, "\n")

# Calcular el conjugado de z1
conj_z1 = Conj(z1)
cat("Conjugado de", z1, "es:", conj_z1, "\n")

# 2. Número complejo de longitud 1 con parte imaginaria positiva
z2 = complex(modulus = 1, argument = pi / 4)
cat("Número complejo original:", z2, "\n")

# Calcular el conjugado de z2
conj_z2 = Conj(z2)
cat("Conjugado de", z2, "es:", conj_z2, "\n")

# 3. Número complejo de longitud 3 con parte imaginaria negativa
z3 = complex(modulus = 3, argument = -pi / 3)
cat("Número complejo original:", z3, "\n")

# Calcular el conjugado de z3
conj_z3 = Conj(z3)
cat("Conjugado de", z3, "es:", conj_z3, "\n")
