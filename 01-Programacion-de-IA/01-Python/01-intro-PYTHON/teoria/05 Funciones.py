"""
Spyder Editor

This is a temporary script file.
"""

#############
# FUNCIONES #
#############

"""
**¿Qué es una función en Python?**

Una función en Python es un bloque de código reutilizable que realiza una tarea 
específica. 
Puedes pensar en una función como una especie de máquina que toma ciertos 
valores de entrada, realiza un conjunto de acciones con esos valores y 
luego devuelve un resultado. 

Las funciones son una parte fundamental de la programación porque nos permiten 
dividir nuestro código en partes más pequeñas y manejables, lo que facilita la 
lectura, la depuración y la reutilización del código.

**¿Por qué son importantes las funciones?**

Las funciones son importantes por varias razones:

1. **Reutilización de código:** Puedes escribir una función una vez y usarla 
muchas veces en tu programa. Esto ahorra tiempo y evita la repetición de código.

2. **Facilitan la lectura:** Dividir tu programa en funciones más pequeñas hace 
que sea más fácil de entender y mantener. Cada función se enfoca en una tarea 
específica.

3. **Modularidad:** Las funciones permiten dividir un programa en módulos más 
pequeños, lo que facilita el desarrollo colaborativo. Diferentes programadores 
pueden trabajar en funciones diferentes.

4. **Depuración:** Si tienes un error en tu programa, las funciones te ayudan a 
aislar y solucionar problemas más fácilmente, ya que puedes probar cada función 
por separado.
"""

# Las funciones pueden requerir argumentos o no
def dime_algo():
    print("Algo")


# Aunque no haya argumentos los paréntesis son obligatorios para que se ejecute
dime_algo
dime_algo()
variable = dime_algo()
type(variable)

# Los argumentos son tuplas con elementos que van entre paréntesis
def dime(mensaje):
    mensaje = mensaje.upper()
    print(mensaje)

dime("Buenos días")
dime("Buenas tardes")

# Las funciones pueden devolver un valor o no
# Las funciones anteriores no devuelven ningún valor
resultado = dime("Buenos días")
# resultado es un objeto NoneType. Es decir, no es nada
type(resultado)

# Creamos una funcion que sume + 1 y devuelva el valor.
def suma1(x: int) -> int:
    # Esto de abajo es un "doc string"
    """
    Suma una unidad al parámetro recibido
    """
    y = x + 1
    return y


sumado = suma1(234)
# El resultado se devuelve en la consola porque es el comportamiento de spyder,
# pero lo normal es guardarlo para usarlo después...
resultado = suma1(233.4)



resultado*2

# Función para comprobar si un número es par o impar
def es_par(num: int) -> bool:
    """
    Entrada: num, número entero positivo. 
    Devuelve True si el número es par, 
    de otra manera devuelve False.
    """
    salida = (num % 2 == 0)
    return salida

# Puedo ver el "return"

es_par(124)
es_par(1987)

# ...o bien usarlo sin guardarlo.
def imprime_si_es_par(num):
    if es_par(num):
        print("Es par")
    else:
        print("Es impar")

imprime_si_es_par(129)

# Función para multiplicar con dos argumentos
# En lugar de multiplicar, estamos sumando 'a', 'b' veces
def multiplicacion(a, b):
    resultado = 0
    while b > 0:
        resultado += a
        #print(resultado, b)
        b -= 1
    return resultado


multiplicacion(5, 80)
valor = multiplicacion(5, 20)
valor

isinstance(valor, int)

# Ejercicio: Crear una función que reciba dos parámetros y 
# que compruebe si el primer número es divisible entre el segundo


def segundo_num_es_divisible(num1, num2):
    # num1 = input("Introuduce el primer número: ")
    # num2 = input("Introuduce el segundo número: ")
    # while isinstance(obj, class_or_tuple)
    
    if num1 % num2  == 0:
        return True
    else:
        return False
    
resultado = segundo_num_es_divisible(20, 4)
    
print(resultado)



#  Versión PROFE
def divisible(numerador, denomidador):
    if denomidador == 0:
        salida = False
    
    elif not isinstance(numerador, (float, int)) or isinstance(denomidador, (float, int)):
        print("No vale meter otra cosa números")
        salida = False
    
    elif (numerador % denomidador) == 0:
        salida = True
    else:
        salida = False
    return salida

0 == 0.0 # True
1 == 1.0 # True
1 == True # True


# Se ejecutará así 
es_divisible = divisible(30, 5)
es_divisible


# ---------------------------

