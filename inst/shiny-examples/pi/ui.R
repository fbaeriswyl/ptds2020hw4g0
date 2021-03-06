library(shiny)

shinyUI(fluidPage(

    titlePanel("Pi Estimation"),

    sidebarLayout(

        sidebarPanel(
            selectInput("method", "Choose the desired method to estimate pi:", choices=c("estimated_pi", "estimated_pi2")),

            numericInput("seed", "Enter the desired seed:", min=1, max=10^6, value=1),

            sliderInput("B", "Enter the number of simulations", min=1, max=1000000, value=100)

        ),

        mainPanel(

            plotOutput("plot"),

            textOutput("time"),

            textOutput("pi")
        )
    )
))
