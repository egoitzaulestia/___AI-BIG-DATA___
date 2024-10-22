#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Sep 28 16:21:29 2024

@author: egoitzaulestiapadilla
"""

# Función decoradora para pedir el password
def pedir_password(func):
    def wrapper(self, *args, **kwargs):
        if input("Escribe password: ") == "1234":
            return func(self, *args, **kwargs)
        else:
            return "No te doy la información"
    return wrapper