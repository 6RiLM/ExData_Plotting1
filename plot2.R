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
library(dplyr)
library(lubridate)

#
# Load and set the data into a tidy dataset
#
# Load the file and set ? as NA
data <- tbl_df(read.csv("./data/household_power_consumption.txt", sep = ";", na.strings = "?")) %>%
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
# Change locale settints to write time series in english
Sys.setlocale(category = "LC_ALL", locale = "en_GB.UTF-8")
# Initialize out file with its extension & dimensions
png("plot2.png", width = 480, height = 480)
# Intialize the plot on graphic device
with(data, plot(datetime, Global_active_power, type = "l", xlab = "",
                ylab = "Global Active Power (kilowatts)"))
# Back to french
Sys.setlocale(category = "LC_ALL", locale = "fr_FR.UTF-8")
# Close the graphic device in order to save the file created
dev.off()
