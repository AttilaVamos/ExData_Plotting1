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

# Read the first 1 row/minute * 60 minute/Hours * 24 Hours/day  * (15+30 + 5) days = 72000 rows
power <- read.table("household_power_consumption.txt", header = TRUE, sep = ";", na.strings = "?", nrows=72000, stringsAsFactors=FALSE)

# Convert Date variable from string to Date object
power <- within(data, DateTime <- as.POSIXlt(paste(Date, Time), format = "%d/%m/%Y %H:%M:%S"))

# Filter out the the rows fro 1st and 2nd of February
power <- power[power$DateTime >= as.POSIXlt("2007-02-01") & power$DateTime < as.POSIXlt("2007-02-03"),]

# Create png inmage file
png("Plot4.png")

# We have 2 x 2 plots
par( mfrow = c(2,2))

# Generate line plot from Global_active_power variable
plot(power$DateTime, power$Global_active_power, type="l", xlab="", ylab="Global Active Power")

# Generate line plot from Voltage variable
plot(power$DateTime, power$Voltage, type="l", xlab="datetime", ylab="Voltage")

# Generate plots from Sub_metering_1..3 variables
plot(power$DateTime, power$Sub_metering_1, type = "l", ylab = "Energy sub metering", xlab = "")
lines(power$DateTime, power$Sub_metering_2, col="red")
lines(power$DateTime, power$Sub_metering_3, col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty=1, bty='n')

# Generate line plot from Global_active_power variable
plot(power$DateTime, power$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")

# Close device ( and png file)
dev.off()
