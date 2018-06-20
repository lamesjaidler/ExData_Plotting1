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

# Create plot
plot(df$Global_active_power ~ df$DateTime, xlab = "", ylab="Global Active Power (kilowatts)", type="l")

# Print plot to PNG
dev.copy(png, file="plot2.png", width=480, height=480)
dev.off()
