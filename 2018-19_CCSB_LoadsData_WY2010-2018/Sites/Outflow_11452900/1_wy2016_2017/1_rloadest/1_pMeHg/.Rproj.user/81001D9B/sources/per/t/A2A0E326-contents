#pMeHg Outlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pMeHg_Outlet<-importRDB("pMeHg_OutletR.txt")  #Use this file when the best model has been selected. 
OutletQ<-importRDB("OutletQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

pMeHg_Outletm1 <- loadReg(pMeHg ~model(1), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm1
pMeHg_Outletm2 <- loadReg(pMeHg ~model(2), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm2
pMeHg_Outletm3 <- loadReg(pMeHg ~model(3), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm3
pMeHg_Outletm4 <- loadReg(pMeHg ~model(4), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm4
pMeHg_Outletm5 <- loadReg(pMeHg ~model(5), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm5
pMeHg_Outletm6 <- loadReg(pMeHg ~model(6), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm6
pMeHg_Outletm7 <- loadReg(pMeHg ~model(7), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm7
pMeHg_Outletm8 <- loadReg(pMeHg ~model(8), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm8
pMeHg_Outletm9 <- loadReg(pMeHg ~model(9), data = pMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Outletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(pMeHg_Outletm1,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm2,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm3,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm4,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm5,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm6,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm7,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm8,brief = FALSE, load.only = FALSE)
#print(pMeHg_Outletm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (pMeHg_Outletm1-9)

plot(pMeHg_Outletm2,ann=FALSE)
title(main = "11452900_pMeHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pMeHg_Outletm2,which = 2,set.up = F)
title(main = "11452900_pMeHg Residuals vs Fitted Values")
plot(pMeHg_Outletm2,which = 3,set.up = F)
title(main = "11452900_pMeHg Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pMeHg_Outletm2,which = 4,set.up = F)
title(main = "11452900_pMeHg Correlogram of Samples")
plot(pMeHg_Outletm2,which = 5,set.up = F)
title(main="11452900_pMeHg Normal Discharge")
plot(pMeHg_Outletm2,which = 6,set.up = F)
title(main="11452900_pMeHg Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

pMeHg_Outlet_load<-predLoad(pMeHg_Outletm2,OutletQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pMeHg_Outlet_load,"1_Outflow_pMeHg_m2_Flux_Annual.csv")
pMeHg_Outlet_load_day<-predLoad(pMeHg_Outletm2, OutletQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pMeHg_Outlet_load_day,"1_Outflow_pMeHg_m2_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.