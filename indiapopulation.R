# set working directory
setwd("D:\Harish\R practice projects\GitHub projects")
getwd()

# load packages
library(ggplot2)
library(ggmap)
library(ggalt)

# ready the csv file
mydata = read.csv("city pol.csv")
# see the structure
str(mydata)
# convert city to character and population to numeric
mydata$city <- as.character(mydata$city)
mydata$population = as.numeric(mydata$pops)

# have a look the data
mydata
str(mydata)
# browse through the csv file and get lontitudes and latitudes of cities
for (i in 1:nrow(mydata)) {
  lat_lon = geocode(mydata[i,1])
  mydata$lon[i] = as.numeric(lat_lon[1])
  mydata$lat[i] = as.numeric(lat_lon[2])
  
}
# look at the data and analyze
head(mydata, 10)

# make dataframe with nececcesary data
India_pops_data = data.frame(mydata$population, mydata$lon, mydata$lat, mydata$city)
# make headings
colnames(India_pops_data) = c('popultion','lon','lat', 'city')
# look at the data and analyze
head(India_pops_data, 10)

# Get map for India 
googleIndia = as.numeric(geocode("india"))
IndiaMap = ggmap(get_googlemap(center=googleIndia, scale=2, zoom=5), extent="normal")

# use GGplot for plotting

IndiaMap +   
  geom_point(aes(x=lon, y=lat, col = city), data=India_pops_data, 
             alpha=0.4, size = India_pops_data$popultion*0.000002) + 
  scale_size_continuous(range=range(India_pops_data$popultion)) +
  scale_colour_manual(values = India_pops_data$city) +
  labs(title = "Top 10 Indian cities with maximum population as in 2018 ")
