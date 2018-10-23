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

SSC_Outlet<-importRDB("SSC_Comb_OutletR.txt") #Use the combined flow for modeling the outlet. Choose the best model, then use only outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

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

