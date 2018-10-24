#SSC Yolo script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

SSC_Yolo<-importRDB("SSC_YoloR.txt")
YoloQ<-importRDB("YoloQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

SSC_Yolom1 <- loadReg(SSC ~model(1), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom1
SSC_Yolom2 <- loadReg(SSC ~model(2), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom2
SSC_Yolom3 <- loadReg(SSC ~model(3), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom3
SSC_Yolom4 <- loadReg(SSC ~model(4), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom4
SSC_Yolom5 <- loadReg(SSC ~model(5), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom5
SSC_Yolom6 <- loadReg(SSC ~model(6), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom6
SSC_Yolom7 <- loadReg(SSC ~model(7), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom7
SSC_Yolom8 <- loadReg(SSC ~model(8), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom8
SSC_Yolom9 <- loadReg(SSC ~model(9), data = SSC_Yolo, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SSC_Yolom9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(SSC_Yolom1,ann=FALSE)
title(main = "11452500_SSC Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SSC_Yolom1,which = 2,set.up = F)
title(main = "11452500_SSC Residuals vs Fitted Values")
plot(SSC_Yolom1,which = 3,set.up = F)
title(main = "11452500_SSC Assessing Heteroscedasticity") #Add "of Residuals"?
plot(SSC_Yolom1,which = 4,set.up = F)
title(main = "11452500_SSC Correlogram of Samples")
plot(SSC_Yolom1,which = 5,set.up = F)
title(main="11452500_SSC Normal Discharge")
plot(SSC_Yolom1,which = 6,set.up = F)
title(main="11452500_SSC Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

SSC_Yolo_load<-predLoad(SSC_Yolom1,YoloQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SSC_Yolo_load,"2_Yolo_SSC_Flux_Annual.csv")
SSC_Yolo_load_day<-predLoad(SSC_Yolom1, YoloQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SSC_Yolo_load_day,"2_Yolo_SSC_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.