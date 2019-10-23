#wwMeHg Outlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

wwMeHg_Outlet<-importRDB("wwMeHg_OutletR.txt")  #Use this file when the best model has been selected. 
OutletQ<-importRDB("OutletQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

wwMeHg_Outletm1 <- loadReg(wwMeHg ~model(1), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm1
wwMeHg_Outletm2 <- loadReg(wwMeHg ~model(2), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm2
wwMeHg_Outletm3 <- loadReg(wwMeHg ~model(3), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm3
wwMeHg_Outletm4 <- loadReg(wwMeHg ~model(4), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm4
wwMeHg_Outletm5 <- loadReg(wwMeHg ~model(5), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm5
wwMeHg_Outletm6 <- loadReg(wwMeHg ~model(6), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm6
wwMeHg_Outletm7 <- loadReg(wwMeHg ~model(7), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm7
wwMeHg_Outletm8 <- loadReg(wwMeHg ~model(8), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm8
wwMeHg_Outletm9 <- loadReg(wwMeHg ~model(9), data = wwMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwMeHg_Outletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(wwMeHg_Outletm1,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm2,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm3,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm4,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm5,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm6,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm7,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm8,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Outletm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (wwMeHg_Outletm1-9)

plot(wwMeHg_Outletm2,ann=FALSE)
title(main = "11452900_wwMeHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(wwMeHg_Outletm2,which = 2,set.up = F)
title(main = "11452900_wwMeHg Residuals vs Fitted Values")
plot(wwMeHg_Outletm2,which = 3,set.up = F)
title(main = "11452900_wwMeHg Assessing Heteroscedasticity") #Add "of Residuals"?
plot(wwMeHg_Outletm2,which = 4,set.up = F)
title(main = "11452900_wwMeHg Correlogram of Samples")
plot(wwMeHg_Outletm2,which = 5,set.up = F)
title(main="11452900_wwMeHg Normal Discharge")
plot(wwMeHg_Outletm2,which = 6,set.up = F)
title(main="11452900_wwMeHg Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

wwMeHg_Outlet_load<-predLoad(wwMeHg_Outletm2,OutletQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(wwMeHg_Outlet_load,"1_Outflow_wwMeHg_m2_Flux_Annual.csv")
wwMeHg_Outlet_load_day<-predLoad(wwMeHg_Outletm2, OutletQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(wwMeHg_Outlet_load_day,"1_Outflow_wwMeHg_m2_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.