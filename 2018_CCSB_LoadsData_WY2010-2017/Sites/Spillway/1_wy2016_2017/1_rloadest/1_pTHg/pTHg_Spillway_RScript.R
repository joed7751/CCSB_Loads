#pTHg Spillway script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pTHg_Spillway<-importRDB("pTHg_SpillwayR.txt")
SpillwayQ<-importRDB("SpillwayQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

pTHg_Spillwaym1 <- loadReg(pTHg ~model(1), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym1
pTHg_Spillwaym2 <- loadReg(pTHg ~model(2), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym2
pTHg_Spillwaym3 <- loadReg(pTHg ~model(3), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym3
pTHg_Spillwaym4 <- loadReg(pTHg ~model(4), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym4
pTHg_Spillwaym5 <- loadReg(pTHg ~model(5), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym5
pTHg_Spillwaym6 <- loadReg(pTHg ~model(6), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym6
pTHg_Spillwaym7 <- loadReg(pTHg ~model(7), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym7
pTHg_Spillwaym8 <- loadReg(pTHg ~model(8), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym8
pTHg_Spillwaym9 <- loadReg(pTHg ~model(9), data = pTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Spillwaym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(pTHg_Spillwaym1,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym2,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym3,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym4,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym5,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym6,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym7,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym8,brief = FALSE, load.only = FALSE)
#print(pTHg_Spillwaym9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (pTHg_Spillwaym1-9)

plot(pTHg_Spillwaym1,ann=FALSE)
title(main = "11452800_pTHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pTHg_Spillwaym1,which = 2,set.up = F)
title(main = "11452800_pTHg Residuals vs Fitted Values")
plot(pTHg_Spillwaym1,which = 3,set.up = F)
title(main = "11452800_pTHg Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pTHg_Spillwaym1,which = 4,set.up = F)
title(main = "11452800_pTHg Correlogram of Samples")
plot(pTHg_Spillwaym1,which = 5,set.up = F)
title(main="11452800_pTHg Normal Discharge")
plot(pTHg_Spillwaym1,which = 6,set.up = F)
title(main="11452800_pTHg Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

pTHg_Spillway_load<-predLoad(pTHg_Spillwaym1,SpillwayQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pTHg_Spillway_load,"1_Spillway_pTHg_m1_Flux_Annual.csv")
pTHg_Spillway_load_day<-predLoad(pTHg_Spillwaym1, SpillwayQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pTHg_Spillway_load_day,"1_Spillway_pTHg_m1_Flux_Daily.csv")

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.