# using sqldf library to select the subset of the dataset
library(sqldf)
file <- "exdata_data_household_power_consumption/household_power_consumption.txt"
df <- read.csv.sql(file, sep = ";", header = TRUE, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")
head(df)

library(lubridate)
df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

library(ggplot2)
#a
a <- ggplot(df, aes(DateTime, Global_active_power))+
  geom_line() +
  theme(axis.text.x = element_text(angle=90))

# b
b <- ggplot(df, aes(x=DateTime, y = Voltage))+
  geom_line() +
  theme(axis.text.x = element_text(angle = 90) )


# c
library("tidyverse")
new_df <- df %>%
  select(DateTime,Sub_metering_1,Sub_metering_2, Sub_metering_3) %>%
  gather(key = "variable", value = "value", -DateTime)

c <- ggplot(new_df, aes(x=DateTime, y=value)) +
  geom_line(aes(color = variable, linetype = variable)) +
  theme(axis.text.x = element_text(angle=90), legend.position=c(.8,.9))+
  labs(y="Energy sub metering")


# d
d <- ggplot(df, aes(x=DateTime, y=Global_reactive_power))+
     geom_line() +
   theme(axis.text.x = element_text(angle = 90))

library("gridExtra")
lst <- list(a,b,c,d)
do.call(grid.arrange, c(lst, list(ncol=2)))


# Plotting using Base
png(file="plot4.png")


par(mfrow=c(2,2))  

plot(x=df$DateTime, y=df$Global_active_power, type="l",xlab="",ylab="Global Active Power")       

plot(x=df$DateTime, y=df$Voltage, type="l",xlab="datetime",ylab="Voltage")          

plot(x=df$DateTime, y=df$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering")      
lines(x=df$DateTime, y=df$Sub_metering_2, col="red")                                       
lines(x=df$DateTime, y=df$Sub_metering_3, col="blue")                                      
legend("topright",c("Sub_metering_1  ","Sub_metering_2  ", "Sub_metering_3  "),col=c("black","red","blue"),lty=c(1,1),bty="n")      ##make legend at topright of 3rd plot of plot4,


plot(x= df$DateTime, y=df$Global_reactive_power, type="l",xlab="datetime",ylab="Global_reactive_power") 
dev.off()
