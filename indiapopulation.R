
setwd("D:/Harish/R practice projects")
getwd()

# load packages
library(ggplot2)
library(ggmap)
library(ggalt)


mydata = read.csv("city pol.csv")

str(mydata)

mydata$city <- as.character(mydata$city)
mydata$population = as.numeric(mydata$pops)

mydata
str(mydata)
for (i in 1:nrow(mydata)) {
#for (i in 1:10) {
  lat_lon = geocode(mydata[i,1])
  mydata$lon[i] = as.numeric(lat_lon[1])
  mydata$lat[i] = as.numeric(lat_lon[2])
  
}
head(mydata, 10)


India_pops_data = data.frame(mydata$population, mydata$lon, mydata$lat, mydata$city)

colnames(India_pops_data) = c('popultion','lon','lat', 'city')

head(India_pops_data, 10)


googleIndia = as.numeric(geocode("india"))
IndiaMap = ggmap(get_googlemap(center=googleIndia, scale=2, zoom=5), extent="normal")



IndiaMap +   
  geom_point(aes(x=lon, y=lat, col = city), data=India_pops_data, 
             alpha=0.4, size = India_pops_data$popultion*0.000002) + 
  scale_size_continuous(range=range(India_pops_data$popultion)) +
  scale_colour_manual(values = India_pops_data$city) 