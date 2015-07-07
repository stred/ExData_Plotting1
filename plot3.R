
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

# Third plot
png("plot3.png", width=480, height=480)

# Default to 1 chart in the output
par(mfrow = c(1, 1))

plot(february_subset$DateTime,february_subset$Sub_metering_1,
     type="l",
     ylab="Energy sub metering",
     xlab="",
     col="black",
     axes=FALSE
)
points(february_subset$DateTime,february_subset$Sub_metering_2, type="S", col="green")
points(february_subset$DateTime,february_subset$Sub_metering_3, type="s", col="blue")

# Create the day axis.
# Note that we only have values for 2 days, up to 23:59:00 on the Friday.
# By adding 60 seconds to the 2nd range value, we get a third "tick" representing
# midnight on the Saturday
axis.POSIXct(1, at = seq(range(february_subset$DateTime)[1], range(february_subset$DateTime)[2]+60, by = "day"), format="%a")
# Create the value axis in steps of 10 between 0 and the max value
axis(2, las=3, at=10*0:floor(max(february_subset$Sub_metering_1)))
# Add a box around the chart
box()
# Add the legend to the top right
legend("topright", pch="_", pt.cex=2, pt.lwd=1, col=c("black", "green", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

# Close the png
dev.off()
