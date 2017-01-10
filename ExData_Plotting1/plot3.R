library(dplyr)
library(ggplot2)

all_data <- read.table("household_power_consumption.txt", 
                       header = TRUE, na.strings = "?", sep = ";")

all_data$Date <- as.Date(all_data$Date, format = "%d/%m/%Y")
all_data$Time <- as.POSIXct(strptime(paste(all_data$Date, all_data$Time), 
                                     format = "%Y-%m-%d %H:%M:%S", ))

mdf <- filter(all_data, (Date >= "2007-02-01") & Date <= "2007-02-02")

# PLOT 3

ggplot(mdf, aes(Time)) + 
  geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1")) +
  geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2")) +
  geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3")) +
  scale_x_datetime(date_labels = "%a", date_breaks = "1 days") +
  xlab("") +
  ylab("Energy sub meeting") +
  theme(legend.title = element_blank(), legend.position = c(1, 1), legend.justification = c(1, 1))

dev.copy(png,'plot3.png')
dev.off()