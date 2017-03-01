ui <- fluidPage(
  titlePanel("Health Expenditure and Life Expectancy"),
  theme = "superhero",
  sidebarLayout(
    sidebarPanel(
      selectInput("select", label = "Primary Data", choices = list("Per Capita Expenditure" = 1,"Percent of GDP Expenditure" = 2, selected = 1))
    ),
    mainPanel(
      plotOutput("plot"),
      br(),
      tableOutput("table")
    )
  )
)
## As a sidenote, in case anyone ever reads this
# When looking for resources to use for this
# plot, I happened to find the Shiny Gallery
# with a plot that also contains health
# expenditure data but plotted against time
# as well. At this point, I considered scrapping
# it all and starting over, but I had already
# invested well over 10 hours into research
# and how to's and refining the data sets
# so I had to stick with it. 
# What I'm referring to, of course, is this
# chart: https://shiny.rstudio.com/gallery/google-charts.html

# Since you've gotten this far, might as well
# share a little tidbit of a thing that I found while
# doing some research around health plans out of
# personal interest. The Japanese apparently have
# something called a "Super Ambulance" which
# is basically just a large truck that folds out
# into a field hospital. It looks quite cool.