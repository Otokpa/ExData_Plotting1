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

# plot histogram
hist(data$Global_active_power, col='Red', main='Global Active Power', 
     xlab='Global Active Power (kilowatts)', ylab='Frequency')

# save to file
dev.copy(png, file='plot1.png', height=480, width=480)
dev.off()