function(input, output, session) {
  
  # cargar datos #
  
  #file1: Mermas.csv
  Mermas <- reactive({
    inFile1 <- input$file1
    if (is.null(input$file1)){
      return(NULL)
    }
    read.csv(inFile1$datapath)
  })
  
  #file2: PlanTrabajo.csv
  PlanTrabajo <- reactive({
    inFile2 <- input$file2
    if (is.null(input$file2)){
      return(NULL)
    }
    read.csv(inFile2$datapath)
  })
  
  
  # ejecucion #
  
  #action button limpieza
  observeEvent(input$action_limpieza, {
    
    datos = Mermas()
  
    #limpieza de datos
    datos$codigo1=NULL
    datos$codigo2=NULL
    datos$codigo3=NULL
    datos$codigo4=NULL
    
    #visualizacion tabla con los datos limpios
    output$table_limpieza <- renderDataTable(
      datatable(datos, options = list(searching = FALSE))
    )
    
  })
    
  
  #action button arbol
  observeEvent(input$action_arbol, {  
  
    datos = Mermas()
    
    #limpieza de datos
    datos$codigo1=NULL
    datos$codigo2=NULL
    datos$codigo3=NULL
    datos$codigo4=NULL
    
    #arbol
    tree = rpart(Calificacion ~ ., data = datos,minsplit=1,maxdepth=3,cp=0)
    
    output$plot_arbol <- renderPlot({
      rpart.plot(tree,type = 4,split.fun=split.fun,yesno = 2,tweak = 1,
                 clip.facs = FALSE, clip.right.labs = FALSE,
                 ycompact=TRUE,roundint=FALSE,cex = 0.8,
                 fallen.leaves=TRUE,Fallen.yspace=0.009)
    })
    
  }) 
    
    
  #action button regresion
  observeEvent(input$action_regresion, {   
    
    datos = Mermas()
    
    #limpieza de datos
    datos$codigo1=NULL
    datos$codigo2=NULL
    datos$codigo3=NULL
    datos$codigo4=NULL
    
    #regresion
    regresionlog = glm(Calificacion~., data=datos,family=binomial)
    
    output$summary_regresion <- renderPrint({
      summary(regresionlog) 
    })
    
  })
    

  #laboratorio de pruebas
  
  datos = reactive({
  
    data.frame(
    
      extralinea1 = factor(input$radio_extralinea1, c("yes", "no")), 
      extralinea2 = factor(input$radio_extralinea2, c("yes", "no")),
      
      parametro1 = as.integer(input$num_parametro1),
      parametro2 = as.numeric(input$num_parametro2),
      parametro3 = as.integer(input$num_parametro3),
      parametro4 = as.numeric(input$num_parametro4),
      parametro5 = as.numeric(input$num_parametro5),
      parametro6 = as.integer(input$num_parametro6),
      parametro7 = as.numeric(input$num_parametro7),
      parametro8 = as.numeric(input$num_parametro8),
      parametro9 = as.integer(input$num_parametro9),
      parametro10 = as.numeric(input$num_parametro10),
      parametro11 = as.numeric(input$num_parametro11),
      parametro12 = as.integer(input$num_parametro12),
      parametro13 = as.numeric(input$num_parametro13),
      parametro14 = as.integer(input$num_parametro14)
      
    )
    
  })
  
  load("modeloRF_Mermas.rda")
  
  Prediccion = reactive({
    prediccion = predict(modeloRF, datos())
    prediccion = as.data.frame(prediccion)
    prediccion$prediccion
  })
  
  output$calificacion <- renderText(as.character(Prediccion()))


  #action button prediccion
  observeEvent(input$action_prediccion, {
    
    load("modeloRF_Mermas.rda")
    
    Predicciones = predict(modeloRF, PlanTrabajo())
    
    Predicciones = as.data.frame(Predicciones)
    Predicciones$Codigo = 1:nrow(Predicciones)
    
    #visualizar tabla
    output$table_prediccion <- renderDataTable(
      datatable(Predicciones, options = list(searching = FALSE))
    )
    
    #descargar tabla
    output$download_prediccion <- downloadHandler(
      filename = "PlanTrabajo_prediccion.csv",
      content = function(file) {
        write.csv(Predicciones, file, row.names = FALSE)
      }
    )
    
  })
 
}