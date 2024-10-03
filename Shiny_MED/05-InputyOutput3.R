library(shiny)

ui= fluidPage(
  sliderInput(inputId = "num",
              label="Selecciona un numero",
              value = 25, min = 1, max = 100),
  textInput(inputId = "titulo",
            label = "Escribe un titulo:",
            value = "25 valores aleatorios"),
  plotOutput("hist"),
  verbatimTextOutput("stadisticos")
)

server=function(input, output){
  output$hist = renderPlot({
    titulo = "100 valores aleatorios"
    r = rnorm(input$num)
    print(r)
    hist(r, main = input$titulo)
    })
  output$stadisticos = renderPrint({
    ra = rnorm(input$num)
    print(ra)
    summary(ra)
  })
}

shinyApp(ui = ui, server = server)

# 
# library(shiny)
# 
# # Interfaz de usuario
# ui <- fluidPage(
#   
#   # Título
#   titlePanel("Genera tu propio gráfico"),
#   
#   # Inputs para los datos
#   sidebarLayout(
#     sidebarPanel(
#       numericInput("x_value", "Valor de X:", 1),
#       numericInput("y_value", "Valor de Y:", 1),
#       actionButton("add_data", "Añadir Datos"),
#       actionButton("reset_data", "Reiniciar Datos"),
#       
#       # Un espacio para mostrar los datos introducidos
#       tableOutput("data_table")
#     ),
#     
#     # Mostrar el gráfico
#     mainPanel(
#       plotOutput("plot"),
#       tags$script(
#         HTML(
#           '
#           // JavaScript para mostrar un mensaje cuando se hace clic en el gráfico
#           $(document).on("shiny:inputchanged", function(event) {
#             if (event.name === "plot_click") {
#               alert("Has hecho clic en el gráfico en (" + event.value.x + ", " + event.value.y + ")");
#             }
#           });
#           '
#         )
#       )
#     )
#   )
# )
# 
# # Servidor
# server <- function(input, output, session) {
#   
#   # Guardar los datos en una variable reactiva
#   data <- reactiveVal(data.frame(x = numeric(0), y = numeric(0)))
#   
#   # Agregar nuevos puntos de datos
#   observeEvent(input$add_data, {
#     new_data <- data.frame(x = input$x_value, y = input$y_value)
#     data(rbind(data(), new_data))
#   })
#   
#   # Reiniciar los datos
#   observeEvent(input$reset_data, {
#     data(data.frame(x = numeric(0), y = numeric(0)))
#   })
#   
#   # Mostrar los datos en una tabla
#   output$data_table <- renderTable({
#     data()
#   })
#   
#   # Generar el gráfico con los datos
#   output$plot <- renderPlot({
#     plot(data()$x, data()$y, main = "Gráfico Generado", xlab = "X", ylab = "Y", pch = 19, col = "blue")
#   })
# }
# 
# # Lanzar la aplicación
# shinyApp(ui, server)
