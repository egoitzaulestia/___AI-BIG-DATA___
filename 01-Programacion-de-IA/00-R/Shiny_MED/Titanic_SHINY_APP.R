datos = read.csv("train.csv")

library(shiny)
library(shinywidgets)

ui = fluidPage(
  titlePanel("Datos Titanic"),
  
  sidebarLayout(
    
  ))
  
  server = function(input, output) {
    
  }
)

# Run the application 
shinyApp(ui = ui, server = server)
