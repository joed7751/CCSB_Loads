#Silt+Clay Yolo script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

SiltClay_Yolo<-importRDB("SiltClay_YoloR.txt")
YoloQ<-importRDB("YoloQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

SiltClay_Yolom1 <- loadReg(Silt.Clay ~model(1), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom1
SiltClay_Yolom2 <- loadReg(Silt.Clay ~model(2), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom2
SiltClay_Yolom3 <- loadReg(Silt.Clay ~model(3), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom3
SiltClay_Yolom4 <- loadReg(Silt.Clay ~model(4), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom4
SiltClay_Yolom5 <- loadReg(Silt.Clay ~model(5), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom5
SiltClay_Yolom6 <- loadReg(Silt.Clay ~model(6), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom6
SiltClay_Yolom7 <- loadReg(Silt.Clay ~model(7), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom7
SiltClay_Yolom8 <- loadReg(Silt.Clay ~model(8), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom8
SiltClay_Yolom9 <- loadReg(Silt.Clay ~model(9), data = SiltClay_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Yolom9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(SiltClay_Yolom1,ann=FALSE)
title(main = "5_11452500_SiltClay_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SiltClay_Yolom1,which = 2,set.up = F)
title(main = "5_11452500_SiltClay_m1 Residuals vs Fitted Values")
plot(SiltClay_Yolom1,which = 3,set.up = F)
title(main = "5_11452500_SiltClay_m1 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(SiltClay_Yolom1,which = 4,set.up = F)
title(main = "5_11452500_SiltClay_m1 Correlogram of Samples")
plot(SiltClay_Yolom1,which = 5,set.up = F)
title(main="5_11452500_SiltClay_m1 Normal Discharge")
plot(SiltClay_Yolom1,which = 6,set.up = F)
title(main="5_11452500_SiltClay_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

SiltClay_Yolo_load<-predLoad(SiltClay_Yolom1,YoloQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SiltClay_Yolo_load,"5_Yolo_SiltClay_m1_Flux_Annual.csv")
SiltClay_Yolo_load_day<-predLoad(SiltClay_Yolom1, YoloQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SiltClay_Yolo_load_day,"5_Yolo_SiltClay_m1_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
