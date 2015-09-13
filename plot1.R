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

#Convert Global_active_power to numeric
hpc$Global_active_power <- as.numeric(hpc$Global_active_power)
#Draw the histogram and copy to png file
hist(hpc$Global_active_power,col="red",xlab="Global Active Power (kilowatts)", ylab="Frequency",main="Global Active Power")
dev.copy(png,file="plot1.png",width=480, height=480)
dev.off()