library(shiny)
library(ggplot2)  # for the diamonds dataset

ui <- fluidPage(
  
  tags$style(HTML("
          .col-sm-4 {
            background: linear-gradient(#cdb08d, #FFF3E3);
            margin-top: 30px;
          }
          .col-sm-8 {
            margin-top: 130px;
          }
          #DataTables_Table_0_filter {
             margin-top: 20px;
          }
          #DataTables_Table_0_length label{
          margin-top: 20px;
          
          }
      ")),
  title = "Examples of DataTables",
  sidebarLayout(
    sidebarPanel(
      conditionalPanel(
        'input.dataset === "diamonds"',
        checkboxGroupInput("show_vars", "Columns in diamonds to show:",
                           names(diamonds), selected = names(diamonds))
      ),
      conditionalPanel(
        'input.dataset === "mtcars"',
        helpText("Click the column header to sort a column.")
      ),
      conditionalPanel(
        'input.dataset === "iris"',
        helpText("Display 5 records by default.")
      )
    ),
    mainPanel(
      tabsetPanel(
        id = 'dataset',
        tabPanel("diamonds", DT::dataTableOutput("mytable1")),
        tabPanel("mtcars", DT::dataTableOutput("mytable2")),
        tabPanel("iris", DT::dataTableOutput("mytable3"))
      )
    )
  )
)

server <- function(input, output) {

  # choose columns to display
  diamonds2 = diamonds[sample(nrow(diamonds), 1000), ]
  output$mytable1 <- DT::renderDataTable({
    print(diamonds2[, input$show_vars, drop = FALSE])
    print(input$show_vars)
    DT::datatable(diamonds2[, input$show_vars, drop = FALSE])
  })

  # sorted columns are colored now because CSS are attached to them
  output$mytable2 <- DT::renderDataTable({
    DT::datatable(mtcars, options = list(orderClasses = TRUE))
  })

  # customize the length drop-down menu; display 5 rows per page by default
  output$mytable3 <- DT::renderDataTable({
    DT::datatable(iris, options = list(lengthMenu = c(5, 30, 50), pageLength = 5))
  })

}

shinyApp(ui, server)
