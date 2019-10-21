#pMeHg Outflow script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pMeHg_Outflow<-importRDB("pMeHg_Comb_OutflowR.txt")
OutflowQ<-importRDB("Comb_OutflowQR.txt")

#A data frame is created by the function importRDB. 
#The call on line 19 brings the constituent data and the instantaneous flow data (Comb_Outflow Q = Outlet Inst Q + Spillway Inst Q)into the script.
#The call on line 20 brings in the daily Comb_Outflow (Outlet Daily Q +Spillway Daily Q) data. 

#***************************************************Do the following if you have censored data:*****************************************************
#(1)Create vector of detection limit

det<-as.numeric(array(.1,dim(pMeHg_Outflow)[1]))

#(2)Create lcens object- as.lcens(values, detlim, censor.codes)
cen_data<-as.lcens(pMeHg_Outflow$PpMeHg,det,pMeHg_Outflow$RpMeHg)

#(3)Create input data frame with censored data object replacing last 2 columns
cen_frame<-data.frame(pMeHg_Outflow[,1:3],cen_data)

#(4)Use this code to run models for censored data:

pMeHg_Outflowm1 <- loadReg(cen_data ~model(1), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm1
pMeHg_Outflowm2 <- loadReg(cen_data ~model(2), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm2
pMeHg_Outflowm3 <- loadReg(cen_data ~model(3), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm3
pMeHg_Outflowm4 <- loadReg(cen_data ~model(4), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm4
pMeHg_Outflowm5 <- loadReg(cen_data ~model(5), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm5
pMeHg_Outflowm6 <- loadReg(cen_data ~model(6), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm6
pMeHg_Outflowm7 <- loadReg(cen_data ~model(7), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm7
pMeHg_Outflowm8 <- loadReg(cen_data ~model(8), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm8
pMeHg_Outflowm9 <- loadReg(cen_data ~model(9), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
pMeHg_Outflowm9

#****************************Use this code to run models for uncensored data, comment out the censored data code(above):******************************

#pMeHg_Outflowm1 <- loadReg(pMeHg ~model(1), data = test_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm1
#pMeHg_Outflowm2 <- loadReg(pMeHg ~model(2), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm2
#pMeHg_Outflowm3 <- loadReg(pMeHg ~model(3), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm3
#pMeHg_Outflowm4 <- loadReg(pMeHg ~model(4), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm4
#pMeHg_Outflowm5 <- loadReg(pMeHg ~model(5), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm5
#pMeHg_Outflowm6 <- loadReg(pMeHg ~model(6), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm6
#pMeHg_Outflowm7 <- loadReg(pMeHg ~model(7), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm7
#pMeHg_Outflowm8 <- loadReg(pMeHg ~model(8), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm8
#pMeHg_Outflowm9 <- loadReg(pMeHg ~model(9), data = pMeHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Outflow")
#pMeHg_Outflowm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(pMeHg_Outflowm1,ann=FALSE)
title(main = "4_11452900_pMeHg_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pMeHg_Outflowm1,which = 2,set.up = F)
title(main = "4_11452900_pMeHg_m1 Residuals vs Fitted Values")
plot(pMeHg_Outflowm1,which = 3,set.up = F)
title(main = "4_11452900_pMeHg_m1 Assessing Heteroscedasticity") 
plot(pMeHg_Outflowm1,which = 4,set.up = F)
title(main = "4_11452900_pMeHg_m1 Correlogram of Samples")
plot(pMeHg_Outflowm1,which = 5,set.up = F)
title(main="4_11452900_pMeHg_m1 Normal Discharge")
plot(pMeHg_Outflowm1,which = 6,set.up = F)
title(main="4_11452900_pMeHg_m1 Box Plot of Loads")

#The functions above plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 66-69 before running the loads predictions. This should be the best model. 

pMeHg_Outflow_load<-predLoad(pMeHg_Outflowm1,OutflowQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pMeHg_Outflow_load,"4_Outflow_pMeHg_m1_Flux_Annual_uncorr.csv")
pMeHg_Outflow_load_day<-predLoad(pMeHg_Outflowm1, OutflowQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pMeHg_Outflow_load_day,"4_Outflow_pMeHg_m1_Flux_Daily_uncorr.csv")

#Lines 66 and 68 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 67 and 69 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv".
#file.choose() lets the user select the location for the .csv files.
