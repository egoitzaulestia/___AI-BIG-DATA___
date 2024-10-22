rm(list=ls())

# 1. Cargar los datos “SalePrice1”, “SalePrice2”, “SalePrice3”.

SalePrice1 = read.csv("SalePrice1.csv", sep= ",", stringsAsFactors = TRUE)
SalePrice2 = read.csv("SalePrice2.csv", sep= ",", stringsAsFactors = TRUE)
SalePrice3 = read.csv("SalePrice3.csv", sep= ",", stringsAsFactors = TRUE)


# 2. Unir las tres tablas “pegando” una a continuación de la otra.

SalePriceAll = cbind(SalePrice1, SalePrice2, SalePrice3)

# Eleiminamos variables repetidas
SalePriceAllFinal = SalePriceAll[!duplicated(lapply(SalePriceAll, summary))] # Le ponemos la exclamación para cambiar el orden y quedarnos con los TRUE


# 3. Cargar los datos de “CasasCaras”.

CasasCaras = read.csv("CasasCaras.csv", stringsAsFactors = TRUE)


# 4. Enriquecer la tabla “CasasCaras” con las variables incluidas en datos1, datos2 y
# datos3, utilizando dos fórmulas diferentes.

# Opción 1 de enriquecimiento: MERGE

CasasCarasEnriquecidos_1 = merge(CasasCaras, SalePriceAllFinal, by= "Id", all.x=TRUE ,all.y=FALSE)

# CasasCarasEnriquecidos_1A = merge(CasasCaras, SalePrice1, all.x=TRUE ,all.y=FALSE)
# CasasCarasEnriquecidos_1B = merge(CasasCarasEnriquecidos_1A, SalePrice2, all.x=TRUE, all.y=FALSE)
# CasasCarasEnriquecidos_1C = merge(CasasCarasEnriquecidos_1B, SalePrice3, all.x=TRUE, all.y=FALSE)


# Opción 2 de enriquecimiento: JOIN
library(plyr)
library(dplyr)

# invocando join a la librería plyr
CasasCarasEnriquecidos_2 = plyr::join(CasasCaras, SalePriceAllFinal, by="Id", type="left")

# CasasCarasEnriquecidos_2A = plyr::join(CasasCaras, SalePrice1, by="Id", type="left")
# CasasCarasEnriquecidos_2B = plyr::join(CasasCarasEnriquecidos_2A, SalePrice2, by="Id", type="left")
# CasasCarasEnriquecidos_2C = plyr::join(CasasCarasEnriquecidos_2B, SalePrice3, by="Id", type="left")

# Aplicando join directamente
CasasCarasEnriquecidos_3  = join(CasasCaras, SalePriceAllFinal, by="Id", type="left")

# CasasCarasEnriquecidos_3A = join(CasasCaras, SalePrice1, by="Id", type="left")
# CasasCarasEnriquecidos_3B = join(CasasCarasEnriquecidos_join_2, SalePrice2, by="Id", type="left")
# CasasCarasEnriquecidos_3C = join(CasasCarasEnriquecidos_join_2, SalePrice3, by="Id", type="left")


# 5. Cargar datosH.

datosH = read.csv("datosH.csv", sep= ",", stringsAsFactors = TRUE)


# 6. Realizar las siguientes uniones con dos funciones:
#    a. Enriquecer datos H con la información de “SalePrice1”, “SalePrice2”,
#       “SalePrice3”.

# Opción 1
datosHEnriquecidos_1 = merge(datosH, SalePriceAllFinal, by= "Id", all.x=TRUE ,all.y=FALSE)

# Opción 2
datosHEnriquecidos_1A = merge(datosH, SalePrice1, all.x=TRUE ,all.y=FALSE)
datosHEnriquecidos_1B = merge(datosHEnriquecidos_1A, SalePrice2, all.x=TRUE, all.y=FALSE)
datosHEnriquecidos_1C = merge(datosHEnriquecidos_1B, SalePrice3, all.x=TRUE, all.y=FALSE)


#    b. Recogiendo toda la información recogida en todas las tablas

# Opción 1
datosHEnriquecidos_2 = merge(datosH, SalePriceAllFinal, by= "Id", all.x=TRUE ,all.y=TRUE)

# Opción 2
datosHEnriquecidos_2A = merge(datosH, SalePrice1, by="Id", all.x=TRUE ,all.y=TRUE)
datosHEnriquecidos_2B = merge(datosHEnriquecidos_2A, SalePrice2, by="Id", all.x=TRUE ,all.y=TRUE)
datosHEnriquecidos_2C = merge(datosHEnriquecidos_2B, SalePrice3, by="Id", all.x=TRUE ,all.y=TRUE)
  

#    c. Recogiendo los elementos comunes.
  
datosHEnriquecidos_3 = merge(datosH, SalePriceAllFinal, by= "Id", all.x=FALSE ,all.y=FALSE)
  
# 7. Seleccionar:
#    a. Los elementos comunes entre datosH y Casascaras.

datosFinal = merge(datosH, CasasCaras, by="Id", all.x = FALSE, all.y=FALSE)


#    b. Enriquecer datosH con Casascaras.


datosHEnriquecidosConCasasCaras = merge(datosH, CasasCaras, by="Id", all.x = TRUE, all.y=FALSE)


#    c. Enriquecer Casascaras con datos H.

CasasCarasEnriquecidosConDatosH = merge(CasasCaras, datosH, by="Id", all.x = TRUE, all.y=FALSE)


#    d. Todos los elementos.

datosFinalEnriquecidos = merge(datosH, CasasCaras, by="Id", all.x = TRUE, all.y=TRUE)

