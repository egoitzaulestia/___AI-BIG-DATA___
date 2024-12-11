rm(list = ls())
library(readxl)
datos <- read.csv("two-way-anova-example-dataset-in-excel.csv", sep=";")


#hay q especificar las categorias de las variables 1 y 2
datos$var1 <- as.factor(datos$var1)
datos$var2 <- as.factor(datos$var2)

#primeramente vamos a realizar unas cuantas visualizacioens
#boxplot
ggplot(datos, aes(x=var1, y=Obs, fill=var2))+
  geom_boxplot()
#lineplot
library("ggpubr")
ggline(datos, x = "var1", y = "Obs", color = "var2",
       add = c("mean_se", "dotplot"))

#hacemos el anova con nuestras sospechas
res.aov2 <- aov(Obs ~ var1 + var2+var1*var2, datos )
summary(res.aov2)


#Podemos sacar la media y la desviacion por grupos con dplyr:
  require("dplyr")
group_by(datos, var1, var2) %>%
  summarise(
    count = n(),
    mean = mean(Obs),
    sd = sd(Obs) )       

#Sabemos que solo la var1 rechazamos la nula as? que hay diferencias entre grupos A.B y c 
#por lo que  podemos evaluarlo con tukey:
TukeyHSD(res.aov2, which = "var1")

#vemos que el grupo A es diferente del B. 
TukeyHSD(res.aov2)

#podemos mirar tb si se cumplen los supuestos
# 1.Homocedasticidad
plot(res.aov2,1)
#o hacemos un test de leven para ver si rechazamos el que las varianzas son iguales o no
library(car)
leveneTest(Obs ~ var1*var2, datos )
# 2. Normalidad
plot(res.aov2, 2)
