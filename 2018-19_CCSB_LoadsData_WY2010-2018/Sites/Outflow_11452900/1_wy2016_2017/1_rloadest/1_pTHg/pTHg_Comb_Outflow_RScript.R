#pTHg Outlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pTHg_Outlet<-importRDB("pTHg_Comb_OutletR.txt") #Use the combined flow for modeling the outlet. Choose the best model, then use only outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

pTHg_Outletm1 <- loadReg(pTHg ~model(1), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm1
pTHg_Outletm2 <- loadReg(pTHg ~model(2), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm2
pTHg_Outletm3 <- loadReg(pTHg ~model(3), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm3
pTHg_Outletm4 <- loadReg(pTHg ~model(4), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm4
pTHg_Outletm5 <- loadReg(pTHg ~model(5), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm5
pTHg_Outletm6 <- loadReg(pTHg ~model(6), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm6
pTHg_Outletm7 <- loadReg(pTHg ~model(7), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm7
pTHg_Outletm8 <- loadReg(pTHg ~model(8), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm8
pTHg_Outletm9 <- loadReg(pTHg ~model(9), data = pTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

