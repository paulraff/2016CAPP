# Packages required for this exercise
install.packages("jsonlite")
library(jsonlite)

# First, let's load the data. Your path may differ.
# This file contains one data frame named df.wsdot.data
load("I:/OneDrive/Work/2016/2016 - CAPP Workshop/wsdot-data.RData")

# Now, do a simple inspection.
# This data was obtained by repeated polling of the WSDOT Data API
# which covers the conditions at 15 mountain passes in WA.
# See http://wsdot.com/traffic/api/ for more information.
summary(df.wsdot.data)
head(df.wsdot.data, 1)

# Make factors where factors are due!
df.wsdot.data$MountainPassName <- as.factor(df.wsdot.data$MountainPassName)
df.wsdot.data$MountainPassId <- as.factor(df.wsdot.data$MountainPassId)
df.wsdot.data$WeatherCondition <- as.factor(df.wsdot.data$WeatherCondition)
df.wsdot.data$RestrictionOne.TravelDirection <- as.factor(df.wsdot.data$RestrictionOne.TravelDirection)
df.wsdot.data$RestrictionTwo.TravelDirection <- as.factor(df.wsdot.data$RestrictionTwo.TravelDirection)

# Now, the hardest part is dealing with the date. Take the first date, for example.
df.wsdot.data$DateUpdated[1]

# It's "/Date(1454181695067-0800)/". Nasty, right?
# The only part that's helpful is this: 1454181695067-0800
# Let's see if built-in R functions can parse this
as.POSIXlt(1454181695, origin = "1970-01-01")
