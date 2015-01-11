## R script to construct Plot 2 of the 1st assignment for the Coursera Exploratory Data Analysis course

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

### construct time series
plot(power_rel$date_time,power_rel$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)",
     cex.lab="0.75",cex.axis="0.75")

### save to png
dev.copy(device=png,filename="plot2.png",width=480,height=480,units="px",bg="white")