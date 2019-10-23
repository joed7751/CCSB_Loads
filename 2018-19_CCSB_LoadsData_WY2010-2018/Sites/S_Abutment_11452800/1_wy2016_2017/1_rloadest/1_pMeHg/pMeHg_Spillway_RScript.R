#pMeHg Spillway script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pMeHg_Spillway<-importRDB("pMeHg_SpillwayR.txt")
SpillwayQ<-importRDB("SpillwayQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

#***************************************************Do the following if you have censored data:*****************************************************
#(1)Create vector of detection limit
#(2)Create lcens object- as.lcens(values, detlim, censor.codes)
#(3)Create input data frame with censored data object replacing last 2 columns

det<-as.numeric(array(.1,dim(pMeHg_Spillway)[1]))
cen_data<-as.lcens(pMeHg_Spillway$PpMeHg,det,pMeHg_Spillway$RpMeHg)
cen_frame<-data.frame(pMeHg_Spillway[,1:3],cen_data)

#(4)Use this code to run models for censored data:

pMeHg_Spillwaym1 <- loadReg(cen_data ~model(1), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym1
pMeHg_Spillwaym2 <- loadReg(cen_data ~model(2), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym2
pMeHg_Spillwaym3 <- loadReg(cen_data ~model(3), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym3
pMeHg_Spillwaym4 <- loadReg(cen_data ~model(4), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym4
pMeHg_Spillwaym5 <- loadReg(cen_data ~model(5), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym5
pMeHg_Spillwaym6 <- loadReg(cen_data ~model(6), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym6
pMeHg_Spillwaym7 <- loadReg(cen_data ~model(7), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym7
pMeHg_Spillwaym8 <- loadReg(cen_data ~model(8), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym8
pMeHg_Spillwaym9 <- loadReg(cen_data ~model(9), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
pMeHg_Spillwaym9

#****************************Use this code to run models for uncensored data, comment out the censored data code(above):******************************

#pMeHg_Spillwaym1 <- loadReg(pMeHg ~model(1), data = test_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym1
#pMeHg_Spillwaym2 <- loadReg(pMeHg ~model(2), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym2
#pMeHg_Spillwaym3 <- loadReg(pMeHg ~model(3), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym3
#pMeHg_Spillwaym4 <- loadReg(pMeHg ~model(4), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym4
#pMeHg_Spillwaym5 <- loadReg(pMeHg ~model(5), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym5
#pMeHg_Spillwaym6 <- loadReg(pMeHg ~model(6), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym6
#pMeHg_Spillwaym7 <- loadReg(pMeHg ~model(7), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym7
#pMeHg_Spillwaym8 <- loadReg(pMeHg ~model(8), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym8
#pMeHg_Spillwaym9 <- loadReg(pMeHg ~model(9), data = pMeHg_Spillway, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Spillway")
#pMeHg_Spillwaym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(pMeHg_Spillwaym1,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym2,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym3,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym4,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym5,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym6,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym7,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym8,brief = FALSE, load.only = FALSE)
#print(pMeHg_Spillwaym9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (pMeHg_Spillwaym1-9)

plot(pMeHg_Spillwaym3,ann=FALSE)
title(main = "Spillway_pMeHg_m3 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pMeHg_Spillwaym3,which = 2,set.up = F)
title(main = "Spillway_pMeHg_m3 Residuals vs Fitted Values")
plot(pMeHg_Spillwaym3,which = 3,set.up = F)
title(main = "Spillway_pMeHg_m3 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pMeHg_Spillwaym3,which = 4,set.up = F)
title(main = "Spillway_pMeHg_m3 Correlogram of Samples")
plot(pMeHg_Spillwaym3,which = 5,set.up = F)
title(main="Spillway_pMeHg_m3 Normal Discharge")
plot(pMeHg_Spillwaym3,which = 6,set.up = F)
title(main="Spillway_pMeHg_m3 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

pMeHg_Spillway_load<-predLoad(pMeHg_Spillwaym3,SpillwayQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pMeHg_Spillway_load,"1_Spillway_pMeHg_m3_Flux_Annual.csv")
pMeHg_Spillway_load_day<-predLoad(pMeHg_Spillwaym3, SpillwayQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pMeHg_Spillway_load_day,"1_Spillway_pMeHg_m3_Flux_Daily.csv")

#Lines 109 and 111 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 110 and 112 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.