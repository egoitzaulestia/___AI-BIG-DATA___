function(input, output) {

  output$scatterPlot <- renderPlot({
    x <- rnorm(input$n)
    y <- rnorm(input$n)
    plot(x, y)
  })
  
  output$tabla = renderTable({
    data.frame(x = rnorm(input$n), y =  rnorm(input$n))
  })

}
