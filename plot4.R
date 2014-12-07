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

### make plot 4 and save it to png

png(file="plot4.png", width=480, height=480, units="px")
par(mfrow=c(2, 2))
with(sDat, {
        hist(sDat$Global_active_power, col="red", main="", xlab="Global active power (kilowatts)", ylim=c(0, 1200))
        plot(DatePosix, Voltage, type="l", ylab="Voltage", xlab="datetime")
        plot(sDat$DatePosix, sDat$Sub_metering_1, type="l", ylab="Energy sub metering", xlab=" ")
        points(sDat$DatePosix, sDat$Sub_metering_2, type="l", col="red")
        points(sDat$DatePosix, sDat$Sub_metering_3, type="l", col="blue")
        legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lwd=2, bty="n")
        plot(DatePosix, Global_reactive_power, type="l", ylab="Global_reactive_power", xlab="datetime")
})
dev.off() 