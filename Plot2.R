# Read data
data<-read.table(unz("exdata-data-household_power_consumption.zip","household_power_consumption.txt"),blank.lines.skip=T,na.strings='?',header=T,sep=";")
dates<-as.Date(data$Date,"%d/%m/%Y")
select<-dates %in% c(as.Date("2007-02-02"),as.Date("2007-02-01"))
subset<-data[select,]

subset$Date<-as.Date(subset$Date,"%d/%m/%Y")
subset$Time<-strptime(subset$Time,"%H:%M:%S")
subset$Dates <- do.call(paste, c(data[select,c("Date", "Time")]))
subset$Dates<-strptime(subset$Dates,"%d/%m/%Y %H:%M:%S")

# png("plot2.png",width = 480, height = 480, bg="white")   # plot with white background
png("plot2.png",width = 480, height = 480, bg="transparent")

# plot 2

subset$Dates <- do.call(paste, c(data[select,c("Date", "Time")]))

subset$Dates<-strptime(subset$Dates,"%d/%m/%Y %H:%M:%S")
plot(subset$Dates,subset$Global_active_power, type="l",xlab="", ylab="Global Active Power (kilowatts)")

# save file
dev.off()
