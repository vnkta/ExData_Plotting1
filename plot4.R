# download and unzip data
  fileUrl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
  dest <- "data.zip"
  if (!file.exists(dest)) {download.file(fileUrl, dest,method="auto")}
  if (!file.exists("household_power_consumption.txt")) {unzip(dest)}

# Load required package
  if("lubridate" %in% rownames(installed.packages()) == FALSE) {install.packages("lubridate")}
  require(lubridate)    


# read the required data
  dt <- read.table(pipe('grep "^[1-2]/2/2007" "household_power_consumption.txt"'),header=F, sep=';')
  x <-read.table("household_power_consumption.txt",nrows=1,sep=";",header=T)
  names(dt) <- names(x)

# Create a datetime variable
  dt$datetime <- ymd_hms(paste(as.Date(dt$Date, format="%d/%m/%Y"), dt$Time))
 
  
# draw plot 4

png("plot4.png")
  par(bg=NA)
  par(mfrow=c(2,2), mar=c(4,4,2,1), oma=c(0,0,2,0))
  plot(dt$datetime,dt$Global_active_power, type="l", ylab="Global Active Power", xlab="")
  plot(dt$datetime,dt$Voltage, type="l", ylab="Voltage", xlab="datetime")
  
  plot(dt$datetime, as.numeric(dt$Sub_metering_1), type="l",
       ylab="Energy sub metering", xlab="")
  lines(dt$datetime, as.numeric(dt$Sub_metering_2), type="l", col="red")
  lines(dt$datetime, as.numeric(dt$Sub_metering_3), type="l", col="blue")
  legend("topright", col=c("black", "red", "blue"), bty="n",lty="solid",
         legend=names(dt)[7:9])
  
  plot(dt$datetime, as.numeric(dt$Global_reactive_power), type="l",
       ylab="Global_reactive_power", xlab="datetime")
  
dev.off()