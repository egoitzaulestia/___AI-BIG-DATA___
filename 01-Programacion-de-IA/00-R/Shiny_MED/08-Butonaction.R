library(shiny)

ui=fluidPage(
  actionButton(inputId = "clicks",
              label = "clickme")
)

server = function(input, output){



}

shinyApp(ui = ui, server = server)


# 
# library(shiny)
# 
# # Interfaz de usuario
# ui <- fluidPage(
#   
#   # Título de la aplicación
#   titlePanel("Ejemplo de uso de isolate() en Shiny"),
#   
#   # Layout con panel lateral y panel principal
#   sidebarLayout(
#     
#     # Panel lateral con un campo de texto y un botón
#     sidebarPanel(
#       textInput("text_input", "Escribe algo:", value = ""),
#       actionButton("update_button", "Actualizar")
#     ),
#     
#     # Panel principal para mostrar el resultado
#     mainPanel(
#       h4("Texto actual:"),
#       textOutput("text_output")
#     )
#   )
# )Hello
# 
# # Servidor
# server <- function(input, output) {
#   
#   # Variable reactiva para almacenar el texto cuando el botón es presionado
#   observeEvent(input$update_button, {
#     # Al hacer clic en el botón, se actualiza el texto con el valor actual del input
#     output$text_output <- renderText({
#       paste("El texto ingresado es:", input$text_input)
#     })
#   })
#   
#   # Utilizamos isolate() para evitar que se actualice sin el botón
#   output$text_output <- renderText({
#     isolate({
#       paste("Esperando para actualizar... El texto ingresado es:", input$text_input)
#     })
#   })
# }
# 
# # Lanzar la aplicación
# shinyApp(ui, server)
