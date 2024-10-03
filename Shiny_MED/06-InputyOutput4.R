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
  datos = reactive({rnorm(input$num)}) # Con "reactive({abc})" convertimos una variable global
  output$hist = renderPlot({
    titulo = "100 valores aleatorios"
    Sys.sleep(2)
    hist(datos(), main = isolate(input$titulo))
    })
  output$stadisticos = renderPrint({
    summary(datos())
  })
}

shinyApp(ui = ui, server = server)