# Test for and install required packages
# Function from: http://stackoverflow.com/a/9341833
pkgTest <- function(x)
{
  if (!require(x,character.only = TRUE))
  {
    install.packages(x,dep=TRUE)
    if(!require(x,character.only = TRUE)) stop("Package not found")
  }
}
pkgTest("WHO")
pkgTest("shiny")
pkgTest("stringr")
pkgTest("ggplot2")
pkgTest("googleVis")
pkgTest("googleVis")


# Initialize Dependencies
library(shiny)
library(WHO)
library(dplyr)
library(stringr)
library(ggplot2)
library(googleVis)



## Download codes
#codes <- get_codes()
#View(codes)

# First, a quick rationale of why the data
# sets are being attached each time. The
# reason for this is that not attaching
# them causes data.frame() to change the
# variable names. This makes subsequent
# operations much more difficult.

# Life Expectancy
setup <- get_data("WHOSIS_000001")
attach(setup)
intermed <- subset(setup, year == "2014")
detach(setup)
attach(intermed)
intermed2 <- subset(intermed, sex == "Both sexes")
detach(intermed)
attach(intermed2)
lifeExpect <- data.frame(year, country, value)
detach(intermed2)
lifeExpect <- na.omit(lifeExpect)
lifeExpect <- lifeExpect[order(lifeExpect$country),]
lifeExpect <- rename(lifeExpect, replace = c(value = lifeExpect))

# Per Capita Health Spending
setup <- get_data("WHS7_105")
attach(setup)
perCapita <- data.frame(year, country, value)
perCapita <- subset(perCapita, year == "2014")
detach(setup)
attach(perCapita)
perCapita <- data.frame(country, value)
detach(perCapita)
perCapita <- na.omit(perCapita)
perCapita <- perCapita[order(perCapita$country),]
perCapita <- rename(perCapita, replace = c(value = perCapita))

# Percent of GDP Health spending
setup <- get_data("WHS7_143")
attach(setup)
perCent <- data.frame(year, country, value)
perCent <- subset(perCent, year == "2014")
detach(setup)
attach(perCent)
perCent <- data.frame(country, value)
detach(perCent)
perCent <- na.omit(perCent)
perCent <- perCent[order(perCent$country),]
perCent <- rename(perCent, replace = c(value = perCent))

# Merge the data sets (order matters because of variable reassignment)
perCapita <- merge(lifeExpect, perCapita, by="country")
full <- merge(perCapita, perCent, by="country")
perCent <- merge(lifeExpect, perCent, by="country")
