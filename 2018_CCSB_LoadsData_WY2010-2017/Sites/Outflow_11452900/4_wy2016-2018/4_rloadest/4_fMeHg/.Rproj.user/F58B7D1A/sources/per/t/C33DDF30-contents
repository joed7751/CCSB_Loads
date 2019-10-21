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

fMeHg_Outflow<-importRDB("fMeHg_Comb_OutflowR.txt")
OutflowQ<-importRDB("Comb_OutflowQR.txt")
#A data frame is created by the function importRDB. 
#The call on line 19 brings the constituent data and the instantaneous flow data (Comb_Outflow Q = Outlet Inst Q + Spillway Inst Q)into the script.
#The call on line 20 brings in the daily Comb_Outflow (Outlet Daily Q +Spillway Daily Q) data. 


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

plot(fMeHg_Outflowm3,ann=FALSE)
title(main = "4_11452900_fMeHg_m3 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(fMeHg_Outflowm3,which = 2,set.up = F)
title(main = "4_11452900_fMeHg_m3 Residuals vs Fitted Values")
plot(fMeHg_Outflowm3,which = 3,set.up = F)
title(main = "4_11452900_fMeHg_m3 Assessing Heteroscedasticity") 
plot(fMeHg_Outflowm3,which = 4,set.up = F)
title(main = "4_11452900_fMeHg_m3 Correlogram of Samples")
plot(fMeHg_Outflowm3,which = 5,set.up = F)
title(main="4_11452900_fMeHg_m3 Normal Discharge")
plot(fMeHg_Outflowm3,which = 6,set.up = F)
title(main="4_11452900_fMeHg_m3 Box Plot of Loads")

#The functions above plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 66-69 before running the loads predictions. This should be the best model. 

fMeHg_Outflow_load<-predLoad(fMeHg_Outflowm3,OutflowQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(fMeHg_Outflow_load,"4_Outflow_fMeHg_m3_Flux_Annual_uncorr.csv")
fMeHg_Outflow_load_day<-predLoad(fMeHg_Outflowm3, OutflowQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(fMeHg_Outflow_load_day,"4_Outflow_fMeHg_m3_Flux_Daily_uncorr.csv")

#Lines 66 and 68 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 67 and 69 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv".
#file.choose() lets the user select the location for the .csv files.
