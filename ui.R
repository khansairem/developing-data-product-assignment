#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
        titlePanel("Predict Temp from Ozone"),
        sidebarLayout(
                sidebarPanel(
                        sliderInput("sliderOzone", "What is the level of Ozone in NewYork Air?", 1, 168, value = 84),
                        checkboxInput("showModel1", "Show/Hide Model 1", value = TRUE),
                        checkboxInput("showModel2", "Show/Hide Model 2", value = TRUE),
                        submitButton("Submit")
                ),
                # ...
                mainPanel(
                        plotOutput("plot1"),
                        h3("Predicted temperature from Model 1:"),
                        textOutput("pred1"),
                        h3("Predicted temperature from Model 2:"),
                        textOutput("pred2")
                                    
                )
        )
))