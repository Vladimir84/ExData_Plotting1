# Read data
data<-read.table(unz("exdata-data-household_power_consumption.zip","household_power_consumption.txt"),blank.lines.skip=T,na.strings='?',header=T,sep=";")
dates<-as.Date(data$Date,"%d/%m/%Y")
select<-dates %in% c(as.Date("2007-02-02"),as.Date("2007-02-01"))
subset<-data[select,]

subset$Date<-as.Date(subset$Date,"%d/%m/%Y")
subset$Time<-strptime(subset$Time,"%H:%M:%S")
subset$Dates <- do.call(paste, c(data[select,c("Date", "Time")]))
subset$Dates<-strptime(subset$Dates,"%d/%m/%Y %H:%M:%S")

# png("plot1.png",width = 480, height = 480)  # plot with white background
png("plot4.png",width = 480, height = 480, bg="transparent")

# plot 4
par(mfrow=c(2,2))

par(mar=c(5,4,4,2)); 

plot(subset$Dates,subset$Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)")

plot(subset$Dates,subset$Voltage,type="l",xlab="datetime",ylab="Voltage")

plot(subset$Dates,subset$Sub_metering_1, type="l",xlab="",ylab="Energy sub metering",col="black")
lines(subset$Dates,subset$Sub_metering_2, col="red")
lines(subset$Dates,subset$Sub_metering_3, col="blue")
# add legend, no boundary, smaller font
legend(x="topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"), bty = "n", cex=0.9)

plot(subset$Dates,subset$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power")

# save file
dev.off()