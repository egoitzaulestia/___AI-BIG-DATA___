#!/usr/bin/env python
# coding: utf-8

# # Mathplotlib

# Funciones de Mathplotlib
# 
# ### Tipos de gŕaficos
# 
# * Bar Para pintar gráficos de barras.
# * Barh Pinta un gráfico de barras horizontal.
# * Boxplot Pinta gráficos de barrasMake a box and whisker plot.
# * Hist Pinta un histograma.
# * hist2d Crea un histograma en 2D.
# * Pie Pinta un gráfico de tarta.
# * Plot Pinta líneas o marcadores en los ejes.
# * Polar Pinta un plot en base a coordenadas polares.
# * Scatter Pinta un gráfico de dispersión (x vs y).
# * Stackplot Pinta un gráfico de áreas apiladas.
# * Stem Crea un gráfico de tallos y hojas.
# * Step Crea un gráfico (mercado de valores).
# * Quiver Crea un campo de flechas en un gráfico 2-D.
# 
# ### Funciones de los ejes
# 
# * Axes Añade ejes a la figura.
# * Text Añade texto a los ejes.
# * Title Añade título a la gráfica.
# * Xlabel Añade título al eje X.
# * Xlim Obtiene o establece los límites del eje x.
# * Xscale Establece el escalado del eje x.
# * Xticks 
# * Ylabel Añade título al eje Y.
# * Ylim Obtiene o establece los límites del eje y.
# * Yscale Establece el escalado del eje y.
# * Yticks 
# 
# ### Funciones de los gráficos (figuras)
# 
# * Figtext Añade texto a la figura.
# * Figure Crea una nueva figura.
# * Show Muestra una figura (gráfico).
# * Savefig Guarda el gráfico actual.
# * Close Cerrar el gráfico actual.
# 
# 
# La instalación puede hacerse a través de **pip install matplotlib**

# In[3]:


import matplotlib.pyplot as plt
import numpy as np
import math
from pylab import *


# In[5]:


# Generamos un set de datos.  Básicamente una función senoidal
x=np.arange(0, math.pi*2, 0.05) # Rango de datos para pintar el eje X
y=np.sin(x)
print(x)
print(y)


# In[6]:


plt.plot(x,y)


# NOTA: En el caso de que las gráficas no se 'pinten' en pantalla desde un notebook jupiter, podemos incluir la directiva siguiente:
# **%matplotlib inline**

# In[7]:


# Añadimos 'cosas'
# Título y etiquetas
plt.xlabel("Ángulo")
plt.ylabel("Seno")
plt.title('Onda senoidal')


# In[10]:


# ¿Qué ha pasado? ¿Dónde está la gráfica?
plt.plot(x,y)
plt.xlabel("Ángulo")
plt.ylabel("Seno")
plt.title('Onda senoidal')
plt.show()


# In[17]:


x = linspace(-3, 3, 30) # Creación de un rango de datos entre -3 y 3 dividido en 30 partes.
y = x**2
plt.plot(x, y)
plt.show()


# Podemos modificar cosas...
# Por ejemplo cambiar el elemento 'a pintar' en la gráfica en rojo y con + 'r+'

# In[23]:


plt.plot(x, y, 'r+')
plt.show()


# In[22]:


plt.plot(x, y, 'b>')
plt.show()


# ### Los códigos de color disponibles son:
# * ‘b’ Blue
# * ‘g’ Green
# * ‘r’ Red
# * ‘c’ Cyan
# * ‘m’ Magenta
# * ‘y’ Yellow
# * ‘k’ Black
# * ‘w’ White

# ### Los marcadores que podemos usar son:
# * '.' Point marker
# * 'o' Circle marker
# * 'x' X marker
# * 'D' Diamond marker
# * ‘H' Hexagon marker
# * 's’ Square marker
# * '+' Plus marker
# * '-' Solid line
# * '—' Dashed line
# * '-.' Dash-dot line
# * ':' Dotted line

# Mathplotlib, pinta los objetos de manera modular, a medida que ejectua el código.  Eso significa que podemos superponer diferentes gráficos en la misma gráfica.

# In[24]:


plt.plot(x, sin(x))
plt.plot(x, cos(x), 'r-')
plt.plot(x, -sin(x), 'g--')
plt.show()


# Podemos definir los diferentes objetos que componen una gráfica.

# In[37]:


