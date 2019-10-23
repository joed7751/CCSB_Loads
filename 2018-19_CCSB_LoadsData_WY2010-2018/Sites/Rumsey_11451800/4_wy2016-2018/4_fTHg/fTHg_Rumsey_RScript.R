#fTHg Rumsey script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

fTHg_Rumsey<-importRDB("fTHg_RumseyR.txt")
RumseyQ<-importRDB("RumseyQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

fTHg_Rumseym1 <- loadReg(fTHg ~model(1), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym1
fTHg_Rumseym2 <- loadReg(fTHg ~model(2), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym2
fTHg_Rumseym3 <- loadReg(fTHg ~model(3), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym3
fTHg_Rumseym4 <- loadReg(fTHg ~model(4), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym4
fTHg_Rumseym5 <- loadReg(fTHg ~model(5), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym5
fTHg_Rumseym6 <- loadReg(fTHg ~model(6), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym6
fTHg_Rumseym7 <- loadReg(fTHg ~model(7), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym7
fTHg_Rumseym8 <- loadReg(fTHg ~model(8), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym8
fTHg_Rumseym9 <- loadReg(fTHg ~model(9), data = fTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
fTHg_Rumseym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(fTHg_Rumseym1,ann=FALSE)
title(main = "4_11451800_fTHg_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(fTHg_Rumseym1,which = 2,set.up = F)
title(main = "4_11451800_fTHg_m1 Residuals vs Fitted Values")
plot(fTHg_Rumseym1,which = 3,set.up = F)
title(main = "4_11451800_fTHg_m1 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(fTHg_Rumseym1,which = 4,set.up = F)
title(main = "4_11451800_fTHg_m1 Correlogram of Samples")
plot(fTHg_Rumseym1,which = 5,set.up = F)
title(main="4_11451800_fTHg_m1 Normal Discharge")
plot(fTHg_Rumseym1,which = 6,set.up = F)
title(main="4_11451800_fTHg_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

fTHg_Rumsey_load<-predLoad(fTHg_Rumseym1,RumseyQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(fTHg_Rumsey_load,"4_Rumsey_fTHg_m1_Flux_Annual.csv")
fTHg_Rumsey_load_day<-predLoad(fTHg_Rumseym1, RumseyQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(fTHg_Rumsey_load_day,"4_Rumsey_fTHg_m1_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
