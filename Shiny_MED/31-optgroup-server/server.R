function(input, output, session) {

  Titanic2 <- as.data.frame(Titanic, stringsAsFactors = FALSE)
  print(Titanic2)
  Titanic2 <- cbind(Titanic2, value = seq_len(nrow(Titanic2)))
  Titanic2$label <- apply(Titanic2[, 2:4], 1, paste, collapse = ', ')
  print(Titanic2)
  updateSelectizeInput(session, 'group', choices = Titanic2, server = TRUE)

  output$row <- renderPrint({
    validate(need(
      input$group, 'Please type and search (e.g. Female)'
    ))
    Titanic2[as.integer(input$group), -(6:7)]
  })
}