# Creamos el objeto figura
fig = plt.figure()
# Añadimos los ejes.  add_axes espera una lista con 4 elementos correspondientes a los elementos izquierda, abajo, ancho y altura de los ejes.
ax=fig.add_axes([0,0,1,1])
# Definir el título y etiquetas de los ejes en la figura.
ax.set_title("Onda senoidal")
ax.set_xlabel('Ángulo')
ax.set_ylabel('Seno')
ax.plot(x,y)
plt.show()


# In[43]:


# En el caso de que no se vea la gráfica...
get_ipython().run_line_magic('matplotlib', 'inline')
fig = plt.figure()
ax=fig.add_axes([0,0,1,1])
ax.set_title("Onda senoidal")
ax.set_xlabel('Ángulo')
ax.set_ylabel('Seno')
ax.plot(x,y)
plt.show()


# In[57]:


# Podemos añadir una leyenda al gráfico.
fig = plt.figure()
ax=fig.add_axes([0,0,1,1])
ax.set_title("Onda senoidal")
ax.set_xlabel('Ángulo')
ax.set_ylabel('Seno')
ax.plot(x,y)
ax.legend(labels=('H'),loc='lower right')
plt.show()


# ### Las opciones disponibles para localizar la leyenda son:
# * Best 
# * upper right
# * upper left
# * lower left
# * lower right
# * Right
# * center left
# * Center right
# * lower center
# * upper center 
# * Center

# In[60]:


# Pintamos un gráfico que incorpore lo visto hasta ahora.
y = [1, 4, 9, 16, 25,36,49, 64]
x1 = [1, 16, 30, 42,55, 68, 77,88]
x2 = [1,6,12,18,28, 40, 52, 65]
fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
l1=ax.plot(x1,y,'ys-') # Línea amarilla y marcador cuadrado
l2=ax.plot(x2,y,'go--') # Línea discontínua en verde y marcador redondo
ax.legend(labels=('Tv', 'Smartphone'), loc='lower right') # Ubicación en la esquina inferior derecha de la leyenda
ax.set_title("Efecto publicidad en ventas")
ax.set_xlabel('Medio')
ax.set_ylabel('Ventas')
plt.show()


# ### Subplots
# A través de esta opción podremos pintar diferentes gráficas en el mismo 'lienzo'
# 
# **plt.subplot(subplot(nrows, ncols, index))**

# En este sentido plt.subplot([1,2,1]), define un lienzo con 1 fila, 2 columnas y el gráfico a pintar ocupará la 1a posición.

# In[67]:


# Pintar una línea en un gráfico.  De manera implícita estamos creando un subplot (111)
plt.plot([1,2,3,4])


# In[72]:


# Creamos ahora un subplot compuesto de una malla con 2 filas y 1 columna
plt.subplot(211)
plt.plot(range(12))
plt.subplot(212, facecolor='g') # generamos el segundo plot, con un fondo verde.  
plt.plot(range(12), 'w')


# In[74]:


# Podemos superponer subplots en otros
fig=plt.figure()
ax1=fig.add_subplot(111)
ax1.plot([1,2,3])
ax2=fig.add_subplot(221, facecolor='y')
ax2.plot([1,2,3])
plt.show()

# Vemos que al definir un subplot diferente en ax1 y ax2, las 2 gráficas se superponen.


# In[76]:


# Otro ejemplo
x=np.arange(0, math.pi*2, 0.05)
fig=plt.figure()
axes1 = fig.add_axes([0.1, 0.1, 0.8, 0.8]) # ejes de la gráfica principal
axes2 = fig.add_axes([0.55, 0.55, 0.3, 0.3]) # ejes de la gráfica secundaria
y=np.sin(x)
axes1.plot(x, y, 'b')
axes2.plot(x,np.cos(x),'r')
axes1.set_title('seno')
axes2.set_title('coseno')
plt.show()


# In[79]:


# También nos puede interesar, no superponer gráficas, sino contraponerlas...
fig,a= plt.subplots(2,2)
x=np.arange(1,5)
a[0][0].plot(x,x*x)
a[0][0].set_title('cuadrado')
a[0][1].plot(x,np.sqrt(x))
a[0][1].set_title('raíz cuadrada')
a[1][0].plot(x,np.exp(x))
a[1][0].set_title('exp')
a[1][1].plot(x,np.log10(x))
a[1][1].set_title('log')
plt.show()


# In[85]:


