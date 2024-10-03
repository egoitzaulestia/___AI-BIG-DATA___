

fluidPage( id = "observatorio_navbarPage", 

           title = "Mapa Mundo",
           titlePanel(title=div(img(src="mundo.png",height="110",width="200"))),
           
           tabPanel(title = "mundo", value = "panel_deteccion", 
                    #sidebarPanel()
                   
                    
                    mainPanel(width = 12, 
                              
                              leafletOutput("mymap", height = 600, width='100%'),
                              
                      
                              )

                    
                    )

           )
