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

with(power, plot(DateTime, Global_active_power, type="l", ylab="Global Active Power (kilowatts)"))

#print to png
dev.copy(png, "plot2.png")
dev.off()
