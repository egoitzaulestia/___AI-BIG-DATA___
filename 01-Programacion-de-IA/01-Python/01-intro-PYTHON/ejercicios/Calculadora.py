# -*- coding: utf-8 -*-
"""
Created on Wed Sep 11 11:39:01 2024

@author: 2425BIGDATA401
"""

# Calculadora simple

def sumar(num1, num2):
    resultado_suma = num1 + num2
    return resultado_suma

def restar(num1, num2):
    resultado_resta = num1 - num2
    return resultado_resta

def multiplicar(num1, num2):
    resultado_multiplicar = num1 * num2
    return resultado_multiplicar

def division(num1, num2):
    resultado_division = num1 / num2
    return resultado_division

# def recoger_numeros():
#     num1 = int(input("Introduce el primer número: "))
#     num2 = int(input("Introduce el segundo número: "))
#     return num1, num2

def recoger_numeros():
    num1 = input("Introduce el primer número: ")
    if num1.isnumeric():
        num1 = float(num1)
    else:
        print("No es un número")
        return False
        
    num2 = input("Introduce el segundo número: ")

    if num2.isnumeric():
        num2 = float(num2)
    else:
        print("No es un número")
        return False
    return num1, num2



def calculadora():
    operacion_selecionada = int(input("""
                 CALCULADORA PYTHON
                 ------------------
                 SUMA = pulse tecla 1
                 RESTA = pulse tecla 2
                 MULTIPLICAR = pulse 3
                 DIVISIÓN = pulse 4
                 ------------------
                 inroduzca la opción deseada aquí: """))
                 
    # num1 = int(input("Introduce el primer número: "))
    # num2 = int(input("Introduce el segundo número: "))
    
    info = {
        1: "Has elegido sumar",
        2: "Has elegido restar",
        3: "Has elegido multiplicar",
        4: "Has elegido dividir"
    }
    
    if operacion_selecionada not in [1, 2, 3, 4]:
        print("Opción equivocada")
        return False
    else:
        print(info[operacion_selecionada])
    
    numeros = recoger_numeros()
    if numeros:
        num1, num2 = numeros
    else:
        return False
    
    match operacion_selecionada: 
        case 1:
            resultado = sumar(num1, num2)
            respuesta = f"La suma entre {num1} y {num2} en {resultado}"
            return respuesta
        case 2:
            resultado = restar(num1, num2)
            respuesta = f"La resta entre {num1} y {num2} es igual a {resultado}"
            return respuesta
        case 3:
            resultado = multiplicar(num1, num2)
            respuesta = f"La multiplicación entre {num1} y {num2} es igual a {resultado}"
            return respuesta
        case 4:
            resultado = division(num1, num2)
            respuesta = f"La division entre {num1} y {num2} es igual a {resultado}"
            return respuesta

result = calculadora()
print(result)
