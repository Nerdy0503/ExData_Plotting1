

library(chron)
# downloading and unzipping the dataset only once

      fileName <- "power_consumption.zip"
      
      if(!file.exists(fileName)){
        
        fileURL <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
        download.file(fileURL, fileName, method = "curl")
        
      }
      
      if(!file.exists("household_power_consumption.txt")){
        
        unzip(fileName)
        
      }

# reading data for 2007-02-01 and 2007-02-02   (lines from 66 638 to 69 517)    

      con <- file("household_power_consumption.txt", "r")
      data <- read.csv(con, skip = 66637,  nrows = 2880, sep = ";", header = FALSE, na.strings = "?")
      close(con)
      
      colnames(data) <- c("Date", "Time", "Global_active_power", "Global_reactive_power", "Voltage", "Global_intensity", "Sub_metering_1", "Sub_metering_2", "Sub_metering_3")
      data$Date <- as.Date(data$Date, "%d/%m/%Y")
      data$Time <- times(data$Time)


# plotting

      png(filename = "plot4.png", width = 480, height = 480)
      
      par(mfcol = c(2,2))
      
      with(data, plot(Global_active_power, type = "l", xlab = "", ylab = "Global Active Power", xaxt = "n"))
      xticks <- seq(0, length(data$Time), by = floor(length(data$Time)/2))
      xticksLab <- c("Thu", "Fri", "Sat")
      axis(side = 1, at = xticks, labels = xticksLab)
      
      with(data, plot(Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering", xaxt = "n"))
      xticks <- seq(0, length(data$Time), by = floor(length(data$Time)/2))
      xticksLab <- c("Thu", "Fri", "Sat")
      axis(side = 1, at = xticks, labels = xticksLab)
      with(data, lines(Sub_metering_2, col = "red"))
      with(data, lines(Sub_metering_3, col = "blue"))
      legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), col = c("black", "red", "blue"), lty = c(1,1,1))
      
      with(data, plot(Voltage, type = "l", xlab = "datetime", ylab = "Voltage", xaxt = "n"))
      xticks <- seq(0, length(data$Time), by = floor(length(data$Time)/2))
      xticksLab <- c("Thu", "Fri", "Sat")
      axis(side = 1, at = xticks, labels = xticksLab)
      
      with(data, plot(Global_reactive_power, type = "l", xlab = "datetime", xaxt = "n"))
      xticks <- seq(0, length(data$Time), by = floor(length(data$Time)/2))
      xticksLab <- c("Thu", "Fri", "Sat")
      axis(side = 1, at = xticks, labels = xticksLab)
      
      dev.off()
