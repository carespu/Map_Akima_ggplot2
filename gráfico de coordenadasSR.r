rm(list=ls())
Sys.setenv(TZ='GMT')
Sys.setlocale("LC_TIME", "English")
par(mfrow=c(1,1))
library(ggplot2)
library(akima)

setwd('')#set working directory

par(mfrow=c(1,2))

#Build coordinates graph

plantas<-read.table('datos generales.todos.txt',header=T)#import dataframe, we have several repetitions in our data frame for each individual
plot(Latitude~Longitude, col=especie, data=plantas) # show plants distribution

a<-aggregate( . ~Plot, plantas, mean )# build df with mean values for each individual from our dataset

gpsli <- interp(a$Longitude, a$Latitude, a$temp, duplicate = "median")#use interp function from akima to create interpolation for soil temperature

image (gpsli, main = "Soil Temperature", ylab = 'Longitude', xlab = 'Latitude')#draw 
contour(gpsli, add=TRUE) 

## increase smoothness (using finer grid):
gpssmooth <-  with(a, interp(Longitude, Latitude, SR, xo=seq(min(Longitude),max(Longitude), length=100), yo=seq(min(Latitude),max(Latitude), length=100), duplicate = "median"))
image (gpssmooth, main = "Soil Respiration")
contour(gpssmooth, add=T)



