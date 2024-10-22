rm(list=ls())

# Cargamos los datos.
datos=read.csv("transaccionesv2.csv",stringsAsFactors = TRUE)

# Lo primero es conocer un poco los datos
summary(datos)

# Si queremos agrupar por a?os/meses/dias es necesario separarlos en varios campos
datos$anio = as.numeric(substring(datos$fecha, 1, 4))
datos$mes  = as.numeric(substring(datos$fecha, 6, 7))
datos$dia  = as.numeric(substring(datos$fecha, 9, 10))

# Tambien lo podemos enriquecer con el dia de la semana que es o si es verano
datos$diasemana = weekdays(as.Date(datos$fecha))
datos$findesemana = ((datos$diasemana=="sábado") | (datos$diasemana=="domingo") | (datos$diasemana=="viernes"))
datos$verano = (datos$mes==7 | datos$mes ==8)

# Llegados a este punto tenemos un dataset muy grande que es necesario "resumir".
# De esta forma podemos comprender mejor la informacion.

# La primera opcion es ralizar agregaciones de los datos.
# Agregamos el importe total por cada tipo de negocio.
# Mostramos la suma.

Tipo = aggregate(importetotal~tipo,data = datos,sum)

# Tambien podemos contar el numero de operaciones.
CountTipo = aggregate(importetotal~tipo,data = datos,length)

# O ccalcular directamente la media.
MeanTipo = aggregate(importetotal~tipo,data = datos,mean)

# Y la desviacion estandar.
DesvTipo = aggregate(importetotal~tipo,data = datos,sd)


# Tambien se pueden realizar agregaciones por mas de una variable.
# En este caso podemos analizar las ventas entre semana/fin de semana.
# Este analisis lo realizamos por tipo de comercio.

Finde = aggregate(importetotal~findesemana+tipo,data = datos,sum)


options(scipen = 999) # Nos ayuda a eleminar la notación cientifica 5+0e
# Podemos graficarlo.
library(ggplot2)
ggplot(Finde,aes(x=findesemana,y=importetotal)) + 
  ggtitle("Total de ventas en fin de semana") + 
  geom_bar(stat="identity")

# Este grafico es un poco "gris".
# Le damos color.
ggplot(Finde,aes(x=findesemana,y=importetotal,fill=findesemana)) + 
  ggtitle("Total de ventas en fin de semana") + 
  geom_bar(stat="identity")

# Otra opcion es analizar el numero de operaciones, en vez de su importe.
FindeCount = aggregate(importetotal~findesemana+tipo,data = datos,length)

# Volvemos a graficarlo.
ggplot(FindeCount,aes(x=findesemana,y=importetotal,fill=findesemana)) + 
  ggtitle("Total de ventas en fin de semana") + 
  geom_bar(stat="identity")


# Tambien podemos realizar el grafico por cada tipo de negocio.
ggplot(Finde,aes(x=reorder(tipo,importetotal),y=importetotal)) + 
  ggtitle("Total de ventas en fin de semana") + 
  geom_bar(aes(fill = findesemana), stat="identity") + 
  coord_flip() # coord_flip() voltea el gráfico

# Pero vemos que es un grafico muy denso.

# Tambien podemos combinar dos agregaciones.
# Esto nos permite tener mas informacion.
# En este caso calcular los porcentajes entre semana y fin de semana.

# Agregamos el importe por fin de semana y tipo.
Finde_Tipo  = aggregate(importetotal~findesemana+tipo,data = datos,sum)

# Hacemos una agregacion de la agregacion anterior.
# Obtenemos el mismo resultado que en la primera agregacion.
Tipo2 = aggregate(importetotal~tipo,data = Finde_Tipo,sum)

# Con la funcion Merge unimos las dos tablas.
DatosFinal  = merge(Finde_Tipo,Tipo2,by = "tipo")

# Cambiamos los nombres de las variables.
colnames(DatosFinal)[3]="importetotal"
colnames(DatosFinal)[4]="importetotalanio"

# Tambien se puede hacer en un solo paso
colnames(DatosFinal)[3:4]=c("importetotal","importetotalanio")

