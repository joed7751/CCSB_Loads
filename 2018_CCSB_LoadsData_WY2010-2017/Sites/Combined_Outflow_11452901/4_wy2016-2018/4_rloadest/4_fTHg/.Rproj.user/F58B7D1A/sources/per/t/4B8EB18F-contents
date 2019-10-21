#fTHg Combined Outlet (Spillway and Outlet) script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

fTHg_Combined<-importRDB("fTHg_CombinedR.txt")   
CombinedQ<-importRDB("CombinedQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

fTHg_Combinedm1 <- loadReg(fTHg ~model(1), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm1
fTHg_Combinedm2 <- loadReg(fTHg ~model(2), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm2
fTHg_Combinedm3 <- loadReg(fTHg ~model(3), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm3
fTHg_Combinedm4 <- loadReg(fTHg ~model(4), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm4
fTHg_Combinedm5 <- loadReg(fTHg ~model(5), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm5
fTHg_Combinedm6 <- loadReg(fTHg ~model(6), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm6
fTHg_Combinedm7 <- loadReg(fTHg ~model(7), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm7
fTHg_Combinedm8 <- loadReg(fTHg ~model(8), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm8
fTHg_Combinedm9 <- loadReg(fTHg ~model(9), data = fTHg_Combined , flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Combinedm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(fTHg_Combinedm1,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm2,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm3,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm4,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm5,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm6,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm7,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm8,brief = FALSE, load.only = FALSE)
#print(fTHg_Combinedm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (fTHg_Combined m1-9)

plot(fTHg_Combinedm3,ann=FALSE)
title(main = "4_114525901_fTHg_m3 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(fTHg_Combinedm3,which = 2,set.up = F)
title(main = "4_114525901_fTHg_m3 Residuals vs Fitted Values")
plot(fTHg_Combinedm3,which = 3,set.up = F)
title(main = "4_114525901_fTHg_m3 Assessing Heteroscedasticity") 
plot(fTHg_Combinedm3,which = 4,set.up = F)
title(main = "4_114525901_fTHg_m3 Correlogram of Samples")
plot(fTHg_Combinedm3,which = 5,set.up = F)
title(main="4_114525901_fTHg_m3 Normal Discharge")
plot(fTHg_Combinedm3,which = 6,set.up = F)
title(main="4_114525901_fTHg_m3 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

fTHg_Combined_load<-predLoad(fTHg_Combinedm3,CombinedQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(fTHg_Combined_load,"4_Combined_fTHg_m3_Flux_Annual.csv")
fTHg_Combined_load_day<-predLoad(fTHg_Combinedm3, CombinedQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(fTHg_Combined_load_day,"4_Combined_fTHg_m3_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.