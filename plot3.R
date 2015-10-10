## ***** START download and format data for use in plot *****

## pull data down from site
print("Starting download and cleaning of data...")
library(dplyr)

fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
fileNm <- "household_power_consumption.txt"
temp <- tempfile()
download.file(fileUrl,temp)
allData <- tbl_df(read.table(unz(temp, fileNm), sep=";", header=TRUE, 
                             stringsAsFactors = FALSE, na.strings = c("?","")))
unlink(temp)

## update date and time columns to R classes
print("Fixing dates...")

allData$Date <- as.Date(allData$Date, format = "%d/%m/%Y")
allData$DateTime <- paste(allData$Date, allData$Time)  
allData$Time <- strptime(allData$DateTime, format = "%Y-%m-%d %H:%M:%S")

print("Subsetting data...")
## subset data to just entries for 2007-02-01 and 2007-02-02
powerData <- allData[allData$Date=="2007-2-1" | allData$Date=="2007-2-2",]

print("Data downloaded and cleaned...")
## ***** END download and format data for use in plot *****
## data set name = powerData

## ***** START create plot *****
## plot 3 is a plot of each submetering by datetime
## making background transparent since orig files from github show transparent
png(file="plot3.png", width = 480, height= 480, bg="transparent")
with(powerData, plot(Time,Sub_metering_1, type="l", col="black",
                     xlab="", ylab="Global Active Power (kilowatts)"))
with(powerData, lines(Time, Sub_metering_2, col="red"))
with(powerData, lines(Time, Sub_metering_3, col="blue"))
legend(x="topright", col=c("black","red","blue"),
       legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, lty=1)
dev.off()

print("File plot3.png generated")
## ***** END create plot *****
