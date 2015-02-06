## Set the working directory
## It should un-comment and change if you want to run this script other directory 
## than 'household_power_consumption.txt'
##setwd("~/Tutorials/Stanford University On-Line Courses/Exploratory Data Analysis/Course Project 1/")


## Check the 'household_power_consumption.txt' file
curDir <-list.files(path = '.', recursive=FALSE)
if (!("household_power_consumption.txt" %in% curDir))
{
  print(c("The current directory is:",getwd()))
  print("I can't find necessary file in!")
  stop("Bye", call.= FALSE)
}

# Read the first 1 row/minute * 60 minute/Hours * 24 Hours/day  * (15 + 30 + 5) days = 72000 rows
# It contains the selected days
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows=72000, stringsAsFactors=FALSE)

# Convert Date variable from string to Date object
power$Date <- as.Date(power$Date, "%d/%m/%Y")

# Filter out the the rows for 1st and 2nd of February
power <- power[power$Date >= as.Date("2007-02-01") & power$Date <= as.Date("2007-02-02"),]

# Generate histrogram from Global_active_power variable
hist(power$Global_active_power, xlab="Global Active Power (kilowatts)", main="Global Active Power", col="red")

# Save histogram
dev.copy(png, "Plot1.png")

dev.off();
