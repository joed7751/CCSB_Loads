#Sand Outflow script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

Sand_Outflow<-importRDB("Sand_Comb_OutflowR.txt") #Use the Combined Outflow (Outlet+Spillway) for modeling the Outflow. Choose the best model, then use only Outflow data on the next script
#The data frame is created by the function importRDB. 
#The call above brings the constituent data and the instantaneous flow data into the script.

Sand_Outflowm1 <- loadReg(Sand ~model(1), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm1
Sand_Outflowm2 <- loadReg(Sand ~model(2), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm2
Sand_Outflowm3 <- loadReg(Sand ~model(3), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm3
Sand_Outflowm4 <- loadReg(Sand ~model(4), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm4
Sand_Outflowm5 <- loadReg(Sand ~model(5), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm5
Sand_Outflowm6 <- loadReg(Sand ~model(6), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm6
Sand_Outflowm7 <- loadReg(Sand ~model(7), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm7
Sand_Outflowm8 <- loadReg(Sand ~model(8), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm8
Sand_Outflowm9 <- loadReg(Sand ~model(9), data = Sand_Outflow, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Outflowm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

