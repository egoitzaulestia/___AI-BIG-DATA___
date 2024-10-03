##### SERVER #####

options(Encoding="UTF-8")

server <- function(input, output, session) {
  
  ################
  # Pestaña Book #
  ################
  
  ###  Pestaña Top 10 ###
  
  filt_B = reactive({  
    req(input$select_book1)
    filter(bookX3,Book %in% input$select_book1)
  })
  
  
  # Agregado #
  agBook=reactive({
    df1 <- filt_B() %>% 
      group_by(Character) %>% 
      dplyr::summarise(  NumeroFrases = n() ) %>%
      arrange(desc(NumeroFrases))  %>%
      head(n = 10)#%>%     
      #rename(Personaje = Character )
    
    df1
  })
  
  
  # Grafico #
  output$plot_graf1 <- renderHighchart({
    hc <- agBook() %>% 
      hchart("column", hcaes(x = Character, y = NumeroFrases,group=Character),
             stacking = "normal") %>%
      hc_colors(c('#AF7AC5', '#5DADE2 ','#58D68D ','#F4D03F ','#EB984E','#c0c3c4'))
    
    hc
  })
  
  

  ### Pestaña Resumen ###
  
  # Agregado #
  agBookR=reactive({
    df2 <- filt_B() %>% 
      group_by(Book) %>% 
      dplyr::summarise(  NumeroFrases = n() ) %>%
      mutate(Porcentaje = NumeroFrases/sum(NumeroFrases)*100)%>%
      mutate(across(c(Porcentaje), round, 3))%>%
      arrange(desc(NumeroFrases)) %>%     
      rename(Codigo_Fecha = codFecha ,Grupo_Cliente  = GRPCLIENTE,  Sumatorio=sumSellOut)  
    
    df2
  })
  

  output$TablaT10 <- DT::renderDataTable(
    DT::datatable(agBook(), options = list(searching = FALSE, 
                                           language = list(url = "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json")
    )) 
  )
  
  #################
  # Pestaña House #
  #################
  
  
  filt_C = reactive({  
    req(input$select_house1)
    filter(characHP,House %in% input$select_house1)
  })
  
  # Agregado #
  agCh=reactive({
    dfc <- filt_C() %>% 
      group_by(House) %>% 
      dplyr::summarise(  NC = n() ) %>%
      mutate(Porcentaje = NC/sum(NC)*100)%>%
      mutate(across(c(Porcentaje), round, 3))%>%
      arrange(desc(NC))  
    
    dfc
  })
  
  # Grafico #
  output$plot_graf3 <- renderHighchart({
    hc <- agCh() %>% 
      hchart(name="Porcentaje de Personajes","pie", hcaes(x = House, y = Porcentaje),
             style = list(fontFamily = "Zilla Slab")
      )  %>%
      hc_colors(c('#AF7AC5', '#5DADE2 ','#58D68D ','#F4D03F ','#EB984E','#c0c3c4', '#036e27','#634eeb')) %>%
      hc_plotOptions(series = list(showInLegend = TRUE))
    hc
  }) 
  
  output$TablaH <- DT::renderDataTable(
    DT::datatable(filt_C(), options = list(searching = FALSE, 
                                           language = list(url = "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json")
    )) 
  )
  
  
  ###################
  # Pestaña Potions #
  ###################
  filt_P = reactive({  
    req(input$LetterP)
    
    potions=potionsHP[startsWith(potionsHP$Name,input$LetterP),]
    
  })
  
  output$TablaP <- DT::renderDataTable(
    DT::datatable(filt_P(), options = list(searching = FALSE, 
                                                         language = list(url = "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json")
    )) 
  )
  
  ##################
  # Pestaña Spells #
  ##################
  
  filt_S = reactive({  
    req(input$LetterP)
    
    spells=spellsHP[startsWith(spellsHP$Name,input$LetterS),]
    
  })
  
  output$TablaS <- DT::renderDataTable(
    DT::datatable(filt_S(), options = list(searching = FALSE, 
                                           language = list(url = "https://cdn.datatables.net/plug-ins/1.10.20/i18n/Spanish.json")
    )) 
  )
  
  

  
}
