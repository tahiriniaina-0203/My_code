library(tidyverse)
library(openxlsx)

#import data
Ogimet_data <- read_excel("Documents/Ogimet_data.xlsx", na = "NA")

#Manipulation date
Ogimet_data$Date <- as.Date(Ogimet_data$Date, origin = "2013-01-01")
Ogimet_data$Year <- format(Ogimet_data$Date, "%Y")
Ogimet_data$Month <- format(Ogimet_data$Date, "%m")

#Calcul mean
Tmean_monthly <- aggregate(TemperatureCAvg ~ Year + Month, data = Ogimet_data, 
                           FUN = mean, na.rm = NA)
Tmean_monthly

#Plot for mean = anne mitmbatra et 
ggplot(data = Tmean_monthly, mapping = aes(x = as.numeric(Month), y = TemperatureCAvg)) + 
  geom_point(aes(group = Year, color = Year)) +
  geom_line(aes(group = Year, color = Year)) +
  labs(title = "MEAN MONTHLY OF TEMPERATU", subtitle = "Mean temperature of 2014 to 2024",
       x = "Month", y = "T_mean ℃", caption = "RABETAFIKA Randriampanarivo Tahiriniaina Fabrice") +
  scale_x_continuous(breaks = 01:12, labels = month.abb) +
  scale_y_continuous(labels = scales::label_number(suffix = " ℃")) +
  facet_wrap(~Year, scales = "free_x", ncol = 3) +# pour separer le graphe pour chaque annee
  theme_gray()

#Mean a pas mensuelle
Tmean_monthly$Month <- factor(x = Tmean_monthly$Month, 
                              levels = sprintf("%02d", 01:12),
                              labels = month.name, ordered = TRUE )#pour affecter les valeur des mois en Nom des mois

ggplot(data = Tmean_monthly, mapping = aes(x = as.numeric(Year), y = TemperatureCAvg), group = Month) +
 # geom_line() + geom_point() +
  geom_point(aes(group = Month , colour = Month)) +
  geom_line(aes(group = Month, colour = Month)) +
  labs(title = "MEAN TEMPERATURE EVERY MONTH", 
       subtitle = "Mean Monthly for every month in 2014 to 2024",
       x = "Year(2014-2024)", y = "T_mean in ℃") + 
  scale_y_continuous(labels = scales::label_number(suffix = (" ℃"))) +
  facet_wrap(~ Month, scales = "free_x", ncol = 3)  

#For export to xlsx
write.xlsx(x = Tmean_monthly, file = "/home/tahiriniaina/Documents/code_memes")
