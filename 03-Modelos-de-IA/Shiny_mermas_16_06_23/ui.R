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
        
        column(3,
        
          #extralinea1
          radioButtons("Proveedor", label = h4("Proveedor"),
                       choices = list("1" = "1", "0" = "0"), 
                       selected = "0"),
          
          #extralinea2
          radioButtons("Transportista", label = h4("Transportista"),
                       choices = list("1" = "1", "0" = "0"), 
                       selected = "0")
        ),
        
        column(3,
               
               radioButtons("Parada", label = h4("Parada"),
                            choices = list("1" = "1", "0" = "0"), 
                            selected = "0"),
               
               #extralinea2
               radioButtons("Linea", label = h4("Línea"),
                            choices = list("1" = "1", "0" = "0"), 
                            selected = "0")
               
        ),
        
        column(3,
          
          #parametro4
          numericInput("Tiempo_Transcurrido", label = h4("Tiempo Transcurrido"), value = 45.07, step = 0.01),
               
          #parametro5
          numericInput("Tiempo_Almacen", label = h4("Tiempo Almacenado"), value = 197.4, step = 0.01),
               
          #parametro6
          numericInput("Humedad", label = h4("Humedad"), value = 99, step = 1),
               
        ),
        
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

        #action button
        sliderInput("Fila", "Unidad Producida:",
                    min = 1, max = 100,
                    value = 1, step = 1,
                    animate =
                      animationOptions(interval = 2000, loop = TRUE))        
      ),
      
      #Panel principal
      mainPanel(
        
        fluidRow(
          
          column(width=3, offset = 0,
                 
                 div(
                   align="center",
                   style = "background-color:#d5e2eb;",
                   h4("Tiempo Transcurrido:"),
                   h1(textOutput("Tiempo_trancurrido_2"))
                 ),
                 
                 div(
                   align="center",
                   style = "background-color:#d5e2eb;",
                   h4("Tiempo Almacén:"),
                   h1(textOutput("Tiempo_Almacen_2"))
                 )
                 
          ),
          
          column(width=3, offset = 0,
                 
                 div(
                   align="center",
                   style = "background-color:#d5e2eb;",
                   h4("Proveedor:"),
                   h1(textOutput("Proveedor_2"))
                 ),
                 
                 div(
                   align="center",
                   style = "background-color:#d5e2eb;",
                   h4("Transportista:"),
                   h1(textOutput("Transportista_2"))
                 )
                 
          ),
          
          column(width=3, offset = 0,
                 
                 div(
                   align="center",
                   style = "background-color:#d5e2eb;",
                   h4("Parada:"),
                   h1(textOutput("Paradada_2"))
                 ),
                 
                 div(
                   align="center",
                   style = "background-color:#d5e2eb;",
                   h4("Línea:"),
                   h1(textOutput("Linea_2"))
                 )
                 
          ),
          
          column(width=3, offset = 0,
                 
                 div(
                   align="center",
                   style = "background-color:#d5e2eb;",
                   h4("Humedad:"),
                   h1(textOutput("Humedad_2"))
                 )
                 
          )
          
        ),
        
        br(), br(),
        
        fluidRow(
          
          column(width=4, offset = 4,
                 align="center",
                 style = "background-color:#d5e2eb;",
                 
                 h2("Calificación:"),
                 h1(textOutput("Calificacion_2"))
          )
          
        )
      )
      
      
             
    )
    
  )
  
)