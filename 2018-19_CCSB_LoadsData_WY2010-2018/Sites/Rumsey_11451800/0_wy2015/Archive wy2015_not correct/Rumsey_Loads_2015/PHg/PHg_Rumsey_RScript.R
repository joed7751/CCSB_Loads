#PHg Rumsey script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

#Library calls, when they are run, reference the packages that you need. 
#This saves from selecting the 15 packages each time this project is opened.

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

PHg_Rumsey<-importRDB("PHg_RumseyR.txt")
RumseyQ<-importRDB("RumseyQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the particulate total mercury data and the daily flow data into the script.

PHg_Rumseym1 <- loadReg(PHg ~model(1), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym1
PHg_Rumseym2 <- loadReg(PHg ~model(2), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym2
PHg_Rumseym3 <- loadReg(PHg ~model(3), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym3
PHg_Rumseym4 <- loadReg(PHg ~model(4), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym4
PHg_Rumseym5 <- loadReg(PHg ~model(5), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym5
PHg_Rumseym6 <- loadReg(PHg ~model(6), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym6
PHg_Rumseym7 <- loadReg(PHg ~model(7), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym7
PHg_Rumseym8 <- loadReg(PHg ~model(8), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym8
PHg_Rumseym9 <- loadReg(PHg ~model(9), data = PHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Yolo")
PHg_Rumseym9

#These lists are created using the loadReg function.
#[A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.] 
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(PHg_Rumseym3,ann=FALSE)
title(main = "11451800_PHg Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(PHg_Rumseym3,which = 2,set.up = F)
title(main = "11451800_PHg Residuals vs Fitted Values")
plot(PHg_Rumseym3,which = 3,set.up = F)
title(main = "11451800_PHg Assessing Heteroscedasticity")
plot(PHg_Rumseym3,which = 4,set.up = F)
title(main = "11451800_PHg Correlogram of Samples")
plot(PHg_Rumseym3,which = 5,set.up = F)
title(main="11451800_PHg Normal Discharge")
plot(PHg_Rumseym3,which = 6,set.up = F)
title(main="11451800_PHg Box Plot of Loads")

#Changed "11452900" to "11451800".(8/21/18, slrose)
#These functions plot the data using the chosen best model and add a title and labels to the plot.

PHg_Rumsey_load<-predLoad(PHg_Rumseym3,RumseyQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(PHg_Rumsey_load,file.choose())
PHg_Rumsey_load_day<-predLoad(PHg_Rumseym3, RumseyQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(PHg_Rumsey_load_day,file.choose())

#Lines 71 and 73 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
