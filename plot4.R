prepareFile <- function(filename){
  require(sqldf) #  install.packages("sqldf") if missing
  df <- read.csv.sql(file = filename,header = TRUE, sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'",sep=";")
  df[,10] <- paste(df$Date,df$Time,sep=' ')
  dates <- strptime(df[,10],"%d/%m/%Y %H:%M:%S")
  df$fulldate = dates
  df
}

generatePlot4<- function(df){
  par(mfrow=c(2,2))
  plot(df$fulldate,df$Global_active_power,type="n",ylab = "Global active power (kilowatts)", xlab = '')
  lines(df$fulldate,df$Global_active_power)
  plot(df$fulldate,df$Voltage,type="n",ylab = "Voltage", xlab = 'datetime')
  lines(df$fulldate,df$Voltage)
  plot(x=df$fulldate,y=df$Sub_metering_1, type="n",ylab = "Energy sub metering", xlab = '')
  lines(df$fulldate,df$Sub_metering_1,col="Black")
  lines(df$fulldate,df$Sub_metering_2,col="Red")
  lines(df$fulldate,df$Sub_metering_3,col="Blue")
  legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("Black","Red","Blue"), lty=c(1,1))
  plot(df$fulldate,df$Global_reactive_power,type="n", xlab = 'datetime')
  lines(df$fulldate,df$Global_reactive_power)
}
df <- prepareFile("household_power_consumption.txt")
png("plot4.png")
generatePlot4(df)
dev.off()
