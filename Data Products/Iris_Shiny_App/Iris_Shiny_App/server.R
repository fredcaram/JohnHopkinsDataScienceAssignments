#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
source("elem_stat_learn_example.R")

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  dataResult <- reactive({
    test_k(input$k)
  })
  
  output$neighbors_plot <- renderPlot({
    res <- dataResult()
    # draw the histogram with the specified number of bins
    kplot <- plot_k(res)
  })
  
  output$accuracy_text <- renderText({
    res <- dataResult()
    paste("Model accuracy:", res$acc)
  })
})
