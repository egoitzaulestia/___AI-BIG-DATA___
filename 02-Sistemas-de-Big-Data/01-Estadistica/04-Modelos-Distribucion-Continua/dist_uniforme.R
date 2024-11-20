#Thanks to : Hartmann, K., Krois, J., Waske, B. (2018): E-Learning Project SOGA: Statistics and Geospatial Data Analysis. Department of Earth Sciences, Freie Universitaet Berlin.
#generamos una sequencia de 0 a 100 numeros enteros
x_dunif <- seq(0, 100, by = 1) 
x_dunif
#asignamos las probabilidades en un intervalo definido
y_dunif <- dunif(x_dunif, min = 10, max = 50) 
y_dunif
#ploteamos
plot(y_dunif, type="o")



# generate 40 random variables, uniformly distributed between -1 and 1 
runif(40, min = -1, max = 1)

# Further, we plot both, the density histogram from above as well as the uniform probability distribution for the interval [-2,0.8], by applying the dunif() function.
a <- -2
b <- 0.8
hist(rand.unif, 
     freq = FALSE, 
     xlab = 'x',  
     ylim = c(0, 0.4),
     xlim = c(-3,3),
     density = 20,
     main = "Uniform distribution for the interval [-2,0.8]")
curve(dunif(x, min = a, max = b), 
      from = -5, to = 5, 
      n = 100000, 
      col = "darkblue", 
      lwd = 2, 
      add = TRUE, 
      yaxt = "n",
      ylab = 'probability')
#The figure indicates that our the 10,000 samples randomly drawn from a uniform distribution (histogram plot) approximate well the uniform probability distribution 
#X???U(???2,0.8)
#X???U(???2,0.8) (line plot).
#Further, we can use the punif function to calculate the area under the curve for a given threshold value or we can use the qunif function to return a threshold value for a particular probability.

#Exercises
#Consider the uniform probability distribution given by  X???U(???3,5.5).

#Question 1
#What is the mean, ??, for the given uniform distribution.
unif.mean <- (-3+5.5)/2
unif.mean
## [1] 1.25

#Question 2
#What is value of  x corresponding to the value that divides the given uniform distribution
#into two equal parts, or written more formally P(X<?)=0.5

px.0.5  <- qunif(0.5, min = -3, max = 5.5)
px.0.5
## [1] 1.25
#Not a surprise at all. The value of  x that divides the uniform distribution into two
#equal parts is 1.25, and is thus equal to ??.

#Question 3
#Given that the distribution from above describes a physical phenomenon. 
#If we take a measurement of that physical process governing the phenomenon, 
#what is the probability of measuring a value >=4
#, or written more formally P(X>=4). Owing to the nature of a uniform distribution 
#the measurement of any particular value within the interval [???3,5.5]is equally likely.

#We will solve that question in two ways, numerically and analytically. First, in order to solve the question numerically we need to conduct an experiment. We will repeat our measurement for a large number of times, and then count the number of times we registered a value 
#>=4. Thanks to the power of R and the integrated random number generator
#(runif for uniformly distributed data) the repetition task is very easy,
#however, be aware that in real life applications quite often there is only a very
#limited number of measurements available.

measurements <- runif(10000, min = -3, max = 5.5) # take 10,000 measurements
above.threshold <- sum(measurements >= 4) #count the number of values >= 4
above.threshold/length(measurements) # calculate the proportion of values >= 4
## [1] 0.1754
#The results shows that approximately 18% of measurements yield values >=4.

#Second, in order to solve the question analytically, we make use of the cumulative
#probability density function, which is implemented in R for uniform distributions by
#the punif function. Make sure to set the lower.tail
#argument to lower.tail = FALSE, as we are looking for the 
#probability to measure values >=4, thus we are interested in
#the area under the curve right to the value of  x=4.
result <- punif(4, min = -3, max = 5.5, lower.tail = FALSE)
result
## [1] 0.1764706

#The analytic approach yields a result of 0.1764706 or in other words,
#with a probability of 17.65% we obtain values  >=4, thus (X>=4)???0.18.
#Obviously both approaches yield very similar results. However, be aware 
#that the result of the numerical approach is an approximation to the analytic result. 
#Keep in mind that the quality of such an approximation is very sensitive on the number of 
#random variables constituting the sample, in our case the number of measurements.

