#pMeHg Yolo script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pMeHg_Yolo<-importRDB("pMeHg_YoloR.txt")
YoloQ<-importRDB("YoloQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

pMeHg_Yolom1 <- loadReg(pMeHg ~model(1), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom1
pMeHg_Yolom2 <- loadReg(pMeHg ~model(2), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom2
pMeHg_Yolom3 <- loadReg(pMeHg ~model(3), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom3
pMeHg_Yolom4 <- loadReg(pMeHg ~model(4), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom4
pMeHg_Yolom5 <- loadReg(pMeHg ~model(5), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom5
pMeHg_Yolom6 <- loadReg(pMeHg ~model(6), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom6
pMeHg_Yolom7 <- loadReg(pMeHg ~model(7), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom7
pMeHg_Yolom8 <- loadReg(pMeHg ~model(8), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom8
pMeHg_Yolom9 <- loadReg(pMeHg ~model(9), data = pMeHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pMeHg_Yolom9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(pMeHg_Yolom5,ann=FALSE)
title(main = "5_11452500_pMeHg_m5 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pMeHg_Yolom5,which = 2,set.up = F)
title(main = "5_11452500_pMeHg_m5 Residuals vs Fitted Values")
plot(pMeHg_Yolom5,which = 3,set.up = F)
title(main = "5_11452500_pMeHg_m5 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pMeHg_Yolom5,which = 4,set.up = F)
title(main = "5_11452500_pMeHg_m5 Correlogram of Samples")
plot(pMeHg_Yolom5,which = 5,set.up = F)
title(main="5_11452500_pMeHg_m5 Normal Discharge")
plot(pMeHg_Yolom5,which = 6,set.up = F)
title(main="5_11452500_pMeHg_m5 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

pMeHg_Yolo_load<-predLoad(pMeHg_Yolom5,YoloQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pMeHg_Yolo_load,"5_Yolo_pMeHg_m5_Flux_Annual.csv")
pMeHg_Yolo_load_day<-predLoad(pMeHg_Yolom5, YoloQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pMeHg_Yolo_load_day,"5_Yolo_pMeHg_m5_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
