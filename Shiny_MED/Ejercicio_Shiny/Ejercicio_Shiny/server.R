function(input, output, session) {

  ########################
  ###### SELECTORES ######
  ########################
  

  observe( {

    shinyalert("Titanic Dataset Observatory", 
               imageUrl='descarga.jpeg',imageWidth='340',imageHeight='110')
    #type = "info",
  })
   
  filtrados = reactive({
     
    datos = titanic_dataset

    # Filtrado Survived #
    l_survived = c(input$survived)
    datos = datos[datos$Survived %in% l_survived,]

    # Filtrado Sex #
    l_sex = c(input$sex)
    datos = datos[datos$Sex %in% l_sex,]
    
    
    # Age Range #
    limAgemin = input$age[1]
    limAgemax = input$age[2]
    
    datos = datos[datos$Age  >= limAgemin,]
    datos = datos[datos$Age <= limAgemax,]


    # Filtrado Enbarked #

    l_enbarked = c(input$enbarked)
    datos = datos[datos$Embarked %in% l_enbarked,]

    # Fare Range #
    limFaremin = input$fare[1]
    limFaremax = input$fare[2]
    
    datos = datos[datos$Fare  >= limFaremin,]
    datos = datos[datos$Fare <= limFaremax,]
    
    datos

   })
 

   # Convertimos a reactive

  reactSurv <- reactive({
    valor=ifelse(is.null(input$survived),0,input$survived)
    valor
  })

  reactSex <- reactive({
    valor=ifelse(is.null(input$sex),0,input$sex)
    valor
  })

  reactAge <- reactive({
    valor=ifelse(is.null(input$age),0,input$age)
    valor
  })

  reactEnba <- reactive({
    valor=ifelse(is.null(input$enbarked),0,input$enbarked)
    valor
  })

  reactFare <- reactive({
    valor=ifelse(is.null(input$fare),0,input$fare)
    valor
  })

  # ObserveEvent
  observeEvent(reactSurv(), {

    datos = titanic_dataset
    
    # Filtrado Survived #
    l_survived = c(input$survived)
    datos = datos[datos$Survived %in% l_survived,]

    # Actualizamos el selector Sex
    freezeReactiveValue(input, "sex")
    listS = c(unique(datos$Sex))

    updatePickerInput(session, "sex", choices = listS, selected = listS)
  })
  
  

  observeEvent({
    reactSurv()
    reactSex()

  },{

    datos = titanic_dataset
    
    # Filtrado Survived #
    l_survived = c(input$survived)
    datos = datos[datos$Survived %in% l_survived,]
    
    # Filtrado Sex #
    l_sex = c(input$sex)
    datos = datos[datos$Sex %in% l_sex,]

    # Actualizamos el selector age
    age_minL = min(datos$Age,na.rm = T)
    age_maxL = max(datos$Age,na.rm = T)

    freezeReactiveValue(input, "age")
    updateNumericRangeInput(session,
      inputId = "age", label = "Age Range:",
      value = c(age_minL, age_maxL)
    )
  })
  
  observeEvent({
    reactSurv()
    reactSex()
    reactAge()

  },{

    datos = titanic_dataset
    
    # Filtrado Survived #
    l_survived = c(input$survived)
    datos = datos[datos$Survived %in% l_survived,]
    
    # Filtrado Sex #
    l_sex = c(input$sex)
    datos = datos[datos$Sex %in% l_sex,]
    
    
    # Age Range #
    limAgemin = input$age[1]
    limAgemax = input$age[2]
    
    datos = datos[datos$Age  >= limAgemin,]
    datos = datos[datos$Age <= limAgemax,]
    

    # Actualizamos el selector enbarked
    freezeReactiveValue(input, "enbarked")
    listE = c(unique(datos$Embarked))
    
    updatePickerInput(session, "enbarked", choices = listE, selected = listE)


  })

  observeEvent({
    reactSurv()
    reactSex()
    reactAge()
    reactEnba()

  },{

    datos = titanic_dataset
    
    # Filtrado Survived #
    l_survived = c(input$survived)
    datos = datos[datos$Survived %in% l_survived,]
    
    # Filtrado Sex #
    l_sex = c(input$sex)
    datos = datos[datos$Sex %in% l_sex,]
    
    
    # Age Range #
    limAgemin = input$age[1]
    limAgemax = input$age[2]
    
    datos = datos[datos$Age  >= limAgemin,]
    datos = datos[datos$Age <= limAgemax,]
    
    # Filtrado Enbarked #
    l_enbarked = c(input$enbarked)
    datos = datos[datos$Embarked %in% l_enbarked,]


    # Actualizamos el selector lFare
    fare_minL = min(datos$Fare,na.rm = T)
    fare_maxL = max(datos$Fare,na.rm = T)

    freezeReactiveValue(input, "fare")
    updateNumericRangeInput(session,
      inputId = "fare", label = "Fare Range:",
      value = c(fare_minL, fare_maxL)
    )

  })
   
# ------------------------  Tabla de datos  ------------------------------ #
  
  
  output$DatosVer <- DT::renderDataTable(
    DT::datatable(filtrados(),rownames = FALSE, options = list(info= T,
                                                               paging = T,
                                                               searching = T, 
                                                               scrollX = T,
                                                               autoWidth = T,
                                                               columnDefs = list(list( targets = c(2), width = '200px')),
                                                               language = list(url = "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json")
    ))
  )
  
  

# --------------------- GRAPHS --------------------------- #
  
  # Agregado Embarked
  agEmb <- reactive({
    x2 = filtrados()
    x3 <- x2 %>% 
      group_by(Embarked) %>% 
      summarise(count = n()) 
    x3
  })
  

  output$plot0 <- renderHighchart({

    export <- list(
      list(
        text = "JPEG",
        onclick = JS("function () {
                   this.exportChart({ type: 'image/jpeg' }); }")
      ),
      list(
        text = "PDF",
        onclick = JS("function () {
                   this.exportChart({ type: 'application/pdf' }); }")
      )
    )
    data = agEmb()
    hc <- data %>%
      hchart("pie", hcaes(x = Embarked, y = count), 
             stacking = "normal",#dataLabels = list(enabled = TRUE, format='{point.Flotas}'),
             tooltip = list(pointFormat = paste0("<strong>Count : </strong> {point.count} ")))
      
    hc  
  
  })
  
  # Agregado Fare
  agFare <- reactive({
    x2 = filtrados()
    x3 <- x2 %>% 
      group_by(Fare) %>% 
      summarise(count = n()) 
    x3
    
  })
  output$plot1 <- renderHighchart({
    
    export <- list(
      list(
        text = "JPEG",
        onclick = JS("function () {
                   this.exportChart({ type: 'image/jpeg' }); }")
      ),
      list(
        text = "PDF",
        onclick = JS("function () {
                   this.exportChart({ type: 'application/pdf' }); }")
      )
    )
    data = agFare()
    hc <- data %>%
      hchart("bar", hcaes(x = Fare, y = count), 
             stacking = "normal",
             tooltip = list(pointFormat = paste0("<strong>Count : </strong> {point.count} "))) 
    
    hc  
    
  })
 
  # Agregado Age
  
  agAge <- reactive({
    x2 = filtrados()
    x3 <- x2 %>% 
      group_by(Age) %>% 
      summarise(count = n()) 
    x3
  })
  
  output$plot2 <- renderHighchart({
    
    export <- list(
      list(
        text = "JPEG",
        onclick = JS("function () {
                   this.exportChart({ type: 'image/jpeg' }); }")
      ),
      list(
        text = "PDF",
        onclick = JS("function () {
                   this.exportChart({ type: 'application/pdf' }); }")
      )
    )
    data = agAge()
    hc <- data %>%
      hchart("bar", hcaes(x = Age, y = count), 
             stacking = "normal",
             tooltip = list(pointFormat = paste0("<strong>Count : </strong> {point.count} "))) 
    
    hc  
    
  })
  
  # Agregados Survival
  agSurv <- reactive({
    x2 = filtrados()
    x3 <- x2 %>% 
      group_by(Survived) %>% 
      summarise(count = n()) 
    x3
  })
  output$plot3 <- renderHighchart({
    
    export <- list(
      list(
        text = "JPEG",
        onclick = JS("function () {
                   this.exportChart({ type: 'image/jpeg' }); }")
      ),
      list(
        text = "PDF",
        onclick = JS("function () {
                   this.exportChart({ type: 'application/pdf' }); }")
      )
    )
    data = agSurv()
    hc <- data %>%
      hchart("pie", hcaes(x = Survived, y = count), 
             stacking = "normal",dataLabels = list(enabled = TRUE, format='{point.Survived}'),
             tooltip = list(pointFormat = paste0("<strong>Count : </strong> {point.count} "))) 
    
    hc  
    
  })
  

  
  output$downloadDatos <- downloadHandler(
    filename = function() {
      paste("Datos_", gsub("-","_",Sys.Date()), ".xlsx", sep="")
    },
    content = function(file) {
      writexl::write_xlsx(filtrados(), file)
    }
  )

  
  observeEvent(input$Limpiar, {

    session$reload()


  })


 }