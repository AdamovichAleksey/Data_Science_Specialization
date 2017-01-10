library(dplyr)
library(ggplot2)

all_data <- read.table("household_power_consumption.txt", 
                       header = TRUE, na.strings = "?", sep = ";")

all_data$Date <- as.Date(all_data$Date, format = "%d/%m/%Y")
all_data$Time <- as.POSIXct(strptime(paste(all_data$Date, all_data$Time), 
                                     format = "%Y-%m-%d %H:%M:%S", ))

mdf <- filter(all_data, (Date >= "2007-02-01") & Date <= "2007-02-02")

# PLOT 2

ggplot(mdf, aes(Time, Global_active_power)) + 
  geom_line() + 
  scale_x_datetime(date_labels = "%a", date_breaks = "1 days") +
  xlab("") +
  ylab("Global Active Power (kilowatts)")

dev.copy(png,'plot2.png')
dev.off()