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

Sand_Outflow<-importRDB("Sand_OutflowR.txt")  #Use this file when the best model has been selected. 
OutflowQ<-importRDB("OutflowQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

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

#print(Sand_Outflowm1,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm2,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm3,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm4,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm5,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm6,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm7,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm8,brief = FALSE, load.only = FALSE)
#print(Sand_Outflowm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (Sand_Outflowm1-9)

plot(Sand_Outflowm2,ann=FALSE)
title(main = "4_11452900_Sand_m2 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(Sand_Outflowm2,which = 2,set.up = F)
title(main = "4_11452900_Sand_m2 Residuals vs Fitted Values")
plot(Sand_Outflowm2,which = 3,set.up = F)
title(main = "4_11452900_Sand_m2 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(Sand_Outflowm2,which = 4,set.up = F)
title(main = "4_11452900_Sand_m2 Correlogram of Samples")
plot(Sand_Outflowm2,which = 5,set.up = F)
title(main="4_11452900_Sand_m2 Normal Discharge")
plot(Sand_Outflowm2,which = 6,set.up = F)
title(main="4_11452900_Sand_m2 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

Sand_Outflow_load<-predLoad(Sand_Outflowm2,OutflowQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(Sand_Outflow_load,"4_Outflow_Sand_m2_Flux_Annual.csv")
Sand_Outflow_load_day<-predLoad(Sand_Outflowm2, OutflowQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(Sand_Outflow_load_day,"4_Outflow_Sand_m2_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.