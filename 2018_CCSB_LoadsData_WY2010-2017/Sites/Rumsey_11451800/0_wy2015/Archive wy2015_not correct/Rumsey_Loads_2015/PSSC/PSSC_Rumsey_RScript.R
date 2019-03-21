#SSC Inlet script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

SSC_Inlet<-importRDB("SSC_InletR.txt")
InletQ<-importRDB("InletQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the particulate total mercury data and the daily flow data into the script.

SSC_Inletm1 <- loadReg(SSC ~model(1), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm1
SSC_Inletm2 <- loadReg(SSC ~model(2), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm2
SSC_Inletm3 <- loadReg(SSC ~model(3), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm3
SSC_Inletm4 <- loadReg(SSC ~model(4), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm4
SSC_Inletm5 <- loadReg(SSC ~model(5), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm5
SSC_Inletm6 <- loadReg(SSC ~model(6), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm6
SSC_Inletm7 <- loadReg(SSC ~model(7), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm7
SSC_Inletm8 <- loadReg(SSC ~model(8), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm8
SSC_Inletm9 <- loadReg(SSC ~model(9), data = SSC_Inlet, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Inletm9

#These lists are created using the loadReg function.
#[A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.] 
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(SSC_Inletm3,ann=FALSE)
title(main = "11452600_SSC Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SSC_Inletm3,which = 2,set.up = F)
title(main = "11452600_SSC Residuals vs Fitted Values")
plot(SSC_Inletm3,which = 3,set.up = F)
title(main = "11452600_SSC Assessing Heteroscedasticity")
plot(SSC_Inletm3,which = 4,set.up = F)
title(main = "11452600_SSC Correlogram of Samples")
plot(SSC_Inletm3,which = 5,set.up = F)
title(main="11452600_SSC Normal Discharge")
plot(SSC_Inletm3,which = 6,set.up = F)
title(main="11452600_SSC Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

SSC_Inlet_load<-predLoad(SSC_Inletm3,InletQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SSC_Inlet_load,file.choose())
SSC_Inlet_load_day<-predLoad(SSC_Inletm3, InletQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SSC_Inlet_load_day,file.choose())

#Lines 71 and 73 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
