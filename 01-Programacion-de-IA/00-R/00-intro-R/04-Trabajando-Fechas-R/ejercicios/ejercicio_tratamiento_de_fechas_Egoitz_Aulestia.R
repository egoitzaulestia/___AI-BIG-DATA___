# Tratamiento de Fechas

rm(list=ls())

# En esta Actividad se deben realizar estas tareas:

# 1. Cargar los datos.

df1 = read.csv("Ejemplo_4.csv", sep=";", header = TRUE,stringsAsFactors = TRUE)


# 2. Mostrar los datos.

show(df1)


# 3. Realizar un resumen estadístico de los datos.

summary(df1)


# 4. Comprobar si la fecha está en un formato correcto.

class(df1$CET)


# 5. En caso de que la fecha no esté correcta transformarla al formato correcto.

df1$fecha <- as.POSIXct(as.character(df1$CET), format="%d/%m/%Y", tz="UTC")

perdidos = df1[is.na(df1$fecha),]


# 6. Comprobar que la transformación se ha hecho de forma correcta.

class(df1$fecha)


# 7. Crear una nueva variable que extraiga el año de la fecha.

library(lubridate)
df1$anio = year(df1$fecha) # sacamos el año


# 8. Crear una nueva variable que extraiga el mes de la fecha.

df1$mes = month(df1$fecha) # saca el mes

# 9. Crear una nueva variable que extraiga el día de la fecha.

df1$dia <- day(df1$fecha) # saca el día


# 10. Realizar un gráfico de la temperatura máxima en función de los años y ver si existen 
#     diferencias a lo largo de los años.

plot(df1$anio, df1$Max.TemperatureC, main = "Temperaturas Máximas años 1997-2015 ", xlab = "Años", ylab = "Temperatura (Cº)")
# No se observan grandes diferencias a lo largo de los años


# 11. Realizar un gráfico de la temperatura máxima en función de los meses y analizar si 
#     existen diferencias entre los meses.

plot(df1$mes, df1$Max.TemperatureC, main = "Temperaturas Máximas a lo largo del Año (12 meses), ", xlab = "Meses", ylab = "Temperatura (Cº)")
# Es este caso sí que vemos un patron que se repite claramente con temperaturas maximas en verano y minimas en invierno.
# Desde Enero van en aumento asta llegar a julio y agosto y después vuelven a decrecer de agosto a Diciembre.


# 12. Realizar un gráfico de la temperatura máxima en función de los días y ver si existen 
#     diferencias según el día.

plot(df1$dia, df1$Max.TemperatureC, main = "Temperaturas Máximas a lo largo de los días del mes", xlab = "Meses", ylab = "Temperatura (Cº)")
# No se observa ningún patrón


# 13. Extraer el día de la semana.

df1$dsemana = wday(df1$fecha,week_start = 1) # Esto hace que el día de la semana empiece en 1 = Lunes


# 14. Crear una variable que determine si se está en fin de semana o no.

df1$finDeSemana[df1$dsemana == 6 | df1$dsemana == 7] = "Si"
df1$finDeSemana[df1$dsemana == 1 | df1$dsemana == 2 | df1$dsemana == 3 | df1$dsemana == 4 | df1$dsemana == 5] = "No"



# 15. Realizar un gráfico en de la temperatura máxima en función de si se está en fin de 
#     semana o no.

class(df1$finDeSemana)
df1$finDeSemana = as.factor(df1$finDeSemana)
class(df1$finDeSemana)

plot(df1$finDeSemana, df1$Max.TemperatureC, main = "Temperaturas Máximas en función del día de la semana, ", xlab = "días de la semana", ylab = "Temperatura (Cº)")


# 16. Calcular la media de la temperatura máxima los fines de semana y entre semana

# Al hacer na.rm nos aseguramos de que los valores faltantes (NA) se omitan en el cálculo, evitando así errores.
sumaTempMax = sum(df1$Max.TemperatureC, na.rm = TRUE) 
tempMedia = round(sumaTempMax / length(df1$Max.TemperatureC), digits = 1) 
