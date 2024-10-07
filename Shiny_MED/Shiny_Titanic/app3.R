# datos = read.csv("train.csv")
# datos$Embarked[datos$Embarked == ""] = NA
# 
# library(shiny)
# library(shinyWidgets)
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#   titlePanel("Datos Titanic"),
# 
#   sidebarLayout(
# 
#     # Sidebar panel for inputs ----
#     sidebarPanel(width = 3,
#       pickerInput(
#         inputId = "Selec_Survived",
#         label = "Realice la selección",
#         choices = unique(datos$Survived),
#         selected = unique(datos$Survived),
#         multiple = TRUE,
#         options = list(`actions-box` = TRUE)
#       ),
#       pickerInput(
#         inputId = "Selec_Sex",
#         label = "Realice la selección",
#         choices = unique(datos$Sex),
#         selected = unique(datos$Sex),
#         multiple = TRUE,
#         options = list(`actions-box` = TRUE)
#       ),
#       #
#       numericRangeInput(
#         inputId = "Selec_Edad", label = "Seleccione Rango de Edad:",
#         separator = " hasta ",
#         value = c(0, 100)
#       ),
# 
#       pickerInput(
#         inputId = "Selec_Enbarked",
#         label = "Realice la selección",
#         choices = unique(na.omit(datos$Embarked)),
#         selected = unique(na.omit(datos$Embarked)),
#         multiple = TRUE,
#         options = list(`actions-box` = TRUE)
#       ),
# 
#       numericRangeInput(
#         inputId = "Selec_Precio", label = "Seleccione Rango de Precio:",
#         separator = " hasta ",
#         value = c(0, 550)
#       )
# 
#     ),
#     mainPanel(width = 9,
# 
#       # Output: Tabset w/ plot, summary, and table ----
#       tabsetPanel(type = "tabs",
#                   tabPanel("Tabla", DT::dataTableOutput("table")),
#                   tabPanel("Gráficos",
#                            fluidRow(
#                              column(6,
#                                     plotOutput("plot_Embarked"),
#                              ),
#                              column(6,
#                                     plotOutput("plot_Fare"))
#                            ),
# 
# 
#                            fluidRow(
#                              column(6,
#                                     plotOutput("plot_Age")),
#                              column(6,
#                                     plotOutput("plot_Survival")
#                             )
#                            )
# 
# 
# 
#                   )
# 
#       )
#     )
#   )
# 
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
# 
#   Datos1 = reactive({
#     Data = datos
# 
#     Data <- Data[Data$Survived %in% input$Selec_Survived,]
#     Data <- Data[Data$Sex %in% input$Selec_Sex,]
#     Data = Data[Data$Age >= input$Selec_Edad[1] &  Data$Age <= input$Selec_Edad[2],]
#     Data <- Data[Data$Embarked %in% input$Selec_Enbarked,]
#     Data = Data[Data$Fare >= input$Selec_Precio[1] &  Data$Fare <= input$Selec_Precio[2],]
# 
# 
#     Data
#   })
# 
#   output$table <- DT::renderDataTable(DT::datatable({
#     Datos1()
#   })
#   )
# 
#   output$plot_Embarked <- renderPlot({
#     plot(as.factor(Datos1()$Embarked), main = "Distribución Embarque", col = "green",
#          xlab = "Puerto", ylab = "Pasajeros")
#   })
# 
#   output$plot_Fare <- renderPlot({
#     hist(Datos1()$Fare, main = "Distribución Precio", col = "red",
#          xlab = "Precio", ylab = "Pasajeros", breaks = 20)
#   })
# 
#   output$plot_Age <- renderPlot({
#     hist(Datos1()$Age, main = "Distribución Edad", col = "blue",
#          xlab = "Edad", ylab = "Pasajeros")
#   })
# 
#   output$plot_Survival <- renderPlot({
#     plot(as.factor(Datos1()$Survived), main = "Distribución Supervivencia", col = "black",
#          xlab = NULL, ylab = "Pasajeros")
#   })
# 
# 
# 
# 
# }
# 
# 
# # Run the application
# shinyApp(ui = ui, server = server)