# Siguiendo la metodología previa, podemos generar gráficas de diferente tamaño
a1= plt.subplot2grid((3,3),(0,0),colspan=2) # Pinta a1 en una malla de 3x3, en la posición 0,0 y compuesta de 2 columnas (2 celdas en la malla)
a2=plt.subplot2grid((3,3),(0,2), rowspan=3) # Pinta a2 en una malla de 3x3, en la posición 0,2 y compuesta de 3 filas (3 celdas en la malla)
a3=plt.subplot2grid((3,3),(1,0),rowspan=2, colspan=2) # Pinta a3 en una malla de 3x3, en la posición 1,0 y compuesta de 2 filas y 2 columnas (4 celdas en la malla)
x=np.arange(1,10)
a1.plot(x, np.exp(x))
a1.set_title('exp')
a2.plot(x, x*x)
a2.set_title('cuadrado')
a3.plot(x, np.log(x))
a3.set_title('log')
plt.tight_layout()
plt.show()


# In[88]:


# Jugamos un poco con las opciones...
a1= plt.subplot2grid((3,3),(0,0),colspan=1)
a2=plt.subplot2grid((3,3),(0,2), rowspan=3)
a3=plt.subplot2grid((3,3),(2,0),rowspan=1, colspan=2)
x=np.arange(1,10)
a1.plot(x, np.exp(x))
a1.set_title('exp')
a2.plot(x, x*x)
a2.set_title('cuadrado')
a3.plot(x, np.log(x))
a3.set_title('log')
plt.tight_layout()
plt.show()


# ### Cuadrícula en la gráfica

# In[98]:


# Por claridad, nos puede interesar mostrar la cuadrícula en el gráfico

fig, axes = plt.subplots(1,3, figsize=(12,4))
x=np.arange(1,11)
axes[0].plot(x, x**3, 'g',lw=20) # Modificado grosor de la línea del gráfico.
axes[0].grid(True)
axes[0].set_title('cuadrícula por defecto')
axes[1].plot(x, np.exp(x), 'r')
axes[1].grid(color='b', ls='-.', lw=.5)
axes[1].set_title('cuadrícula personalizada')
axes[2].plot(x,x)
axes[2].set_title('sin cuadrícula')
fig.tight_layout()
plt.show()


# ### Invertir los ejes

# In[9]:


fig, axes = plt.subplots(1,3, figsize=(12,4))
x=np.arange(1,11)
axes[0].plot(x, x**3, 'g',lw=20) # Modificado grosor de la línea del gráfico.
axes[0].grid(True)
axes[0].set_title('cuadrícula por defecto')
axes[1].plot(x, np.exp(x), 'r')
axes[1].grid(color='b', ls='-.', lw=.5)
axes[1].set_title('cuadrícula personalizada')
axes[2].plot(x,x)
axes[2].set_title('sin cuadrícula')

# Invertimos los ejes en la primera gráfica
axes[0].invert_xaxis()
axes[0].invert_yaxis()

fig.tight_layout()

plt.show()


# ### Formateando los ejes

# In[100]:


fig, axes = plt.subplots(1, 2, figsize=(10,4))
x=np.arange(1,5)
axes[0].plot( x, np.exp(x))
axes[0].plot(x,x**2)
axes[0].set_title("Escala normal") # Definimos el título del eje X
axes[1].plot (x, np.exp(x))
axes[1].plot(x, x**2)
axes[1].set_yscale("log") # Definimos la escala logarítmica en el eje Y
axes[1].set_title("Escala logarítmica (y)")
axes[0].set_xlabel("eje x")
axes[0].set_ylabel("eje y")
axes[0].xaxis.labelpad = 10
axes[1].set_xlabel("eje x")
axes[1].set_ylabel("eje y")
plt.show()


# In[7]:


# Añadir color a los ejes y mdificar su grosor
fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
ax.spines['bottom'].set_color('blue')
ax.spines['left'].set_color('red')
ax.spines['left'].set_linewidth(8) # Grosor
ax.spines['right'].set_color('green')
ax.spines['top'].set_color('grey')
ax.spines['top'].set_linewidth(8) # Grosor
ax.plot([1,2,3,4,5])
plt.show()


# ### Limitando los ejes

# In[8]:


fig=plt.figure()
a1=fig.add_axes([0,0,1,1])
x=np.arange(1,10)
a1.plot(x, np.exp(x))
a1.set_title('exp')
plt.show()


# In[10]:


