function(input, output, session) {
  
  Mermas = reactive({datos_Modelo})
  
  #action button limpieza
  observeEvent(input$action_limpieza, {
    
    datos = Mermas()

    
    #visualizacion tabla con los datos limpios
    output$table_limpieza <- renderDataTable(
      datatable(datos, options = list(searching = FALSE))
    )
    
  })
    
  
  #action button arbol
  observeEvent(input$action_arbol, {  
  
    datos = Mermas()
    
    #limpieza de datos
    datos$Proveedor = as.factor(datos$Proveedor)
    datos$Transportista = as.factor(datos$Transportista)
    datos$Parada = as.factor(datos$Parada)
    datos$Linea = as.factor(datos$Linea)
    datos$Resultado = as.factor(datos$Resultado)
    
    #arbol
    tree = rpart(Resultado ~ ., data = datos,minsplit=30,maxdepth=3,cp=0)
    
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
    
    #regresion
    regresionlog = glm(Resultado~., data=datos,family=binomial)
    
    output$summary_regresion <- renderPrint({
      summary(regresionlog) 
    })
    
  })
    

  #laboratorio de pruebas
  
  datos_Pred = reactive({
  
    data.frame(
    
      Proveedor = as.numeric(input$Proveedor),  
      Transportista = as.numeric(input$Transportista),
      Parada = as.numeric(input$Parada),
      Linea = as.numeric(input$Linea),
      Tiempo_Transcurrido = as.numeric(input$Tiempo_Transcurrido),
      Tiempo_Almacen = as.numeric(input$Tiempo_Almacen),
      Humedad = as.numeric(input$Humedad)
      
      
    )
    
  })
  
  load("ModeloMermas.rda")
  
  
  Prediccion = reactive({
    prediccion = predict(modeloc50, datos_Pred(), type = "class")
    prediccion = as.data.frame(prediccion)
    prediccion$prediccion
  })
  

  output$calificacion <- renderText(as.character(Prediccion()))

  datos3 = reactive({datos_Modelo2[input$Fila,]})

  output$Tiempo_trancurrido_2 <- renderText({datos3()$Tiempo_Transcurrido[1]})
  output$Tiempo_Almacen_2 <- renderText({datos3()$Tiempo_Almacen[1]})
  output$Humedad_2 <- renderText({datos3()$Humedad[1]})

  output$Proveedor_2 <- renderText({datos3()$Proveedor[1]})
    output$Transportista_2 <- renderText({datos3()$Transportista[1]})

  output$Paradada_2 <- renderText({datos3()$Parada[1]})
  output$Linea_2 <- renderText({datos3()$Linea[1]})
  
  output$Calificacion_2 <- renderText({datos3()$Resultado[1]})
  #action button prediccion
  # observeEvent(input$action_prediccion, {
  #   
  #   load("ModeloMermas.rda")
  #   
  #   datos_pred2 = datos_Modelo2
  #   
  #   lapply(1:nrow(datos_pred2), function(i){
  #     
  #     print(i)
  #     datos3 = datos_pred2[i,]
  #     
  #     output$Tiempo_trancurrido_2 <- renderText({datos3$Tiempo_Transcurrido[1]})
  #     output$Tiempo_Almacen_2 <- renderText({datos3$Tiempo_Almacen[1]})
  #     output$Humedad_2 <- renderText({datos3$Humedad[1]})
  #     
  #     output$Proveedor_2 <- renderText({datos3$Proveedor[1]})
  #     output$Transportista_2 <- renderText({datos3$Transportista[1]})
  #     
  #     output$Paradada_2 <- renderText({datos3$Parada[1]})
  #     output$Linea_2 <- renderText({datos3$Linea[1]})
  #     
  #     
  #     # Prediccion = reactive({
  #     #   prediccion = predict(modeloc50, datos3[1,], type = "class")
  #     #   prediccion = as.data.frame(prediccion)
  #     #   prediccion$prediccion
  #     # })
  #     
  #     output$Calificacion_2 <- renderText({datos3$Resultado[1]})
  #     
  #     Sys.sleep(2)
  #   })

  #})

 
}