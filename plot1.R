
# Load the electricity consumption data (Source: UC Irvine Machine Learning Repository)
# note that this file contains "?" for unknown data so using na.strings = "?"
consumption <- read.table("data/household_power_consumption.txt", 
                          header = TRUE, 
                          sep = ";", 
                          colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric"),
                          na.strings = "?")
# Calculate the date/time from the strings
consumption$DateTime <- strptime(paste(consumption$Date, consumption$Time), format="%d/%m/%Y %H:%M:%S")

# Create a subset of the data for examination - 2007-02-01 and 2007-02-02
february_subset <- subset(consumption, DateTime>="2007-02-01 00:00:00" & DateTime<="2007-02-02 23:59:59")

# First plot
png("plot1.png", width=480, height=480)

hist(february_subset$Global_active_power, 
     main="Global Active Power",
     xlab="Global Active Power (kilowats)",
     col="red"
)

dev.off()
