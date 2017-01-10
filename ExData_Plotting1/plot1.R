library(dplyr)
library(ggplot2)

all_data <- read.table("household_power_consumption.txt", 
                       header = TRUE, na.strings = "?", sep = ";")

all_data$Date <- as.Date(all_data$Date, format = "%d/%m/%Y")
all_data$Time <- as.POSIXct(strptime(paste(all_data$Date, all_data$Time), 
                                     format = "%Y-%m-%d %H:%M:%S", ))

mdf <- filter(all_data, (Date >= "2007-02-01") & Date <= "2007-02-02")

# PLOT 1

with(mdf, hist(Global_active_power, 
               main = "Global Active Power", 
               xlab = "Global Active Power (kilowatts)", 
               col = "orange"))

dev.copy(png,'plot1.png')
dev.off()