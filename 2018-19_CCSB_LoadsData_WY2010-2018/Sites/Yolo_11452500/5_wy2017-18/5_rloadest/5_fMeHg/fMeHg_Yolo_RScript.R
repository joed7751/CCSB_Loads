#fMeHg Yolo script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

fMeHg_Yolo<-importRDB("fMeHg_YoloR.txt")
YoloQ<-importRDB("YoloQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

fMeHg_Yolom1 <- loadReg(fMeHg ~model(1), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom1
fMeHg_Yolom2 <- loadReg(fMeHg ~model(2), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom2
fMeHg_Yolom3 <- loadReg(fMeHg ~model(3), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom3
fMeHg_Yolom4 <- loadReg(fMeHg ~model(4), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom4
fMeHg_Yolom5 <- loadReg(fMeHg ~model(5), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom5
fMeHg_Yolom6 <- loadReg(fMeHg ~model(6), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom6
fMeHg_Yolom7 <- loadReg(fMeHg ~model(7), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom7
fMeHg_Yolom8 <- loadReg(fMeHg ~model(8), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom8
fMeHg_Yolom9 <- loadReg(fMeHg ~model(9), data = fMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
fMeHg_Yolom9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(fMeHg_Yolom5,ann=FALSE)
title(main = "5_11452500_fMeHg_m5 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(fMeHg_Yolom5,which = 2,set.up = F)
title(main = "5_11452500_fMeHg_m5 Residuals vs Fitted Values")
plot(fMeHg_Yolom5,which = 3,set.up = F)
title(main = "5_11452500_fMeHg_m5 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(fMeHg_Yolom5,which = 4,set.up = F)
title(main = "5_11452500_fMeHg_m5 Correlogram of Samples")
plot(fMeHg_Yolom5,which = 5,set.up = F)
title(main="5_11452500_fMeHg_m5 Normal Discharge")
plot(fMeHg_Yolom5,which = 6,set.up = F)
title(main="5_11452500_fMeHg_m5 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

fMeHg_Yolo_load<-predLoad(fMeHg_Yolom5,YoloQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(fMeHg_Yolo_load,"5_Yolo_fMeHg_m5_Flux_Annual.csv")
fMeHg_Yolo_load_day<-predLoad(fMeHg_Yolom5, YoloQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(fMeHg_Yolo_load_day,"5_Yolo_fMeHg_m5_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
