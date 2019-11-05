#SSC S_Abutment script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

SSC_SAbutment<-importRDB("SSC_SWeirR.txt")
S_AbutmentQ<-importRDB("SpillwayQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

SSC_SAbutmentm1 <- loadReg(SSC ~model(1), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm1
SSC_SAbutmentm2 <- loadReg(SSC ~model(2), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm2
SSC_SAbutmentm3 <- loadReg(SSC ~model(3), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm3
SSC_SAbutmentm4 <- loadReg(SSC ~model(4), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm4
SSC_SAbutmentm5 <- loadReg(SSC ~model(5), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm5
SSC_SAbutmentm6 <- loadReg(SSC ~model(6), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm6
SSC_SAbutmentm7 <- loadReg(SSC ~model(7), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm7
SSC_SAbutmentm8 <- loadReg(SSC ~model(8), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm8
SSC_SAbutmentm9 <- loadReg(SSC ~model(9), data = SSC_SAbutment, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_SAbutmentm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(SSC_SAbutmentm1,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm2,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm3,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm4,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm5,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm6,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm7,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm8,brief = FALSE, load.only = FALSE)
#print(SSC_SAbutmentm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (SSC_SAbutmentm1-9)

plot(SSC_SAbutmentm3,ann=FALSE)
title(main = "11452800_SSC_m3 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SSC_SAbutmentm3,which = 2,set.up = F)
title(main = "11452800_SSC_m3 Residuals vs Fitted Values")
plot(SSC_SAbutmentm3,which = 3,set.up = F)
title(main = "11452800_SSC_m3 Assessing Heteroscedasticity") 
plot(SSC_SAbutmentm3,which = 4,set.up = F)
title(main = "11452800_SSC_m3 Correlogram of Samples")
plot(SSC_SAbutmentm3,which = 5,set.up = F)
title(main="11452800_SSC_m3 Normal Discharge")
plot(SSC_SAbutmentm3,which = 6,set.up = F)
title(main="11452800_SSC_m3 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

SSC_SAbutment_load<-predLoad(SSC_SAbutmentm3,S_AbutmentQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SSC_SAbutment_load,"8_S_Abutment_SSC_m3_Flux_Annual.csv")
SSC_SAbutment_load_day<-predLoad(SSC_SAbutmentm3, S_AbutmentQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SSC_SAbutment_load_day,"8_S_Abutment_SSC_m3_Flux_Daily.csv")

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.