# Calculamos el porcentaje.
DatosFinal$porc_importetotal = DatosFinal$importetotal / DatosFinal$importetotalanio

# Diferenciamos si es fin de semana o no.
DatosFinal$nueva = (DatosFinal$porc_importetotal)*DatosFinal$findesemana

# Graficamos.
ggplot(DatosFinal,aes(x=reorder(tipo,nueva),y=porc_importetotal)) + 
  ggtitle("Porcentage de ventas en fin de semana") + 
  geom_bar(aes(fill = findesemana), stat="identity") + 
  coord_flip()

# Podemos eliminar el "es_" de los nombres
DatosFinal$tipo = gsub("es_", "", DatosFinal$tipo)

# Repetimos el grafico.
ggplot(DatosFinal,aes(x=reorder(tipo,nueva),y=porc_importetotal)) + 
  ggtitle("Porcentage de ventas en fin de semana") + 
  geom_bar(aes(fill = findesemana), stat="identity") + 
  coord_flip()


# Agregamos por zonas (CP) y tipo.
datos$tipo = gsub("es_", "", datos$tipo)
ZonaTipo = aggregate(importetotal~cp+tipo,data = datos,sum)

# Graficamos
ggplot(ZonaTipo,aes(x=tipo,y=importetotal)) + 
  ggtitle("Porcentage de ventas por código postal") + 
  geom_bar(aes(fill = as.factor(cp)), stat="identity") + 
  coord_flip()


# Tambien podemos ver como influye el dia de la semana
datosplot = aggregate(importetotal~diasemana+tipo,data = datos,sum)

# Graficamos.
ggplot(datosplot,aes(x=tipo,y=importetotal)) + 
  ggtitle("Porcentage de ventas por día de la semana") + 
  geom_bar(aes(fill = as.factor(diasemana)), stat="identity") + 
  coord_flip()

# Tambien es posible volver a una tabla normal

library(reshape)

# Volvemos a una tabla normal.
tabla1=cast(ZonaTipo, cp ~ tipo)
NA + 5
tabla1[is.na(tabla1)]=0

# O filtrar mas la informacio para tener una mejor visualizacion.
datosplot = data.frame(tabla1$cp,tabla1$cafe,tabla1$bet,tabla1$parking)
colnames(datosplot)=c("cp","cafe","bet","parking")
cor(datosplot$cafe,datosplot$bet)
datosplot = melt(datosplot,id="cp")

par(mfrow=c(1,2))

ggplot(datosplot, aes(x=cp, y=value,fill=variable)) +
  geom_bar(stat="identity", position = "dodge")

ggplot(datosplot, aes(x=cp, y=value,fill=variable)) +
  geom_bar(stat="identity")

library(ggrepel)

# Tambien podemos ver donde se vende mas y ventas mas grandes
d1=aggregate(transacciones~cp,data=datos,sum)
d2=aggregate(importetotal~cp,data=datos,sum)
d3=merge(d1,d2,by="cp")

d3$importemedio = d3$importetotal/d3$transacciones

ggplot(d3,aes(x=transacciones, y=importemedio)) + 
  geom_point() + 
  xlab("Numero de Ventas (anual)") + ylab("Valor promedio de las Ventas") + ggtitle("Consumo en Bilbao") + 
  geom_text_repel(aes(label=as.character(cp)))




# Ademas de agregar podemos transformarla en una tabla "normal".

# Cargamos una version mas reducida de los datos.
rm(list=ls())
datos2 = read.csv("transaccionesv3.csv",stringsAsFactors = FALSE)
library(reshape2)
# aggregate + cast  = dcast

datos3 = aggregate(importetotal ~ cp + tipo, data = datos2, sum)
datos4 = cast(datos3, cp ~ tipo)
# Hacemos una tabla normal con el CP y el tipo.
# En este caso cuenta el numero de transacciones(Opcion por defecto).
Tipo_CP = dcast(datos2,cp~tipo, value.var = "importetotal")

# Tambien podemos mostrar la suma.
Tipo_CP_Sum = dcast(datos2,cp~tipo, value.var = "importetotal",fun.aggregate = sum)

