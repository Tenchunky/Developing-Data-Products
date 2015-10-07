library(shiny)

# Shiny UI
shinyUI(fluidPage(
     
     # Title of Page
     titlePanel(h1("Predicting MPG based on Motor Trend 1974", align ="center")),
     
     # Side Bar on Left, Main Panel on Right
     sidebarLayout(
          # Side Bar (Left)
          sidebarPanel(
               helpText("Please choose the technical specifications of the car you want to predict."),
               br(),
               selectInput("am", "Transmission",
                           choices = list("Automatic" = 0, "Manual" = 1), 
                           selected = 0),
               br(),
               sliderInput("wt",
                           "Weight (Lb/1000):",
                           min = 1.5,
                           max = 5.5,
                           value = 3.5,
                           step = 0.1),
               br(),
               submitButton("Submit")
               
          ),
          
          # Main Panel (Right)
          mainPanel(
               # Instructions on App
               p("This application predicts the miles per gallon (MPG) of the selected car based on ",
                 "its transmission type and weight by fitting a linear regression on the 1974 Motor ",
                 "Trend US magazine data."),
               p("1. Select the transmission type of the car to predict"),
               p("2. Select the weight of the car to predict"),
               p("3. Click on the submit button"),
               br(),
               
               # Print inputs
               strong("Selected Inputs:"),
               textOutput("selected.am"),
               textOutput("selected.wt"),
               br(),
               
               # Print prediction (mpg)
               strong(textOutput("predicted.mpg")),
               br(),
               
               # Plot prediction (mpg) and show it with respect to data set
               plotOutput("plot.mpg.am.wt")
          )
     )
))