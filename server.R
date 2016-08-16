# Author - Anupama Rajaram
# Date - Aug 15 2016
# Description - server.R script for Yelp shiny app
#               Basic webpage/app with action button for processing input 
#               and displaying output on 2-tabbed panes
#               

server <- function(input, output, session) {
  

  # ====================================================== #
  # outputs on Tab1
  # ====================================================== #
  # the text output on Tab1
  # instead of observe and isolate, you could instead use observeEvent
  observe({
    input$updateButton
    updateTextInput(session, "text_output2", value = isolate(input$text_input))
  })
  
  # distance text output on Tab1
  observe({
    input$updateButton
    updateTextInput(session, "value", value = isolate(input$slider1*1609.34))
  })
  
 
  
  # ====================================================== #
  # outputs on Tab2 - PLOT
  # ====================================================== #  
  # outputs on Tab2 - PLOT
 
  observe({
    input$updateButton
    mapdf <- yelp_map(input$slider1, input$text_input, 3)
    output$mymap <- renderLeaflet({
      leaflet(mapdf) %>% 
        addTiles() %>%
        addMarkers(~longitude, ~latitude, popup=~College,
                   options = popupOptions(closeButton = TRUE),
                   clusterOptions = markerClusterOptions()
        )
    })
    
  })
    
    
  # ====================================================== #
  # outputs on Tab3 - TABLE
  # ====================================================== #     
  
  observe({
    input$updateButton
    #output$table <- renderTable({ cars    })
    output$table <- renderTable({  yelp_srch(input$slider1, input$text_input, 3)    })
    })
    
    
    
}





