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

#Plot a histogram of Global Active Power
hist(power$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)", xlim = c(0, 6), axes = FALSE)
axis(side=1,at=c(0, 2, 4, 6))
axis(side = 2, at = c(0, 200, 400, 600, 800, 1000, 1200))

#print to png
dev.copy(png, "plot1.png")
dev.off()
