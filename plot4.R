
library(dplyr)

# Fetch and unzip our data.
src <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
dest <- "household_power_consumption.zip"
download.file(src, destfile=dest, method="curl")
unzip(dest)

# Load our data from the CSV file.
hpc <- read.csv('household_power_consumption.txt', sep=";", stringsAsFactors=FALSE)

# Grab the names of the numeric columns.
nc <- names(hpc)[3:length(hpc)]

# Convert the numeric columns to numbers.
# '?' values will be coerced into NAs.  This is fine.
suppressWarnings(hpc[nc] <- sapply(hpc[nc], as.numeric))

# Pull out the records for the two dates of interest.
# This is the dataframe for our plots.
df <- filter(hpc, Date == '1/2/2007' | Date == '2/2/2007')

# Reset all graphics params to their defaults.
par()

# Create plot 4: A grid of 4 plots, all by day from Thursday to Saturday.
png("plot4.png",height=480, width=480)

# Set things up for a row-major, 2x2 grid.
par(mfrow=c(2,2))

# Upper left plot: Global Active Power
plot(df$Global_active_power, type="l", xaxt="n", xlab="", ylab = "Global Active Power")
axis(1, at=c(1, nrow(df)/2, nrow(df)), labels = c("Thr", "Fri", "Sat"))

# Upper right plot: Voltage
plot(df$Voltage, type="l", ylab="Voltage", xlab="datetime", xaxt="n")
axis(1, at=c(1, nrow(df)/2, nrow(df)), labels = c("Thr", "Fri", "Sat"))

# Lower left plot: Energy sub metering, with small legend.
plot(df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", xaxt="n")
points(df$Sub_metering_2, type="l", col="red")
points(df$Sub_metering_3, type="l", col="blue")
axis(1, at=c(1, nrow(df)/2, nrow(df)), labels = c("Thr", "Fri", "Sat"))
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col=c("black", "red", "blue"), seg.len=2, lty=1, cex=.8, bty="n")

# Lower right plot: Global_reactive_power.
plot(df$Global_reactive_power, type="l", xaxt="n", xlab="datetime", ylab = "Global_reactive_power")
axis(1, at=c(1, nrow(df)/2, nrow(df)), labels = c("Thr", "Fri", "Sat"))

dev.off()