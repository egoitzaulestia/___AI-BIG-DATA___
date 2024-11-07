#Supongamos que un grupo est´a interesado en determinar si los adolescentes obtienen sus licencias de conducir aproximadamente a la misma edad promedio en todo el pa´ıs. Suponga que los siguientes
#datos se recopilan aleatoriamente de cinco adolescentes en cada regi´on del pa´ıs. Los n´umeros representan la
#edad a la que los adolescentes obtuvieron sus licencias de conducir.
#Los datos se encuentran en carne_conducir.txt
#a) ¿Al hacer un ANOVA, qu´e hip´otesis estar´ıamos evaluando en este caso?
#b) Se pide hacer el an´alisis de dos maneras: en excel o a mano y en R.
#c) ¿Cuál ser´ıa nuestra conclusi´on?

setwd("~/01_CODE/___AI-BIG-DATA___/02-Sistemas-de-Big-Data/01-Estadistica/07-ANOVA/carne_conducir.txt")
data <- read.csv("carne_conducir.txt", sep="&")
data
#visualizamos
library(reshape2)
library(ggplot2)
data_long <-melt(data, measure=c("Norte", "Sur", "Este","Oeste", "Centro"))
#La función melt() de R, que se encuentra en los paquetes reshape2 o data.table, se usa para transformar un conjunto de datos de formato ancho (wide) a formato largo (long). En tu caso, parece que tienes varias columnas que representan diferentes regiones (como "Norte", "Sur", "Este", "Oeste", "Centro") y quieres convertir esas columnas en una única columna con un formato más largo.
ggplot(data_long, aes(x=variable, y=value, 
                      fill=variable))+
  geom_boxplot()

#sacamos un resumencito
require("dplyr")
group_by(data_long, variable) %>%
     summarise(
         count = n(),
         mean = mean(value),
         sd = sd(value) )
#sospechamos del centro y hacemos anova
#el objetivo es comparar las medias de los valores de la variable value en función de los diferentes niveles de la variable variable.
res.aov <- aov(value ~ variable, data_long )
summary(res.aov)
#efectivamente rechamoz ho, vamos a ver d?nde esta la diferencia con tueky
TukeyHSD(res.aov)
#vemos que al 5% centro es estad?sticamente diff de norte y de este. Es decir, 
#es diferente sacarse el carn? de conducir en el norte vs. centro y en el este vs. centro
#en cuanto a la edad.

