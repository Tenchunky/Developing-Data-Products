library(shiny)
library(ggplot2)

# Load 'mtcars' data set
data(mtcars)

# Encode categorical variable (am) to factor variable
mtcars$am <- as.factor(mtcars$am)

# Linear regression with the chosen variables (am + wt)
fit <- lm(mpg ~ am + wt, mtcars)

# Shiny Server
shinyServer(function(input, output) {
     # Print inputs (am)
     output$selected.am <- renderText({
               paste("Transmission:", c("Automatic","Manual")[as.integer(input$am)+1])
     })
     
     # Print inputs (wt)
     output$selected.wt <- renderText({
               paste("Weight (Lb/1000):", input$wt)
     })
     
     # Calculate prediction
     predicted.mpg <- reactive({
          predict(fit, newdata = data.frame(am=input$am, wt=input$wt))[1]})
     
     # Print prediction (mpg)
     output$predicted.mpg <- renderText({
          sprintf("Predicted Miles per Gallon (MPG): %.2f", predicted.mpg())
     })
     
     # Plot prediction (mpg) and show it with respect to data set
     output$plot.mpg.am.wt <- renderPlot({
          g <- ggplot(mtcars, aes(x=wt, y=mpg, color=am)) + 
               scale_color_discrete(name="Transmission",breaks=c(0, 1), labels=c("Automatic", "Manual")) +
               geom_point(size = 3) +
               geom_hline(yintercept = predicted.mpg()) +
               geom_vline(xintercept = input$wt) +
               labs(x ='Weight (Lb/1000)') +
               labs(y = 'Miles per Gallon') +
               labs(title ='Miles per Gallon (MPG) against Weight(Lb/1000)')
          print(g)
     })
})