# Ahora limitamos los valores del eje X a 5 e Y a 5000
fig=plt.figure()
a1=fig.add_axes([0,0,1,1])
x=np.arange(1,10)
a1.plot(x, np.exp(x),'r')
a1.set_title('exp')
a1.set_ylim(0,5000)
a1.set_xlim(0,5)
plt.show()


# ### Edición de los marcadores de los ejes

# In[13]:


# A través de xticks() y set_xlabels()
x=np.arange(0, math.pi*2, 0.05)
fig=plt.figure()
ax = fig.add_axes([0.1, 0.1, 0.8, 0.8]) # ejes principales
y=np.sin(x)
ax.plot(x, y)
ax.set_xlabel('ángulo')
ax.set_title('seno')
ax.set_xticks([0,2,4,6])
ax.set_xticklabels(['cero','dos','cuatro','seis'])
ax.set_yticks([-1,0,1])
plt.show()


# ### Dobles ejes (Y)
# Podemos contraponer 2 variables en 2 ejes diferentes

# In[14]:


fig=plt.figure()
a1=fig.add_axes([0,0,1,1])
x=np.arange(1,11)
a1.plot(x,np.exp(x))
a1.set_ylabel('exp')
a2=a1.twinx()
a2.plot(x, np.log(x),'ro-')
a2.set_ylabel('log')
fig.legend(labels=('exp','log'),loc='upper left')
plt.show()


# ## Pintando unas gráficas

# ### Gráficos de barras

# **ax.bar(x, height, width, bottom, align)**
# 
# * x: datos x a representar (en formato array)
# * height: datos y a representar (en formato array)
# * width: ancho de las barras (en formato array)
# * bottom: define el origen de datos para el eje Y
# * align: alineación de los datos,'center' o 'edge', respecto de los marcadores (ticks)
# 
# ¡Ojo! Porque si definimos bottom, se desplaza el eje Y.  En el ejemplo, Y=23, tras el desplazamiento se representa como Y=123

# In[22]:


fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
prod=['TV', 'Netflix', 'Pluto', 'Rakuten', 'Otros']
usuarios=[23,17,35,29,12]
ax.bar(prod,usuarios, bottom=100, align="edge")
plt.show()


# In[23]:


fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
prod=['TV', 'Netflix', 'Pluto', 'Rakuten', 'Otros']
usuarios=[23,17,35,29,12]
ax.bar(prod,usuarios, bottom=100, align="center")
plt.show()


# In[26]:


data = [[30, 25, 50, 20],[40, 23, 51, 17],[35, 22, 45, 19]]
X = np.arange(4)
fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
ax.bar(X + 0.00, data[0], color = 'b', width = 0.25)
ax.bar(X + 0.25, data[1], color = 'g', width = 0.25)
ax.bar(X + 0.50, data[2], color = 'r', width = 0.25)


# In[27]:


# Ahora definimos los nombres de los marcadores del eje X
data = [[30, 25, 50, 20],[40, 23, 51, 17],[35, 22, 45, 19]]
X = np.arange(4)
fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
ax.bar(X + 0.00, data[0], color = 'b', width = 0.25)
ax.bar(X + 0.25, data[1], color = 'g', width = 0.25)
ax.bar(X + 0.50, data[2], color = 'r', width = 0.25)
ax.set_xticks([0.25,1.25,2.25,3.25])
ax.set_xticklabels([2015,2016,2017,2018])
ax.legend(labels=['CS','IT','E&TC'])
plt.show()


# In[34]:


# Barras apiladas.  Aplimos diferentes categorías en las posiciones X
N = 5
menMeans = (20, 35, 30, 35, 27)
womenMeans = (25, 32, 34, 20, 25)
ind = np.arange(N) # the x locations for the groups
width = .85
fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
ax.bar(ind, menMeans, width, color='r')
ax.bar(ind, womenMeans, width,bottom=menMeans, color='b') # usamos botom para definir la posición de partida de los segundos datos.
ax.set_ylabel('Valores')
ax.set_title('Valores por grupo y sexo')
ax.set_xticks(ind)
ax.set_xticklabels(['G1', 'G2', 'G3', 'G4', 'G5'])
ax.set_yticks(np.arange(0, 81, 10))
ax.legend(labels=['Mujeres', 'Hombres'])
plt.show()


