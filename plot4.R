## R script to construct Plot 4 of the 1st assignment for the Coursera Exploratory Data Analysis course

### read data table
power<-read.table("data/household_power_consumption.txt",header=TRUE, sep=";",na.strings="?", 
                  colClasses=c("character","character","numeric","numeric","numeric","numeric","numeric","numeric"
                               ,"numeric"))

### convert first column to date format
date<-as.Date(power[,1],"%d/%m/%Y")
power[,1]<-date

### convert second column to time format
power$Time<-paste(power$Date,power$Time)
date_time<-strptime(power$Time,format="%Y-%m-%d %H:%M:%S")
power$Time<-date_time

### remove date only column
power<-power[,-1]

### rename "Time" column to "date_time"
colnames(power)[1]<-"date_time"

### subset relevant data
power_rel<-subset(power, power$date_time>="2007-02-01" & power$date_time<"2007-02-03")

## open graphics device
png(filename="plot4.png",width=480,height=480,units="px",bg="white")

### set up 4 graph combination to fill by row
par(mfrow=c(2,2))

### fill in by row with correct graphs
        ### upper left
        plot(power_rel$date_time,power_rel$Global_active_power,type="l",xlab="",ylab="Global Active Power",
             cex.lab="1.0",cex.axis="1.0")

        ### upper right
        plot(power_rel$date_time,power_rel$Voltage,type="l",xlab="datetime",ylab="Voltage",
             cex.lab="1.0",cex.axis="1.0")

        ### lower left
        plot(power_rel$date_time,power_rel$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",
             cex.lab="1.0",cex.axis="1.0",col="black")
        lines(power_rel$date_time,power_rel$Sub_metering_2,col="red")
        lines(power_rel$date_time,power_rel$Sub_metering_3,col="blue")
        legend("topright",lty="solid",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
               cex=0.85)

        ### lower right
        plot(power_rel$date_time,power_rel$Global_reactive_power,type="l",xlab="datetime",ylab="Global_reactive_power",
             cex.lab="1.0",cex.axis="1.0",yaxt="n")
        axis(side=2,at=seq(0,0.5,by=0.1),cex.axis="0.7")

### close graphics device
dev.off()
