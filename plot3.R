prepareFile <- function(filename){
  require(sqldf) #  install.packages("sqldf") if missing
  df <- read.csv.sql(file = filename,header = TRUE, sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'",sep=";")
  df[,10] <- paste(df$Date,df$Time,sep=' ')
  dates <- strptime(df[,10],"%d/%m/%Y %H:%M:%S")
  df$fulldate = dates
  df
}

generatePlot3<- function(df){
plot(x=df$fulldate,y=df$Sub_metering_1, type="n",ylab = "Energy sub metering", xlab = '')
lines(df$fulldate,df$Sub_metering_1,col="Black")
lines(df$fulldate,df$Sub_metering_2,col="Red")
lines(df$fulldate,df$Sub_metering_3,col="Blue")
legend("topright",legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("Black","Red","Blue"), lty=c(1,1))
}

df <- prepareFile("household_power_consumption.txt")
png("plot3.png")
generatePlot3(df)
dev.off()