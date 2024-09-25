rm(list=ls())

# Cargamos todos los datos.
# Estamos hablando de datos de una compañia telefonica.
# Esta empresa ha separado los datos 
# Los que se han fugado estan en una tabla y los que se han quedado en otra tabla

ClientesEstrella=read.csv("ClienteEstrella.csv",stringsAsFactors = T)
LLamadasFieles=read.csv("LlamadasFieles.csv",stringsAsFactors = T)
LlamadasFugados=read.csv("LLamadasFugados.csv",stringsAsFactors = T)
PlanFieles=read.csv("PlanFieles.csv",stringsAsFactors = T)
PlanFugados=read.csv("PlanFugados.csv",stringsAsFactors = T)
Serviciotecnicofieles=read.csv("Serviciotecnicofieles.csv",stringsAsFactors = T)
Serviciotecnicofugados=read.csv("Serviciotecnicofugados.csv",stringsAsFactors = T)

#PlanFieles2 = PlanFieles[order(PlanFieles$Id, decreasing  = TRUE),]
#row.names(PlanFieles2) = 1:nrow(PlanFieles2)
# La primera forma de unir es pegar dos tablas.
# "Como si fuesen dos trozos de una hoja partida".
# Tienen que tener las mismas dimensiones.

Fugados=cbind(LlamadasFugados,PlanFugados,Serviciotecnicofugados)
Fieles=cbind(LLamadasFieles,PlanFieles,Serviciotecnicofieles)
#Fieles2=cbind(LLamadasFieles,PlanFieles2,Serviciotecnicofieles)

# Tambien se pueden poner una tabla debajo de otra.
# Tienen que tener las mismas variables y llamarse igual.
Clientes=rbind(Fieles,Fugados)
sum(Clientes[17] != Clientes[19])

colnames(Clientes)[19] = "Identificador"
j = summary(Clientes)
jj = lapply(Clientes, summary)
# En este caso nos duplica las Id ya que aparecen en todas las tablas.
# El siguiente paso seria eliminar columnas duplicadas (con el mismo nombre)
ClientesBien=Clientes[!duplicated(lapply(Clientes, summary))] # Le ponemos la exclamación para cambiar el orden y quedarnos con los TRUE
ClientesBien2=Clientes[!duplicated(colnames(Clientes))]

# En este caso queremos juntar tablas similares y quedarnos con todos los datos.
# Esto no es siempre asi, por ello existen otras funciones.


# En este caso tenemos unos clientes estrella identificados.
# De ellos no tenemos mucha informacion, en su tabla.
# Dicha informacion esta en otras tablas.
# Queremos completar esa tabla con toda la informacion disponible sobre esos clientes.

# La funcion merge detecta todos los datos comunes
EstrellaEnriquecidos=merge(ClientesEstrella,ClientesBien,all.x=TRUE ,all.y=FALSE)

# Tambien podemos indicarle por que variable tiene que hacer la union.
# En este caso si hay mas variables comunes las duplica.
EstrellaEnriquecidos2=merge(ClientesEstrella,ClientesBien,by="Id",all.x=TRUE ,all.y=FALSE)

# Tambien se pueden seleccionar los elementos de la tabla de la derecha.
Derecha=merge(ClientesEstrella,ClientesBien,all.x=FALSE ,all.y=TRUE)

# O todos los elementos existentes en las dos tablas (Outer) 
Outer=merge(ClientesEstrella,ClientesBien,all.x=TRUE ,all.y=TRUE)

# O solo los comunes a las dos tablas (Inner)
Inner=merge(ClientesEstrella,ClientesBien,all.x=FALSE ,all.y=FALSE)


# Esto mismo se puede realizar con la funcion "Join".
library(plyr)
library(dplyr)
JoinIzquierda=plyr::join(ClientesEstrella,ClientesBien,type="left")

JoinDerecha=join(ClientesEstrella,ClientesBien,type="right")

JoinInner=join(ClientesEstrella,ClientesBien,type="inner")

JoinOuter=join(ClientesEstrella,ClientesBien,type="full")

# En Join tambien se puede indicar la variable por la que realizar la union.
# Ocurre lo mismo que en Merge.
Otra=join(ClientesEstrella,ClientesBien,by="Id",type="left")

Otra$Day.Mins = NULL
# Una vez modificada la tabla podemos guardarla.
write.csv(EstrellaEnriquecidos,"ClientesInteresantes.csv",row.names = FALSE)


Datos1 = data.frame(
  Year = c(2020,2020,2020,2021,2021),
  Maquina = factor(c("A1","A2","A3","A1","A2")),
  Valor = c(1,2,3,4,5)
)

Datos2 = data.frame(
  Year = c(2020,2020,2021,2021,2021),
  Maquina = factor(c("A1","A3","A1","A2","A3")),
  Valor = c(6,7,8,9,10)
)


Datos3 = merge(Datos1,Datos2, by =c("Year","Maquina"), all = T)
Datos4 = join(Datos1,Datos2, by =c("Year","Maquina"), type = "full")
