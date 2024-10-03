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



data=read.csv('data/world_country_and_usa_states_latitude_and_longitude_values.csv', 
              header = TRUE, sep = ',', stringsAsFactors = FALSE)

dataM = data[,c(1:4)]
dataUSA = data[,c(5:8)]
dataUSA = dataUSA[complete.cases(dataUSA),]


# paleta = c( "#6A3D9A", "#FF7F00","#6e675f" ,"#FDBF6F","#ee31f5", "#3605ed", "#3ae043", "#ed5e26" ,"#419168", "#472a1e", 
#             "#c8ed40", "#97aff0", "#1e92e6","#30565e", "#f72530", "#E31A1C", "#d9898d","#4287f5","#a274cc","#75cc72",
#             "#b33030","#ebeb7f","#286607","#614646","#0c7d37","#1e92e6","#473294","#234013","#666607","#f28d8d","#62d98f",
#             "#6A3D9A", "#FF7F00","#6e675f" ,"#FDBF6F","#968ca1", "#3605ed", "#42404a", "#ed5e26" ,"#b8b2cf", "#472a1e", 
#             "#c8ed40", "#97aff0", "#1e92e6","#30565e", "#f72530", "#E31A1C", "#d9898d","#4287f5","#a274cc","#75cc72",
#             "#b33030","#ebeb7f","#286607","#614646","#0c7d37","#1e92e6","#473294","#234013","#666607","#f28d8d","#62d98f",
#             "#6A3D9A", "#FF7F00","#6e675f" ,"#FDBF6F","#968ca1", "#3605ed", "#42404a", "#ed5e26" ,"#b8b2cf", "#472a1e", 
#             "#c8ed40", "#97aff0", "#1e92e6","#30565e  ", "#f72530", "#E31A1C", "#d9898d","#4287f5","#a274cc","#75cc72",
#             "#b33030","#ebeb7f","#286607","#614646","#0c7d37","#1e92e6","#473294","#234013","#666607","#f28d8d","#62d98f")