#pMeHg Rumsey script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pMeHg_Rumsey<-importRDB("pMeHg_RumseyR.txt")
RumseyQ<-importRDB("RumseyQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

#***************************************************Do the following if you have censored data:*****************************************************
#(1)Create vector of detection limit

det<-as.numeric(array(.1,dim(pMeHg_Rumsey)[1]))

#(2)Create lcens object- as.lcens(values, detlim, censor.codes)
cen_data<-as.lcens(pMeHg_Rumsey$PpMeHg,det,pMeHg_Rumsey$RpMeHg)

#(3)Create input data frame with censored data object replacing last 2 columns
cen_frame<-data.frame(pMeHg_Rumsey[,1:3],cen_data)

#(4)Use this code to run models for censored data:

pMeHg_Rumseym1 <- loadReg(cen_data ~model(1), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym1
pMeHg_Rumseym2 <- loadReg(cen_data ~model(2), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym2
pMeHg_Rumseym3 <- loadReg(cen_data ~model(3), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym3
pMeHg_Rumseym4 <- loadReg(cen_data ~model(4), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym4
pMeHg_Rumseym5 <- loadReg(cen_data ~model(5), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym5
pMeHg_Rumseym6 <- loadReg(cen_data ~model(6), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym6
pMeHg_Rumseym7 <- loadReg(cen_data ~model(7), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym7
pMeHg_Rumseym8 <- loadReg(cen_data ~model(8), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym8
pMeHg_Rumseym9 <- loadReg(cen_data ~model(9), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
pMeHg_Rumseym9

#****************************Use this code to run models for uncensored data, comment out the censored data code(above):******************************

#pMeHg_Rumseym1 <- loadReg(pMeHg ~model(1), data = test_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym1
#pMeHg_Rumseym2 <- loadReg(pMeHg ~model(2), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym2
#pMeHg_Rumseym3 <- loadReg(pMeHg ~model(3), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym3
#pMeHg_Rumseym4 <- loadReg(pMeHg ~model(4), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym4
#pMeHg_Rumseym5 <- loadReg(pMeHg ~model(5), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym5
#pMeHg_Rumseym6 <- loadReg(pMeHg ~model(6), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym6
#pMeHg_Rumseym7 <- loadReg(pMeHg ~model(7), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym7
#pMeHg_Rumseym8 <- loadReg(pMeHg ~model(8), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym8
#pMeHg_Rumseym9 <- loadReg(pMeHg ~model(9), data = pMeHg_Rumsey, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Rumsey")
#pMeHg_Rumseym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

plot(pMeHg_Rumseym1,ann=FALSE)
title(main = "4_11451800_pMeHg_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pMeHg_Rumseym1,which = 2,set.up = F)
title(main = "4_11451800_pMeHg_m1 Residuals vs Fitted Values")
plot(pMeHg_Rumseym1,which = 3,set.up = F)
title(main = "4_11451800_pMeHg_m1 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(pMeHg_Rumseym1,which = 4,set.up = F)
title(main = "4_11451800_pMeHg_m1 Correlogram of Samples")
plot(pMeHg_Rumseym1,which = 5,set.up = F)
title(main="4_11451800_pMeHg_m1 Normal Discharge")
plot(pMeHg_Rumseym1,which = 6,set.up = F)
title(main="4_11451800_pMeHg_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

pMeHg_Rumsey_load<-predLoad(pMeHg_Rumseym1,RumseyQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pMeHg_Rumsey_load,"4_Rumsey_pMeHg_m1_Flux_Annual.csv")
pMeHg_Rumsey_load_day<-predLoad(pMeHg_Rumseym1, RumseyQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pMeHg_Rumsey_load_day,"4_Rumsey_pMeHg_m1_Flux_Daily.csv")

#Lines 64 and 66 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 65 and 67 write the data frames to a .csv file.
#file.choose() lets the user select the location for the .csv files.
