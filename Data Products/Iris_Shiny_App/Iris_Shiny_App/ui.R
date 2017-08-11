#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("K nearest neighbors example"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("k",
                   "Number of neighbors:",
                   min = 1,
                   max = 50,
                   value = 30)
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
        tabPanel(
         "Result",
         plotOutput("neighbors_plot"),
         textOutput("accuracy_text")
        ),
      tabPanel(
          "Help",
          h2("Using the k nearest neighbors example"),
          p("Drag the slide bar to test different value of k for the nearest neighbors model"),
          p("Example adapted from the book Elements of Statistical Learning:"),
          a("http://statweb.stanford.edu/~tibs/ElemStatLearn/")
        )
      )
    )
  )
))
