library(shiny)

ui= fluidPage(
  sliderInput(inputId = "num",
              label="Selecciona un numero",
              value = 25, min = 1, max = 100),
  textInput(inputId = "titulo",
            label = "Escribe un titulo:",
            value = "100 valores aleatorios"),
  actionButton(inputId = "go",
               label = "update"),
  plotOutput("hist"),
  plotOutput("hist2"),
  verbatimTextOutput("stadisticos")
)

server=function(input, output){
  datos = eventReactive(input$go,{rnorm(input$num)})
  output$hist = renderPlot({
    titulo = "100 valores aleatorios"
    hist(datos(), main = isolate(input$titulo))
    })
  output$hist2 = renderPlot({
    titulo = "100 valores aleatorios"
    hist(datos(), main = isolate(input$titulo))
  })
  output$stadisticos = renderPrint({
    summary(datos())
  })
}

shinyApp(ui = ui, server = server)