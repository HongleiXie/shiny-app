shinyUI(pageWithSidebar(
  headerPanel('Test Test Test'),
  sidebarPanel(
    selectInput('bus', 'Business Lines', names(table(data$bus))),
    selectInput('type', 'Calls Type', names(table(data$joint)))

  ),
  mainPanel(
    plotOutput('plot1')
  )
))
