library(shiny)
load("US_Trade.RData")
# Define UI for application that draws a histogram
shinyUI(fluidPage(

  # Application title
  titlePanel("World Trade with USA"),

  # Sidebar with a slider input for the number of bins
  sidebarLayout(
                sidebarPanel( 
                helpText(paste("Please to get trade deficit between USA and a given country,",
                "select the year by hovering the mouse cursor over the graph, and enter a country,",
                'Then press the "GO?" button')),
                
                sliderInput("range", label = "Year:", min = 2007, max = 2013, 
                value = c(2007, 2013),sep=""),
                br(),                
                selectInput("Country_var", h4("Choose US Partner"), choices=unique(as.character(df1$USPartner))), 
                br(),
                 helpText(paste("Enter a Type of Trade Flow, to see principal Items and their value.", 
                'Then press the "GO?" button')),
                selectInput("Trade_Flow", h4("Choose a Trade Flow"), choices=c("Import","Export","Re-Export")),       
                #radioButtons("Trade_Flow", h4("Choose a Trade Flow"), c("Import","Export","Re-Export")), 
                br(),
                numericInput("obs", "Number of observations to view:", 10),
                br(),                 
                submitButton("GO?")
                ),
    
           
    # Show the caption and plot of the requested variable against Trade Value
      # Show a plot of the generated distribution

    mainPanel(
              textOutput("TradeBal"),
              textOutput("TB"), 
              br(),
              tabPanel(p(icon("table"),"Data"),
              dataTableOutput("table"),
              downloadButton('downloadBest', 'Download'))
    ))
))

