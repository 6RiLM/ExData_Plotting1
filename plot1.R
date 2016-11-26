################################################################################
#
# This script is relating to course Exploratory Data Analysis from Coursera.com
#
# This aims to plot data representation in several files
#
#
# Author : 6RiLM
# Date   : 2016-11-24
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
# Intialize the plot on graphic device
hist(data$Global_active_power, main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", col = "red")
# Copy the graph to a PNG file
dev.copy(png, filename = "plot1.png", width = 480, height = 480)
# Close the graphic device in order to save the file created
dev.off()
