library(shiny)
library(openxlsx)
library(bslib)
library(dplyr)
library(leaflet)
library(htmltools)
library(sp)
library(pals)
library(lubridate)
library(leaflegend)
library(shinyWidgets)
library(shinyBS)
library(shinyalert)
library(highcharter)


titanic_dataset = read.csv('data/titanic.csv', header = TRUE, sep = ',', stringsAsFactors = FALSE)

list_survived = c(unique(titanic_dataset$Survived))
list_sex = c(unique(titanic_dataset$Sex))
#list_age = c(unique(titanic_dataset$Age))
age_min = min(as.numeric(titanic_dataset$Age), na.rm = TRUE)
age_max = max(as.numeric(titanic_dataset$Age), na.rm = TRUE)

list_enbarked = c(unique(titanic_dataset$Embarked))
#list_fare= c(unique(titanic_dataset$Fare))
fare_min = min(as.numeric(titanic_dataset$Fare), na.rm = TRUE)
fare_max = max(as.numeric(titanic_dataset$Fare), na.rm = TRUE)

titanic_dataset$PassengerId=NULL