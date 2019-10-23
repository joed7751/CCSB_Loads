#wwMeHg Combined Outlet (Spillway and Outlet) script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

wwMeHg_Combined<-importRDB("wwMeHg_CombinedR.txt")   
CombinedQ<-importRDB("CombinedQR.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

#***************************************************Do the following if you have censored data:*****************************************************
#(1)Create vector of detection limit

det<-as.numeric(array(.1,dim(wwMeHg_Combined)[1]))

#(2)Create lcens object- as.lcens(values, detlim, censor.codes)
cen_data<-as.lcens(wwMeHg_Combined$PwwMeHg,det,wwMeHg_Combined$RwwMeHg)

#(3)Create input data frame with censored data object replacing last 2 columns
cen_frame<-data.frame(wwMeHg_Combined[,1:3],cen_data)

#(4)Use this code to run models for censored data:

wwMeHg_Combinedm1 <- loadReg(cen_data ~model(1), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm1
wwMeHg_Combinedm2 <- loadReg(cen_data ~model(2), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm2
wwMeHg_Combinedm3 <- loadReg(cen_data ~model(3), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm3
wwMeHg_Combinedm4 <- loadReg(cen_data ~model(4), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm4
wwMeHg_Combinedm5 <- loadReg(cen_data ~model(5), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm5
wwMeHg_Combinedm6 <- loadReg(cen_data ~model(6), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm6
wwMeHg_Combinedm7 <- loadReg(cen_data ~model(7), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm7
wwMeHg_Combinedm8 <- loadReg(cen_data ~model(8), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm8
wwMeHg_Combinedm9 <- loadReg(cen_data ~model(9), data = cen_frame, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
wwMeHg_Combinedm9

#****************************Use this code to run models for uncensored data, comment out the censored data code(above):******************************

#wwMeHg_Combinedm1 <- loadReg(wwMeHg ~model(1), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm1
#wwMeHg_Combinedm2 <- loadReg(wwMeHg ~model(2), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm2
#wwMeHg_Combinedm3 <- loadReg(wwMeHg ~model(3), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm3
#wwMeHg_Combinedm4 <- loadReg(wwMeHg ~model(4), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm4
#wwMeHg_Combinedm5 <- loadReg(wwMeHg ~model(5), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm5
#wwMeHg_Combinedm6 <- loadReg(wwMeHg ~model(6), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm6
#wwMeHg_Combinedm7 <- loadReg(wwMeHg ~model(7), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm7
#wwMeHg_Combinedm8 <- loadReg(wwMeHg ~model(8), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm8
#wwMeHg_Combinedm9 <- loadReg(wwMeHg ~model(9), data = wwMeHg_Combined, flow="Flow", dates = "Dates" ,conc.units="ng/L" , station = "CCSB-Combined")
#wwMeHg_Combinedm9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(wwMeHg_Combinedm1,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm2,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm3,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm4,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm5,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm6,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm7,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm8,brief = FALSE, load.only = FALSE)
#print(wwMeHg_Combinedm9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (wwMeHg_Combined m1-9)

plot(wwMeHg_Combinedm1,ann=FALSE)
title(main = "4_114525901_wwMeHg_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(wwMeHg_Combinedm1,which = 2,set.up = F)
title(main = "4_114525901_wwMeHg_m1 Residuals vs Fitted Values")
plot(wwMeHg_Combinedm1,which = 3,set.up = F)
title(main = "4_114525901_wwMeHg_m1 Assessing Heteroscedasticity") 
plot(wwMeHg_Combinedm1,which = 4,set.up = F)
title(main = "4_114525901_wwMeHg_m1 Correlogram of Samples")
plot(wwMeHg_Combinedm1,which = 5,set.up = F)
title(main="4_114525901_wwMeHg_m1 Normal Discharge")
plot(wwMeHg_Combinedm1,which = 6,set.up = F)
title(main="4_114525901_wwMeHg_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

#Change the model number in lines 77 and 79 before running the loads predictions. This should be the best model. 

wwMeHg_Combined_load<-predLoad(wwMeHg_Combinedm1,CombinedQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(wwMeHg_Combined_load,"4_Combined_wwMeHg_m1_Flux_Annual.csv")
wwMeHg_Combined_load_day<-predLoad(wwMeHg_Combinedm1, CombinedQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(wwMeHg_Combined_load_day,"4_Combined_wwMeHg_m1_Flux_Daily.csv")

#Lines 77 and 79 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 78 and 80 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.