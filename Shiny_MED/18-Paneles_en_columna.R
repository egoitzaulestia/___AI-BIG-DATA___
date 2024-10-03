"
A navlistPanel is like a tabPanel, except that the navigation links 
are on the left instead of the top.
"

library(shiny)


ui <- fluidPage(
  tags$style(HTML("
          .row {
            background-image: url('agua.jpg');
          }
          .col-sm-4 {
            margin-top: 130px;
          }
      ")),
    titlePanel("Navlist panel example"),
    
    navlistPanel(
        "Header",
        tabPanel("First",
                 h3("This is the first panel")
        ),
        tabPanel("Second",
                 h3("This is the second panel")
        ),
        tabPanel("Third",
                 h3("This is the third panel")
        )
    )
)


server <- function(input, output) {
        
    }

# Run the application 
shinyApp(ui = ui, server = server)
