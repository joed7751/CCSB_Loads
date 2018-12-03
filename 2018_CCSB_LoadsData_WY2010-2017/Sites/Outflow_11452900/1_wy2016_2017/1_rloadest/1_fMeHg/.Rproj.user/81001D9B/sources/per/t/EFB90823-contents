#fMeHg Outlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

fMeHg_Outlet<-importRDB("fMeHg_Comb_OutletR.txt") #Use the combined flow for modeling the outlet. Choose the best model, then use only outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

fMeHg_Outletm1 <- loadReg(fMeHg ~model(1), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm1
fMeHg_Outletm2 <- loadReg(fMeHg ~model(2), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm2
fMeHg_Outletm3 <- loadReg(fMeHg ~model(3), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm3
fMeHg_Outletm4 <- loadReg(fMeHg ~model(4), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm4
fMeHg_Outletm5 <- loadReg(fMeHg ~model(5), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm5
fMeHg_Outletm6 <- loadReg(fMeHg ~model(6), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm6
fMeHg_Outletm7 <- loadReg(fMeHg ~model(7), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm7
fMeHg_Outletm8 <- loadReg(fMeHg ~model(8), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm8
fMeHg_Outletm9 <- loadReg(fMeHg ~model(9), data = fMeHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

