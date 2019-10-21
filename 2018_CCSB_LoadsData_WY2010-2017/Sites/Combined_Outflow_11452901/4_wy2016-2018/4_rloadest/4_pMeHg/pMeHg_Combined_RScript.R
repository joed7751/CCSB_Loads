#pMeHg Combined Outlet (Spillway and Outlet) script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

pMeHg_Combined<-importRDB("pMeHg_CombinedR.txt")   
CombinedQ<-importRDB("CombinedQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

#***************************************************Do the following if you have censored data:*****************************************************
#(1)Create vector of detection limit

det<-as.numeric(array(.1,dim(pMeHg_Combined)[1]))

#(2)Create lcens object- as.lcens(values, detlim, censor.codes)
cen_data<-as.lcens(pMeHg_Combined$PpMeHg,det,pMeHg_Combined$RpMeHg)

#(3)Create input data frame with censored data object replacing last 2 columns
cen_frame<-data.frame(pMeHg_Combined[,1:3],cen_data)

#(4)Use this code to run models for censored data:

pMeHg_Combinedm1 <- loadReg(cen_data ~model(1), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm1
pMeHg_Combinedm2 <- loadReg(cen_data ~model(2), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm2
pMeHg_Combinedm3 <- loadReg(cen_data ~model(3), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm3
pMeHg_Combinedm4 <- loadReg(cen_data ~model(4), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm4
pMeHg_Combinedm5 <- loadReg(cen_data ~model(5), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm5
pMeHg_Combinedm6 <- loadReg(cen_data ~model(6), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm6
pMeHg_Combinedm7 <- loadReg(cen_data ~model(7), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm7
pMeHg_Combinedm8 <- loadReg(cen_data ~model(8), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm8
pMeHg_Combinedm9 <- loadReg(cen_data ~model(9), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
pMeHg_Combinedm9

#****************************Use this code to run models for uncensored data, comment out the censored data code(above):******************************

#pMeHg_Combinedm1 <- loadReg(pMeHg ~model(1), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm1
#pMeHg_Combinedm2 <- loadReg(pMeHg ~model(2), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm2
#pMeHg_Combinedm3 <- loadReg(pMeHg ~model(3), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm3
#pMeHg_Combinedm4 <- loadReg(pMeHg ~model(4), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm4
#pMeHg_Combinedm5 <- loadReg(pMeHg ~model(5), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm5
#pMeHg_Combinedm6 <- loadReg(pMeHg ~model(6), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm6
#pMeHg_Combinedm7 <- loadReg(pMeHg ~model(7), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm7
#pMeHg_Combinedm8 <- loadReg(pMeHg ~model(8), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm8
#pMeHg_Combinedm9 <- loadReg(pMeHg ~model(9), data = pMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#pMeHg_Combinedm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(pMeHg_Combinedm1,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm2,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm3,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm4,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm5,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm6,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm7,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm8,brief = FALSE, load.only = FALSE)
#print(pMeHg_Combinedm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (pMeHg_Combined m1-9)

plot(pMeHg_Combinedm1,ann=FALSE)
title(main = "4_114525901_pMeHg_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(pMeHg_Combinedm1,which = 2,set.up = F)
title(main = "4_114525901_pMeHg_m1 Residuals vs Fitted Values")
plot(pMeHg_Combinedm1,which = 3,set.up = F)
title(main = "4_114525901_pMeHg_m1 Assessing Heteroscedasticity") 
plot(pMeHg_Combinedm1,which = 4,set.up = F)
title(main = "4_114525901_pMeHg_m1 Correlogram of Samples")
plot(pMeHg_Combinedm1,which = 5,set.up = F)
title(main="4_114525901_pMeHg_m1 Normal Discharge")
plot(pMeHg_Combinedm1,which = 6,set.up = F)
title(main="4_114525901_pMeHg_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

pMeHg_Combined_load<-predLoad(pMeHg_Combinedm1,CombinedQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(pMeHg_Combined_load,"4_Combined_pMeHg_m1_Flux_Annual.csv")
pMeHg_Combined_load_day<-predLoad(pMeHg_Combinedm1, CombinedQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(pMeHg_Combined_load_day,"4_Combined_pMeHg_m1_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.