# # Cargar las librerías necesarias
# library(shiny)
# library(shinyWidgets)
# library(highcharter)
# library(DT)
# 
# # Cargar los datos
# datos = read.csv("train.csv")
# datos$Embarked[datos$Embarked == ""] = NA
# 
# # Define UI for application that draws a histogram
# ui <- fluidPage(
#   titlePanel("Datos Titanic"),
#   
#   sidebarLayout(
#     # Sidebar panel for inputs ----
#     sidebarPanel(width = 3, 
#                  pickerInput(
#                    inputId = "Selec_Survived",
#                    label = "Realice la selección",
#                    choices = unique(datos$Survived),
#                    selected = unique(datos$Survived),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Sex",
#                    label = "Realice la selección",
#                    choices = unique(datos$Sex),
#                    selected = unique(datos$Sex),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Edad", label = "Seleccione Rango de Edad:",
#                    separator = " hasta ",
#                    value = c(0, 100)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Enbarked",
#                    label = "Realice la selección",
#                    choices = unique(na.omit(datos$Embarked)),
#                    selected = unique(na.omit(datos$Embarked)),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Precio", label = "Seleccione Rango de Precio:",
#                    separator = " hasta ",
#                    value = c(0, 550)
#                  ),
#                  # Selector para el tipo de gráfico
#                  pickerInput(
#                    inputId = "Selec_TipoGrafico",
#                    label = "Seleccione el tipo de gráfico:",
#                    choices = c("Barras" = "column", "Pie" = "pie"),
#                    selected = "column"
#                  )
#     ),
#     mainPanel(width = 9,
#               tabsetPanel(type = "tabs",
#                           tabPanel("Tabla", DT::dataTableOutput("table")),
#                           tabPanel("Gráficos",
#                                    fluidRow(
#                                      column(6,
#                                             highchartOutput("plot_Embarked")
#                                      ),
#                                      column(6,
#                                             highchartOutput("plot_Fare")
#                                      )
#                                    ),
#                                    fluidRow(
#                                      column(6,
#                                             highchartOutput("plot_Age")
#                                      ),
#                                      column(6,
#                                             highchartOutput("plot_Survival")
#                                      )
#                                    )
#                           )
#               )
#     )
#   )
# )
# 
# # Define server logic required to draw a histogram
# server <- function(input, output) {
#   
#   Datos1 = reactive({
#     Data = datos
#     
#     Data <- Data[Data$Survived %in% input$Selec_Survived,]
#     Data <- Data[Data$Sex %in% input$Selec_Sex,]
#     Data = Data[Data$Age >= input$Selec_Edad[1] &  Data$Age <= input$Selec_Edad[2],]
#     Data <- Data[Data$Embarked %in% input$Selec_Enbarked,]
#     Data = Data[Data$Fare >= input$Selec_Precio[1] &  Data$Fare <= input$Selec_Precio[2],]
#     
#     Data
#   })
#   
#   output$table <- DT::renderDataTable(DT::datatable({
#     Datos1()
#   })
#   )
#   
#   # Gráfico de Embarque (Embarked)
#   output$plot_Embarked <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Embarked))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Embarque")
#   })
#   
#   # Gráfico de Precios (Fare)
#   output$plot_Fare <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Fare, breaks = 10)))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Precio")
#   })
#   
#   # Gráfico de Edad (Age)
#   output$plot_Age <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Age, breaks = 10)))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Edad")
#   })
#   
#   # Gráfico de Supervivencia (Survived)
#   output$plot_Survival <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Survived))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Supervivencia")
#   })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)


