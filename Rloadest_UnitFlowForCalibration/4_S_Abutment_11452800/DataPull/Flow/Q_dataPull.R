library(loadflex)
library(rloadest)
library(dataRetrieval)


###################################################
#Pulling Flow Data
###################################################
siteNumber <-"11452800" #South Abutment# 
parameterCd <- "00060" # Discharge
SouthQ <- readNWISdv(siteNumber, parameterCd,
                           "2009-10-01", "2019-09-30") 
SouthQ <- renameNWISColumns(SouthQ)
SouthQ <- SouthQ[c("Date","Flow")] #pulling out only the columns we need
colnames(SouthQ) = c("Dates", "Flow")        #changing columns name
SouthQ <- subset(SouthQ, Dates < as.POSIXct("2019-10-01 00:00:00", tz="EST5EDT"))
exportCSV(SouthQ, file.name = "SouthQDaily_2010_2019.cvs")
SouthQ

South_UQ <- readNWISuv(siteNumber, parameterCd,
                       "2009-10-01", "2019-09-30") 
South_UQ <- renameNWISColumns(South_UQ)
South_UQ <- South_UQ[c("dateTime","Flow_Inst")] #pulling out only the columns we need
colnames(South_UQ) = c("Dates", "Flow")        #changing columns name
SouthQ <- subset(South_UQ, Dates < as.POSIXct("2019-10-01 00:00:00", tz="EST5EDT"))
exportCSV(South_UQ, file.name = "SouthQ_Unit_2010_2019.cvs")
South_UQ
