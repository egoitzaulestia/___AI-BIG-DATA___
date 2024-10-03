library(shiny)

ui= fluidPage(
  sliderInput(inputId = "num",
    label="Selecciona un número",
    value = 25, min = 1, max = 1000)
)

server=function(input, output){
  
  
  
}

shinyApp(ui = ui, server = server)