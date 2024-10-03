library(shiny)

ui= fluidPage(
  sliderInput(inputId = "num",
              label="Selecciona un numero",
              value = 25, min = 1, max = 100),
  plotOutput("hist")
)

server=function(input, output){
  output$hist=renderPlot({
    tittle = "25 valores aleatorios"
    hist(rnorm(input$num), main = (input$num))
  })
}

shinyApp(ui = ui, server = server)