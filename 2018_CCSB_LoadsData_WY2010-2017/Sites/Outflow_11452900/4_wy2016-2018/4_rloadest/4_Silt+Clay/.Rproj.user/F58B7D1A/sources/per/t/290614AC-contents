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

SiltClay_Outflow<-importRDB("SiltClay_OutflowR.txt")  #Use this file when the best model has been selected. 
OutflowQ<-importRDB("OutflowQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

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

#print(SiltClay_Outflowm1,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm2,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm3,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm4,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm5,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm6,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm7,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm8,brief = FALSE, load.only = FALSE)
#print(SiltClay_Outflowm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (SiltClay_Outflowm1-9)

plot(SiltClay_Outflowm5,ann=FALSE)
title(main = "4_11452900_SiltClay_m5 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SiltClay_Outflowm5,which = 2,set.up = F)
title(main = "4_11452900_SiltClay_m5 Residuals vs Fitted Values")
plot(SiltClay_Outflowm5,which = 3,set.up = F)
title(main = "4_11452900_SiltClay_m5 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(SiltClay_Outflowm5,which = 4,set.up = F)
title(main = "4_11452900_SiltClay_m5 Correlogram of Samples")
plot(SiltClay_Outflowm5,which = 5,set.up = F)
title(main="4_11452900_SiltClay_m5 Normal Discharge")
plot(SiltClay_Outflowm5,which = 6,set.up = F)
title(main="4_11452900_SiltClay_m5 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

SiltClay_Outflow_load<-predLoad(SiltClay_Outflowm5,OutflowQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SiltClay_Outflow_load,"4_Outflow_SiltClay_m5_Flux_Annual.csv")
SiltClay_Outflow_load_day<-predLoad(SiltClay_Outflowm5, OutflowQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SiltClay_Outflow_load_day,"4_Outflow_SiltClay_m5_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.