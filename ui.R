# Author - Anupama Rajaram
# Date - Aug 15 2016
# Description - ui.R script for Yelp shiny app
#               Basic webpage/app with action button for processing input 
#               and displaying output on 2-tabbed panes

source("fn_yelp_api_calls.R")

ui <- shinyUI(pageWithSidebar(
  # header for the Shiny app
  headerPanel('Yelp College Search App'),
  
  # sidebar panel for user input text
  sidebarPanel(
    h4("User Input Panel"),
    br(),
    textInput("text_input", "Type city name or zipcode", value = "19104"),
   
    sliderInput("slider1", label = "Select Radius in Miles", min = 0, 
                max = 20, value = 4),
    br(),
    
    actionButton("updateButton", "Analyze Input")
    
  ),
  
  
  # output panel - right hand side
  mainPanel(
    h4("Output Panel"),
  
    tabsetPanel(type = "tabs", 
              tabPanel("Tab1", 
                       br(),
                       textInput("text_output2", "Updates only with action button click",
                                 value = "19104"),
                       textInput("value", "value in metres", value = 4)
                       ), 
              tabPanel("Plot",
                       br(),
                       leafletOutput("mymap")
                       
                       ),
              tabPanel("Table",
                       br(),
                       tableOutput("table")
                       )
              )
    
  )
  
))