# 
# 
# 
# # Cargar las librerías necesarias
# library(shiny)
# library(shinyWidgets)
# library(highcharter)
# library(DT)
# 
# # Cargar los datos
# datos = read.csv("train.csv")
# datos$Embarked[datos$Embarked == ""] = NA
# 
# # Define UI for application
# ui <- fluidPage(
#   titlePanel("Datos Titanic"),
# 
#   sidebarLayout(
#     # Sidebar panel for inputs ----
#     sidebarPanel(width = 3,
#                  pickerInput(
#                    inputId = "Selec_Survived",
#                    label = "Seleccione Supervivientes",
#                    choices = unique(datos$Survived),
#                    selected = unique(datos$Survived),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Sex",
#                    label = "Seleccione Sexo",
#                    choices = unique(datos$Sex),
#                    selected = unique(datos$Sex),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Edad", label = "Seleccione Rango de Edad:",
#                    separator = " hasta ",
#                    value = c(0, 100)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Enbarked",
#                    label = "Seleccione Puerto de Embarque",
#                    choices = unique(na.omit(datos$Embarked)),
#                    selected = unique(na.omit(datos$Embarked)),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Precio", label = "Seleccione Rango de Precio:",
#                    separator = " hasta ",
#                    value = c(0, 550)
#                  ),
#                  # Selector para el tipo de gráfico
#                  pickerInput(
#                    inputId = "Selec_TipoGrafico",
#                    label = "Seleccione el tipo de gráfico:",
#                    choices = c("Barras" = "column", "Pie" = "pie"),
#                    selected = "column"
#                  )
#     ),
#     mainPanel(width = 9,
#               tabsetPanel(type = "tabs",
#                           tabPanel("Tabla", DT::dataTableOutput("table")),
#                           tabPanel("Gráficos",
#                                    fluidRow(
#                                      column(6,
#                                             highchartOutput("plot_Embarked")
#                                      ),
#                                      column(6,
#                                             highchartOutput("plot_Fare")
#                                      )
#                                    ),
#                                    fluidRow(
#                                      column(6,
#                                             highchartOutput("plot_Age")
#                                      ),
#                                      column(6,
#                                             highchartOutput("plot_Survival")
#                                      )
#                                    )
#                           )
#               )
#     )
#   )
# )
# 
# # Define server logic
# server <- function(input, output) {
# 
#   Datos1 = reactive({
#     Data = datos
# 
#     Data <- Data[Data$Survived %in% input$Selec_Survived,]
#     Data <- Data[Data$Sex %in% input$Selec_Sex,]
#     Data = Data[Data$Age >= input$Selec_Edad[1] &  Data$Age <= input$Selec_Edad[2],]
#     Data <- Data[Data$Embarked %in% input$Selec_Enbarked,]
#     Data = Data[Data$Fare >= input$Selec_Precio[1] &  Data$Fare <= input$Selec_Precio[2],]
# 
#     Data
#   })
# 
#   output$table <- DT::renderDataTable(DT::datatable({
#     Datos1()
#   })
#   )
# 
#   # Gráfico de Embarque (Embarked)
#   output$plot_Embarked <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Embarked))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Embarque")
#   })
# 
#   # Gráfico de Precios (Fare)
#   output$plot_Fare <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Fare, breaks = 10)))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Precio")
#   })
# 
#   # Gráfico de Edad (Age)
#   output$plot_Age <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Age, breaks = 10)))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Edad")
#   })
# 
#   # Gráfico de Supervivencia (Survived)
#   output$plot_Survival <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Survived))
#     hchart(Data, input$Selec_TipoGrafico, hcaes(x = Var1, y = Freq), name = "Supervivencia")
#   })
# }
# 
# # Run the application
# shinyApp(ui = ui, server = server)







