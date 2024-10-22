rm(list=ls())

# 1. Cargar los datos de trainmod (Los creados en el apartado anterior).

datos <- read.csv("trainmod.csv", header = TRUE, sep = ",", stringsAsFactors = TRUE)


# 2. Mostrar los datos.

show(datos)


# 3. Realizar un resumen estadístico de los datos y realizar una interpretación.

summary(datos)


# 4. Determinar los niveles existentes para la variable “Crisis”.

levels(datos$Crisis)


# 5. Sustituir los “Si” por “Crisis” y los “No” por “Burbuja”.

datos$Crisis = as.character(datos$Crisis)
datos$Crisis[datos$Crisis == "Si"] = "Crisis"
datos$Crisis[datos$Crisis == "No"] = "Burbuja"
datos$Crisis = as.factor((datos$Crisis))


# 6. Determinar la clase de cada uno de los datos.

sapply(datos, class)


# 7. Realizar un gráfico del precio de venta.

# Ejecutamos el gráfico de caja boxplot
boxplot(datos$SalePrice, main="Gráfico de Caja del Precio de Venta", ylab="Precio de Venta", col="blue")
# Observación:
# El gráfico de caja muestra una distribución asimétrica del precio de venta con varios valores atípicos 
# hacia la derecha (precios más altos), lo que indica que la mayoría de las casas se venden por precios más bajos, 
# con algunas excepciones que se venden a precios significativamente más altos.

library(ggplot2)
ggplot(datos,aes(x=SalePrice))+geom_histogram(binwidth=5000)


# 8. Realizar un histograma del precio de venta.
hist(datos$SalePrice, main = "Distribucion del Precio de Venta", 
     xlab = "Precio de Venta", ylab = "Frecuencia de Ventas", col= "blue")


# 9. Graficar el precio de venta en función de la variable MSZoning.

# Tambien podemos analizar la temperatura max en funcion de los eventos.
plot(datos$MSZoning, datos$SalePrice, main="Boxplots: Zonificación vs Precio de Venta", 
     xlab="Zonificación", ylab="Precio de Venta", las=2, cex.axis=0.5)


# 10. Mostrar, gráficamente la relación entre el precio de venta y “GrLivArea”. ¿Como es?.
#    ¿Y la relación con “LotArea”?.

# Scatter Plot (gráfico de nubes) del precio de venta y “GrLivArea”:
# Podemos observar que la mayoría de casas rondan entre los 750 y 1750 square feet (unos 70 y 160 m2).
# Se ovserva heterocedasticidad: si hacemos una regresión lineal la varianza de los errores no será constante en todas las observaciones realizadas.
# También se ven varios outliers o casos atípicos en el precio de ventas y la área habitable (GrLivArea)
plot(datos$GrLivArea, datos$SalePrice, main="Gráfico de Dispersión: Área Habitable vs Precio de Venta", 
     xlab="Área Habitable (GrLivArea)", ylab="Precio de Venta", col="blue")

# Scatter Plot (gráfico de nubes) del precio de venta y “LotArea”:
# En este caso, no tenemos una relación lineal (se ve más claro en la segunda gráfico) y vemos outliers muy exagerados en el área de la superficie (LotArea), 
# los cuales distorsionan la interpretación general del gráfico, al forzar una escala más amplia 
# que dificulta observar la tendencia central de los datos.
plot(datos$LotArea, datos$SalePrice, main="Gráfico de Dispersión: Área de la Superficie vs Precio de Venta", 
     xlab="Área de la Superficie (LotArea)", ylab="Precio de Venta", col="blue")

plot(datos$SalePrice, datos$LotArea, main="Gráfico de Dispersión: Área de la Superficie vs Precio de Venta", 
     xlab="Área de la Superficie (LotArea)", ylab="Precio de Venta", col="blue")


# 11. Realizar un gráfico de la variable “MSZoning”.

# Creamos un vector de tabla (vector nombrado) de frecuencias de MSZoning 
zonas = table(datos$MSZoning)

# Realizamos el gráfico de barras para visualizar cuántos datos pertenecen a cada categoría de zonificación
barplot(zonas, main="Distribución de la Zonificación (MSZoning)", xlab="Zonificación", ylab="Frecuencia", col="blue")


