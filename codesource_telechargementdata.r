library(climate)

date <- seq(as.Date("2014/01/01"),as.Date("2024/12/31"), "day") #pachage des donnes

dir.out <- "/home/tahiriniaina/Documents/data_ogimet" #Repertoir de sortie de donne

station_name <- "Ivato" #Nom de la station 

r <- NULL

for (k in 1:length(date)) {
  
  df <- meteo_ogimet(interval = "daily", date = c(date[k]),station = "67083")
  
  r = rbind.data.frame(r,df)
  
  print(date[k])
  
  write.table(r, paste(dir.out,station_name,"csv",sep = ""),row.names = FALSE,na="",sep = ";")
  
}

