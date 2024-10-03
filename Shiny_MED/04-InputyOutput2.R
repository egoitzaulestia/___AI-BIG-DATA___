library(shiny)

ui= fluidPage(
  sliderInput(inputId = "num",
              label="Selecciona un numero",
              value = 25, min = 1, max = 100),
  textInput(inputId = "titulo",
            label = "Escribe un titulo:",
            value = "25 valores aleatorios"),
  plotOutput("hist")
)

server=function(input, output){
  output$hist=renderPlot({
        hist(rnorm(input$num), main = input$titulo)
  })
}

shinyApp(ui = ui, server = server)