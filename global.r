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
pkgTest("dplyr")
pkgTest("stringr")
pkgTest("ggplot2")
pkgTest("plotly")


# Initialize Dependencies
library(shiny)
library(WHO)
library(dplyr)
library(stringr)
library(ggplot2)
library(plotly)



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
setup <- subset(setup, sex == "Both sexes")
attach(setup)
lifeExpect <- data.frame(year, country, value)
detach(setup)
lifeExpect <- na.omit(lifeExpect)
lifeExpect <- lifeExpect[order(lifeExpect$country),]
names(lifeExpect) <- c("year","country","lifeExpect")

# Per Capita Health Spending
setup <- get_data("WHS7_105")
attach(setup)
perCapita <- data.frame(year, country, value, worldbankincomegroup)
detach(setup)
perCapita <- na.omit(perCapita)
perCapita <- perCapita[order(perCapita$country),]
names(perCapita) <- c("year","country","perCapita","income")

# Percent of GDP Health spending
setup <- get_data("WHS7_143")
attach(setup)
perCent <- data.frame(year, country, value)
detach(setup)
perCent <- na.omit(perCent)
perCent <- perCent[order(perCent$country),]
names(perCent) <- c("year","country","perCent")


# Merge the data sets (order matters because of variable reassignment)
perCapita <- merge(perCapita, lifeExpect, by=c("country","year"))
final <- merge(perCapita, perCent, by=c("country","year"))
final$income <- as.factor(final$income)
