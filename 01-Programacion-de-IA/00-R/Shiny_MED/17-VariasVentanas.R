#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
ui <- navbarPage(
    "My Application",
    tabPanel("Component 1"),
    tabPanel("Component 2"),
    tabPanel("Component 3")
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
}

# Run the application 
shinyApp(ui = ui, server = server)