# ### Histogramas
# * x: Valores a representar
# * bins: Total de elementos a representar sobre le eje X (opcional)
# * range: Rango de los datos.
# * density:
# * cumulative: Representar los datos de manera acumulativa
# * histtype: Permite bar, barstacked, step y stepfilled
# 
# 

# In[35]:


fig,ax=plt.subplots(1,1)
a = np.array([22,87,5,43,56,73,55,54,11,20,51,5,79,31,27])
ax.hist(a, bins = [0,25,50,75,100]) # Limitamos el rango de representación de los datos.  Agrupamos los datos por rangos
ax.set_title("Histograma")
ax.set_xticks([0,25,50,75,100])
ax.set_xlabel('Puntuación')
ax.set_ylabel('# de estudiantes')
plt.show()


# ### Boxplot 
# Muy usado en Data Science

# In[99]:


np.random.seed(123)
set1 = np.random.normal(100, 10, 250)
set2 = np.random.normal(80, 30, 250)
set3 = np.random.normal(90, 20, 250)
set4 = np.random.normal(70, 25, 250)


# In[100]:


datos = [set1, set2, set3, set4]

fig = plt.figure()
ax = fig.add_axes([0,0,1,1])

bp = ax.boxplot(datos)
plt.show()


# ### Gráfico de violin 
# Similar al boxplot, pero con un gráfico rotado a cada lado

# In[101]:


fig = plt.figure()
ax = fig.add_axes([0,0,1,1])

bp = ax.violinplot(datos)
plt.show()


# ### Gráfico de tarta/sectores
# 
# Sólo permiten representar una serie de datos a la vez.
# * x: datos a representar
# * labels: etiquetas de los datos (lista)
# * colors: colores a usar para representar los datos
# * autopct: añadir a los sectores su valor numérico

# In[38]:


fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
prod=['TV', 'Netflix', 'Pluto', 'Rakuten', 'Otros']
usuarios=[23,17,35,29,12]
ax.axis('equal')
ax.pie(usuarios, labels=prod, autopct='%1.2f%%')
plt.show()


# ### Gráfico de dispersión
# 

# In[40]:


valoracion_mujeres = [89, 90, 70, 89, 100, 80, 90, 100, 80, 34]
valoracion_hombres = [30, 29, 49, 48, 100, 48, 38, 45, 20, 30]
rango_valoraciones = [10, 20, 30, 40, 50, 60, 70, 80, 90, 100]
fig=plt.figure()
ax=fig.add_axes([0,0,1,1])
ax.scatter(rango_valoraciones, valoracion_mujeres, color='r')
ax.scatter(rango_valoraciones, valoracion_hombres, color='b')
ax.set_xlabel('Rango valoraciones')
ax.set_ylabel('Valoración alcanzadas')
ax.set_title('Gráfico de dispersión')
ax.legend(labels=['Mujeres', 'Hombres'])
plt.show()


# ### Trabajando con textos
# 
# Admite los siguientes argumentos:
# * text:  Añade texto a una gráfica.
# * annotate:  Añade una anotación (flecha opcional) para un texto.
# * xlabel: Añade etiqueta al eje X.
# * ylabel: Añade etiqueta al eje Y.
# * title: Añade título a los ejes.
# * figtext: Añade texto en una ubicación arbitraria.
# * suptitle: Añade título al gráfico.

# In[103]:


fig = plt.figure()
ax = fig.add_axes([0,0,1,1])
ax.set_title('Título gráfico')
ax.set_xlabel('Etiqueta eje X')
ax.set_ylabel('Etiqueta eje Y')
ax.text(3, 8, 'Texto con estilo itálica', style='italic', bbox={'facecolor': 'red'})
ax.text(2, 6, r'una ecuación cualquiera: $E=mc^2$', fontsize=15)
ax.text(4, 0.05, 'texto coloreado en los ejes', verticalalignment='bottom', color='green', fontsize=15)
ax.plot([2], [1], 'o')
ax.annotate('Referencia a un elemento en el gráfico', xy=(2, 1), xytext=(3, 4), arrowprops=dict(facecolor='black', shrink=0.05))
ax.axis([0, 10, 0, 10])
plt.show()


# ### Gráficas 3D

# #### Línea en 3D

# In[1]:


from mpl_toolkits import mplot3d


# In[7]:


fig = plt.figure()
ax = plt.axes(projection='3d')
z = np.linspace(0, 1, 100)
x = z * np.sin(30 * z)
y = z * np.cos(30 * z)
ax.plot3D(x, y, z, 'red')
ax.set_title('3D line plot')
plt.show()


