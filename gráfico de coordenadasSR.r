
rm(list=ls())
Sys.setenv(TZ='GMT')
Sys.setlocale("LC_TIME", "English")
par(mfrow=c(1,1))
library(ggplot2)
library(akima)

setwd('c:\..\YOURpath\') #set your working directory 


#Build coordinates graph:

plants<-read.table('yourdata.txt',header=T)# import dataframe, we have several in my case I imported a df with plant distribution in a field with 
# temperature and soil respiration variables, and several dais of mesurements for all the individuals, I have repetitions in my data frame for each individual

plot(Latitude~Longitude, col=specie, data=plants) # show plants distribution in a plot to know yor data, in my case I had diferent species

a<-aggregate( . ~Plot, plants, mean )# I want to sea the mean values, so I build df with mean values for each individual from our dataset

gpsli <- interp(a$Longitude, a$Latitude, a$temp, duplicate = "median")#use interp function from akima to create interpolation for soil temperature

image (gpsli, main = "Soil Temperature", ylab = 'Longitude', xlab = 'Latitude')#draw the raster
contour(gpsli, add=TRUE) #draw the contourn

## we can increase increase smoothness (using finer grid), in this example I use soil respiration :
gpssmooth <-  with(a, interp(Longitude, Latitude, SR, xo=seq(min(Longitude),max(Longitude), length=100), yo=seq(min(Latitude),max(Latitude), length=100), duplicate = "median"))
image (gpssmooth, main = "Soil Respiration")
contour(gpssmooth, add=T)



