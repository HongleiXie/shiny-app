library(shiny)
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

# Define the overall UI
shinyUI(
  
  # Use a fluid Bootstrap layout
  fluidPage(    
    
    # Give the page a title
    titlePanel("TEST TITLE"),
    
    # Generate a row with a sidebar
    sidebarLayout(      
      
      # Define the sidebar with one input
      sidebarPanel(
        selectInput("name", "LEVEL:", 
                    choices=c('NAME_VP', 'NAME_ML', 'NAME_GL', 'Employee__HR_Full_Name')),
        hr(),
        helpText("Data TEST TEST")
      ),
      
      # Create a spot for the barplot
      mainPanel(
        plotOutput("phonePlot")  
      )
      
    )
  )
)