# # Cargar las librerías necesarias
# library(shiny)
# library(shinyWidgets)
# library(highcharter)
# library(DT)
# 
# # Cargar los datos
# datos = read.csv("train.csv")
# datos$Embarked[datos$Embarked == ""] = NA
# 
# # Define UI for application
# ui <- fluidPage(
#   titlePanel("Datos Titanic"),
#   
#   sidebarLayout(
#     sidebarPanel(width = 3, 
#                  pickerInput(
#                    inputId = "Selec_Survived",
#                    label = "Seleccione Supervivientes",
#                    choices = unique(datos$Survived),
#                    selected = unique(datos$Survived),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Sex",
#                    label = "Seleccione Sexo",
#                    choices = unique(datos$Sex),
#                    selected = unique(datos$Sex),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Edad", label = "Seleccione Rango de Edad:",
#                    separator = " hasta ",
#                    value = c(0, 100)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Enbarked",
#                    label = "Seleccione Puerto de Embarque",
#                    choices = unique(na.omit(datos$Embarked)),
#                    selected = unique(na.omit(datos$Embarked)),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Precio", label = "Seleccione Rango de Precio:",
#                    separator = " hasta ",
#                    value = c(0, 550)
#                  ),
#                  # Selector para el tipo de gráfico
#                  pickerInput(
#                    inputId = "Selec_TipoGrafico",
#                    label = "Seleccione el tipo de gráfico:",
#                    choices = c("Barras" = "column", "Pie" = "pie"),
#                    selected = "column"
#                  )
#     ),
#     mainPanel(width = 9,
#               tabsetPanel(type = "tabs",
#                           tabPanel("Tabla", DT::dataTableOutput("table")),
#                           tabPanel("Gráficos",
#                                    fluidRow(
#                                      column(6, highchartOutput("plot_Embarked")),
#                                      column(6, highchartOutput("plot_Fare"))
#                                    ),
#                                    fluidRow(
#                                      column(6, highchartOutput("plot_Age")),
#                                      column(6, highchartOutput("plot_Survival"))
#                                    )
#                           )
#               )
#     )
#   )
# )
# 
# # Define server logic 
# server <- function(input, output) {
#   
#   Datos1 = reactive({
#     Data = datos
#     Data <- Data[Data$Survived %in% input$Selec_Survived,]
#     Data <- Data[Data$Sex %in% input$Selec_Sex,]
#     Data = Data[Data$Age >= input$Selec_Edad[1] &  Data$Age <= input$Selec_Edad[2],]
#     Data <- Data[Data$Embarked %in% input$Selec_Enbarked,]
#     Data = Data[Data$Fare >= input$Selec_Precio[1] &  Data$Fare <= input$Selec_Precio[2],]
#     Data
#   })
#   
#   output$table <- DT::renderDataTable(DT::datatable({
#     Datos1()
#   }))
#   
#   # Gráfico de Embarque (Embarked)
#   output$plot_Embarked <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Embarked))
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Puerto de Embarque")
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Puerto de Embarque") %>%
#         hc_xAxis(title = list(text = "Puerto")) %>%
#         hc_yAxis(title = list(text = "Pasajeros"))
#     }
#   })
#   
#   # Gráfico de Precios (Fare)
#   output$plot_Fare <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Fare, breaks = 5)))  # Agrupar en rangos para el gráfico de tarta
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Precio")
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Precio") %>%
#         hc_xAxis(title = list(text = "Rango de Precio")) %>%
#         hc_yAxis(title = list(text = "Pasajeros"))
#     }
#   })
#   
#   # Gráfico de Edad (Age)
#   output$plot_Age <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Age, breaks = 5)))  # Agrupar en rangos para el gráfico de tarta
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Edad")
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Edad") %>%
#         hc_xAxis(title = list(text = "Edad")) %>%
#         hc_yAxis(title = list(text = "Pasajeros"))
#     }
#   })
#   
#   # Gráfico de Supervivencia (Survived)
#   output$plot_Survival <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Survived))
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Supervivencia")
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Supervivencia") %>%
#         hc_xAxis(title = list(text = "Supervivencia (0=No, 1=Sí)")) %>%
#         hc_yAxis(title = list(text = "Pasajeros"))
#     }
#   })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)




