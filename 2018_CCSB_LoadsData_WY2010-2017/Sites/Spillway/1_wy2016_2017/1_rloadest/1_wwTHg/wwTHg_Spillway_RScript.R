#wwTHg Spillway script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

wwTHg_Spillway<-importRDB("wwTHg_SpillwayR.txt")
SpillwayQ<-importRDB("SpillwayQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

wwTHg_Spillwaym1 <- loadReg(wwTHg ~model(1), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym1
wwTHg_Spillwaym2 <- loadReg(wwTHg ~model(2), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym2
wwTHg_Spillwaym3 <- loadReg(wwTHg ~model(3), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym3
wwTHg_Spillwaym4 <- loadReg(wwTHg ~model(4), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym4
wwTHg_Spillwaym5 <- loadReg(wwTHg ~model(5), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym5
wwTHg_Spillwaym6 <- loadReg(wwTHg ~model(6), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym6
wwTHg_Spillwaym7 <- loadReg(wwTHg ~model(7), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym7
wwTHg_Spillwaym8 <- loadReg(wwTHg ~model(8), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym8
wwTHg_Spillwaym9 <- loadReg(wwTHg ~model(9), data = wwTHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Spillwaym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(wwTHg_Spillwaym1,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym2,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym3,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym4,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym5,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym6,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym7,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym8,brief = FALSE, load.only = FALSE)
#print(wwTHg_Spillwaym9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (wwTHg_Spillwaym1-9)

plot(wwTHg_Spillwaym5,ann=FALSE)
title(main = "11452800_wwTHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(wwTHg_Spillwaym5,which = 2,set.up = F)
title(main = "11452800_wwTHg Residuals vs Fitted Values")
plot(wwTHg_Spillwaym5,which = 3,set.up = F)
title(main = "11452800_wwTHg Assessing Heteroscedasticity") #Add "of Residuals"?
plot(wwTHg_Spillwaym5,which = 4,set.up = F)
title(main = "11452800_wwTHg Correlogram of Samples")
plot(wwTHg_Spillwaym5,which = 5,set.up = F)
title(main="11452800_wwTHg Normal Discharge")
plot(wwTHg_Spillwaym5,which = 6,set.up = F)
title(main="11452800_wwTHg Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

wwTHg_Spillway_load<-predLoad(wwTHg_Spillwaym5,SpillwayQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(wwTHg_Spillway_load,"1_Spillway_wwTHg_m5_Flux_Annual.csv")
wwTHg_Spillway_load_day<-predLoad(wwTHg_Spillwaym5, SpillwayQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(wwTHg_Spillway_load_day,"1_Spillway_wwTHg_m5_Flux_Daily.csv")

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.