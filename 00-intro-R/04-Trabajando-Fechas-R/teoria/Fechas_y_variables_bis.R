# En este ejercicio trabaremos SERIES TEMPORALES - TIMES SERIES
# Nos va interesar mucho ver la variación de los datos a lo largo del tiempo
# Cuando vemos NAs en series temporales, si nos falta un dato o dos, podemo sacar una media de los de arriba y los de debajo
# Pero si tenemos un montón de NAs en una variable (columna) es mucho más dificil de predecir

# En una fecha como veremos, tiene desde el día, hora, mes, año, pero po

# Borramos el data frame

rm(list=ls())

# Cargamos los datos

df1 <- read.csv("Ejemplo_1.csv",header = TRUE,stringsAsFactors = TRUE)

# Lo primero es hacernos una idea de los datos con los que trabajamos

show(df1)
summary(df1)

# En algunos casos es util saber el tipo de variable 

class(df1$date)
class(df1$ws)

# La fariable date esta como factor pero es una fecha, hay que modificarla
# Creo la variable fecha y le indico el formato que deseo

df1$fecha <- as.POSIXct(as.character(df1$date), format="%d/%m/%Y %H:%M")

sum(is.na(df1$date))
sum(is.na(df1$fecha))


# Es importante no igualas una valiabre

perdidos = df1[is.na(df1$fecha),]
#Vemos que los NAs son el mismo día durante todos los años


# Para evitar el cambio de hora hay que hacer lo siguiente -> Ponemos tz="UTC"
df1$fecha <- as.POSIXct(as.character(df1$date), format="%d/%m/%Y %H:%M", tz = "UTC")

#volvemos a mirar los NAs y vemos que ya no tenemos
perdidos = df1[is.na(df1$fecha),]

# Elimino la variable date ya que no me aporta nada

df1$date=NULL
 
 # Tambien puede ser interesante descomponer la fecha para poder trabajar con ella
 
library(lubridate)
df1$mes <- month(df1$fecha) # saca el mes
df1$dia <- day(df1$fecha) # saca el día
df1$hora <- hour(df1$fecha) # saca la hora
df1$diasemana = weekdays(df1$fecha) # devuelve día de la semana en letras (CUIDADO, porque al devolver las letras, en otro ordenador se puede traducir, y eso puede ser un problema)
df1$dsemana = wday(df1$fecha) # Nos da el numéro de la seman
df1$semana = week(df1$fecha) # nos da el número de la semana
df1$anio = year(df1$fecha) # sacamos el año
df1$dsemana2 = wday(df1$fecha,week_start = 1) # Esto hace que el día de la semana empiece en 1 = Lunes


# Ordenamo las variables como queramos
 
df1<-df1[,c(10:ncol(df1),1:9)]
 
# Otra forma de cambiar los nombres de las variables

names(df1)[names(df1)=="ws"] <- "windSpeed"
names(df1)[names(df1)=="wd"] <- "windDirection"
 
# Sacamos otra vez un resumen de los datos
 
summary(df1)
 
 
# Realizar una serie de graficos tambien puede ser de gran ayuda
 
plot(df1$fecha,df1$windSpeed)
plot(df1$fecha,df1$pm10)
plot(df1$fecha,df1$so2)
 
# O puede que no seamos capaces de ver nada
 
# Tambien podemos modificar los graficos.
 
plot(df1$fecha,df1$windSpeed, main = "Wind speed", xlab = "Years", ylab = "m/s")
plot(df1$fecha,df1$pm10, col="blue")
plot(df1$fecha,df1$so2, cex = 0.1)
 
 
 
 