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

# Convert Global_active_power column to numeric
df$Global_active_power <- as.numeric(as.character(df$Global_active_power))

# Convert Sub_metering columns to numeric
df$Sub_metering_1 <- as.numeric(as.character(df$Sub_metering_1))
df$Sub_metering_2 <- as.numeric(as.character(df$Sub_metering_2))
df$Sub_metering_3 <- as.numeric(as.character(df$Sub_metering_3))

# Convert Voltage column to numeric
df$Voltage <- as.numeric(as.character(df$Voltage))

# Convert Global_reactive_power column to numeric
df$Global_reactive_power <- as.numeric(as.character(df$Global_reactive_power))

# Set global plotting parameters (for grid)
par(mfrow=c(2,2))

# Create 1st plot
plot(df$Global_active_power ~ df$DateTime, xlab = "", ylab="Global Active Power", type="l")

# Create 2nd plot
plot(df$Voltage ~ df$DateTime, xlab = "datetime", ylab="Voltage", type="l")

# Create 3rd plot
plot(df$Sub_metering_1 ~ df$DateTime, xlab = "", ylab="Energy sub metering", type="l")
lines(df$Sub_metering_2 ~ df$DateTime, col="red")
lines(df$Sub_metering_3 ~ df$DateTime, col="blue")
legend("topright", lty=1, col=c("black","red","blue"), 
       cex = 0.75, bty = "n", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# Create 4th plot
plot(df$Global_reactive_power ~ df$DateTime, xlab = "datetime", ylab="Global_reactive_power", type="l")

# Print plot to PNG
dev.copy(png, file="plot4.png", width=480, height=480)
dev.off()
