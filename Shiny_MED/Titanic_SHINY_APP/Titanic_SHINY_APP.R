datos = read.csv("train.csv")
# datos = read.csv("train.csv", na.strings = c("", "NA"))
datos$Embarked[datos$Embarked == "NA"] = "" 
sum(is.na(datos$Embarked))
datos[is.na(datos$Embarked), ]
datos$Embarked[is.na(datos$Embarked)]

summary(datos$Fare)

a = max(datos$Fare)
b = max(datos)


library(shiny)
library(shinyWidgets)

ui = fluidPage(
  titlePanel("Datos Titanic"),

  sidebarLayout(

  )
)

  server = function(input, output) {

  }

# Run the application
shinyApp(ui = ui, server = server)




# library(shiny)
# library(shinywidgets)
# 
# # Cargamos los datos
# datos = read.csv("train.csv")
# 
# # Definimos la interfaz de usuario (UI)
# ui = fluidPage(
#   titlePanel("Datos Titanic"),
#   
#   # Completamos el sidebarLayout correctamente
#   sidebarLayout(
#     sidebarPanel(
#       # Aquí puedes agregar inputs o controles en el sidebar
#       p("Este es el panel lateral.")
#     ),
#     
#     mainPanel(
#       # Aquí puedes agregar las salidas (outputs)
#       p("Este es el panel principal.")
#     )
#   )
# )
# 
# # Definimos el servidor
# server = function(input, output) {
#   # Aquí va la lógica del servidor
# }
# 
# # Ejecutamos la aplicación
# shinyApp(ui = ui, server = server)

