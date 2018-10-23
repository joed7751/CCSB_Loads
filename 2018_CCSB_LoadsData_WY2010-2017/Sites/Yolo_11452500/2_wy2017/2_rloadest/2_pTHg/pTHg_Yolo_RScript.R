#pTHg Yolo script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pTHg_Yolo<-importRDB("pTHg_YoloR.txt")
YoloQ<-importRDB("YoloQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

pTHg_Yolom1 <- loadReg(pTHg ~model(1), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom1
pTHg_Yolom2 <- loadReg(pTHg ~model(2), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom2
pTHg_Yolom3 <- loadReg(pTHg ~model(3), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom3
pTHg_Yolom4 <- loadReg(pTHg ~model(4), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom4
pTHg_Yolom5 <- loadReg(pTHg ~model(5), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom5
pTHg_Yolom6 <- loadReg(pTHg ~model(6), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom6
pTHg_Yolom7 <- loadReg(pTHg ~model(7), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom7
pTHg_Yolom8 <- loadReg(pTHg ~model(8), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom8
pTHg_Yolom9 <- loadReg(pTHg ~model(9), data = pTHg_Yolo, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
pTHg_Yolom9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(pTHg_Yolom3,ann=FALSE)
title(main = "11452500_pTHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pTHg_Yolom3,which = 2,set.up = F)
title(main = "11452500_pTHg Residuals vs Fitted Values")
plot(pTHg_Yolom3,which = 3,set.up = F)
title(main = "11452500_pTHg Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pTHg_Yolom3,which = 4,set.up = F)
title(main = "11452500_pTHg Correlogram of Samples")
plot(pTHg_Yolom3,which = 5,set.up = F)
title(main="11452500_pTHg Normal Discharge")
plot(pTHg_Yolom3,which = 6,set.up = F)
title(main="11452500_pTHg Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

pTHg_Yolo_load<-predLoad(pTHg_Yolom3,YoloQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pTHg_Yolo_load,file.choose())
pTHg_Yolo_load_day<-predLoad(pTHg_Yolom3, YoloQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pTHg_Yolo_load_day,file.choose())

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
