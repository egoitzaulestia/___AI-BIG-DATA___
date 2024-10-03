library(shiny)

ui <- navbarPage(
  
  tags$head(
    # Incluye la biblioteca de Font Awesome
    tags$link(rel = "stylesheet", href = "https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0-beta3/css/all.min.css")
  ),
  title = 'DataTable Options',
  tabPanel('Function callback 1',     DT::dataTableOutput('ex1')),
  tabPanel('Function callback 2',        DT::dataTableOutput('ex2')),
  tabPanel('Function callback 3',      DT::dataTableOutput('ex3')),
  tabPanel('Function callback 4',       DT::dataTableOutput('ex4')),
  tabPanel('Function callback 5',  DT::dataTableOutput('ex5'))
)

# Define server logic required to draw a histogram
server <- function(input, output) {
  
   # write literal JS code in JS()
  output$ex5 <- DT::renderDataTable(DT::datatable(
    iris,
    options = list(rowCallback = DT::JS(
      'function(row, data) {
        if (parseFloat(data[1]) >= 5.0) {
          $("td:last", row).append("<i class=\'fa fa-check\' style=\'color:green\'></i>");
        }
      }'
    ))
  ))
}

# Run the application 
shinyApp(ui = ui, server = server)
