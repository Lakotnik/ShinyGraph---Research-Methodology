# Include plainfully long data calculations
# to find the data.r file use this:
source("data.r")

server <- function(input, output){
  output$plots <- renderGvis({
    if(input$select == 1){
      gvisBubbleChart(full, idvar = "country", xvar = "perCapita", yvar = "lifeExpect", colorvar = "year", sizevar = "perCent")
    } else if(input$select == 2){
      gvisBubbleChart(full, idvar = "country", xvar = "perCent", yvar = "lifeExpect", colorvar = "year", sizevar = "perCapita")
    }
  })
}

