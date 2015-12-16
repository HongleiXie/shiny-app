library(shiny)
library(plyr)

library("openxlsx");
dt <- read.xlsx("~/Desktop/temp.xlsx", 
                sheet = 1, 
                startRow = 1, 
                colNames = TRUE
                );

dt <- data.frame(lapply(dt, function(v) {
  if (is.character(v)) return(toupper(v))
  else return(v)
    }
  )
)

# Define a server for the Shiny app
shinyServer(function(input, output) {
   
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    df2 <- count(dt, vars = input$name);
    # Render a barplot
    barplot(df2$freq, 
            main=input$name,
            ylab="ds",
            xlab="das")
  })
})
