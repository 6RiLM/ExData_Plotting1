################################################################################
#
# This script is relating to course Exploratory Data Analysis from Coursera.com
#
# This aims to plot data representation in several files
#
#
# Author : 6RiLM
# Date   : 2016-11-26
#
################################################################################

#
# Load libraries
#
library(data.table)
library(dplyr)
library(lubridate)

#
# Load and set the data into a tidy dataset
#
# Load the file and set ? as NA
#data <- tbl_df(read.csv("./data/household_power_consumption.txt", sep = ";", na.strings = "?")) %>%
data <- tbl_df(fread("./data/household_power_consumption.txt", na.strings = "?")) %>%
    # Create timestamp from Date & Time into lubridate format
    mutate(datetime = dmy_hms(paste(Date, Time))) %>%
    # Keep data coming from 2007, 01 & 02 february
    filter(datetime >= as.Date("2007-02-01") & datetime < as.Date("2007-02-03")) %>%
    # Reorder features for convinience
    select(datetime, Global_active_power:Sub_metering_3) %>%
    # Order record by datetime
    arrange(datetime)

#
# Plot histogramm of features Global_active_power in a PNG file
#
# Open window on screen 
x11()
# Change locale settints to write time series in english
Sys.setlocale(category = "LC_ALL", locale = "en_GB.UTF-8")
# Set param to get a window with 4 graphs
par(mfcol = c(2, 2))

######### GRAPH 1
# Intialize the plot on graphic device
with(data, plot(datetime, Global_active_power, type = "l", xlab = "",
                ylab = "Global Active Power"))

######### GRAPH 2
# Intialize the plot on graphic device
with(data, plot(datetime, Sub_metering_1, type = "l", xlab = "",
                ylab = "Energy sub metering"))
# Add other curves on the same window
with(data, lines(datetime, Sub_metering_2, col = "red"))
with(data, lines(datetime, Sub_metering_3, col = "blue"))
# Add legend on the graph
legend("topright", lty = 1, col = c("black", "red", "blue"), 
       legend = names(data)[6:8], bty = "n")

######### GRAPH 3
# Intialize the plot on graphic device
with(data, plot(datetime, Voltage, type = "l"))

######### GRAPH 4
# Intialize the plot on graphic device
with(data, plot(datetime, Global_reactive_power, type = "l"))
     

# Back to french
Sys.setlocale(category = "LC_ALL", locale = "fr_FR.UTF-8")
# Copy the graph to a PNG file
dev.copy(png, filename = "plot4.png", width = 480, height = 480)
# Close the graphic device in order to save the file created
dev.off()
