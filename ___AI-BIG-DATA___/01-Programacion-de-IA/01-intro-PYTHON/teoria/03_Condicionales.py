####################################
# Condicionales y Control de flujo #
####################################

# Creamos una lista.
a = [6, 0, 3, 4, 5]


# Ejemplo de condicional simple
if a[0] > a[-1]:
    print("Se ejecuta cuando el primer elemento de la lista es mayor que el último")
    if a[1] < a[2]:
        d = 34 * a[0]
        print(d)

print(a)

# Acción alternativa usando "else"
if a[0] > a[-1]:
    print("El primer elemento de la lista es mayor que el último")
else:
    print("El primer elemento de la lista es menor o igual que el último")


# Cambiamos el orden de la lista y ejecutamos el mismo código.
a.sort(reverse=True)

# Repetimos la condicion.
if a[0] > a[-1]:
    print("El primer elemento de la lista es mayor que el último")
else:
    print("El primer elemento de la lista es menor que el último")

# Agregamos la función elif para más opciones
if a[0] > a[-1]:
    print("El primer elemento de la lista es mayor que el último")
elif a[0] < a[-1]:
    print("El primer elemento de la lista es menor que el último")
else:
    print("El primer elemento de la lista es igual que el último")

# Cambiamos el primer elemento
a[0] = 0

# Repetimos la condición (es el mismo código de arriba).
if a[0] > a[-1]:
    print("El primer elemento de la lista es mayor que el último")
elif a[0] == a[-1]:
    print("El primer elemento de la lista es igual que el último")
else:
    print("El primer elemento de la lista es menor que el último")

# También podemos añadir un elemento en función de la condición
if a[0] > a[-1]:
    print(f"El primer elemento de la lista es mayor que el último y es {a[0]}")
elif a[0] == a[-1]:
    print(f"El primer elemento de la lista es igual que el último y es {a[0]}")
else:
    print(f"El primer elemento de la lista es menor que el último y es {a[0]}")

# Uso de una variable límite
limite = -5

if a[0] > limite:
    print(f"El primer elemento de la lista es mayor que el límite y es {a[0]}")
elif a[0] == limite:
    print(f"El primer elemento de la lista es igual que el límite y es {a[0]}")
else:
    print(f"El primer elemento de la lista es menor que el límite y es {a[0]}")

# Uso de operador ternario
print("El primero es mayor" if a[0] > a[-1] else "El primero no es mayor que el último")

a[0]=-1
# Almacenar la condición en una variable
condicion = (a[0] > a[-1])
print("El primero es mayor que el último" if condicion else "El primero no es mayor que el último")

print(f"El primero {'NO' if a[0] <= a[-1] else ''} es mayor que el último")

# Formas "raras" de escribir condicionales.
# Uso del operador "or" con una expresión condicional 
(3 < 4) or print("El primer elemento no es mayor que el segundo")

# Uso del operador "and" con una expresión condicional 
(5 < 4) and print("El primer elemento es mayor que el segundo")