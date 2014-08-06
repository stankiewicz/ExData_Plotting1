prepareFile <- function(filename){
  require(sqldf)  # install.packages("sqldf") if missing
  df <- read.csv.sql(file = filename,header = TRUE, sql = "select * from file where Date='1/2/2007' or Date='2/2/2007'",sep=";")
  df[,1] <- as.Date(df[,1],"%d/%m/%Y")
  df
}

generatePlot1 <-function(df){
  hist(df$Global_active_power,col = 'Red', xlab = "Global active power (kilowatts)", main = "Global Active Power")
}

df <- prepareFile("household_power_consumption.txt")
png("plot1.png")
generatePlot1(df)
dev.off()