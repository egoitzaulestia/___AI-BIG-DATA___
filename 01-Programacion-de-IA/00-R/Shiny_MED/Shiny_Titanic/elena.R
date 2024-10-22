datos = read.csv("train.csv")

library(shiny)
library(shinyWidgets)

summary(datos$Fare)

a = max(na.omit(datos$Fare))
a
ui <- fluidPage(
  titlePanel("Datos Titanic"),
  
  sidebarLayout(

    #Survived: pickerInput
    sidebarPanel(width = 3,
                 
                 #Survival: pickerInput
                 pickerInput(
                   inputId = "Selec_Survived",
                   label = "Realice la selección",
                   choices = unique(datos$Survived),
                   selected = unique(datos$Survived),
                   multiple = TRUE,
                   options = list(`actions-box` = TRUE)
                 ),
                 #Age: numericRangeInput
                 pickerInput(
                   inputId = "Selec_Sex",
                   label = "Realice la selección",
                   choices = unique(datos$Sex),
                   selected = unique(datos$Sex),
                   multiple = TRUE,
                   options = list(`actions-box` = TRUE)
                 ),
                 #Sex: pickerInput
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
                   value = c(0, a)
                 )
                 ),
    mainPanel(width = 9,
                           
                     tabsetPanel(type = "pills",
                                 tabPanel("Tabla", DT::dataTableOutput("table")),
                                 tabPanel("Gráfico", 
                                          tabsetPanel(type = "tabs",
                                                      tabPanel("Gráfico Puerto",plotOutput("plot_Embarked")),
                                                      tabPanel("Gráfico Precio",plotOutput("plot_Fare")),
                                                      tabPanel("Gráfico Edad",plotOutput("plot_Age")),
                                                      tabPanel("Gráfico Supervivencia",plotOutput("plot_Survival"))
                                          )
                                 )         
                     )
                 )
                 
     
  )

  #Age: numericRangeInput
  #Embarked: pickerInput
  #Fare: numericRangeInput
)

# Define server logic required to draw a histogram
server <- function(input, output) {

  
}


# Run the application 
shinyApp(ui = ui, server = server)