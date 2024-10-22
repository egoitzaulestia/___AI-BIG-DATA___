function(input, output, session) {


  
  contenidoPopup <- reactive({


    popup = paste0( "Codigo: " , dataM$country_code , "<br>",
                    "Pais: " ,dataM$country , "<br>",
                    "Longitud: " ,dataM$longitude , "<br>",
                    "Latitud: " ,dataM$latitude , "<br>"
                   
    )

  })
  
  contenidoPopup2 <- reactive({
    
    
    popup = paste0( "Codigo: " , dataUSA$usa_state_code , "<br>",
                    "Pais: " ,dataUSA$usa_state , "<br>",
                    "Longitud: " ,dataUSA$usa_state_longitude , "<br>",
                    "Latitud: " ,dataUSA$usa_state_latitude , "<br>"
                    
    )
    
  })

  
  pal <- colorFactor(
    #palette = "YlGnBu",
    palette = topo.colors(nrow(dataUSA)),
    domain = dataUSA$usa_state,
    
  )
  
  output$mymap <- renderLeaflet({


    leaflet() %>%
      
        setView(lng = -3.74, lat = 40.46, zoom = 2) %>%

        addProviderTiles(providers$Stamen.TerrainBackground, group = 'TB') %>%
        addProviderTiles(providers$Stamen.Toner, group = 'Toner') %>%
        addProviderTiles(providers$Esri.WorldImagery, group = 'ESRI') %>%
      
        addCircleMarkers(data = dataM,lng= ~longitude,lat= ~latitude, radius = 8, popup = contenidoPopup() , group = 'Mundo')%>%
        #addCircleMarkers(data = dataM,lng=~longitude,lat= ~latitude,clusterOptions = markerClusterOptions(), popup = contenidoPopup() , group = 'Mundo')%>%
      
        addCircleMarkers(data = dataUSA,lng=~usa_state_longitude,lat= ~usa_state_latitude,radius = 10, popup = contenidoPopup2() , color = ~pal(usa_state), group = 'USA')%>%
        
        addEasyButton(easyButton(
          icon="fa-globe", title="Zoom to Level 1",
          onClick=JS("function(btn, map){ map.setZoom(1); }"))) %>%
      
          addLayersControl(
            baseGroups = c("TB", "Toner", "ESRI"),
            overlayGroups = c("Mundo",'USA'),
            options = layersControlOptions(collapsed = TRUE)
          )%>%
        
        addMiniMap(tiles = providers$Esri.WorldStreetMap,
                     toggleDisplay = TRUE)
        

    
    

  })


 
  
  
  
  

  
  
  
  
  
  
  
  
  
  
  
  
  
}