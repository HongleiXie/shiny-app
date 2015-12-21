
positions <- c('AUG', 'SEP', 'OCT', 'NOV');

library(ggplot2);
library(xlsx);
library(shiny);
Logged <- FALSE;
PASSWORD <- data.frame(Brukernavn = "test", Passord = "202cb962ac59075b964b07152d234b70");

dir.data <- "~/Desktop/shiny_app";
data <- read.xlsx(file.path(dir.data, 'data.xlsx'), sheetName = "Sheet1");

shinyServer(function(input, output, session) {
  
  # Combine the selected variables into a new data frame
  selectedData <- reactive({
    
    subset(data, data$joint == input$type & data$bus == input$bus);
    
  })
  
  
  output$plot1 <- renderPlot({
    
    ggplot(selectedData(), aes(x=month, y=count, fill=type)) +  xlab("Meeting Date") + ylab("Number of Calls") +
      geom_bar(stat="identity", position=position_dodge())+scale_x_discrete(limits = positions);
    
  })
  
})
