#download the file, unzip and free up space
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "hpc.zip"
download.file(url,destfile,method="libcurl")
unzip("hpc.zip")
rm(url,destfile)

#read the file in to a dataframe
hpc <- read.table("household_power_consumption.txt", header=TRUE,sep=";",stringsAsFactor=FALSE)
#convert the date to one recognize by R
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")
#Subset the dataframe to the needed information
hpc <- subset(hpc,hpc$Date>="2007-02-01" & hpc$Date<="2007-02-02")
#Convert the variable Sub_metering to numeric
hpc$Sub_metering_1 <- as.numeric(hpc$Sub_metering_1)
hpc$Sub_metering_2 <- as.numeric(hpc$Sub_metering_2)
hpc$Sub_metering_3 <- as.numeric(hpc$Sub_metering_3)
#Combine the Data and Time to DT and in a format that is known to R
hpc$DT <- strptime(paste(hpc$Date,hpc$Time),format="%Y-%m-%d %H:%M:%S")

#Open a png graphic device and start drawing
png(filename="plot3.png",width=480,height=480)
plot(hpc$DT,hpc$Sub_metering_1,type="n",xlab="",ylab="Energy sub metering")
lines(hpc$DT,hpc$Sub_metering_1,type="l",col="black")
lines(hpc$DT,hpc$Sub_metering_2,type="l",col="red")
lines(hpc$DT,hpc$Sub_metering_3,type="l",col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),lty=c(1,1,1),col=c("black","red","blue"))
dev.off()
