#pTHg Outflow script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pTHg_Outflow<-importRDB("pTHg_OutflowR.txt")  #Use this file when the best model has been selected. 
OutflowQ<-importRDB("OutflowQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

pTHg_Outflowm1 <- loadReg(pTHg ~model(1), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm1
pTHg_Outflowm2 <- loadReg(pTHg ~model(2), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm2
pTHg_Outflowm3 <- loadReg(pTHg ~model(3), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm3
pTHg_Outflowm4 <- loadReg(pTHg ~model(4), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm4
pTHg_Outflowm5 <- loadReg(pTHg ~model(5), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm5
pTHg_Outflowm6 <- loadReg(pTHg ~model(6), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm6
pTHg_Outflowm7 <- loadReg(pTHg ~model(7), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm7
pTHg_Outflowm8 <- loadReg(pTHg ~model(8), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm8
pTHg_Outflowm9 <- loadReg(pTHg ~model(9), data = pTHg_Outflow, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Outflowm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(pTHg_Outflowm1,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm2,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm3,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm4,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm5,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm6,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm7,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm8,brief = FALSE, load.only = FALSE)
#print(pTHg_Outflowm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (pTHg_Outflowm1-9)

plot(pTHg_Outflowm5,ann=FALSE)
title(main = "4_11452900_pTHg_m5 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pTHg_Outflowm5,which = 2,set.up = F)
title(main = "4_11452900_pTHg_m5 Residuals vs Fitted Values")
plot(pTHg_Outflowm5,which = 3,set.up = F)
title(main = "4_11452900_pTHg_m5 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pTHg_Outflowm5,which = 4,set.up = F)
title(main = "4_11452900_pTHg_m5 Correlogram of Samples")
plot(pTHg_Outflowm5,which = 5,set.up = F)
title(main="4_11452900_pTHg_m5 Normal Discharge")
plot(pTHg_Outflowm5,which = 6,set.up = F)
title(main="4_11452900_pTHg_m5 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

pTHg_Outflow_load<-predLoad(pTHg_Outflowm5,OutflowQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pTHg_Outflow_load,"4_Outflow_pTHg_m5_Flux_Annual.csv")
pTHg_Outflow_load_day<-predLoad(pTHg_Outflowm5, OutflowQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pTHg_Outflow_load_day,"4_Outflow_pTHg_m5_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.