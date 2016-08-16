# Author - Anupama Rajaram
# Date - Aug 15 2016
# Description - server.R script for Yelp shiny app
#               Basic webpage/app with action button for processing input 
#               and displaying output on 2-tabbed panes
#               

source("fn_yelp_api_calls.R")
server <- function(input, output, session) {
  

  observe({
    updateTextInput(session, "text_output1", value = input$text_input)
  })
  

  # instead of observe and isolate, you could instead use observeEvent
  observe({
    input$updateButton
    updateTextInput(session, "text_output2", value = isolate(input$text_input))
  })
  
  observe({
    input$updateButton
    updateTextInput(session, "text_outputx2", value = isolate(input$text_inputx))
  })
  
  observe({
    input$updateButton
    #output$value <- renderPrint({ input$slider1 })
    updateTextInput(session, "value", value = isolate(input$slider1*1609.34))
  })
  
  observe({
    input$updateButton
    #output$table <- renderTable({ cars    })
    output$table <- renderTable({  yelp_srch(input$slider1, input$text_input, 3)    })
    })
    
    observe({
      input$updateButton
      mapdf <- yelp_map(input$slider1, input$text_input, 3)
      t1long <- mapdf[1,"latitude"]
      t1lat<- mapdf[1,"longitude"]
      output$mymap <- renderLeaflet({
        leaflet(mapdf) %>% 
          setView(t1lat, t1long, zoom = 3) %>%
          addTiles() %>%
          addMarkers(~longitude, ~latitude, popup=~College,
                     options = popupOptions(closeButton = TRUE),
                     clusterOptions = markerClusterOptions()
          )
      })
    
  })
  
}


