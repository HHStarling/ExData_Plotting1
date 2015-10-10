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
## plot 1 is a histogram of global active power


## change column to numeric
powerData$Global_active_power <- as.numeric(powerData$Global_active_power)

## generate histogram
png(file="plot1.png", width = 480, height= 480)
hist(powerData$Global_active_power, 
     xlab="Global Active Power (kilowatts)", 
     main="Global Active Power", col="red", ylim = c(0,1200))
dev.off()

print("File plot1.png generated")
## ***** END create plot *****


