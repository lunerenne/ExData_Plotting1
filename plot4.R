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

datetime <-paste(power$Date,power$Time)
power$datetime <-strptime(datetime, "%m/%d/%Y %H:%M:%S")
par(mfrow=c(2,2), mar=c(4,4,2,1))
with(power, {
        plot(datetime, Global_active_power, type = "l", ylab = "Global Active Power", xlab = "")
        plot(datetime, Voltage, type="l")
        plot(datetime, Sub_metering_1, type="l", ylab = "Energy Sub Metering", col="black", ylim = c(0, 30), xlab = "")
        points(power$datetime, power$Sub_metering_2, type="l", col="red")
        points(power$datetime, power$Sub_metering_3, type="l", col="blue")
        legend("topright", lty = 1, col =c("black", "red", "blue"),legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
        plot(datetime, Global_reactive_power, type = "l")
        })

#print to png
dev.copy(png, "plot3.png")
dev.off()
