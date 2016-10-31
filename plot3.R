#Load relevant packages
library(pacman)
p_load(janitor, dplyr, magrittr, lubridate)

#Import data set
power <- read.delim("household_power_consumption.txt", sep = ";")

#change Date to a character for purposes of filtering
power$Date <- as.character(power$Date)

#filter for only February 1st and 2nd 2007
power <- power %>%
        filter(Date == "2/1/2007" | Date == "2/2/2007")

#Turn Global Active Power into a numeric variable
power$Global_active_power <- as.numeric(as.character(power$Global_active_power))

DateTime <-paste(power$Date,power$Time)
power$DateTime <-strptime(DateTime, "%m/%d/%Y %H:%M:%S")

with(power, plot(DateTime,Sub_metering_1, type="l", ylab = "Energy Sub Metering", col="black", ylim = c(0, 30)))
points(power$DateTime, power$Sub_metering_2, type="l", col="red")
points(power$DateTime, power$Sub_metering_3, type="l", col="blue")
legend("topright", lty = 1, col =c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))

#print to png
dev.copy(png, "plot3.png")
dev.off()
