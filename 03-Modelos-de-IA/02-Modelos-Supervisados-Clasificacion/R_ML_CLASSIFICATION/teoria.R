
####################### MODELOS ##################################################

# IDEA GENERAL.


########## 1. REGRESIÓN LINEAL (SIMPLE Y MÚLTIPLE) ############################### 

# y = b_0 + b_1*x_1 + b_2*x_2 + ... + b_n*x_n
      # y -> v. dependiente
      # x_i -> v. independientes
      # b_i -> coeficientes 

#Los coefincientes b_i indican el aumento(+) o la perdida(-) de la v. dependiente, 
# b_0 -> la ganancia base
# b_i*x_i -> cuanto por cada unidad de x_i ganamos/perdemos en la y ('pendiente')



######### 2. ÁRBOL (REGRESIÓN/CLASIFICACIÓN) #####################################

# Con una sola variable independiente no es la mejor técnica que podemos utilizar

# 2.1. ÁRBOL de Clasificación:
#  Clasifican en categorias una determinada observación



# 2.2 ÁRBOL de Regresión:
#  Predecir valores. 

# IDEA GENERAL:

# Situados en el plano, con dos variables, el algoritmo divide los puntos del plano
# mediante rectas horizontales y verticales. Cada una de esas divisiones equivale 
# a 'bajar' un  nivel en el diagrama del árbol.
# Las divisiones hacen que los puntos de nuestros datos queden en uno de esos 
# determinados segmentos. Realmente el algoritmo lo que hace es mirar la entropia,
# como de juntos o como de dispersos pueden estar esos puntos o que similitud 
# tienen entre sí. Intenta agrupar puntos con características comunes.

# Cada una de estas divisiones (rectangulos) del plano es un nodo del árbol. 
# y que cada una de estas divisiones aporta una información lo suficientemente buena 
# para que la clasificacion final tenga sentido.

# El seguir dividiendo el árbol (plano) infinitamente tampoco tiene sentido, 
# porque cada punto nos quedaría en un nodo diferente (OVERFITTING).
# La idea es limitar cada nodo por la cantidad de puntos que contenga o bien 
# aplicar otras reglas de parada del algoritmo.

# El valor de la v.objetivo se define nodo a nodo (segmento) como la MEDIA de
# todos los puntos del mismo (para el caso de clasificación -> MODA)


# FUNCIONAMIENTO:

#Cada vez que dividimos el conjunto de datos(puntos) en diferentes porciones
#se crea un arbol, un diagrama, para decidir que valor se asigna a cada uno de 
#ellos.

#Las divisiones se hacen para cada variable con preguntas del tipo 
#x_i < konst. ? si/no y asi estableciendo asi rectangulos en el plano

# PREDICCIÓN.
# Usando los puntos/datos del correspondiente rectángulo, hace la media de todos 
# ellos, siendo este valor el que se le asocia a cada punto nuevo que caiga en él.
# Es decir, para todos los puntos que caen dentro de la misma hoja/nodo/sección
# el árbol nos da la misma predicción.





###########  3. RANDOM FOREST  #####################################################

# Random forest: Conjunto de árboles

# Versión mejorada del árbol de regresión porque un unico arbol puede tener un 
# poco de sesgo en el sentido de que a lo mejor cortara o no ramificara lo suficiente,
# pero cuando promediamos 500000 arboles de decision es muy dificil que la media 
# tambien este sesgada porque cada arbol ha aprendido con un conjunto diferente.


#FUNCIONAMIENTO DEL ALGORITMO:

# paso1: Elegir un numero aleatorio K que sera un subconjunto de los 
#        puntos de datos del Conjunto de Entrenamiento

# paso2: Construir el Arbol de Decision asociado a esos K puntos de datos.

# paso3: Elegir el número de arboles (Ntree) que queremos construir y repetimos los
#        pasos 1 y 2 hasta haber construido todos los árboles.

# paso4: Cada nuevo dato se evalua en los Ntree árboles y obtenemos una predicción
#        por cada uno de ellos (del valor de Y), y así la predicción final se obtiene
#        con el promedio de todas las predicciones Y de todos los árboles.



###############  3. XG BOOST  #####################################################

#En términos de rendimiento y velocidad de ejecución es EL MÁS POTENTE

# RECOMENDABLE para un conjunto GRANDE DE DATOS

# Los datos con los que trabaja el algoritmo tienen que estar en formato matriz

# VARIABLES en formato NUMÉRICO: 
#   ·Las que son numericas as.numeric()
#   ·Las que son factor as.numeric(as.factor)