# 12. Seleccionar los datos numéricos.
# Para poder seleccionar todas las variables numéricas creamos un filtro con la función sapply() 
# recogiendo todas las variables numéricas mediante is.numeric()
datosNum = datos[,sapply(datos,is.numeric)]


# 13. Graficar todas las relaciones entre las variables.

# Con este grafico visualizamos la relacion entre las variables y su correlacion.
library(PerformanceAnalytics)
chart.Correlation(datosNum,hist=T)


# 14. Crear un nuevo Data Frame con las 10 últimas variables.

datosNum10UltimasVariables = datosNum[,30:39] # elegimos las 10 últimas columnas


# 15. Analizar la relación de estas variables con dos gráficos diferentes.

# a) Visualizamos la relacion entre las variables y su correlacion
chart.Correlation(datosNum10UltimasVariables, hist=T)

# b) Matriz de dispersión
pairs(datosNum10UltimasVariables, main="Matriz de Dispersión de las Variables Numéricas")

# c) Heatmap (mapa de calor)
# Calculamos la matriz de correlación
correlacion10UltVar = cor(datosNum10UltimasVariables, use="complete.obs")

# Generar un heatmap de la matriz de correlación
heatmap(correlacion10UltVar, main="Heatmap de Correlación entre Variables Numéricas", 
        col=colorRampPalette(c("blue", "white", "red"))(20), symm=TRUE)

                  
# 16. Analizar la correlación entre las variables numéricas.

correlaciones = cor(datosNum)

library(corrplot)
corrplot(cor(datosNum), method="shade", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=FALSE, cl.pos="n")


# 17. Eliminar los valores perdidos.

# Antes de borrar los NAs hacemos una pequeña exploración de cuantos NAs tenemos respecto al total de los datos que poseemos

# Verificamos si tenemos valores perdido (NAs) en las varaibles numéricas -> respuesta booleana
any(is.na(datosNum)) # Devuelve TRUE = Hay NAs en nuestro dataframe

# NAs por variable (columna) numéricas
colSums(is.na(datos))

# Para saber de cuantos datos disponemos
totalValoresNum = nrow(datosNum) * ncol(datosNum)
totalValoresNum # 56940 valores

# Sema de todos los NAs numéricos
sum(is.na(datosNum)) # 348 NAs, muy pocos respecto al total de los valores numéricos de nuestro dataframe


# Procedemos a eliminar todos los NAs
datosNumSinNA = datosNum[complete.cases(datosNum),]

any(is.na(datosNumSinNA)) # Devuelve FALSE = Hemos borrado todos los NAs


# 18. Volver a analizar la correlación realizando tres tipos de dibujos diferentes.

# a) Sombreado (shade): Representa la correlación con áreas sombreadas.
corrplot(cor(datosNumSinNA), method="shade", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=FALSE, cl.pos="n", tl.cex=0.6)

# b) Círculos (circle): Muestra la correlación con círculos, donde el tamaño indica la fuerza.
corrplot(cor(datosNumSinNA), method="circle", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n", tl.cex=0.6)

# c) Cuadrados (square): Usa cuadrados de distintos tamaños para mostrar la fuerza de la correlación.
corrplot(cor(datosNumSinNA), method="square", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n", tl.cex=0.6)

# d) Elipses (ellipse): Muestra la correlación con elipses, donde la forma indica la fuerza y dirección.
corrplot(cor(datosNumSinNA), method="ellipse", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n", tl.cex=0.6)

# e) Números (number): Muestra los valores exactos de correlación como números.
corrplot(cor(datosNumSinNA), method="number", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n", tl.cex=0.6)

# f) Colores (color): Representa la fuerza de la correlación mediante colores.
corrplot(cor(datosNumSinNA), method="color", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n", tl.cex=0.6)

# g) Gráficos de tarta (pie): Usa gráficos de "pie" para mostrar la fuerza de la correlación.
corrplot(cor(datosNumSinNA), method="pie", shade.col=NA, tl.col="black", 
         tl.srt=45, addgrid.col="black", type="lower", diag=TRUE, cl.pos="n", tl.cex=0.6)


# 19. Guardar los datos.
write.csv(datos, "trainmod.csv", row.names=FALSE)


