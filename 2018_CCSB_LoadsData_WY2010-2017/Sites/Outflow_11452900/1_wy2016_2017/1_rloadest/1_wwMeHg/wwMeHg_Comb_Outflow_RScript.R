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

wwMeHg_Outlet<-importRDB("wwMeHg_Comb_OutletR.txt") #Use the combined flow for modeling the outlet. Choose the best model, then use only outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

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

