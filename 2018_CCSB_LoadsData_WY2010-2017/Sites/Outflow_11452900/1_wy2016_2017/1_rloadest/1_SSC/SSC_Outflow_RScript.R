#SSC Outlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

SSC_Outlet<-importRDB("SSC_OutletR.txt")  #Use this file when the best model has been selected. 
OutletQ<-importRDB("OutletQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

SSC_Outletm1 <- loadReg(SSC ~model(1), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm1
SSC_Outletm2 <- loadReg(SSC ~model(2), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm2
SSC_Outletm3 <- loadReg(SSC ~model(3), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm3
SSC_Outletm4 <- loadReg(SSC ~model(4), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm4
SSC_Outletm5 <- loadReg(SSC ~model(5), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm5
SSC_Outletm6 <- loadReg(SSC ~model(6), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm6
SSC_Outletm7 <- loadReg(SSC ~model(7), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm7
SSC_Outletm8 <- loadReg(SSC ~model(8), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm8
SSC_Outletm9 <- loadReg(SSC ~model(9), data = SSC_Outlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Outletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(SSC_Outletm1,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm2,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm3,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm4,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm5,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm6,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm7,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm8,brief = FALSE, load.only = FALSE)
#print(SSC_Outletm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (SSC_Outletm1-9)

plot(SSC_Outletm5,ann=FALSE)
title(main = "11452900_SSC Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SSC_Outletm5,which = 2,set.up = F)
title(main = "11452900_SSC Residuals vs Fitted Values")
plot(SSC_Outletm5,which = 3,set.up = F)
title(main = "11452900_SSC Assessing Heteroscedasticity") #Add "of Residuals"?
plot(SSC_Outletm5,which = 4,set.up = F)
title(main = "11452900_SSC Correlogram of Samples")
plot(SSC_Outletm5,which = 5,set.up = F)
title(main="11452900_SSC Normal Discharge")
plot(SSC_Outletm5,which = 6,set.up = F)
title(main="11452900_SSC Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

SSC_Outlet_load<-predLoad(SSC_Outletm5,OutletQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SSC_Outlet_load,"1_Outflow_SSC_Flux_Annual.csv")
SSC_Outlet_load_day<-predLoad(SSC_Outletm5, OutletQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SSC_Outlet_load_day,"1_Outflow_SSC_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.