# using sqldf library to select the subset of the dataset 
library(sqldf)

file <- "exdata_data_household_power_consumption/household_power_consumption.txt"
df <- read.csv.sql(file, sep = ";", header = TRUE, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")
dim(df)

library("lubridate")

df$DateTime <- as.POSIXct(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S")

library("tidyverse")
new_df <- df %>%
  select(DateTime,Sub_metering_1,Sub_metering_2, Sub_metering_3) %>%
  gather(key = "variable", value = "value", -DateTime)

library("ggplot2")


ggplot(new_df, aes(x=DateTime, y=value)) +
  geom_line(aes(color = variable, linetype = variable))
