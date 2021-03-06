# download and unzip data
fileURL <- 'https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip'
download.file(fileURL, 'household_power_consumption.txt' , method = "curl")
unzip('exdata-data-household_power_consumption.zip')

# load data
dataFile <- 'household_power_consumption.txt'
data <- read.table(dataFile, header = T, sep = ';', stringsAsFactors = F, na.strings = '?')

# subset data and handle date, time class
data$Date <- as.Date(data$Date, format = '%d/%m/%Y')
data <- subset(data, subset = Date >= '2007-02-01' & Date <= '2007-02-02')
data$dateTime <- as.POSIXct(paste(data$Date, data$Time))

# plot 3
par(mfrow= c(1,1))
with(data, {
  plot(Sub_metering_1 ~ dateTime, type='l', ylab='Global Active Power (kilowatts)', xlab='')
  lines(Sub_metering_2 ~ dateTime,col='Red')
  lines(Sub_metering_3 ~ dateTime,col='Blue')
})
legend("topright", col=c('black', 'red', 'blue'), lty=1, lwd=2, 
       legend=c('Sub_metering_1', 'Sub_metering_2', 'Sub_metering_3'))

# save to file
dev.copy(png, file='plot3.png', height=480, width=480)
dev.off()
