library(lubridate)

filename <- "data.zip"


#download zip file from course website
if (!file.exists(filename)){
  fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip" 
  download.file(fileURL, filename)
}  
#unzip
if (file.exists(filename)) { 
  unzip(filename) 
}

#read data
filename <- "household_power_consumption.txt"
data <- read.table(filename, sep = ";", header =  FALSE, skip = 1,
                   col.names = c("Date", "Time", "Global_active_power", "Global_reactive_power",
                                 "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2",
                                 "Sub_metering_3"), na.strings = "?", stringsAsFactors = FALSE)
#convert date and time in date and time types
data$DateTime <- strptime(paste(data$Date, data$Time, sep=" "), "%d/%m/%Y %H:%M:%S")
data$Date <- dmy(data$Date)
data$Time <- hms(data$Time)


# Extract to february 2007, 01 and 02 data
data <- subset(data,Date == dmy("01-02-2007") | Date == dmy("02-02-2007"))


# plot2
with(data, plot(DateTime,Global_active_power, type = "l", xlab = " ", ylab = "Global Active Pwer (kilowatts)" ))
dev.copy(png, file = "plot2.png")
dev.off()
