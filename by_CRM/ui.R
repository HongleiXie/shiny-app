shinyUI(bootstrapPage(
  # Add custom CSS & Javascript;
  tagList(
    tags$head(
      tags$link(rel="stylesheet", type="text/css",href="style.css"),
      tags$script(type="text/javascript", src = "md5.js"),
      tags$script(type="text/javascript", src = "passwdInputBinding.js")
    )
  ),
  
  ## Login module;
  div(class = "login",
      uiOutput("uiLogin"),
      textOutput("pass")
  ), 
  
  h1("Welcome to Scotiabank Commercial Banking"),
  
  div(class = "span4", uiOutput("crm")),
  div(class = "span4", plotOutput("plot1")),
  div(class = "span4", plotOutput("plot2"))
  
  
  
))
