prepareFile <- function(filename){
  require(sqldf) #  install.packages("sqldf") if missing
  df <- read.csv.sql(file = filename,header = TRUE, sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'",sep=";")
  df[,10] <- paste(df$Date,df$Time,sep=' ')
  dates <- strptime(df[,10],"%d/%m/%Y %H:%M:%S")
  df$fulldate = dates
  df
}

generatePlot2<- function(df){
  plot(df$fulldate,df$Global_active_power,type="n",ylab = "Global active power (kilowatts)", xlab = '')
  lines(df$fulldate,df$Global_active_power)
}

df <- prepareFile("household_power_consumption.txt")
png("plot2.png")
generatePlot2(df)
dev.off()