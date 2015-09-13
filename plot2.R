#download the file, unzip and free up space
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
destfile <- "hpc.zip"
download.file(url,destfile,method="libcurl")
unzip("hpc.zip")
rm(url,destfile)

#read the file in to a dataframe
hpc <- read.table("household_power_consumption.txt", header=TRUE,sep=";",stringsAsFactor=FALSE)
#convert the Date to one recognize by R
hpc$Date <- as.Date(hpc$Date,format="%d/%m/%Y")
#Subset the dataframe to the needed information
hpc <- subset(hpc,hpc$Date>="2007-02-01" & hpc$Date<="2007-02-02")
#Combine the Data and Time to DT and in a format that is known to R
hpc$DT <- strptime(paste(hpc$Date,hpc$Time),format="%Y-%m-%d %H:%M:%S")

#Plot and copy to png file
plot(hpc$DT,hpc$Global_active_power,type="l",xlab="",ylab="Global Active Power (kilowatts)")
dev.copy(png,file="plot2.png",width=480, height=480)
dev.off()

