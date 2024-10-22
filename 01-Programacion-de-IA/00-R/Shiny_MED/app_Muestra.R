

library(shiny)
library(shinythemes)
datos <- read.csv("Ejemplo_4.csv",header = TRUE,sep = ";",stringsAsFactors = TRUE)
levels(datos$Events)[1] <- "No_evento"

# Define UI for application that draws a histogram
ui <- fluidPage(

  theme = shinytheme("cerulean"),
  
  titlePanel("Demo Shiny"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("Event", "Selecciona un evento:",
                  choices = c("Todos",unique(as.character(datos$Events)))),
      
      sliderInput("Tmax","Temperatura Máxima", min = min(datos$Max.TemperatureC, na.rm = T), max = max(datos$Max.TemperatureC, na.rm = T),value = round(mean(datos$Max.TemperatureC, na.rm = T),0)),
      
      br(),br(),
      
    ),
    
    
    mainPanel(
      br(),br(),
      tabsetPanel(
        id = 'dataset',
        tabPanel("tabla", DT::dataTableOutput("mytable1")),
        tabPanel("summary", verbatimTextOutput("summary")),
        tabPanel("grafico", plotOutput('grafico'))
      )
    )
  )
  
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
  datos2 = reactive({
    datosa = datos
    if(input$Event != "Todos"){
      datosa = datosa[datos$Events == input$Event,]
      datosa
    }else{
      datosa = datosa
      
    }
  })
  
  datos3 = reactive({
    datosa2 = datos2()
    datosa2 = datosa2[datosa2$Max.TemperatureC >= input$Tmax,]
    datosa2
  })
  
   output$mytable1 = DT::renderDataTable({
     DT::datatable(datos3())
   })
   
   output$summary = renderPrint({
     summary(datos3())
   })
   
   output$grafico = renderPlot({
     plot(datos3()$Max.TemperatureC)
   })
}

# Run the application 
shinyApp(ui = ui, server = server)
