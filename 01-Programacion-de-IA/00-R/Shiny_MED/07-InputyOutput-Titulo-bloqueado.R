library(shiny)

ui= fluidPage(
  sliderInput(inputId = "num",
              label="Selecciona un numero",
              value = 25, min = 1, max = 100),
  textInput(inputId = "titulo",
            label = "Escribe un titulo:",
            value = "25 valores aleatorios"),
  textInput(inputId = "titulo2",
            label = "Escribe un valor de X:",
            value = "lalalala"),
  plotOutput("hist"),
  verbatimTextOutput("stadisticos")
)

server=function(input, output){
  datos = reactive({rnorm(input$num)})
  output$hist = renderPlot({
    titulo = "100 valores aleatorios"
    hist(datos(), main = input$titulo, xlab = "Hola")
    })
  output$stadisticos = renderPrint({
    summary(datos())
  })
}

shinyApp(ui = ui, server = server)