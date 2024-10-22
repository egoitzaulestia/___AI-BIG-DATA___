
El dataset de los libros de Harry Potter lo he encontrado en la plataforma Kaggle:

https://www.kaggle.com/gulsahdemiryurek/harry-potter-dataset

Es un dataset que contiene 5 archivos csv.
- Harry_Potter_1,Harry_Potter_2 y Harry_Potter_3: Se corresponden a las frases que dice cada personaje en cada uno
	 de los tres primeros libros.
- Characters: Resumen de los personajes que toman parte en los libros, junto con varias caracteristicas.
- Potions and Spells: Cada uno de los archivos contiene un listado de las pociones y encantamientos utilizados en los libros,
	 junto con varias caracteristicas.



El shiny se compone de 4 pestañas:

- Pestaña Book: En esta pestaña, podemos ver un resumen del Top 10 de los personajes que mas frases tienen en los libros.
 Se ha añadido un selectro multiple, para que el usuario pueda elegir que datos visualizar.
 Ademas del grafico se ha añadido una pestaña donde se visualiza una tabla resumen de los datos.

- Pestaña Houses: Aqui se puede ver un grafico resumen de los personajes divididos en funcion de la casa/escuela a la que pertenecen.
 Ademas del grafico se ha añadido una pestaña donde se visualiza una tabla resumen de los datos.

- Pestaña Potions: Para esta pestaña, se ha creado un buscador de pociones en funcion de la letra por la que empiecen 

- Pestaña Spells: Para esta pestaña, se ha creado un buscador de Encantamientos en funcion de la letra por la que empiecen 


PUBLICACION

A la hora de publicarlo en shinyApps, encontré un problema en el codigo y por ello no me dejaba publicarlo.
Es la linea 36 del archivo global. Parece ser que la función que utilicé para corregir los nombres de los personajes no le gusta.
Probé a publicarlo sin eso, y no me surgió ningun problema. 

Muchas gracias por la formación impartida en este area. Un saludo

