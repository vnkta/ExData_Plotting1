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
  
# draw plot 2

png("plot2.png")
  par(bg=NA)
  plot(dt$Global_active_power ~  dt$datetime, type="l", 
       ylab="Global Active Power (kilowatts)",
       xlab="")
dev.off ()
