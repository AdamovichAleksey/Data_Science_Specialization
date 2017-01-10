library(dplyr)
library(ggplot2)

# additional library for multiplot in ggplot2
# use for plot4
library(gridExtra)

all_data <- read.table("household_power_consumption.txt", 
                       header = TRUE, na.strings = "?", sep = ";")

all_data$Date <- as.Date(all_data$Date, format = "%d/%m/%Y")
all_data$Time <- as.POSIXct(strptime(paste(all_data$Date, all_data$Time), 
                                     format = "%Y-%m-%d %H:%M:%S", ))

mdf <- filter(all_data, (Date >= "2007-02-01") & Date <= "2007-02-02")

# PLOT 4

# Plot 4-a

p_4_a <- ggplot(mdf, aes(Time, Global_active_power)) + 
  geom_line() + 
  scale_x_datetime(date_labels = "%a", date_breaks = "1 days") +
  xlab("") +
  ylab("Global Active Power")

# Plot 4-b

p_4_b <- ggplot(mdf, aes(Time, Voltage)) + 
  geom_line() + 
  scale_x_datetime(date_labels = "%a", date_breaks = "1 days") +
  xlab("datetime") +
  ylab("Voltage")

# Plot 4-c

p_4_c <- ggplot(mdf, aes(Time)) + 
  geom_line(aes(y = Sub_metering_1, colour = "Sub_metering_1")) +
  geom_line(aes(y = Sub_metering_2, colour = "Sub_metering_2")) +
  geom_line(aes(y = Sub_metering_3, colour = "Sub_metering_3")) +
  scale_x_datetime(date_labels = "%a", date_breaks = "1 days") +
  xlab("") +
  ylab("Energy sub meeting") +
  theme(legend.title = element_blank(), legend.position = c(1, 1), legend.justification = c(1, 1))

# Plot 4-d

p_4_d <- ggplot(mdf, aes(Time, Global_reactive_power)) + 
  geom_line() + 
  scale_x_datetime(date_labels = "%a", date_breaks = "1 days") +
  xlab("datetime") +
  ylab("Global_reactive_power")

# PLOT 4
grid.arrange(p_4_a, p_4_b, p_4_c, p_4_d, ncol = 2)

dev.copy(png,'plot4.png')
dev.off()