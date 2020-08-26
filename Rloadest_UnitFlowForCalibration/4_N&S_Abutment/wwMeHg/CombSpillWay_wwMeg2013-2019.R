library(rloadest)
library(dataRetrieval)
library(ggplot2)
library(loadflex)
##############################################################################################
#Importing DATA for Cache Creek at CombSpillWay
##############################################################################################
# Interpolation data:CombSpillWay wwMeHg data grab sample observations

wwMeHg_CombSpillWay <- importRDB("SN_wwMeHg.txt")
wwMeHg_CombSpillWay
### Reading in Flow Data
CombSpillWayQ <- importRDB("SouthQDaily_2013_2019.txt")
CombSpillWayQ$Dates <- with(CombSpillWayQ, as.POSIXct(paste(Dates), format= "%Y-%m-%d"))


CombSpillWayQ 

##############################################################################################
#Runing Load Models 
##############################################################################################

###Selecting best fit model###############

app1.lr <- selBestModel("wwMeHg", data = wwMeHg_CombSpillWay, 
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
wwMeHg_CombSpillWay_lr1 <- loadReg(wwMeHg ~ model(1), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr1

wwMeHg_CombSpillWay_lr2 <- loadReg(wwMeHg ~ model(2), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr2

wwMeHg_CombSpillWay_lr3 <- loadReg(wwMeHg ~ model(3), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr3

wwMeHg_CombSpillWay_lr4 <- loadReg(wwMeHg ~ model(4), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr4

wwMeHg_CombSpillWay_lr5 <- loadReg(wwMeHg ~ model(5), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr5

wwMeHg_CombSpillWay_lr6 <- loadReg(wwMeHg ~ model(6), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr6

wwMeHg_CombSpillWay_lr7 <- loadReg(wwMeHg ~ model(7), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr7

wwMeHg_CombSpillWay_lr8 <- loadReg(wwMeHg ~ model(8), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr8

wwMeHg_CombSpillWay_lr9 <- loadReg(wwMeHg ~ model(9), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at CombSpillWay")
wwMeHg_CombSpillWay_lr9

###############################################################################################
###############################################################################################
#Once we decide on the model we want to use we can run some diagnostic plots
#In order to look at some diagnostic plots that are only availble in  we need to run the model we 
#selected (we feel best fitted) outside of the loadflex routine (by rinignloadReg only)
#the most usful plots are plot 1, plot 2, and plot 5
###############################################################################################
###############################################################################################
wwMeHg_CombSpillWay_lr2 <- loadReg(wwMeHg ~ model(2), data=wwMeHg_CombSpillWay,
                         flow="Flow", date="Dates", time.step="day", 
                         flow.units="cfs", conc.units="ng/L", load.units="kg",
                         station="Cache Creek at CombSpillWay")

setSweave("wwMeHg_CombSpillWay_lr2_plot2",5,5)
plot(wwMeHg_CombSpillWay_lr2,which=1,set.up=FALSE) #plot 1: Calibrated regression model
graphics.off()

setSweave("wwMeHg_CombSpillWay_lr2_plot1",5,5)
plot(wwMeHg_CombSpillWay_lr2,which=2,set.up=FALSE) #plot 2:Estimates of log load versus model residuals from AMLE regression
graphics.off()

setSweave("wwMeHg_CombSpillWay_lr2_plot3",5,5)
plot(wwMeHg_CombSpillWay_lr2,which=3,set.up=FALSE)# plot 3: Estimates of log load versus squared model residuals 
graphics.off()

setSweave("wwMeHg_CombSpillWay_lr2_plot4",5,5)
plot(wwMeHg_CombSpillWay_lr2,which=4,set.up=FALSE) # plot 4: Standardized Serial Correlation
graphics.off()

setSweave("wwMeHg_CombSpillWay_lr2_plot5",5,5)
plot(wwMeHg_CombSpillWay_lr2,which=5,set.up=FALSE) # plot 5: Normal probability plot for the model residuals (Quantile plot)
graphics.off()

#############################################################################################
#predict concntrations
###############################################################################################
preds_conc_lr2 <- predConc(wwMeHg_CombSpillWay_lr2, CombSpillWayQ, by= "day", allow.incomplete= TRUE )
preds_conc_lr2
exportCSV(preds_conc_lr2, file.name = "CombSpillWay_wwMeHg_conc_lr2_2013-2019.cvs")

###############################################################################################
##We plot the estimated unite conc Vs the obsereved unite conc in xls
###############################################################################################

###############################################################################################
#load calculations using selected model 
###############################################################################################

preds_Flux_lr2day<-predLoad(wwMeHg_CombSpillWay_lr2,CombSpillWayQ,load.units="kg",by="day",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr2day
exportCSV(preds_Flux_lr2day, file.name = "CombSpillWay_wwMeHgFlux_lr2_Day2013-2019.cvs")


preds_Flux_lr2WY<-predLoad(wwMeHg_CombSpillWay_lr2,CombSpillWayQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr2WY
exportCSV(preds_Flux_lr2WY, file.name = "CombSpillWay_wwMeHg_Flux_lr2_WY2013-2019.cvs")
