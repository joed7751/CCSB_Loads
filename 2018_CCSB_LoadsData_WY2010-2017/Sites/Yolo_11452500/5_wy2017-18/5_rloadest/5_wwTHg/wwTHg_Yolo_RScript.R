#wwTHg Yolo script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

wwTHg_Yolo<-importRDB("wwTHg_YoloR.txt")
YoloQ<-importRDB("YoloQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

wwTHg_Yolom1 <- loadReg(wwTHg ~model(1), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom1
wwTHg_Yolom2 <- loadReg(wwTHg ~model(2), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom2
wwTHg_Yolom3 <- loadReg(wwTHg ~model(3), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom3
wwTHg_Yolom4 <- loadReg(wwTHg ~model(4), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom4
wwTHg_Yolom5 <- loadReg(wwTHg ~model(5), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom5
wwTHg_Yolom6 <- loadReg(wwTHg ~model(6), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom6
wwTHg_Yolom7 <- loadReg(wwTHg ~model(7), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom7
wwTHg_Yolom8 <- loadReg(wwTHg ~model(8), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom8
wwTHg_Yolom9 <- loadReg(wwTHg ~model(9), data = wwTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
wwTHg_Yolom9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(wwTHg_Yolom1,ann=FALSE)
title(main = "5_11452500_wwTHg_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(wwTHg_Yolom1,which = 2,set.up = F)
title(main = "5_11452500_wwTHg_m1 Residuals vs Fitted Values")
plot(wwTHg_Yolom1,which = 3,set.up = F)
title(main = "5_11452500_wwTHg_m1 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(wwTHg_Yolom1,which = 4,set.up = F)
title(main = "5_11452500_wwTHg_m1 Correlogram of Samples")
plot(wwTHg_Yolom1,which = 5,set.up = F)
title(main="5_11452500_wwTHg_m1 Normal Discharge")
plot(wwTHg_Yolom1,which = 6,set.up = F)
title(main="5_11452500_wwTHg_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

wwTHg_Yolo_load<-predLoad(wwTHg_Yolom1,YoloQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(wwTHg_Yolo_load,"5_Yolo_wwTHg_m1_Flux_Annual.csv")
wwTHg_Yolo_load_day<-predLoad(wwTHg_Yolom1, YoloQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(wwTHg_Yolo_load_day,"5_Yolo_wwTHg_m1_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