# # Cargar las librerías necesarias
# library(shiny)
# library(shinyWidgets)
# library(highcharter)
# library(DT)
# 
# # Cargar los datos
# datos = read.csv("train.csv")
# datos$Embarked[datos$Embarked == ""] = NA
# 
# # Definir el CSS para aplicar colores pastel
# css <- "
#   body {
#     background-color: #F5F5F5;
#   }
#   .sidebarPanel {
#     background-color: #E6F2FF; /* Fondo azul pastel */
#     padding: 15px;
#     border-radius: 10px;
#   }
#   .mainPanel {
#     background-color: #FFF5E6; /* Fondo naranja pastel */
#     padding: 15px;
#     border-radius: 10px;
#   }
#   .form-control {
#     border-radius: 5px;
#     background-color: #FFF5E6; /* Fondo de los campos de entrada */
#     border: 1px solid #E6F2FF;
#   }
#   .btn {
#     background-color: #FFCCE5; /* Botones rosados */
#     border: none;
#     color: black;
#   }
#   .btn:hover {
#     background-color: #FF99CC; /* Efecto hover en los botones */
#   }
# "
# 
# # Define UI for application
# ui <- fluidPage(
#   tags$style(HTML(css)),  # Insertar el CSS personalizado
#   titlePanel("Datos Titanic"),
#   
#   sidebarLayout(
#     sidebarPanel(width = 3, class = "sidebarPanel",  # Aplicar clase CSS
#                  pickerInput(
#                    inputId = "Selec_Survived",
#                    label = "Seleccione Supervivientes",
#                    choices = unique(datos$Survived),
#                    selected = unique(datos$Survived),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Sex",
#                    label = "Seleccione Sexo",
#                    choices = unique(datos$Sex),
#                    selected = unique(datos$Sex),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Edad", label = "Seleccione Rango de Edad:",
#                    separator = " hasta ",
#                    value = c(0, 100)
#                  ),
#                  pickerInput(
#                    inputId = "Selec_Enbarked",
#                    label = "Seleccione Puerto de Embarque",
#                    choices = unique(na.omit(datos$Embarked)),
#                    selected = unique(na.omit(datos$Embarked)),
#                    multiple = TRUE,
#                    options = list(`actions-box` = TRUE)
#                  ),
#                  numericRangeInput(
#                    inputId = "Selec_Precio", label = "Seleccione Rango de Precio:",
#                    separator = " hasta ",
#                    value = c(0, 550)
#                  ),
#                  # Selector para el tipo de gráfico
#                  pickerInput(
#                    inputId = "Selec_TipoGrafico",
#                    label = "Seleccione el tipo de gráfico:",
#                    choices = c("Barras" = "column", "Pie" = "pie"),
#                    selected = "column"
#                  )
#     ),
#     mainPanel(width = 9, class = "mainPanel",  # Aplicar clase CSS
#               tabsetPanel(type = "tabs",
#                           tabPanel("Tabla", DT::dataTableOutput("table")),
#                           tabPanel("Gráficos",
#                                    fluidRow(
#                                      column(6, highchartOutput("plot_Embarked")),
#                                      column(6, highchartOutput("plot_Fare"))
#                                    ),
#                                    fluidRow(
#                                      column(6, highchartOutput("plot_Age")),
#                                      column(6, highchartOutput("plot_Survival"))
#                                    )
#                           )
#               )
#     )
#   )
# )
# 
# # Define server logic 
# server <- function(input, output) {
#   
#   # Definir una paleta de colores personalizada
#   colors <- c("#FF5733", "#33FF57", "#3357FF", "#FFC300", "#DAF7A6", "#900C3F")
#   
#   Datos1 = reactive({
#     Data = datos
#     Data <- Data[Data$Survived %in% input$Selec_Survived,]
#     Data <- Data[Data$Sex %in% input$Selec_Sex,]
#     Data = Data[Data$Age >= input$Selec_Edad[1] &  Data$Age <= input$Selec_Edad[2],]
#     Data <- Data[Data$Embarked %in% input$Selec_Enbarked,]
#     Data = Data[Data$Fare >= input$Selec_Precio[1] &  Data$Fare <= input$Selec_Precio[2],]
#     Data
#   })
#   
#   output$table <- DT::renderDataTable(DT::datatable({
#     Datos1()
#   }))
#   
#   # Gráfico de Embarque (Embarked)
#   output$plot_Embarked <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Embarked))
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Puerto de Embarque") %>%
#         hc_colors(colors)
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Puerto de Embarque") %>%
#         hc_xAxis(title = list(text = "Puerto")) %>%
#         hc_yAxis(title = list(text = "Pasajeros")) %>%
#         hc_colors(colors)
#     }
#   })
#   
#   # Gráfico de Precios (Fare)
#   output$plot_Fare <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Fare, breaks = 5)))  # Agrupar en rangos para el gráfico de tarta
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Precio") %>%
#         hc_colors(colors)
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Precio") %>%
#         hc_xAxis(title = list(text = "Rango de Precio")) %>%
#         hc_yAxis(title = list(text = "Pasajeros")) %>%
#         hc_colors(colors)
#     }
#   })
#   
#   # Gráfico de Edad (Age)
#   output$plot_Age <- renderHighchart({
#     Data <- as.data.frame(table(cut(Datos1()$Age, breaks = 5)))  # Agrupar en rangos para el gráfico de tarta
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Edad") %>%
#         hc_colors(colors)
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Edad") %>%
#         hc_xAxis(title = list(text = "Edad")) %>%
#         hc_yAxis(title = list(text = "Pasajeros")) %>%
#         hc_colors(colors)
#     }
#   })
#   
#   # Gráfico de Supervivencia (Survived)
#   output$plot_Survival <- renderHighchart({
#     Data <- as.data.frame(table(Datos1()$Survived))
#     
#     if (input$Selec_TipoGrafico == "pie") {
#       hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Supervivencia") %>%
#         hc_colors(colors)
#     } else {
#       hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Supervivencia") %>%
#         hc_xAxis(title = list(text = "Supervivencia (0=No, 1=Sí)")) %>%
#         hc_yAxis(title = list(text = "Pasajeros")) %>%
#         hc_colors(colors)
#     }
#   })
# }
# 
# # Run the application 
# shinyApp(ui = ui, server = server)





