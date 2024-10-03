

fluidPage( id = "observatorio_navbarPage", 

           title = "Titanic",
           titlePanel(title=div(img(src="descarga.jpeg",height="110",width="340"))),
           tabPanel(title = "observatorio", value = "panel_deteccion", 
                   
                  
                     sidebarPanel(width = 3, 
                                  pickerInput("survived",label="Survived",choices=c(list_survived),options = list(`actions-box` = TRUE), multiple = TRUE, selected = c(list_survived)),
                                 
                                  pickerInput("sex",label="Sex",choices=list_sex,options = list(`actions-box` = TRUE), multiple = TRUE, selected = list_sex),
                                  
                                  numericRangeInput(
                                    inputId = "age", label = "Age Range:",
                                    value = c(age_min, age_max)
                                  ),
                                  
                                  pickerInput("enbarked",label="Embarked",choices=list_enbarked,options = list(`actions-box` = TRUE), multiple = TRUE, selected = list_enbarked),
                                  
                                  numericRangeInput(
                                    inputId = "fare", label = "Fare Range:",
                                    value = c(fare_min, fare_max)
                                  ),
                                  downloadButton('downloadDatos', label = 'Download metadata'), 
                                  actionButton(inputId = 'Limpiar', label = 'Clean Selection')
                                  
                                  ),
                    
                    
                    mainPanel(width = 9, 
                              tabsetPanel(  id = 'tabs',
                              tabPanel(title = "Observatory", value = "panel2", 
                                tags$style(type="text/css", "div.info.legend.leaflet-control br {clear: both;width: 300px; height: 3000px;}"),
                                br(),br(),
                                DT::dataTableOutput("DatosVer",width  ="100%" , height = "auto")#,
                                
                               

                      
                                    ),
                              tabPanel(title = "Graphs", value = "panel3", 
                                       highchartOutput("plot0", width = "100%", height = "auto"),
                                       br(),
                                       highchartOutput("plot1", width = "100%", height = "auto"),
                                       br(),
                                       highchartOutput("plot2", width = "100%", height = "auto"),
                                       br(),
                                       highchartOutput("plot3", width = "100%", height = "auto"),
                                       
                                               
                                               
                                               )
                           
                                  )
                            )
                    
                    )
           
           
           
           
           )
