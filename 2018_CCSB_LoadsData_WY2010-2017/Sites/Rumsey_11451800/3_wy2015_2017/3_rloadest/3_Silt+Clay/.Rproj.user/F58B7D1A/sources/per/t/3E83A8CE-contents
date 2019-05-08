#Silt+Clay Rumsey script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

SiltClay_Rumsey<-importRDB("SiltClay_RumseyR_A.txt")
RumseyQ<-importRDB("RumseyQR_A.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

SiltClay_Rumseym1 <- loadReg(Silt.Clay ~model(1), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym1
SiltClay_Rumseym2 <- loadReg(Silt.Clay ~model(2), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym2
SiltClay_Rumseym3 <- loadReg(Silt.Clay ~model(3), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym3
SiltClay_Rumseym4 <- loadReg(Silt.Clay ~model(4), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym4
SiltClay_Rumseym5 <- loadReg(Silt.Clay ~model(5), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym5
SiltClay_Rumseym6 <- loadReg(Silt.Clay ~model(6), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym6
SiltClay_Rumseym7 <- loadReg(Silt.Clay ~model(7), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym7
SiltClay_Rumseym8 <- loadReg(Silt.Clay ~model(8), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym8
SiltClay_Rumseym9 <- loadReg(Silt.Clay ~model(9), data = SiltClay_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
SiltClay_Rumseym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(SiltClay_Rumseym1,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym2,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym3,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym4,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym5,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym6,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym7,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym8,brief = FALSE, load.only = FALSE)
#print(SiltClay_Rumseym9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (SiltClay_Rumseym1-9)

plot(SiltClay_Rumseym3,ann=FALSE)
title(main = "11451800_A_Silt+Clay_m3 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(SiltClay_Rumseym3,which = 2,set.up = F)
title(main = "11451800_A_Silt+Clay_m3 Residuals vs Fitted Values")
plot(SiltClay_Rumseym3,which = 3,set.up = F)
title(main = "11451800_A_Silt+Clay_m3 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(SiltClay_Rumseym3,which = 4,set.up = F)
title(main = "11451800_A_Silt+Clay_m3 Correlogram of Samples")
plot(SiltClay_Rumseym3,which = 5,set.up = F)
title(main="11451800_A_Silt+Clay_m3 Normal Discharge")
plot(SiltClay_Rumseym3,which = 6,set.up = F)
title(main="11451800_A_Silt+Clay_m3 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

SiltClay_Rumsey_load<-predLoad(SiltClay_Rumseym3,RumseyQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(SiltClay_Rumsey_load,"3_Rumsey_A_Silt+Clay_m3_Flux_Annual.csv")
SiltClay_Rumsey_load_day<-predLoad(SiltClay_Rumseym3, RumseyQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(SiltClay_Rumsey_load_day,"3_Rumsey_A_Silt+Clay_m3_Flux_Daily.csv")

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.