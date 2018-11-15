#fTHg Inlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

fTHg_Inlet<-importRDB("fTHg_InletR.txt")
InletQ<-importRDB("InletQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

fTHg_Inletm1 <- loadReg(fTHg ~model(1), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm1
fTHg_Inletm2 <- loadReg(fTHg ~model(2), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm2
fTHg_Inletm3 <- loadReg(fTHg ~model(3), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm3
fTHg_Inletm4 <- loadReg(fTHg ~model(4), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm4
fTHg_Inletm5 <- loadReg(fTHg ~model(5), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm5
fTHg_Inletm6 <- loadReg(fTHg ~model(6), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm6
fTHg_Inletm7 <- loadReg(fTHg ~model(7), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm7
fTHg_Inletm8 <- loadReg(fTHg ~model(8), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm8
fTHg_Inletm9 <- loadReg(fTHg ~model(9), data = fTHg_Inlet, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fTHg_Inletm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(fTHg_Inletm1,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm2,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm3,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm4,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm5,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm6,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm7,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm8,brief = FALSE, load.only = FALSE)
#print(fTHg_Inletm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (fTHg_Inletm1-9)

plot(fTHg_Inletm8,ann=FALSE)
title(main = "11452600_fTHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(fTHg_Inletm8,which = 2,set.up = F)
title(main = "11452600_fTHg Residuals vs Fitted Values")
plot(fTHg_Inletm8,which = 3,set.up = F)
title(main = "11452600_fTHg Assessing Heteroscedasticity") #Add "of Residuals"?
plot(fTHg_Inletm8,which = 4,set.up = F)
title(main = "11452600_fTHg Correlogram of Samples")
plot(fTHg_Inletm8,which = 5,set.up = F)
title(main="11452600_fTHg Normal Discharge")
plot(fTHg_Inletm8,which = 6,set.up = F)
title(main="11452600_fTHg Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

fTHg_Inlet_load<-predLoad(fTHg_Inletm8,InletQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(fTHg_Inlet_load,"1_Inlet_fTHg_m8_Flux_Annual.csv")
fTHg_Inlet_load_day<-predLoad(fTHg_Inletm8, InletQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(fTHg_Inlet_load_day,"1_Inlet_fTHg_m8_Flux_Daily.csv")

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.