library(shiny)

ui= fluidPage(
  sliderInput(inputId = "num",
              label="Selecciona un numero",
              value = 25, min = 1, max = 100),
  textInput(inputId = "titulo",
            label = "Escribe un titulo:",
            value = "100 valores aleatorios"),
  plotOutput("hist"),
  verbatimTextOutput("stadisticos")
)

server=function(input, output){
  output$hist = renderPlot({
    titulo = "100 valores aleatorios"
    hist(rnorm(input$num), main = input$titulo)
    })
  output$stadisticos = renderPrint({
    summary(rnorm(input$num))
  })
}

shinyApp(ui = ui, server = server)