library(rloadest)
library(dataRetrieval)
library(ggplot2)
library(loadflex)
##############################################################################################
#Importing DATA for Cache Creek at CombSpillWay
##############################################################################################
# Interpolation data:CombSpillWay wwTHg data grab sample observations

wwTHg_CombSpillWay <- importRDB("SN_wwTHg.txt")
wwTHg_CombSpillWay
### Reading in Flow Data
CombSpillWayQ <- importRDB("SouthQDaily_2013_2019.txt")
CombSpillWayQ$Dates <- with(CombSpillWayQ, as.POSIXct(paste(Dates), format= "%Y-%m-%d"))


CombSpillWayQ 

##############################################################################################
#Runing Load Models 
##############################################################################################

###Selecting best fit model###############

app1.lr <- selBestModel("wwTHg", data = wwTHg_CombSpillWay, 
                        flow = "Flow", dates = "Dates", conc.units="ng/L",
                        station="Cache Creek at CombSpillWay")
print(app1.lr)
#####################################################################################################
# Extract the fitted values look at the output and evaluate the AIC and SPPC stats, the SelBestModel will 
#always pick the model with the lowest AIC, but we need to look at the SPPC also if there is a modle with 
#a lower SPPC then we need to evaluate that model also and decide which model we will used based on the 
#p-values of the perameters and the Bias (BP, needs to be as lower that 25%, and the E value needs to be high)
###############################################################################################
#Run the recomended model, and any other model we might think is good based on the Bp and E values
###############################################################################################
wwTHg_CombSpillWay_lr1 <- loadReg(wwTHg ~ model(1), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr1

wwTHg_CombSpillWay_lr2 <- loadReg(wwTHg ~ model(2), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr2

wwTHg_CombSpillWay_lr3 <- loadReg(wwTHg ~ model(3), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr3

wwTHg_CombSpillWay_lr4 <- loadReg(wwTHg ~ model(4), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr4

wwTHg_CombSpillWay_lr5 <- loadReg(wwTHg ~ model(5), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr5

wwTHg_CombSpillWay_lr6 <- loadReg(wwTHg ~ model(6), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr6

wwTHg_CombSpillWay_lr7 <- loadReg(wwTHg ~ model(7), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr7

wwTHg_CombSpillWay_lr8 <- loadReg(wwTHg ~ model(8), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr8

wwTHg_CombSpillWay_lr9 <- loadReg(wwTHg ~ model(9), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwTHg_CombSpillWay_lr9

###############################################################################################
###############################################################################################
#Once we decide on the model we want to use we can run some diagnostic plots
#In order to look at some diagnostic plots that are only availble in  we need to run the model we 
#selected (we feel best fitted) outside of the loadflex routine (by rinignloadReg only)
#the most usful plots are plot 1, plot 2, and plot 5
###############################################################################################
###############################################################################################
wwTHg_CombSpillWay_lr5 <- loadReg(wwTHg ~ model(5), data=wwTHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day", 
                         flow.units="cfs", conc.units="ng/L", load.units="kg",
                         station="Cache Creek at CombSpillWay")

setSweave("wwTHg_CombSpillWay_lr5_plot2",5,5)
plot(wwTHg_CombSpillWay_lr5,which=1,set.up=FALSE) #plot 1: Calibrated regression model
graphics.off()

setSweave("wwTHg_CombSpillWay_lr5_plot1",5,5)
plot(wwTHg_CombSpillWay_lr5,which=2,set.up=FALSE) #plot 2:Estimates of log load versus model residuals from AMLE regression
graphics.off()

setSweave("wwTHg_CombSpillWay_lr5_plot3",5,5)
plot(wwTHg_CombSpillWay_lr5,which=3,set.up=FALSE)# plot 3: Estimates of log load versus squared model residuals 
graphics.off()

setSweave("wwTHg_CombSpillWay_lr5_plot4",5,5)
plot(wwTHg_CombSpillWay_lr5,which=4,set.up=FALSE) # plot 4: Standardized Serial Correlation
graphics.off()

setSweave("wwTHg_CombSpillWay_lr5_plot5",5,5)
plot(wwTHg_CombSpillWay_lr5,which=5,set.up=FALSE) # plot 5: Normal probability plot for the model residuals (Quantile plot)
graphics.off()

#############################################################################################
#predict concntrations
###############################################################################################
preds_conc_lr5 <- predConc(wwTHg_CombSpillWay_lr5, CombSpillWayQ, by= "day", allow.incomplete= TRUE )
preds_conc_lr5
exportCSV(preds_conc_lr5, file.name = "CombSpillWay_wwTHg_conc_lr5_2013-2019.cvs")

###############################################################################################
##We plot the estimated unite conc Vs the obsereved unite conc in xls
###############################################################################################

###############################################################################################
#load calculations using selected model 
###############################################################################################

preds_Flux_lr5day<-predLoad(wwTHg_CombSpillWay_lr5,CombSpillWayQ,load.units="kg",by="day",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr5day
exportCSV(preds_Flux_lr5day, file.name = "CombSpillWay_wwTHgFlux_lr5_Day2013-2019.cvs")


preds_Flux_lr5WY<-predLoad(wwTHg_CombSpillWay_lr5,CombSpillWayQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr5WY
exportCSV(preds_Flux_lr5WY, file.name = "CombSpillWay_wwTHg_Flux_lr5_WY2013-2019.cvs")
