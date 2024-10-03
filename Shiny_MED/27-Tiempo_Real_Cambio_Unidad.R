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
ui <- basicPage(
    h4(
        "The time is ",
        # We give textOutput a span container to make it appear
        # right in the h4, without starting a new line.
        textOutput("currentTime", container = span)
    ),
    selectInput("interval", "Update every:", c(
        "5 seconds" = "5000",
        "1 second" = "1000",
        "0.5 second" = "500"
    ), selected = 1000, selectize = FALSE)
)

options(digits.secs = 3) # Include milliseconds in time display

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    output$currentTime <- renderText({
        # invalidateLater causes this output to automatically
        # become invalidated when input$interval milliseconds
        # have elapsed
        invalidateLater(as.integer(input$interval), session)
        
        format(Sys.time())
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
