#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyServer(function(input, output) {
        airquality$Ozonesp <- ifelse(airquality$Ozone - 84 > 0, airquality$Ozone - 84, 0)
        model1 <- lm(Temp ~ Ozone, data = airquality)
        model2 <- lm(Temp ~ Ozonesp + Ozone, data = airquality)
        
        model1pred <- reactive({
                OzoneInput <- input$sliderOzone
                predict(model1, newdata = data.frame(Ozone = OzoneInput))
        })
        
        model2pred <- reactive({
                OzoneInput <- input$sliderOzone
                predict(model2, newdata = 
                                data.frame(Ozone = OzoneInput,
                                           Ozonesp = ifelse(OzoneInput - 84 > 0,
                                                          OzoneInput - 84, 0)))
        })
        output$plot1 <- renderPlot({
                OzoneInput <- input$sliderOzone
                
                plot(airquality$Ozone, airquality$Temp, xlab = "Ozone in air", 
                     ylab = "Temperature", bty = "n", pch = 16,
                     xlim = c(1, 168), ylim = c(56, 97))
                if(input$showModel1){
                        abline(model1, col = "red", lwd = 2)
                }
                if(input$showModel2){
                        model2lines <- predict(model2, newdata = data.frame(
                                Ozone = 1:168, Ozonesp = ifelse(1:168 - 84 > 0, 1:168 - 84, 0)
                        ))
                        lines(1:168, model2lines, col = "blue", lwd = 2)
                }
                legend(25, 250, c("Model 1 Prediction", "Model 2 Prediction"), pch = 16, 
                       col = c("red", "blue"), bty = "n", cex = 1.2)
                points(OzoneInput, model1pred(), col = "red", pch = 16, cex = 2)
                points(OzoneInput, model2pred(), col = "blue", pch = 16, cex = 2)
        })
        
        output$pred1 <- renderText({
                model1pred()
        })
        
        output$pred2 <- renderText({
                model2pred()
        })
        
})