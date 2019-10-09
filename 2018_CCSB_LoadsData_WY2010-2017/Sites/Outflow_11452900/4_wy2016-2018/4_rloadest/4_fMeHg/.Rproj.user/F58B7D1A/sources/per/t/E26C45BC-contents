#fMeHg Outflow script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

fMeHg_Outflow<-importRDB("fMeHg_Comb_OutflowR.txt") #Use the Combined Outflow (Outlet+Spillway) for modeling the Outflow. Choose the best model, then use only Outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

fMeHg_Outflowm1 <- loadReg(fMeHg ~model(1), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm1
fMeHg_Outflowm2 <- loadReg(fMeHg ~model(2), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm2
fMeHg_Outflowm3 <- loadReg(fMeHg ~model(3), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm3
fMeHg_Outflowm4 <- loadReg(fMeHg ~model(4), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm4
fMeHg_Outflowm5 <- loadReg(fMeHg ~model(5), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm5
fMeHg_Outflowm6 <- loadReg(fMeHg ~model(6), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm6
fMeHg_Outflowm7 <- loadReg(fMeHg ~model(7), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm7
fMeHg_Outflowm8 <- loadReg(fMeHg ~model(8), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm8
fMeHg_Outflowm9 <- loadReg(fMeHg ~model(9), data = fMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Outflowm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

