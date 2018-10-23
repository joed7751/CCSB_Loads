#SSC Spillway script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

library(akima)
library(dataRetrieval)
library(digest)
library(leaps)
library(lubridate)
library(memoise)
library(rloadest)
library(smwrBase)
library(smwrData)
library(smwrGraphs)
library(smwrQW)
library(smwrStats)
library(boot)
library(KernSmooth)
library(lattice)

SSC_Spillway<-importRDB("SSC_SpillwayR.txt")
SpillwayQ<-importRDB("SpillwayQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

SSC_Spillwaym1 <- loadReg(SSC ~model(1), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym1
SSC_Spillwaym2 <- loadReg(SSC ~model(2), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym2
SSC_Spillwaym3 <- loadReg(SSC ~model(3), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym3
SSC_Spillwaym4 <- loadReg(SSC ~model(4), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym4
SSC_Spillwaym5 <- loadReg(SSC ~model(5), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym5
SSC_Spillwaym6 <- loadReg(SSC ~model(6), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym6
SSC_Spillwaym7 <- loadReg(SSC ~model(7), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym7
SSC_Spillwaym8 <- loadReg(SSC ~model(8), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym8
SSC_Spillwaym9 <- loadReg(SSC ~model(9), data = SSC_Spillway, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Spillwaym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(SSC_Spillwaym1,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym2,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym3,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym4,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym5,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym6,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym7,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym8,brief = FALSE, load.only = FALSE)
#print(SSC_Spillwaym9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (SSC_Spillwaym1-9)

plot(SSC_Spillwaym7,ann=FALSE)
title(main = "11452800_SSC Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SSC_Spillwaym7,which = 2,set.up = F)
title(main = "11452800_SSC Residuals vs Fitted Values")
plot(SSC_Spillwaym7,which = 3,set.up = F)
title(main = "11452800_SSC Assessing Heteroscedasticity") #Add "of Residuals"?
plot(SSC_Spillwaym7,which = 4,set.up = F)
title(main = "11452800_SSC Correlogram of Samples")
plot(SSC_Spillwaym7,which = 5,set.up = F)
title(main="11452800_SSC Normal Discharge")
plot(SSC_Spillwaym7,which = 6,set.up = F)
title(main="11452800_SSC Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

SSC_Spillway_load<-predLoad(SSC_Spillwaym7,SpillwayQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SSC_Spillway_load,file.choose())
SSC_Spillway_load_day<-predLoad(SSC_Spillwaym7, SpillwayQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SSC_Spillway_load_day,file.choose())

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.