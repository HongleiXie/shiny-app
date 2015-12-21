library(ggplot2);
library(openxlsx);
library(shiny);
Logged <- FALSE;
PASSWORD <- data.frame(Brukernavn = "test", Passord = "BLACKOUT PASSWORD");

positions <- c('AUG', 'SEP', 'OCT', 'NOV');

dir.data <- "PATH TO SHINY FOLDER";

data <- read.xlsx(xlsxFile = file.path(dir.data, 'data.xlsx'), 
                  sheet = 1, 
                  startRow = 1, 
                  colNames = TRUE,
                  detectDates = TRUE,
                  skipEmptyRows = TRUE,
                  check.names = TRUE
                  );

shinyServer(function(input, output) {
  source("www/Login.R",  local = TRUE)
  
  observe({
    if (USER$Logged == TRUE) {
      
      output$bus <- renderUI({
        
        selectInput('bus', 'Business Lines', names(table(data$bus)))
        
      })
      
      output$type <- renderUI({
        
        selectInput('type', 'Calls Type', names(table(data$joint)))
        
      })
      
      # Combine the selected variables into a new data frame
      selectedData <- reactive({
        
        subset(data, data$joint == input$type & data$bus == input$bus);
        
      })
      
      
      output$plot1 <- renderPlot({
        
        ggplot(selectedData(), aes(x=month, y=count, fill=type)) +  xlab("Meeting Date") + ylab("Number of Calls") +
          geom_bar(stat="identity", position=position_dodge())+scale_x_discrete(limits = positions);
        
      })
      
    }
    
  })
})
