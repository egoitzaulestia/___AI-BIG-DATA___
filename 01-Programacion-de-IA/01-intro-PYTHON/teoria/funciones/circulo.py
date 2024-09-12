# -*- coding: utf-8 -*-

from math import pi

def area(r):
    result = round(pi * (r ** 2), 2)  
    return result

# area(5)


def perimetro(r):
    result = round(2 * pi * r, 2)
    return result

# perimetro(5)

if __name__ == "__main__":
    perimetro(5)