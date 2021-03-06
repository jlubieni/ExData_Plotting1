## this script assumes file is in working directory

library(data.table)

### read in first 70000 rows
dat <- fread("household_power_consumption.txt", nrows=70000, na.strings="?")

### subset for data from 1/2/2007 and 2/2/2007
sDat <- dat[dat$Date== "1/2/2007" | dat$Date== "2/2/2007",]
rm(dat)

### convert Date and time column to POSIX format
sDat <- as.data.frame(sDat)
sDat$DateTime <- paste(sDat$Date, sDat$Time)
sDat$DatePosix <- strptime(sDat$DateTime, "%d/%m/%Y %H:%M:%S")
sDat$DateTime <- NULL
str(sDat)
for(i in 3:9){
        sDat[, i]  <- as.numeric(sDat[, i])
}

### make plot 1 and save it to png

png(file="plot1.png", width=480, height=480, units="px")
hist(sDat$Global_active_power, col="red", main="Global Active Power", xlab="Global active power (kilowatts)", ylim=c(0, 1200))
dev.off() 

