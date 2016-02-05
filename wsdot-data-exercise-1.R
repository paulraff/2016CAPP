# Packages required for this exercise
install.packages("RCurl")
install.packages("jsonlite")
library(RCurl)
library(jsonlite)

# We can use the getURL function in the RCurl library to get the contents of an HTTP call
wsdot.result <- getURL("http://wsdot.com/Traffic/api/MountainPassConditions/MountainPassConditionsREST.svc/GetMountainPassConditionsAsJson?AccessCode=eb16e03d-25c8-462c-b970-a45206479228")

# Then, we can use the fromJSON function in the jsonlite library
# Using the option flatten = TRUE is helpful
df.wsdot.result <- fromJSON(wsdot.result, flatten = TRUE)

# Now, let's look at the data
summary(df.wsdot.result)
t(head(df.wsdot.result, 1))

# So we have data! And we're done, right?