#!/usr/bin/env python3
# -*- coding: utf-8 -*-
"""
Created on Sat Sep 28 16:21:29 2024

@author: egoitzaulestiapadilla
"""



from POO.APP_POO_Biblioteca import Libro, DVD, Revista



if __name__ == "__main__":
    
    libro_1 = Libro(2314, "Titanes", "Miguel Vartus", 345, 2023, "Español", "boomers", "Novela Fantástica", "libros")
    libro_2 = Libro(1542, "Guns", "Rails McTorth", 260, 2023, "Inglés", "North's word", "Novela Policíaca", "libros")
    
    libro_1.obtener_paginas()
    libro_2.obtener_paginas()
    
    libro_1.__gt__(libro_2)
    libro_1.__eq__(libro_2)
    
    print(libro_1)
    libro_1.mostrar_info_detallada()  # Password: 1234
    print(libro_2)
    libro_2.mostrar_info_detallada()  # Password: 1234
    

    libro_1.alquilar_objeto()
    libro_1.comprar(3, 5)
    
    libro_1.disponibilidad  # Password: 1234

    libro_1.alquilar_objeto()

    libro_1.devolver_objeto(False)  # False si el objeto esta defectuoso al entregar

    libro_1.balance  # Password: 1234
    
    libro_1.disponibilidad          # Password: 1234
    libro_1.desablitar_objeto()     # Password: 1234
    libro_1.disponibilidad          # Password: 1234
    libro_1.habilitar_objeto()      # Password: 1234
    libro_1.disponibilidad          # Password: 1234
    libro_1.disponibilidad = False  # Password: 1234
    libro_1.disponibilidad          # Password: 1234
    libro_1.disponibilidad = True   # Password: 1234

    
    dvd_1 = DVD(1010, "Matrix", "Hermanas Wachowski", 136, 18, "Blue-Ray", "Español", ["Español", "Ingles", "Esperanto"], 1999, "Ciencia Ficción", "películas")
    dvd_2 = DVD(1234, "Fight Club", "David Fincher", 139, 18, "Blue-Ray", "Español", ["Español", "Ingles", "Alemán", "Ucraniano"], 1999, "Thriller Psicológico", "películas")

    print(dvd_1)
    dvd_1.mostrar_info_detallada()  # Password: 1234

    print(dvd_2)
    dvd_2.mostrar_info_detallada()  # Password: 1234
     
    dvd_1.obtener_duracion()
    dvd_2.obtener_duracion()
    
    dvd_1.__gt__(dvd_2)
    dvd_1.__eq__(dvd_2)
    dvd_1.__lt__(dvd_2)

    dvd_1.consultar_subtitulos()
    dvd_2.consultar_subtitulos()    
    
    dvd_1.comprar(5, 15)
    dvd_1.alquilar_objeto()
    libro_1.devolver_objeto(True)  # True si el objeto está en buenas conciones
    dvd_1.balance


    revista_1 = Revista(3452, "AI Future", 2, "Machines World", 106, "Inteligencia Artificial", "Bimensual", 2024, "Inglés", "Septiembre", "Tecnología", "revistas")
    revista_2 = Revista(2345, "Otakumataku", 45, "Isiru Haito", 106, "Otakus", "Trimestral", 2023, "Español", "Abril", "Manga", "revistas")

    print(revista_1)
    revista_1.mostrar_info_detallada()
    
    print(revista_2)
    revista_2.mostrar_info_detallada()
    
    revista_1.obtener_tema()