# Cargar las librerías necesarias
library(shiny)
library(shinyWidgets)
library(highcharter)
library(DT)

# Cargar los datos
datos = read.csv("train.csv")
datos$Embarked[datos$Embarked == ""] = NA

# Definir el CSS para aplicar colores pastel
css <- "
  body {
    background-color: #F5F5F5;
  }
  .sidebarPanel {
  border-radius: 5px;
    background-color: #FFF5E6; /* Fondo de los campos de entrada */
    border: 1px solid #E6F2FF;
    /*background-color: #E6F2FF;  Fondo azul pastel 
    padding: 15px;
    border-radius: 10px;*/
  }
  .mainPanel {
    background-color: #FFF5E6; /* Fondo naranja pastel */
    padding: 15px;
    border-radius: 10px;
  }
  .form-control {
    border-radius: 5px;
    background-color: #FFFFFF; /* Fondo de los campos de entrada */
    border: 1px solid #E6F2FF;
  }
  .btn {
      background-color: #EDE0D4;  /* Fondo del botón */
      /* font-weight: bold;  Texto en negrita */
      color: #7F5539;  /* Color del texto */
      padding: 15px;  /* Espaciado interno */
      border-radius: 10px;  /* Bordes redondeados */
  }
  .btn:hover {
    background-color: #7F5539; /* Efecto hover en los botones */
    color: #E6CCB2;
  }

  table.dataTable.display>tbody>tr.odd.selected>*{
      box-shadow: inset 0 0 0 9999px rgba(127, 85, 57, 0.923);
      /* box-shadow: inset 0 0 0 9999px rgba(var(127, 85, 57, 0.923); */
  }
  table.dataTable.display>tbody>tr.even.selected>*{
    box-shadow: inset 0 0 0 9999px rgba(127, 85, 57, 0.923);
    /* box-shadow: inset 0 0 0 9999px rgba(var(127, 85, 57), 0.923); */
  }

  table.dataTable.display>tbody>tr.odd.selected:hover>*{
      box-shadow: inset 0 0 0 9999px rgba(127, 85, 57, 0.923);
      /* box-shadow: inset 0 0 0 9999px rgba(var(127, 85, 57, 0.923); */
  }

  table.dataTable.hover>tbody>tr:hover>*, table.dataTable.display>tbody>tr:hover>* {
      box-shadow: inset 0 0 0 9999px rgba(255, 255, 255, 0.035);
      /* box-shadow: inset 0 0 0 9999px rgba(var(--dt-row-hover), 0.035); */
  }

  table.dataTable.hover>tbody>tr.selected:hover>*,table.dataTable.display>tbody>tr.selected:hover>* {
      box-shadow: inset 0 0 0 9999px rgba(176, 137, 104, 1) !important;
  }
  
  table.dataTable.row-border>tbody>tr.selected+tr.selected>td,table.dataTable.display>tbody>tr.selected+tr.selected>td {
    border-top-color: #E6CCB2;
}

"

# Define UI for application
ui <- fluidPage(
  tags$style(HTML(css)),  # Insertar el CSS personalizado
  titlePanel("Datos Titanic"),
  
  sidebarLayout(
    sidebarPanel(width = 3, class = "sidebarPanel",  # Aplicar clase CSS
                 pickerInput(
                   inputId = "Selec_Survived",
                   label = "Seleccione Supervivientes",
                   choices = unique(datos$Survived),
                   selected = unique(datos$Survived),
                   multiple = TRUE,
                   options = list(`actions-box` = TRUE)
                 ),
                 pickerInput(
                   inputId = "Selec_Sex",
                   label = "Seleccione Sexo",
                   choices = unique(datos$Sex),
                   selected = unique(datos$Sex),
                   multiple = TRUE,
                   options = list(`actions-box` = TRUE)
                 ),
                 numericRangeInput(
                   inputId = "Selec_Edad", label = "Seleccione Rango de Edad:",
                   separator = " hasta ",
                   value = c(0, 100)
                 ),
                 pickerInput(
                   inputId = "Selec_Enbarked",
                   label = "Seleccione Puerto de Embarque",
                   choices = unique(na.omit(datos$Embarked)),
                   selected = unique(na.omit(datos$Embarked)),
                   multiple = TRUE,
                   options = list(`actions-box` = TRUE)
                 ),
                 numericRangeInput(
                   inputId = "Selec_Precio", label = "Seleccione Rango de Precio:",
                   separator = " hasta ",
                   value = c(0, 550)
                 ),
                 # Selector para el tipo de gráfico
                 pickerInput(
                   inputId = "Selec_TipoGrafico",
                   label = "Seleccione el tipo de gráfico:",
                   choices = c("Barras" = "column", "Pie" = "pie"),
                   selected = "column"
                 )
    ),
    mainPanel(width = 9, class = "mainPanel",  # Aplicar clase CSS
              tabsetPanel(type = "tabs",
                          tabPanel("Tabla", DT::dataTableOutput("table")),
                          tabPanel("Gráficos",
                                   fluidRow(
                                     column(6, highchartOutput("plot_Embarked")),
                                     column(6, highchartOutput("plot_Fare"))
                                   ),
                                   fluidRow(
                                     column(6, highchartOutput("plot_Age")),
                                     column(6, highchartOutput("plot_Survival"))
                                   )
                          )
              )
    )
  )
)

