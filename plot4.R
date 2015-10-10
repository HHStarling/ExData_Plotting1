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
## plot 4 is multiple plots in 2x2 grid

## making background transparent since orig files from github show transparent
png(file="plot4.png", width = 480, height= 480, bg="transparent")
par(mfcol=c(2,2))
with(powerData, {
  ## upper left
  plot(Time,Global_active_power, type="l",
                     xlab="", ylab="Global Active Power")
  ## lower left
  with(powerData, {
    plot(Time,Sub_metering_1, type="l", col="black",
         xlab="", ylab="Energy sub metering")
    lines(Time, Sub_metering_2, col="red")
    lines(Time, Sub_metering_3, col="blue")
    legend(x="topright", col=c("black","red","blue"),
           legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lwd=1, lty=1, bty="n")
  })
  
  ## upper right
  plot(Time,Voltage, type="l", xlab="datetime", ylab="Voltage")
  
  ## lower right
  plot(Time, Global_reactive_power, type="l",  xlab="datetime", ylab="Global_reactive_power")

})
dev.off()

print("File plot4.png generated")
## ***** END create plot *****
