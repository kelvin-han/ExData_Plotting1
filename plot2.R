library(downloader)
library(data.table)

URL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download(URL, dest="household_power_consumption.zip", mode="wb") 
unzip ("household_power_consumption.zip", exdir = "./")

## Read text file
data <- read.table("household_power_consumption.txt", sep=";",na.strings = "?", header=TRUE, stringsAsFactors=FALSE)

## convert Date string to Date format
data$Date <- as.Date(data$Date, format = "%d/%m/%Y")

## filter Data by date range given
subSetData <- filter(data, Date >= as.Date("2007-02-01"), Date < as.Date("2007-02-03"))

## paste Date and Time and convert to posix
subSetData$DateTime <- paste(subSetData$Date, subSetData$Time)
subSetData$DateTime <- strptime(subSetData$DateTime, "%Y-%m-%d %H:%M:%S")

## Reorder the columns in dataframe
subSetData <- subSetData[, c("DateTime","Date","Time","Global_active_power","Global_reactive_power", "Voltage","Global_intensity","Sub_metering_1","Sub_metering_2","Sub_metering_3")]

## Remove original data object
rm(data)

## Generate line plot and save in png format
png('plot2.png')
plot(subSetData$DateTime,subSetData$Global_active_power,type="l", ylab = "Global Active Power (kilowatts)", xlab = "")
dev.off()