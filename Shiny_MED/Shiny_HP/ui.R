
options(Encoding="UTF-8")

fluidPage(
  title = "Analisis Harry Potter",
  #theme = shinytheme("cerulean"),
  titlePanel(title=div(img(src="escudo2.png",height="60",width="60"),"Analisis Harry Potter")),
  navbarPage("",
             tabPanel("Books",
                      
                      sidebarPanel(width = 2, fluidRow(
                        
                        # Book
                        column(width=12,
                               checkboxGroupInput(
                                 inputId = "select_book1",
                                 label = h4("Book"), 
                                 choices = list(1,2,3),
                                 selected = 1
                               )),
                        
                      )),
                      
                      # Place for Graphics
                      mainPanel(width =10,
                                tabsetPanel(              
                                  
                                  tabPanel("Top 10 Characters",
                                           highchartOutput("plot_graf1", width = "100%", height = "450px")
                                  ),
                                  
                                  tabPanel("Tabla Resumen",
                                           DT::dataTableOutput("TablaT10",width  ="100%" , height = "auto")
                                           
                                  ))
                      )
             ),
             
             tabPanel("Houses",
                      
                      sidebarPanel(width =3, fluidRow(
                        
                        # Book
                        column(width=12,
                               checkboxGroupInput(
                                 inputId = "select_house1",
                                 label = h4("Book"), 
                                 choices = list("Beauxbatons Academy of Magic", "Durmstrang Institute", "Gryffindor","Hufflepuff", "Ravenclaw", "Slytherin"),
                                 selected = c("Gryffindor","Hufflepuff", "Ravenclaw", "Slytherin")
                               )),
                        
                      )),
                      
                      # Place for Graphics
                      mainPanel(width =9,
                                tabsetPanel(              
                                  
                                  tabPanel("Houses",
                                           highchartOutput("plot_graf3", width = "100%", height = "450px")
                                  ),
                                  
                                  tabPanel("Tabla Resumen",
                                           DT::dataTableOutput("TablaH",width  ="90%" , height = "auto")
                                           
                                  ))
                      )
             ),
             
             tabPanel("Potions",
                      
                      sidebarPanel(width = 12, fluidRow(
                        
                        # Leter
                        column(width=12,  
                               sliderTextInput("LetterP",label="Letter", choices =c("A","B","C","D","E","F","G","H","I","J","K","L",
                                                                               "M","N","O", "P","Q","R","S","T","U","V","W","X",
                                                                               "Y","Z") ,grid = T
                               )), 
                        
                      )),
                      
                      # Place for Graphics
                      mainPanel(width = 12,
                                tabsetPanel(              

                                  tabPanel("Potions", 
                                           DT::dataTableOutput("TablaP",width  ="100%" , height = "auto")

                                  ))
         
                      )
                      
             ),
             
             tabPanel("Spells",
                      
                      sidebarPanel(width = 12, fluidRow(
                        
                        # Year
                        column(width=12,  
                               sliderTextInput("LetterS",label="Letter", choices =c("A","B","C","D","E","F","G","H","I","J","K","L",
                                                                               "M","N","O", "P","Q","R","S","T","U","V","W","X",
                                                                               "Y","Z") ,grid = T
                               )), 
                        
                      )),
                      
                      # Place for Graphics
                      mainPanel(width = 12,
                                tabsetPanel(              
                                  
                                  tabPanel("Spells", 
                                           DT::dataTableOutput("TablaS",width  ="100%" , height = "auto")
                                           
                                  ))
                                
                      )
                      
             )
             
  )
)
