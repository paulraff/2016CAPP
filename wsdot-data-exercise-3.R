# Packages required for this exercise
install.packages("lubridate")
library(lubridate)

# We set up our simulation environment
GetRandomInteger <- function(min, max)
{
  return(sample(min:max, 1))
}

# First, we need to get a random user
GetRandomUser <- function()
{
  n <- sample(1:100, 1)
  return(paste("user", as.character(n), sep = ""))
}

# Now we have a function to get a random event
GetRandomEvent <- function()
{
  vals <- c("Search", "Click", "Leave", "Sign-in", "Sign-out")
  return(sample(vals, 1))
}

# Get a random time on 2016-01-01
GetRandomTime <- function(d)
{
  hour <- GetRandomInteger(0, 23)
  if (hour < 10)
  {
    hour <- paste("0", hour, sep = "")
  }
  minute <- GetRandomInteger(0, 59)
  if (minute < 10)
  {
    minute <- paste("0", minute, sep = "")
  }
  second <- GetRandomInteger(0, 59)
  if (second < 10)
  {
    second <- paste("0", second, sep = "")
  }
  return(paste("2016-01-01 ", hour, ":", minute, ":", second, sep = ""))
}

# Now we want to get a random date in 2015
GetRandomDate <- function()
{
  month <- GetRandomInteger(1, 12)
  if (month < 10)
  {
    month <- paste("0", month, sep = "")
  }
  day <- GetRandomInteger(1, 28)
  if (day < 10)
  {
    day <- paste("0", day, sep = "")
  }
  return(paste("2015-", month, "-", day, sep = ""))
}

# Now, let's make some action data
d <- as.Date("2016-01-01")
users <- sapply(1:10000, function(x) GetRandomUser())
events <- sapply(1:10000, function(x) GetRandomEvent())
times <- sapply(1:10000, function(x) GetRandomTime())
df.actions <- data.frame(users, events, times)
colnames(df.actions) <- c("Userid", "Event", "Time")
head(df.actions, 100)

# Now, let's make some user-level data on start date and end date
users <- sapply(1:100, function(x) {return(paste("user", x, sep = ""))})
startdates <- sapply(1:100, function(x) GetRandomDate())
enddates <- sapply(1:100, function(x) GetRandomDate())
df.userdata <- data.frame(users, startdates, enddates)
colnames(df.userdata) <- c("User", "StartDate", "EndDate")

# Now, let's make some user-level historical data
users <- sapply(1:100, function(x) {return(paste("user", x, sep = ""))})
users.extra <- sapply(1:10, function(x) {return(paste("user", x, sep = ""))})
treatments <- sapply(1:110, function(x) {return(sample(c("Treatment", "Control"), 1))})
df.flightinfo <- data.frame(c(users, users.extra), treatments)
colnames(df.flightinfo) <- c("User", "Flight")

# We now have three different data frames that we want to combine into one.
# Specification is that we have at least three columns: USER_ID, TREATMENT, DATE
# We also want to add a SEGMENT_UserAge segment
# Here's a proposed way to do it:
# Step 1: combine event data with the age data to get the segment
df.actions.with.userdata <- merge(df.actions, df.userdata, by.x = "Userid", by.y = "User", all.x = TRUE, all.y = FALSE)

# Step 2: Combine this new data with flight info to get flight assignment
df.actions.with.userdata.and.flightinfo <- merge(df.actions.with.userdata, df.flightinfo, by.x = "Userid", by.y = "User")

# Rename columns
colnames(df.actions.with.userdata.and.flightinfo) <- c("USER_ID", "Event", "DATE", "SEGMENT_UserAge", "EndDate", "TREATMENT")

# Anything interesting about this data?