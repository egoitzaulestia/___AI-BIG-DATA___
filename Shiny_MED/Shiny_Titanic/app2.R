datos = read.csv("train.csv")
datos$Embarked[datos$Embarked == ""] = NA

library(shiny)
library(shinyWidgets)

# Define UI for application that draws a histogram
ui <- fluidPage(
  titlePanel("Datos Titanic"),
  
  sidebarLayout(
    
    # Sidebar panel for inputs ----
    sidebarPanel(width = 3, 
      pickerInput(
        inputId = "Selec_Survived",
        label = "Realice la selección",
        choices = unique(datos$Survived),
        selected = unique(datos$Survived),
        multiple = TRUE,
        options = list(`actions-box` = TRUE)
      ),
      pickerInput(
        inputId = "Selec_Sex",
        label = "Realice la selección",
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
        label = "Realice la selección",
        choices = unique(na.omit(datos$Embarked)),
        selected = unique(na.omit(datos$Embarked)),
        multiple = TRUE,
        options = list(`actions-box` = TRUE)
      ),
      
      numericRangeInput(
        inputId = "Selec_Precio", label = "Seleccione Rango de Precio:",
        separator = " hasta ",
        value = c(0, 550)
      )
      
    ),
    mainPanel(width = 9,
      
      # Output: Tabset w/ plot, summary, and table ----
      tabsetPanel(type = "tabs",
                  tabPanel("Tabla", DT::dataTableOutput("table")),
                  navbarMenu("Gráficos",
                             tabPanel("Gráfico Puerto",plotOutput("plot_Embarked")),
                             tabPanel("Gráfico Precio",plotOutput("plot_Fare")),
                             tabPanel("Gráfico Edad",plotOutput("plot_Age")),
                             tabPanel("Gráfico Supervivencia",plotOutput("plot_Survival"))

                  )

      )
    )
  )

)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
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
  })
  )
  
  output$plot_Embarked <- renderPlot({
    plot(as.factor(Datos1()$Embarked), main = "Distribución Embarque", col = "green",
         xlab = "Puerto", ylab = "Pasajeros")
  })
  
  output$plot_Fare <- renderPlot({
    hist(Datos1()$Fare, main = "Distribución Precio", col = "red",
         xlab = "Precio", ylab = "Pasajeros", breaks = 20)
  })
  
  output$plot_Age <- renderPlot({
    hist(Datos1()$Age, main = "Distribución Edad", col = "blue",
         xlab = "Edad", ylab = "Pasajeros")
  })
  
  output$plot_Survival <- renderPlot({
    plot(as.factor(Datos1()$Survived), main = "Distribución Supervivencia", col = "black",
         xlab = NULL, ylab = "Pasajeros")
  })
  
  

    
}


# Run the application 
shinyApp(ui = ui, server = server)
