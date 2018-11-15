#fTHg Outlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

fTHg_Outlet<-importRDB("fTHg_OutletR.txt")  #Use this file when the best model has been selected. 
OutletQ<-importRDB("OutletQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

fTHg_Outletm1 <- loadReg(fTHg ~model(1), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm1
fTHg_Outletm2 <- loadReg(fTHg ~model(2), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm2
fTHg_Outletm3 <- loadReg(fTHg ~model(3), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm3
fTHg_Outletm4 <- loadReg(fTHg ~model(4), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm4
fTHg_Outletm5 <- loadReg(fTHg ~model(5), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm5
fTHg_Outletm6 <- loadReg(fTHg ~model(6), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm6
fTHg_Outletm7 <- loadReg(fTHg ~model(7), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm7
fTHg_Outletm8 <- loadReg(fTHg ~model(8), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm8
fTHg_Outletm9 <- loadReg(fTHg ~model(9), data = fTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Outletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(fTHg_Outletm1,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm2,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm3,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm4,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm5,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm6,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm7,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm8,brief = FALSE, load.only = FALSE)
#print(fTHg_Outletm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (fTHg_Outletm1-9)

plot(fTHg_Outletm5,ann=FALSE)
title(main = "11452900_fTHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(fTHg_Outletm5,which = 2,set.up = F)
title(main = "11452900_fTHg Residuals vs Fitted Values")
plot(fTHg_Outletm5,which = 3,set.up = F)
title(main = "11452900_fTHg Assessing Heteroscedasticity") #Add "of Residuals"?
plot(fTHg_Outletm5,which = 4,set.up = F)
title(main = "11452900_fTHg Correlogram of Samples")
plot(fTHg_Outletm5,which = 5,set.up = F)
title(main="11452900_fTHg Normal Discharge")
plot(fTHg_Outletm5,which = 6,set.up = F)
title(main="11452900_fTHg Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

fTHg_Outlet_load<-predLoad(fTHg_Outletm5,OutletQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(fTHg_Outlet_load,"1_Outflow_fTHg_m5_Flux_Annual.csv")
fTHg_Outlet_load_day<-predLoad(fTHg_Outletm5, OutletQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(fTHg_Outlet_load_day,"1_Outflow_fTHg_m5_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.