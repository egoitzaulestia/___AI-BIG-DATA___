"
Action buttons should always be used with one of eventReactive() or observeEvent(). 
See the article Using Action Buttons for details.
"

library(shiny)

# Define UI for application that draws a histogram
ui <- pageWithSidebar(
    headerPanel("actionButton test"),
    sidebarPanel(
        numericInput("n", "N:", min = 0, max = 100, value = 50),
        br(),
        actionButton("goButton", "Go!"),
        p("Click the button to update the value displayed in the main panel.")
    ),
    mainPanel(
        verbatimTextOutput("nText")
    )
)

# Define server logic required to draw a histogram
server <- function(input, output) {
    
    # builds a reactive expression that only invalidates 
    # when the value of input$goButton becomes out of date 
    # (i.e., when the button is pressed)
    ntext <- eventReactive(input$goButton, {
        input$n
    })
    
    output$nText <- renderText({
        ntext()
    })
}

# Run the application 
shinyApp(ui = ui, server = server)
