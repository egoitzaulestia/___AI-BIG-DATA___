###############
# ITERACIONES #
###############

#################
# Funcion While #
#################
# Imprimir una secuencia de números menor que 10
contador = 0
while contador < 10:
    print(contador)
    contador = contador +1


# Podemos romper un bucle while si se cumple una condición
# Imprimir una secuencia de números.
# Si el número = 5 abortar la iteración.
contador = 10
while contador > 0:
    print('Valor actual de la variable: ', contador)
    contador = contador - 1
    if contador == 5:
        print("He alcanzado el valor buscado")
        break

contador = 0
# Ejemplo de bucle while con continue
while contador < 10:
    contador += 1
    # Si i es divisible por 2, saltamos a la siguiente iteración sin imprimir nada
    if contador % 3 == 0:
        print("Tenemos un divisible entre 3")
        continue
    # Este código solo se ejecutará para valores impares del contador
    print(f"El valor del contador es {contador}")
    if contador == 7:
        print("El bucle termina cuando contador alcanza el valor 7")
        break



# EJEMPLO DE USO DE BUCLE WHILE
# Comprobar si un número proporcionado es un cubo perfecto o no.
# En este caso introducimos manualmente el numero
entrada_por_teclado = input("Imprimo algo: ")
print(entrada_por_teclado)

x = int(input('Introduce un número entero: '))
type(x)
print(x)

contador = 0
while contador**3 < x:
    contador = contador + 1
    if contador**3 != x:
        print(str(x), 'no es un cubo perfecto de', contador)
    else:
        print('El cubo de', str(contador), 'es', str(x))


contador = 0
while contador**3 < x:
    contador = contador + 1
    if contador**3 != x:
        print(f"{x} no es un cubo perfecto de {contador}")
    else:
        print(f"El cubo de {str(contador)} es {str(x)}")
        
        
x = input('Introduce un número entero: ')

if x.isdigit():
    x = int(x)
    print(f"Hemos convertido tu input {x} a entero")
    print(type(x))
else:
    print("´Tu input no se puede convertir en entero")

        
        
###############
# Funcion For #
###############
# Primero vamos a ver lo que es un rango
# range puede tener inicio, fin y salto
rango_con_salto = range(1, 10, 2)
# si falta un número, será el salto, considerará que es 1
rango_con_inicio = range(1, 10)
# si faltan dos será el inicio, considerará que es 0
rango_desde_cero = range(10)

print(list(rango_con_salto))
print(list(rango_con_inicio))
print(list(rango_desde_cero))

# El objeto rango no devuelve sus valores hasta que se itera sobre él

# Imprimir un rango de números
for a in range(1, 10):
    print(a)

for elemento in [1, 2, 3, 4, "Hola", 6, 7, 8, 9]:
    print(elemento)

# La función list hace un volcado del range
lista_con_rango = list(range(1, 10))
rango = range(7)

lista = ["Madrid", "Barcelona", "Bilbao"]

for elemento in lista:
    salida = elemento.upper()
    print(salida*2)


for elemento in rango:
    print(2*elemento/3)

# Imprimir una secuencia de números en orden descendiente de 5.
for a in range(150, 100, -5):
    print("a:", a)

"""
Imprimir una secuencia de números (a) que empezando por 1 termine en 99
y se incremente de 2 en 2 (1,3,5,...)
Además imprimir una segunda secuencia con los valores acumulativos generados
a=1 -> b = 1
a=3 -> b = 4
a=5 -> b = 9
...
"""
b = 0
for a in range(1, 100, 2):
    b = b + a
    print("a:", a, " -> b:", b)


# Comprobar si una cadena de texto contiene las vocales
# i y u
cadena = input('Introduce una cadena de texto en minúsculas: ')

for indice in range(len(cadena)):
    if cadena[indice] == "i" or cadena[indice] == "u":
        print("La cadena contiene una i o una u")
        print(cadena[indice])
        break

# Mejor así:
cadena = input('Introduce una cadena de texto en minúsculas: ')

for letra in cadena:
    if (letra == "c"):
        print("La cadena contiene una c")
        print(letra)
    elif letra == "u":
        print("La cadena contiene una u")
    elif letra == "ü":
        print("La cadena contiene una ü")
    else:
        print(letra)

# Aún mejor:
cadena = input('Introduce una cadena de texto en minúsculas: ')

vocales = "iuíúü"
for letra in cadena:
    if letra in vocales:
        print("La cadena contiene una i o una u")
        print(letra)

# Tambien podemos hacerlo dos búsquedas por separado.
cadena = input('Introduce una cadena de texto en minúsculas: ').lower()


abiertas = "aeoáéó"
cerradas = "iuíúü"
for letra in cadena:
    if letra in abiertas:
        print("La cadena contiene una vocal abierta")
        print(letra)
        continue
    if letra in cerradas:
        print("La cadena contiene una vocal cerrada")
        print(letra)

#######################
# zip() y enumerate() #
#######################
"""
    ZIP = CREMALLERA
La función zip se utiliza para combinar dos o más iterables en una secuencia de 
tuplas, donde la i-ésima tupla contiene el i-ésimo elemento de cada uno de los 
iterables pasados.
Es decir, esta función agrupa los elementos de las listas, tuplas o cualquier 
otro iterable que se le pase como argumento.
"""

provincias = ["Bizkaia", "Gipuzkoa", "Álava", 'Navarra']
capitales = ['Bilbao', 'San Sebastián', 'Vitoria', "Pamplona"]

combinados = zip(provincias, capitales)
print(list(combinados))

for provincia, capital in zip(provincias, capitales):
    print(f"La capital de {provincia} es {capital}")


# La función enumerate se utiliza para agregar un contador a un iterable y devolverlo como un objeto enumerado.
print(list(enumerate(provincias)))

for indice, provincia in enumerate(provincias):
    print(f"La provincia número {indice} es {provincia}")
    print(capitales[indice])
