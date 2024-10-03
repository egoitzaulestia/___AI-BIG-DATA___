library(shiny)

ui = fluidPage(
  sliderInput(inputId = "num",
              label = "Selecciona un numero",
              value = 100, min = 1, max = 100),
  actionButton(inputId = "go",
               label = "update"),

  plotOutput("Histograma")
)


server = function(input, output){

  data = eventReactive(input$go,{
    a = rnorm(input$num)
    print(a)
  })

  observeEvent(input$go, {
    print(as.numeric(input$go))
    })

  output$Histograma = renderPlot({
    hist(data())
  })
}


shinyApp(ui = ui, server = server)




# library(shiny)
# 
# ui = fluidPage(
#   
#   # Estilos CSS para un diseño minimalista tipo Apple
#   tags$head(
#     tags$style(HTML("
#       body {
#         background-color: #f5f5f7;
#         font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Helvetica, Arial, sans-serif;
#         color: #333;
#       }
#       .title {
#         color: #1d1d1f;
#         font-size: 24px;
#         font-weight: 600;
#         margin-bottom: 20px;
#       }
#       .btn {
#         background-color: #007aff;
#         color: white;
#         border: none;
#         padding: 10px 20px;
#         font-size: 16px;
#         border-radius: 8px;
#         margin-top: 20px;
#         transition: background-color 0.3s ease;
#       }
#       .btn:hover {
#         background-color: #005bb5;
#       }
#       .well {
#         background-color: white;
#         border-radius: 12px;
#         padding: 20px;
#         box-shadow: 0 2px 12px rgba(0, 0, 0, 0.1);
#         margin-bottom: 20px;
#       }
#       input[type=range] {
#         -webkit-appearance: none;
#         width: 100%;
#         height: 12px;
#         background: #d1d1d6;
#         border-radius: 12px;
#         outline: none;
#         opacity: 0.9;
#         transition: opacity .15s ease-in-out;
#       }
#       input[type=range]::-webkit-slider-thumb {
#         -webkit-appearance: none;
#         appearance: none;
#         width: 20px;
#         height: 20px;
#         border-radius: 50%;
#         background: #007aff;
#         cursor: pointer;
#       }
#       input[type=range]::-moz-range-thumb {
#         width: 20px;
#         height: 20px;
#         border-radius: 50%;
#         background: #007aff;
#         cursor: pointer;
#       }
#     "))
#   ),
#   
#   # Título y slider input para seleccionar el número de observaciones
#   titlePanel(div("Histograma", class = "title")),
#   
#   # Panel principal con el slider y el botón
#   sidebarLayout(
#     sidebarPanel(
#       sliderInput(inputId = "num",
#                   label = "Selecciona un número de observaciones:",
#                   value = 100, min = 1, max = 100),
#       actionButton(inputId = "go",
#                    label = "Actualizar",
#                    class = "btn")
#     ),
#     
#     # Panel principal para mostrar el histograma
#     mainPanel(
#       plotOutput("Histograma", width = "100%", height = "400px")
#     )
#   )
# )
# 
# server = function(input, output) {
#   
#   # Generar los datos de manera reactiva al presionar el botón
#   data = eventReactive(input$go, {
#     a = rnorm(input$num)
#     return(a)
#   })
#   
#   # Imprimir cuántas veces se hace clic en el botón
#   observeEvent(input$go, {
#     print(as.numeric(input$go))
#   })
#   
#   # Generar el histograma con los datos reactivos
#   output$Histograma = renderPlot({
#     hist(data(), col = "#007aff", border = "white", main = "Histograma de Números Aleatorios",
#          xlab = "Valores", ylab = "Frecuencia", breaks = 10)
#   })
# }
# 
# shinyApp(ui = ui, server = server)
