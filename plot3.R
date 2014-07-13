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
 
  
# draw plot 3

png("plot3.png")
  par(bg=NA)
  plot(dt$datetime,dt$Sub_metering_1, type="l", 
       ylab="Energy sub metering", xlab="")
  lines(dt$datetime, as.numeric(dt$Sub_metering_2),  col="red")
  lines(dt$datetime, as.numeric(dt$Sub_metering_3), col="blue")
  legend("topright", col=c("black", "red", "blue"), lty="solid", 
         c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
dev.off ()
