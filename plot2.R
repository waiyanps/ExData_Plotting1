# using sqldf library to select the subset of the dataset 
library(sqldf)

file <- "exdata_data_household_power_consumption/household_power_consumption.txt"
df <- read.csv.sql(file, sep = ";", header = TRUE, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")
dim(df)

library("lubridate")

df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")


library("ggplot2")
# ggplot
ggplot(df, aes(DateTime, Global_active_power))+
  geom_line()

png(file="plot2.png")
# base plot
plot(df$DateTime, df$Global_active_power, type="l", xlab = " ", ylab = "Global Active Power (kilowatts)")

dev.off()