# #### Contorno 3D

# In[8]:


from mpl_toolkits import mplot3d

def f(x, y):
    return np.sin(np.sqrt(x ** 2 + y ** 2))

x = np.linspace(-6, 6, 30)
y = np.linspace(-6, 6, 30)
X, Y = np.meshgrid(x, y)
Z = f(X, Y)


fig = plt.figure()
ax = plt.axes(projection='3d')
ax.contour3D(X, Y, Z, 50, cmap='binary')
ax.set_xlabel('x')
ax.set_ylabel('y')
ax.set_zlabel('z')
ax.set_title('Contorno 3D')
plt.show()


# ### Diagramas de contorno
# 

# In[53]:


xlist[:10]


# In[57]:


xlist = np.linspace(-3.0, 3.0, 100)
ylist = np.linspace(-1.0, 3.0, 100)
print(xlist[:10])
print(ylist[:10])
X, Y = np.meshgrid(xlist, ylist)
#print(X)
#print(Y)
Z = np.sqrt(X**2 + Y**2)
print(Z)
fig,ax=plt.subplots(1,1)
cp = ax.contourf(X, Y, Z)
fig.colorbar(cp) # Add a colorbar to a plot
ax.set_title('Filled Contours Plot')
#ax.set_xlabel('x (cm)')
ax.set_ylabel('y (cm)')
plt.show()


# ### Gráfica de vectores o quiver

# Son necesarios los siguientes parámetros para dibujar un gráfico de vectores:
# * x: Secuencia o un array unidimensional o bidimensional para las coordenadas de ubicación del eje X
# * y: Secuencia o un array unidimensional o bidimensional para las coordenadas de ubicación del eje Y
# * u: Secuencia o un array unidimensional o bidimensional para los componentes del eje X
# * v: Secuencia o un array unidimensional o bidimensional para los componentes del eje Y
# * c: Secuencia o un array unidimensional o bidimensional para los colores de las flechas.
# 
# Todos los elementos deberán tener las mismas dimensiones.
#     

# In[61]:


x,y = np.meshgrid(np.arange(-2, 2, .2), np.arange(-2, 2, .25))
z = x*np.exp(-x**2 - y**2)
v, u = np.gradient(z, .2, .2)
fig, ax = plt.subplots()
q = ax.quiver(x,y,u,v)
plt.show()


# In[97]:


x,y = np.meshgrid(np.arange(-2, 2, .2), np.arange(-2, 2, .25))
z = x*np.exp(-x**2 - y**2)
v, u = np.gradient(z, .2, .2)
fig, ax = plt.subplots()
c = x+y
q = ax.quiver(x,y,u,v,c)
plt.show()


# In[91]:


# Otro ejemplo, con 2 plots

# Definimos la malla para los plots
fig, (ax1, ax2) = plt.subplots(1, 2, figsize =(14, 8))

# Primer subplot
# Generación de los vectores
x = np.arange(0, 2.2, 0.2)
y = np.arange(0, 2.2, 0.2)
X, Y = np.meshgrid(x, y)
u = np.cos(X)*Y
v = np.sin(y)*Y
n = -2
 
# Definición del color
color = np.sqrt(((v-n)/2)*2 + ((u-n)/2)*2)
 
# Creación del plot
ax1.quiver(X, Y, u, v, color, alpha = 0.8)
ax1.xaxis.set_ticks([])
ax1.yaxis.set_ticks([])
ax1.axis([-0.2, 2.3, -0.2, 2.3])
ax1.set_aspect('equal')
ax1.set_title('Función meshgrid')
 
# Segundo subplot
# Creación de los vectores
x = np.arange(-2, 2.2, 0.2)
y = np.arange(-2, 2.2, 0.2)
X, Y = np.meshgrid(x, y)
z = X * np.exp(-X**2 -Y**2)
dx, dy = np.gradient(z)
n = -2
 
# Defining color
color = np.sqrt(((dx-n)/2)*2 + ((dy-n)/2)*2)
 
# Creating plot
ax2.quiver(X, Y, dx, dy, color)
ax2.xaxis.set_ticks([])
ax2.yaxis.set_ticks([])
ax2.set_aspect('equal')
ax2.set_title('gradient')
 
 
# show figure
plt.tight_layout()
plt.show()


# In[ ]:




