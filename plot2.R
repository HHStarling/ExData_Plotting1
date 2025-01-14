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
## plot 2 is a plot of global active power by datetime
## making background transparent since orig files from github show transparent
png(file="plot2.png", width = 480, height= 480, bg="transparent")
plot(powerData$Time,powerData$Global_active_power, type="l", 
     xlab="", ylab="Global Active Power (kilowatts)")
dev.off()

print("File plot2.png generated")
## ***** END create plot *****
