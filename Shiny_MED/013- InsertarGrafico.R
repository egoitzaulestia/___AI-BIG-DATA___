

library(shiny)

# Define UI for application that draws a histogram
ui <- basicPage(
    h2('Immediate output here'),
    verbatimTextOutput('fast'),
    h2('Delayed output comes after the page is ready'),
    verbatimTextOutput('slow'),
    plotOutput('slow_plot')
)

# Define server logic required to draw a histogram
server <- function(input, output, session) {
    
    values <- reactiveValues()
    values$starting2 = TRUE
    values$starting3 <- "hola"
    print(values)
    session$onFlushed(function() {
        values$starting2 <- FALSE
    })

    output$fast <- renderText({ "This happens right away" })
    output$slow <- renderText({
        if (values$starting2) {
              print(values$starting3)
            #invalidateLater(5000, session)
            return("Please wait for 5 seconds")
        }
        Sys.sleep(2)
         # pretend this is time-consuming
        "This happens later"
    })
    output$slow_plot <- renderPlot({
      print(values$starting2)
        if (values$starting2) {
            #invalidateLater(5000, session)
            return(plot(cars, main = "Please wait for a while"))
        }
      Sys.sleep(5)
        plot(rnorm(100000), main = "A slow plot")
    })
    
}

# Run the application 
shinyApp(ui = ui, server = server)
