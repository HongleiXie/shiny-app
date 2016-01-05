library(ggplot2);
library(shiny);


Logged <- FALSE;
PASSWORD <- data.frame(Brukernavn = "mis", Passord = "BLACKOUT PASSWORD");

source('global.R');

shinyServer(function(input, output) {
  source("www/Login.R",  local = TRUE)
  
  observe({
    if (USER$Logged == TRUE) {
      
#       output$crm <- renderUI({
#         
#         selectInput('crm', 'CRM Name', unique(names(table(data$CRM))))
#         
#       })
      
      
      # Combine the selected variables into a new data frame
      data1 <- reactive({
        subset(data, data$CRM == input$crm & data$type %in% c('Client', 'Prospect/COI'));
      })
      
      data2 <- reactive({
        subset(data, data$CRM == input$crm & data$type == 'Joint');
      })
      
      output$plot1 <- renderPlot({
        
        ggplot(data=data1(), aes(x=month, y=count, fill=type, ymax = ymax1+1)) +  
          xlab("Meeting Date") + ylab("Number of Calls") +
          geom_bar(stat="identity", position=position_dodge())+
          scale_x_discrete(limits = positions)+
          theme_bw()+
          geom_text(aes(label = count,y = count, x=month),size = 5, position = position_dodge(width=0.9))+
          geom_hline(yintercept = target_all, colour = "red", size = 1.5)
        
      })
      
      output$plot2 <- renderPlot({
        
        
        ggplot(data=data2(), aes(x=month, y=count, fill=type, ymax = ymax2+1)) +  
          xlab("Meeting Date") + ylab("Number of Calls") +
          geom_bar(stat="identity", position=position_dodge())+
          scale_x_discrete(limits = positions)+
          theme_bw()+
          geom_text(aes(label = count,y = count, x=month),size = 5, position = position_dodge(width=0.9))+
          geom_hline(yintercept = target_joint, colour = "red", size = 1.5) +
          scale_fill_manual(values = c("Joint" = "orange"))
        
      })  
      
    }
    
  })
})