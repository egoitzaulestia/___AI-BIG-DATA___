##### GLOBAL #####

#directorio
#setwd(dirname(rstudioapi::getActiveDocumentContext()$path))


#librerias
library(shiny)
library(rpart)
library(rpart.plot)
library(C50)
library(DT)
library(shinythemes)

datos_Modelo = read.csv("Datos//Mermas.csv")

datos_Modelo2 = datos_Modelo[1:100,]

#funcion split.fun
split.fun <- function(x, labs, digits, varlen, faclen)
{
  # replace commas with spaces (needed for strwrap)
  labs <- gsub(",", " ", labs)
  for(i in 1:length(labs)) {
    # split labs[i] into multiple lines
    labs[i] <- paste(strwrap(labs[i], width=50), collapse="\n")
  }
  labs
}


