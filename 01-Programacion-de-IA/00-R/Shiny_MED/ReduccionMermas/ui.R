##### UI #####

fluidPage(
  
  #tema
  theme = shinytheme("cerulean"),
  
  #Give the page a title
  titlePanel("Reducción de Mermas"),
  titlePanel(title=div(img(src="logo_DVM.jpg",height="100",width="150"),"")),
  
  #Creacion del menu superior
  navbarPage(
    
    title = 'REDUCCION MERMAS',
    
    tabPanel('Carga y limpieza de datos',
      
      #Panel lateral
      sidebarPanel(
        
        #cargar archivo
        fileInput("file1", accept = ".csv", label = h4("Cargar 'Mermas.csv'")),
        
        #action button
        actionButton("action_limpieza", "Ejecutar la limpieza")
        
      ),
      
      #Panel principal
      mainPanel(
        #tabla importancia
        dataTableOutput("table_limpieza"), style = "height:500px; overflow-y: scroll;overflow-x: scroll"
      )
      
    ), 
             
    
    tabPanel('Analisis de lo sucedido',
      
      tabsetPanel(
        
        #arbol
        tabPanel("Arbol",
                 
          br(),
                 
          #action button
          actionButton("action_arbol", "Ejecutar el arbol"),
                 
          #plot arbol
          plotOutput("plot_arbol")
          
        ),
        
        #regresion
        tabPanel("Regresion",
          
          br(),
                 
          #action button
          actionButton("action_regresion", "Ejecutar la regresion"),
                 
          #verbatim regresion
          verbatimTextOutput("summary_regresion")      
                 
        )
        
      )
      
    ),
             

    tabPanel('Laboratorio de pruebas',
      
      #INPUTS
      fluidRow(       

        style = "padding: 20px;", 
        style = "background-color:#f5f5f5;",
        
        column(2,
        
          #extralinea1
          radioButtons("radio_extralinea1", label = h4("Extralinea 1"),
                       choices = list("Si" = "yes", "No" = "no"), 
                       selected = "yes"),
          
          #extralinea2
          radioButtons("radio_extralinea2", label = h4("Extralinea 2"),
                       choices = list("Si" = "yes", "No" = "no"), 
                       selected = "yes")
        ),
        
        column(2,
               
          #parametro1
          numericInput("num_parametro1", label = h4("parametro 1"), value = 25, step = 1),
               
          #parametro2
          numericInput("num_parametro2", label = h4("parametro 2"), value = 265.1, step = 0.01),
               
          #parametro3
          numericInput("num_parametro3", label = h4("parametro 3"), value = 110, step = 1),
               
        ),
        
        column(2,
          
          #parametro4
          numericInput("num_parametro4", label = h4("parametro 4"), value = 45.07, step = 0.01),
               
          #parametro5
          numericInput("num_parametro5", label = h4("parametro 5"), value = 197.4, step = 0.01),
               
          #parametro6
          numericInput("num_parametro6", label = h4("parametro 6"), value = 99, step = 1),
               
        ),
        
        column(2,
               
          #parametro7
          numericInput("num_parametro7", label = h4("parametro 7"), value = 16.78, step = 0.01),
               
          #parametro8
          numericInput("num_parametro8", label = h4("parametro 8"), value = 244.7, step = 0.01),
               
          #parametro9
          numericInput("num_parametro9", label = h4("parametro 9"), value = 91, step = 1),
               
        ),
        
        column(2,
          
          #parametro10
          numericInput("num_parametro10", label = h4("parametro 10"), value = 11.01, step = 0.01),
               
          #parametro11
          numericInput("num_parametro11", label = h4("parametro 11"), value = 10.0, step = 0.01),
               
          #parametro12
          numericInput("num_parametro12", label = h4("parametro 12"), value = 3, step = 1),
               
        ),
        
        column(2,
        
          #parametro13
          numericInput("num_parametro13", label = h4("parametro 13"), value = 2.7, step = 0.01),
        
          #parametro14
          numericInput("num_parametro14", label = h4("parametro 14"), value = 1, step = 1)
        
        )
        
      ),
      
      br(),
      
      #RESULTADO
      fluidRow(
        
        column(width=3, offset = 4,
               align="center",
               style = "background-color:#d5e2eb;",
               
               h3("Calificacion:"),
               h1(textOutput("calificacion"))
        )
        
      )
      
    ),
    
    
    tabPanel('Predicciones a futuro',
      
      #Panel lateral
      sidebarPanel(
             
        #cargar archivo
        fileInput("file2", accept = ".csv", label = h4("Cargar 'PlanTrabajo.csv'")),
        
        #action button
        actionButton("action_prediccion", "Ejecutar la prediccion")
        
      ),
      
      #Panel principal
      mainPanel( 
        dataTableOutput("table_prediccion"),
        downloadButton("download_prediccion", "Descargar")
      )
             
    )
    
  )
  
)