# Define server logic 
server <- function(input, output) {
  
  # Definir una paleta de colores personalizada
  colors <- c("#B08569", "#9C6644", "#7F5539", "#B08968", "#DDB892", "#E6CCB2")
  
  Datos1 = reactive({
    Data = datos
    Data <- Data[Data$Survived %in% input$Selec_Survived,]
    Data <- Data[Data$Sex %in% input$Selec_Sex,]
    Data = Data[Data$Age >= input$Selec_Edad[1] &  Data$Age <= input$Selec_Edad[2],]
    Data <- Data[Data$Embarked %in% input$Selec_Enbarked,]
    Data = Data[Data$Fare >= input$Selec_Precio[1] &  Data$Fare <= input$Selec_Precio[2],]
    Data
  })
  
  output$table <- DT::renderDataTable(DT::datatable({
    Datos1()
  }))
  
  # Gráfico de Embarque (Embarked)
  output$plot_Embarked <- renderHighchart({
    Data <- as.data.frame(table(Datos1()$Embarked))
    
    if (input$Selec_TipoGrafico == "pie") {
      hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Puerto de Embarque") %>%
        hc_colors(colors)
    } else {
      hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Puerto de Embarque") %>%
        hc_xAxis(title = list(text = "Puerto")) %>%
        hc_yAxis(title = list(text = "Pasajeros")) %>%
        hc_colors(colors)
    }
  })
  
  # Gráfico de Precios (Fare)
  output$plot_Fare <- renderHighchart({
    Data <- as.data.frame(table(cut(Datos1()$Fare, breaks = 5)))  # Agrupar en rangos para el gráfico de tarta
    
    if (input$Selec_TipoGrafico == "pie") {
      hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Precio") %>%
        hc_colors(colors)
    } else {
      hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Precio") %>%
        hc_xAxis(title = list(text = "Rango de Precio")) %>%
        hc_yAxis(title = list(text = "Pasajeros")) %>%
        hc_colors(colors)
    }
  })
  
  # Gráfico de Edad (Age)
  output$plot_Age <- renderHighchart({
    Data <- as.data.frame(table(cut(Datos1()$Age, breaks = 5)))  # Agrupar en rangos para el gráfico de tarta
    
    if (input$Selec_TipoGrafico == "pie") {
      hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Edad") %>%
        hc_colors(colors)
    } else {
      hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Edad") %>%
        hc_xAxis(title = list(text = "Edad")) %>%
        hc_yAxis(title = list(text = "Pasajeros")) %>%
        hc_colors(colors)
    }
  })
  
  # Gráfico de Supervivencia (Survived)
  output$plot_Survival <- renderHighchart({
    Data <- as.data.frame(table(Datos1()$Survived))
    
    if (input$Selec_TipoGrafico == "pie") {
      hchart(Data, "pie", hcaes(name = Var1, y = Freq), name = "Supervivencia") %>%
        hc_colors(colors)
    } else {
      hchart(Data, "column", hcaes(x = Var1, y = Freq), name = "Supervivencia") %>%
        hc_xAxis(title = list(text = "Supervivencia (0=No, 1=Sí)")) %>%
        hc_yAxis(title = list(text = "Pasajeros")) %>%
        hc_colors(colors)
    }
  })
}

# Run the application 
shinyApp(ui = ui, server = server)
