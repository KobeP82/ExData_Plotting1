
## R script to construct Plot 1 of the 1st assignment for the Coursera Exploratory Data Analysis course

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

### construct histogram
hist(power_rel$Global_active_power,freq=TRUE,main="Global Active Power",xlab="Global Active Power (kilowatts)",
     ylab="Frequency",col="red",cex.lab="0.75",cex.axis="0.75",cex.main="0.85")

### save to png
dev.copy(device=png,filename="plot1.png",width=480,height=480,units="px",bg="white")
