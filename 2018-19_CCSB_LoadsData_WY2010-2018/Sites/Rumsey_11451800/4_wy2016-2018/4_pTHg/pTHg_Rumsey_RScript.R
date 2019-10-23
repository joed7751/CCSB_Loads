#pTHg Rumsey script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pTHg_Rumsey<-importRDB("pTHg_RumseyR.txt")
RumseyQ<-importRDB("RumseyQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

pTHg_Rumseym1 <- loadReg(pTHg ~model(1), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym1
pTHg_Rumseym2 <- loadReg(pTHg ~model(2), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym2
pTHg_Rumseym3 <- loadReg(pTHg ~model(3), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym3
pTHg_Rumseym4 <- loadReg(pTHg ~model(4), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym4
pTHg_Rumseym5 <- loadReg(pTHg ~model(5), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym5
pTHg_Rumseym6 <- loadReg(pTHg ~model(6), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym6
pTHg_Rumseym7 <- loadReg(pTHg ~model(7), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym7
pTHg_Rumseym8 <- loadReg(pTHg ~model(8), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym8
pTHg_Rumseym9 <- loadReg(pTHg ~model(9), data = pTHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pTHg_Rumseym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(pTHg_Rumseym3,ann=FALSE)
title(main = "4_11451800_pTHg_m3 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pTHg_Rumseym3,which = 2,set.up = F)
title(main = "4_11451800_pTHg_m3 Residuals vs Fitted Values")
plot(pTHg_Rumseym3,which = 3,set.up = F)
title(main = "4_11451800_pTHg_m3 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pTHg_Rumseym3,which = 4,set.up = F)
title(main = "4_11451800_pTHg_m3 Correlogram of Samples")
plot(pTHg_Rumseym3,which = 5,set.up = F)
title(main="4_11451800_pTHg_m3 Normal Discharge")
plot(pTHg_Rumseym3,which = 6,set.up = F)
title(main="4_11451800_pTHg_m3 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

pTHg_Rumsey_load<-predLoad(pTHg_Rumseym3,RumseyQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pTHg_Rumsey_load,"4_Rumsey_pTHg_m3_Flux_Annual.csv")
pTHg_Rumsey_load_day<-predLoad(pTHg_Rumseym3, RumseyQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pTHg_Rumsey_load_day,"4_Rumsey_pTHg_m3_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
