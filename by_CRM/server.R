library(ggplot2);
library(shiny);
library(reshape);

Logged <- FALSE;
PASSWORD <- data.frame(Brukernavn = "test", Passord = "202cb962ac59075b964b07152d234b70");

positions <- c('AUG', 'SEP', 'OCT', 'NOV', 'DEC');

data <- read.csv(
  "~/Desktop/shiny_app/targets_all.csv",
  na.strings = ".."
  );

data <- data[, c('Employee__HR_Full_Name', 'month', 
                 'Client_all', 'Prospect_COI_all', 'joint')];

data <- melt(data, id = c('Employee__HR_Full_Name','month'));

colnames(data)[1] <- 'CRM';
colnames(data)[3] <- 'type';
colnames(data)[4] <- 'count';


ymax1 <- sort(data[which(data$type %in% c('Client_all', 'Prospect_COI_all')),]$count,decreasing = T)[1];
ymax2 <- sort(data[which(data$type == 'joint'),]$count,decreasing = T)[1];

target_joint <- 4;
target_all <- 9;


shinyServer(function(input, output) {
  source("www/Login.R",  local = TRUE)
  
  observe({
    if (USER$Logged == TRUE) {
      
      output$crm <- renderUI({
        
        selectInput('crm', 'CRM Name', unique(names(table(data$CRM))))
        
      })
      
      
      # Combine the selected variables into a new data frame
      data1 <- reactive({
        
        subset(data, data$CRM == input$crm & data$type %in% c('Client_all', 'Prospect_COI_all'));
        
      })
      
      data2 <- reactive({
        
        subset(data, data$CRM == input$crm & data$type == 'joint');
        
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
          scale_fill_manual(values = c("joint" = "lightblue"))
        
      })  
      
    }
    
  })
})