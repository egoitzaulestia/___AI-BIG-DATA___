#Distribución Exponencial

#producimos numeros aleatorios procedentes de una distribución exponencial espcificando la cantidad
#y también el ratio(la tasa: el numero de occurencias)
x1 <-rexp(1000, rate = 1)
x2 <-rexp(1000, rate = 1.33)
x3 <-rexp(1000, rate = 0.53)
x4 <-rexp(1000, rate = 0.8)
#comprobamos que las medias tienden a acercarse a 1/tasa
meandiff1<- mean(x1)- 1
meandiff2 <- mean(x2) - 1/1.33
meandiff3 <- mean(x3) - 1/0.53
meandiff4 <- mean(x4) - 1/0.8
#De hecho, podemos calcular que la media no es significativamente diferente de su valor poblacional
#a través de un t.test (esto lo veremos más adelante)
t.test(x1, mu=1, alternative="two.sided")


#tambien podemos obtener la función de densidad si especificamos la tasa y una sequencia
x <- seq(0,2, by=0.02)
dexp(x, rate = 5)
plot(x,dexp(x, rate = 5),main="pdf")
#y la funcion de prob. acumulada
pexp(x, rate = 5)
plot(x,pexp(x, rate = 5), main="cdf")

#podemos usar la anterior para encontrar las probablidades que se nos piden.
pexp(2, rate = 5)

#y podemos obtener los diferentes percentiles
percentil50 <- qexp(0.5, 5)


##vamos a ver como los diferentes valores de lambda afectan la forma de la distribución
par(mfrow=c(2,2))
x <- seq(0,2, by=0.02)
plot(x,dexp(x, rate = 3),  main="pdf lambda= 3", type="l")
plot(x,dexp(x, rate = 1), main="pdf lambda= 1", type="l")
plot(x,dexp(x, rate = 1/0.8),  main="pdf lambda= 0.8", type="l")
plot(x,dexp(x, rate = 0.2), main="pdf lambda= 0.2", type="l")
#es lógico que el tiempo de espera sea menor para valores de lambda mayores: en sí tasas altas.

