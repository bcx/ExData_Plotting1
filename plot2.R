
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

# Create plot 2: A line graph of Global Active Power, from Thursday to Saturday.
png("plot2.png",height=480, width=480);
plot(df$Global_active_power, type="l", xaxt="n", xlab="", ylab = "Global Active Power (kilowatts)")
axis(1, at=c(1, nrow(df)/2, nrow(df)), labels = c("Thr", "Fri", "Sat"))
dev.off()
