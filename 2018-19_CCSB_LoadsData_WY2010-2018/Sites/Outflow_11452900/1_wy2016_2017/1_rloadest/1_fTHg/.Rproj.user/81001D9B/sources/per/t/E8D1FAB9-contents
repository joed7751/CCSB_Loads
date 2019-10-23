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

fTHg_Outlet<-importRDB("fTHg_Comb_OutletR.txt") #Use the combined flow for modeling the outlet. Choose the best model, then use only outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

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

