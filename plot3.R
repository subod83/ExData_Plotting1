#Load data from file
dataproj <- fread("./ExploratoryDataAnalysis/Proj1/household_power_consumption.txt", sep = ";", na.strings = c("?"), nrows = 2075259,header = TRUE, verbose=TRUE)

#Fix ? values to NA
dataproj[dataproj == "?"] <- NA

#Correct Date format
dataproj <- dataproj[,Date := as.Date(Date, format = "%d/%m/%Y")]

# Subset to the data used for analysis
r <-subset(dataproj, subset = dataproj$Date == "2007-02-01" | dataproj$Date == "2007-02-02")

#Create new column with both date and time
r <- r[,DateTime := paste(Date,Time,sep = " ")]

#Correct the type of the numerical values
r <- r[,Global_active_power := as.numeric(Global_active_power)]
r <- r[,Global_reactive_power := as.numeric(Global_reactive_power)]
r <- r[,Voltage := as.numeric(Voltage)]
r <- r[,Sub_metering_1 := as.numeric(Sub_metering_1)]
r <- r[,Sub_metering_2 := as.numeric(Sub_metering_2)]
r <- r[,Sub_metering_3 := as.numeric(Sub_metering_3)]

#Creates the image file for the graph
png(filename="plot3.png", width = 480, height = 480, units = "px", pointsize = 12, bg = "white")


#Set the parameters for plotting the graph
par(mfrow = c(1,1), mar = c(5.1,4.1,4.1,2.1))

# Plot the graph(s)
plot(strptime(r$DateTime,format = "%Y-%m-%d %H:%M:%S"), r$Sub_metering_1, type="n", xlab = " ", ylab = "Energy sub metering")

lines(strptime(r$DateTime,format = "%Y-%m-%d %H:%M:%S"), r$Sub_metering_1, col="black")

lines(strptime(r$DateTime,format = "%Y-%m-%d %H:%M:%S"), r$Sub_metering_2, col="red")

lines(strptime(r$DateTime,format = "%Y-%m-%d %H:%M:%S"), r$Sub_metering_3, col="blue")

legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = c(1,1), cex = 0.75)


dev.off()