def divisible(num1, num2):
    if num1 % num2 == 0:
        print(num1, "es divisible entre", num2)
        return True
    else:
        print(num1, "NO es divisible entre", num2)
        return False

es_divisible = divisible(31, 5)


##################################################################
# Parámetros posicionales y parámetros con nombre en una función #
##################################################################

# Función que devuele el valor de una ecuación de 2ºgrado

def evaluar_cuadratica(a, b, c, x):
    '''
    a, b, c: valores numéricos de los coeficientes de una ecuación
    de segundo grado
    x: valor de la variable x.
    '''
    solucion = a*x*x+b*x+c
    return solucion

evaluar_cuadratica(2, 2, 3, 8)  # f(x=8) = 2x² + 2x + 3

# El problema de invocar esta funcion así es que
# tengo que acordarme del orden de los coeficientes
evaluar_cuadratica(a = 2, b = 2, c = 3, x = 8)

evaluar_cuadratica(x = 8, c = 3, a = 2, b = 2)

# Así sí
evaluar_cuadratica(2, 2, x=8, c=3)

# Así no
# evaluar_cuadratica(a=2, 2, 3, 8) # Si metemos un keyword argument, debemos de meter los siguientes así también si no nos dara error
# Siempre los keyword arguments AL FINAL

# Si quiero forzar que los argumentos sólo puedan introducirse por clave-valor
# puedo reescribir la función así (Sólo cambia el asterisco en los parámetros):
def evaluar_cuadratica(*, a, b, c, x):
    '''
    a, b, c: valores numéricos de los coeficientes de una ecuación
    de segundo grado
    x: valor de la variable x.
    '''
    solucion = a*x*x+b*x+c
    return solucion

# Si intentamos introducir ahora un argumento posicional obtendremos:
"""TypeError: evaluar_cuadratica() takes 0 positional arguments but 3 positional arguments (and 1 keyword-only argument) were given"""
# Error:
evaluar_cuadratica(2, 2, 3, x=8)
# Correcto:
evaluar_cuadratica(x = 8, c = 3, a = 2, b = 2)


# ¿Y si quiero calcular f(8) siendo f = x²+3?
evaluar_cuadratica(a=1, c=3, x=8)


# A los coeficientes puedo darles un valor "por defecto"
# Pero los argumentos sin valor por defecto deben ir ANTES que los otros
def evaluar_cuadratica_incompleta(x: float, a = 0, b = 0, c = 0) -> float:
    '''
    a, b, c: valores numéricos de los coeficientes de una ecuación
    de segundo grado
    x: valor de la variable x.
    '''
    solucion = a*x*x+b*x+c
    return solucion


evaluar_cuadratica_incompleta()
evaluar_cuadratica_incompleta(3)
evaluar_cuadratica_incompleta(a=1, c=3, x=8)
evaluar_cuadratica_incompleta(a=2, b=2, c=3, x=8)
evaluar_cuadratica_incompleta(3, b=2)


###########################
#    *args y **kwargs      #
###########################
# ¿Y si no sé el número de parámetros posicionales que voy a meter?
def imprime_lineas(a, *lineas):
    print(a.upper())
    for arg in lineas:
        print(arg)
    return a, lineas


num1 =3
imprime_lineas("Puedo imprimir", "las líneas", "que quiera", "fin", num1)
imprime_lineas("a")
a, lis = imprime_lineas("Puedo imprimir", "las líneas", "que quiera", "fin", num1)
print(a)
print(lis)

# Podría hacerlo con una lista
def imprime_lineas_con_lista(lista):
    for linea in lista:
        print(linea)

lista_a_imprimir = ("Puedo imprimir", "las líneas", "que quiera")
imprime_lineas_con_lista(lista_a_imprimir)

imprime_lineas_con_lista(["Puedo imprimir", "las líneas", "que quiera"])

# pero conviene saber lo que significa el asterisco porque aparece en la
# documentación de las funciones que importaremos
def imprime_lineas2(**argumentos_por_clave):
    for clave, valor in argumentos_por_clave.items():
        print(f'{clave}= {valor}')


imprime_lineas2(nombre='Juan', edad=30, ciudad='Madrid', calle = "calle")

# Esto podríamos haberlo hecho con un diccionario

def imprime_lineas_con_diccionario(diccionario):
    for clave, valor in diccionario.items():
        print(f'{clave}= {valor}')
        
diccionario = {"nombre":'Juan', "edad":30, "ciudad":'Madrid'}
imprime_lineas_con_diccionario(diccionario)

imprime_lineas_con_diccionario(nombre='Juan', edad=30, ciudad='Madrid', calle = "calle")
