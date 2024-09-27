# -*- coding: utf-8 -*-

def pedir_password(func):
    def wrapper(self, *args, **kwargs):
        if input("Escribe password: ") == "1234":
            return func(self, *args, **kwargs)
        else:
            return "No te doy la información"
    return wrapper