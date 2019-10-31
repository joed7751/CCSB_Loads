#pTHg N_Abutment script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pTHg_NAbutment<-importRDB("pTHg_NWeirR.txt")
N_AbutmentQ<-importRDB("SpillwayQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

pTHg_NAbutmentm1 <- loadReg(pTHg ~model(1), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm1
pTHg_NAbutmentm2 <- loadReg(pTHg ~model(2), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm2
pTHg_NAbutmentm3 <- loadReg(pTHg ~model(3), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm3
pTHg_NAbutmentm4 <- loadReg(pTHg ~model(4), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm4
pTHg_NAbutmentm5 <- loadReg(pTHg ~model(5), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm5
pTHg_NAbutmentm6 <- loadReg(pTHg ~model(6), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm6
pTHg_NAbutmentm7 <- loadReg(pTHg ~model(7), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm7
pTHg_NAbutmentm8 <- loadReg(pTHg ~model(8), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm8
pTHg_NAbutmentm9 <- loadReg(pTHg ~model(9), data = pTHg_NAbutment, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_NAbutmentm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(pTHg_NAbutmentm1,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm2,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm3,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm4,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm5,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm6,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm7,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm8,brief = FALSE, load.only = FALSE)
#print(pTHg_NAbutmentm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (pTHg_NAbutmentm1-9)

plot(pTHg_NAbutmentm1,ann=FALSE)
title(main = "384115121402501_pTHg_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pTHg_NAbutmentm1,which = 2,set.up = F)
title(main = "384115121402501_pTHg_m1 Residuals vs Fitted Values")
plot(pTHg_NAbutmentm1,which = 3,set.up = F)
title(main = "384115121402501_pTHg_m1 Assessing Heteroscedasticity") 
plot(pTHg_NAbutmentm1,which = 4,set.up = F)
title(main = "384115121402501_pTHg_m1 Correlogram of Samples")
plot(pTHg_NAbutmentm1,which = 5,set.up = F)
title(main="384115121402501_pTHg_m1 Normal Discharge")
plot(pTHg_NAbutmentm1,which = 6,set.up = F)
title(main="384115121402501_pTHg_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

pTHg_NAbutment_load<-predLoad(pTHg_NAbutmentm1,N_AbutmentQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pTHg_NAbutment_load,"1_N_Abutment_pTHg_m1_Flux_Annual.csv")
pTHg_NAbutment_load_day<-predLoad(pTHg_NAbutmentm1, N_AbutmentQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pTHg_NAbutment_load_day,"1_N_Abutment_pTHg_m1_Flux_Daily.csv")

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.