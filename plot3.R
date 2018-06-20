# Download data 
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              "baseData.zip")

# Unzip zip folder containing data
unzip("baseData.zip")

# Read in data
df <- read.table("household_power_consumption.txt", sep = ";", header=T)

# Create DateTime column which concatenates Date and Time columns
df$DateTime <- as.POSIXct(strptime(paste(df$Date, df$Time), format="%d/%m/%Y %H:%M:%S"))

# Filter dataset between 2007-02-01 and 2007-02-02
df <- df[df$DateTime >= "2007-02-01" & df$DateTime < "2007-02-03", ]

# Convert Sub_metering columns to numeric
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Create plot
plot(df$Sub_metering_1 ~ df$DateTime, xlab = "", ylab="Energy sub metering", type="l")
lines(df$Sub_metering_2 ~ df$DateTime, col="red")
lines(df$Sub_metering_3 ~ df$DateTime, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Print plot to PNG
dev.copy(png, file="plot3.png", width=480, height=480)
dev.off()
