#wwTHg Outlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

wwTHg_Outlet<-importRDB("wwTHg_Comb_OutletR.txt") #Use the combined flow for modeling the outlet. Choose the best model, then use only outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

wwTHg_Outletm1 <- loadReg(wwTHg ~model(1), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm1
wwTHg_Outletm2 <- loadReg(wwTHg ~model(2), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm2
wwTHg_Outletm3 <- loadReg(wwTHg ~model(3), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm3
wwTHg_Outletm4 <- loadReg(wwTHg ~model(4), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm4
wwTHg_Outletm5 <- loadReg(wwTHg ~model(5), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm5
wwTHg_Outletm6 <- loadReg(wwTHg ~model(6), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm6
wwTHg_Outletm7 <- loadReg(wwTHg ~model(7), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm7
wwTHg_Outletm8 <- loadReg(wwTHg ~model(8), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm8
wwTHg_Outletm9 <- loadReg(wwTHg ~model(9), data = wwTHg_Outlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Outletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

