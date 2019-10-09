#SiltClay Outflow script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

SiltClay_Outflow<-importRDB("SiltClay_Comb_OutflowR.txt") #Use the Combined Outflow (Outlet+Spillway) for modeling the Outflow. Choose the best model, then use only Outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

SiltClay_Outflowm1 <- loadReg(Silt.Clay ~model(1), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm1
SiltClay_Outflowm2 <- loadReg(Silt.Clay ~model(2), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm2
SiltClay_Outflowm3 <- loadReg(Silt.Clay ~model(3), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm3
SiltClay_Outflowm4 <- loadReg(Silt.Clay ~model(4), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm4
SiltClay_Outflowm5 <- loadReg(Silt.Clay ~model(5), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm5
SiltClay_Outflowm6 <- loadReg(Silt.Clay ~model(6), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm6
SiltClay_Outflowm7 <- loadReg(Silt.Clay ~model(7), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm7
SiltClay_Outflowm8 <- loadReg(Silt.Clay ~model(8), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm8
SiltClay_Outflowm9 <- loadReg(Silt.Clay ~model(9), data = SiltClay_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Outflowm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

