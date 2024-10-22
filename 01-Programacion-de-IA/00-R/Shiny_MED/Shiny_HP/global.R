##### GLOBAL #####

options(Encoding="UTF-8")

#librerias

library(shinythemes)
library(dplyr)
library(highcharter)
library(shinyWidgets)
library(stringdist)
library(shinydashboard)
library(DT)

################################################################################

# Cargar Datos
characHP=read.csv("datos/Characters.csv",sep = ";")
book1HP=read.csv("datos/Harry_Potter_1.csv",sep = ";")
book2HP=read.csv("datos/Harry_Potter_2.csv",sep = ";")
book3HP=read.csv("datos/Harry_Potter_3.csv",sep = ";")
spellsHP=read.csv("datos/Spells.csv",sep = ";")
potionsHP=read.csv("datos/Potions.csv",sep = ";")
################################################################################

##### DATASET DE TRABAJO #####
book1HP$Book=1 
book2HP$Book=2 
book3HP$Book=3 
colnames(book3HP)=c("Character","Sentence","Book")

bookX3=bind_rows(book1HP,book2HP,book3HP)

library(stringr)
bookX3$Character=str_to_title(bookX3$Character) 
#bookX3$Character=trimws(bookX3$Character, which =  "right", whitespace = "[ \t\r\n]")


potionsHP$Name=as.character(potionsHP$Name)
spellsHP$Name=as.character(spellsHP$Name)

characHP$House=as.character(characHP$House)
characHP$House[characHP$House==""]="Unknown"
characHP$Id=NULL
