# Include plainfully long data calculations
# to find the data.r file use this:
source("global.r")
colors <- c("#4AC6B7", "#965F8A", "#FF7070")
server <- function(input, output){
  output$plot <- renderPlotly({
    final <- filter(final, year == input$YEAR)
    plot_ly(final, x = final$perCapita, y = final$lifeExpect, color = final$income, size = final$perCent,
                         colors = colors, type = "scatter", mode = "markers", sizes = c(min(final$perCent), max(final$perCent)),
                         marker = list(symbol = "circle", sizemode = "diameter",
                                       line = list(width = 2, color = "#000000")),
                         text = ~paste("Country:", final$country, "<br>Life Expectancy:", final$lifeExpect,
                                       "<br>Expenditure Per Capita:", final$perCapita,
                                       "<br>Expenditure as % of GDP:", final$perCent)) %>%
    layout(title = "Life Expectancy vs Expenditure on Health",
           xaxis = list(title = "Health Expenditure Per Capita in USD",
                        gridcolor = "rgb(119, 119, 119)",
                        range = c(-500,10500),
                        zerolinewidth = 1,
                        ticklen = 2000,
                        gridwidth = 2),
           yaxis = list(title = "Life Expectancy in years",
                        gridcolor = "rgb(100, 100, 100)",
                        range = c(42,88),
                        zerolinewidth = 1,
                        ticklen = 5,
                        gridwidth = 2),
           paper_bgcolor = 'rgb(243, 243, 243)',
           plot_bgcolor = 'rgb(243, 243, 243)'
  )
})
}
