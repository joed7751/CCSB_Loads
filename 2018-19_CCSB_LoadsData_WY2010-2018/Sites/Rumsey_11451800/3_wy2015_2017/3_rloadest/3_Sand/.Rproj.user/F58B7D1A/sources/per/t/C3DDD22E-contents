#Sand Rumsey script for retrieving loads models stats (the stats are used to select the best model for this constituent at this site) and loads predictions.

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

Sand_Rumsey<-importRDB("Sand_RumseyR_B.txt")
RumseyQ<-importRDB("RumseyQR_B.txt")

#These data frames are created by the function importRDB. 
#The calls above bring the constituent data and the daily flow data into the script.

Sand_Rumseym1 <- loadReg(Sand ~model(1), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym1
Sand_Rumseym2 <- loadReg(Sand ~model(2), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym2
Sand_Rumseym3 <- loadReg(Sand ~model(3), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym3
Sand_Rumseym4 <- loadReg(Sand ~model(4), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym4
Sand_Rumseym5 <- loadReg(Sand ~model(5), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym5
Sand_Rumseym6 <- loadReg(Sand ~model(6), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym6
Sand_Rumseym7 <- loadReg(Sand ~model(7), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym7
Sand_Rumseym8 <- loadReg(Sand ~model(8), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym8
Sand_Rumseym9 <- loadReg(Sand ~model(9), data = Sand_Rumsey, flow="Flow", dates = "Dates" ,conc.units="mg/L" , station = "CCSB-Yolo")
Sand_Rumseym9

#These objects of class "loadReg" are created.
#A list in R allows you to gather a variety of objects under one name (that is, the name of the list) in an ordered way. 
#These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
#When the models are run (m1-m9), the output will be in the console. These are the stats used to select the best model. 

#print(Sand_Rumseym1,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym2,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym3,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym4,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym5,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym6,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym7,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym8,brief = FALSE, load.only = FALSE)
#print(Sand_Rumseym9,brief = FALSE, load.only = FALSE)
#Commenting these out. These provide some explanations of the data in a longer form. Brief results are printed to console (Sand_Rumseym1-9)

plot(Sand_Rumseym1,ann=FALSE)
title(main = "11451800_B_Sand_m1 Response vs Fitted Values",xlab = "Fitted Values",ylab = "Response Values")
plot(Sand_Rumseym1,which = 2,set.up = F)
title(main = "11451800_B_Sand_m1 Residuals vs Fitted Values")
plot(Sand_Rumseym1,which = 3,set.up = F)
title(main = "11451800_B_Sand_m1 Assessing Heteroscedasticity") #Add "of Residuals"?
plot(Sand_Rumseym1,which = 4,set.up = F)
title(main = "11451800_B_Sand_m1 Correlogram of Samples")
plot(Sand_Rumseym1,which = 5,set.up = F)
title(main="11451800_B_Sand_m1 Normal Discharge")
plot(Sand_Rumseym1,which = 6,set.up = F)
title(main="11451800_B_Sand_m1 Box Plot of Loads")

#These functions plot the data using the chosen best model and add a title and labels to the plot.

Sand_Rumsey_load<-predLoad(Sand_Rumseym1,RumseyQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
write.csv(Sand_Rumsey_load,"3_Rumsey_B_Sand_m1_Flux_Annual.csv")
Sand_Rumsey_load_day<-predLoad(Sand_Rumseym1, RumseyQ,load.units = "kg",by="day",allow.incomplete = TRUE,conf.int = 0.90,print = TRUE)
write.csv(Sand_Rumsey_load_day,"3_Rumsey_B_Sand_m1_Flux_Daily.csv")

#Lines 75 and 77 create data frames that use the function predLoad. 
#Description of predLoad: Estimate loads from a rating-curve model from loadReg for a new data frame, aggregating the loads by specified time periods.
#Lines 76 and 78 write the data frames to a .csv file. Important note: The file must be intentionally saved as a CSV file- type ".csv" at the end when prompted.
#file.choose() lets the user select the location for the .csv files.