# O la media.
Tipo_CP_Mean = dcast(datos2,cp~tipo, value.var = "importetotal",fun.aggregate = mean)

# O la desviacion estandar.
Tipo_CP_SD = dcast(datos2,cp~tipo, value.var = "importetotal",fun.aggregate = sd)


# tambien se puede normalizar la tabla por dos filas.
FechaCP_Tipo = dcast(datos2,fecha+cp~tipo, value.var = "importetotal")

# Hay valores que salen como NAs.
# Son valores que en realidad son 0
# Representan codigos postales en los que un tipo de transaccion no se ha realizado.
# Los transformamos en ceros.
FechaCP_Tipo[is.na(FechaCP_Tipo)]=0

# Tambien se puede hacer por dos columnas.
Tipo_MesCP_Mean = dcast(datos2,tipo~mes+cp, value.var = "transacciones",fun.aggregate = mean)

# Podemos modificarel nombre de las variables 
colnames(Tipo_MesCP_Mean) = gsub("^1_", "Enero_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("12_", "Diciembre_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("2_", "Febrero_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("3_", "Marzo_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("4_", "Abril_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("5_", "Mayo_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("6_", "Junio_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("7_", "Julio_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("8_", "Agosto_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("9_", "Septiembre_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("10_", "Octubre_", colnames(Tipo_MesCP_Mean))
colnames(Tipo_MesCP_Mean) = gsub("11_", "Noviembre_", colnames(Tipo_MesCP_Mean))

# Otra opcion es combinar de estas dos funciones (aggregate y dcast).
# En este caso obtenemos el mismo resultado que al principio.
Aggregate3 = aggregate(importetotal~cp+tipo,data=datos2,sum)
Cast3 = dcast(datos2,cp~tipo, value.var = "importetotal",sum)



# Otra transformacion es la fusion o vertizalizacion de tablas.
Vertical1=melt(Tipo_CP, id = "cp")
Vertical2=melt(Tipo_CP_Sum)

# Tmabien se puede seleccionar las variables sobre las que verticalizar
Vertical3 = melt(FechaCP_Tipo,id.vars = c("fecha","cp"))

# Analizamos los tipos de datos de vertical3.
sapply(Vertical3, class)

# Pasamos la fecha a formato fecha.
Vertical3$fecha = as.POSIXct(Vertical3$fecha, format="%Y-%m-%d")

# Realizamos la comprobacion.
sapply(Vertical3, class)

# Realizamos una serie de graficos.
library(ggplot2)
ggplot(Vertical3,aes(x=fecha,y=value))+geom_point()
ggplot(Vertical3,aes(x=fecha,y=value,col=variable))+geom_line()
ggplot(Vertical3,aes(x=fecha,y=value,col=variable))+geom_line()+facet_wrap("cp", scales = "free")
ggplot(Vertical3,aes(x=fecha,y=value,col=variable))+geom_line()+facet_wrap("cp") # En este le hemos quitado la escala libre, para que se la misma scala

# Tambien podemos realizar con la fecha de origen.
melt3 = Vertical3[Vertical3$fecha<as.POSIXlt("2015-06-01"),]
ggplot(melt3,aes(x=fecha,y=value,col=variable))+geom_line()+facet_wrap("cp", scales = "free")

# Transponemos la tabla Tipo_MesCP_Mean
Tipo_MesCP_MeanT = as.data.frame(t(Tipo_MesCP_Mean))

# Cambiamos los nombres.
colnames(Tipo_MesCP_MeanT)=Tipo_MesCP_Mean$tipo

# Eliminamos la primera fila.
Tipo_MesCP_MeanT=Tipo_MesCP_MeanT[-1,]

# Tambien podemos hacer de la siguiente manera.
Tipo_MesCP_MeanT = t(Tipo_MesCP_Mean)
colnames(Tipo_MesCP_MeanT)=Tipo_MesCP_MeanT[1,]
Tipo_MesCP_MeanT=as.data.frame(Tipo_MesCP_MeanT)
Tipo_MesCP_MeanT = Tipo_MesCP_MeanT[2:nrow(Tipo_MesCP_MeanT),]

