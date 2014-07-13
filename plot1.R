# setwd("c:/coursera/ExData_Plotting1/")

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
  
  
# draw plot 1
  
  png("plot1.png")
  par(bg=NA) 
  hist(dt$Global_active_power, col="red", 
       main="Global Active Power", 
       xlab="Global Active Power (kilowatts)")
  dev.off()
  