# # Instalar las librerías si no las tienes
# install.packages('shiny')
# install.packages('rmarkdown')
# install.packages('tinytex')
# 
# # Instalar TinyTeX si aún no lo tienes
# tinytex::install_tinytex()

# Cargar las librerías
library(shiny)
library(rmarkdown)
library(tinytex)



function(input, output) {

  regFormula <- reactive({
    as.formula(paste('mpg ~', input$x))
  })

  output$regPlot <- renderPlot({
    par(mar = c(4, 4, 4, 4))
    plot(regFormula(), data = mtcars, pch = 19)
  })

  output$downloadReport <- downloadHandler(
    filename = function() {
      paste('my-report', sep = '.', switch(
        input$format, PDF = 'pdf', HTML = 'html', Word = 'docx'
      ))
    },

    content = function(file) {
      src <- normalizePath('report.Rmd')

      # temporarily switch to the temp dir, in case you do not have write
      # permission to the current working directory
      owd <- setwd(tempdir())
      on.exit(setwd(owd))
      file.copy(src, 'report.Rmd', overwrite = TRUE)

      library(rmarkdown)
      out <- render('report.Rmd', switch(
        input$format,
        PDF = pdf_document(), HTML = html_document(), Word = word_document()
      ))
      file.rename(out, file)
    }
  )

}
