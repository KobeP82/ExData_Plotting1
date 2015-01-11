## R script to construct Plot 3 of the 1st assignment for the Coursera Exploratory Data Analysis course

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

### open graphics device
png(filename="plot3.png",width=480,height=480,units="px",bg="white")

### construct time series
plot(power_rel$date_time,power_rel$Sub_metering_1,type="l",xlab="",ylab="Energy sub metering",
     cex.lab="1.0",cex.axis="1.0",col="black")
lines(power_rel$date_time,power_rel$Sub_metering_2,col="red")
lines(power_rel$date_time,power_rel$Sub_metering_3,col="blue")
legend("topright",lty="solid",col=c("black","red","blue"),legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       cex=1.0)

### close graphics device
dev.off()