# using sqldf library to select the subset of the dataset 
library(sqldf)

file <- "exdata_data_household_power_consumption/household_power_consumption.txt"
df <- read.csv.sql(file, sep = ";", header = TRUE, sql = "select * from file where Date in ('1/2/2007','2/2/2007')")
View(df)

library(ggplot2)
library(ggthemr)

# histogram using base
hist(df$Global_active_power)

# histogram using ggplot2 - qplot 
qplot(df$Global_active_power,
      geom = "histogram",
      col ='red',
      )
ggthemr("dust",type="outer", layout="scientific", spacing=2)


# save plot as png
png(file="plot1.png")
# histogram using ggplot2 - ggplot
ggplot(data = df, aes(Global_active_power)) +
  geom_histogram(col="red", fill="black",alpha=0.1) +
  labs(title= "Global Active Power", x = "Global Active Power (kilowatts)", y = "Count")

dev.off()
  
