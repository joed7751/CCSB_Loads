library(rloadest)
library(dataRetrieval)
library(ggplot2)
library(loadflex)
##############################################################################################
#Importing DATA for Cache Creek at Road102
##############################################################################################
# Interpolation data:Road102 wwTHg data grab sample observations

wwTHg_Road102 <- importRDB("Road102_wwTHg.txt")
wwTHg_Road102
### Reading in Flow Data
Road102Q <- importRDB("Road102_DailyQ.txt")
Road102Q$Dates <- with(Road102Q, as.POSIXct(paste(Dates), format= "%Y-%m-%d"))


Road102Q 

##############################################################################################
#Runing Load Models 
##############################################################################################

###Selecting best fit model###############

app1.lr <- selBestModel("wwTHg", data = wwTHg_Road102, 
                        flow = "Flow", dates = "Dates", conc.units="ng/L",
                        station="Cache Creek at Road102")
print(app1.lr)
#####################################################################################################
# Extract the fitted values look at the output and evaluate the AIC and SPPC stats, the SelBestModel will 
#always pick the model with the lowest AIC, but we need to look at the SPPC also if there is a modle with 
#a lower SPPC then we need to evaluate that model also and decide which model we will used based on the 
#p-values of the perameters and the Bias (BP, needs to be as lower that 25%, and the E value needs to be high)
###############################################################################################
#Run the recomended model, and any other model we might think is good based on the Bp and E values
###############################################################################################
wwTHg_Road102_lr1 <- loadReg(wwTHg ~ model(1), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr1

wwTHg_Road102_lr2 <- loadReg(wwTHg ~ model(2), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr2

wwTHg_Road102_lr3 <- loadReg(wwTHg ~ model(3), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr3

wwTHg_Road102_lr4 <- loadReg(wwTHg ~ model(4), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr4

wwTHg_Road102_lr5 <- loadReg(wwTHg ~ model(5), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr5

wwTHg_Road102_lr6 <- loadReg(wwTHg ~ model(6), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr6

wwTHg_Road102_lr7 <- loadReg(wwTHg ~ model(7), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr7

wwTHg_Road102_lr8 <- loadReg(wwTHg ~ model(8), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr8

wwTHg_Road102_lr9 <- loadReg(wwTHg ~ model(9), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
wwTHg_Road102_lr9
###############################################################################################
###############################################################################################
#Once we decide on the model we want to use we can run some diagnostic plots
#In order to look at some diagnostic plots that are only availble in  we need to run the model we 
#selected (we feel best fitted) outside of the loadflex routine (by rinignloadReg only)
#the most usful plots are plot 1, plot 2, and plot 5
###############################################################################################
###############################################################################################
wwTHg_Road102_lr1 <- loadReg(wwTHg ~ model(1), data=wwTHg_Road102,
                         flow="Flow", date="Dates", time.step="day", 
                         flow.units="cfs", conc.units="ng/L", load.units="kg",
                         station="Cache Creek at Road102")

setSweave("wwTHg_Road102_lr1_plot2",5,5)
plot(wwTHg_Road102_lr1,which=1,set.up=FALSE) #plot 1: Calibrated regression model
graphics.off()

setSweave("wwTHg_Road102_lr1_plot1",5,5)
plot(wwTHg_Road102_lr1,which=2,set.up=FALSE) #plot 2:Estimates of log load versus model residuals from AMLE regression
graphics.off()

setSweave("wwTHg_Road102_lr1_plot3",5,5)
plot(wwTHg_Road102_lr1,which=3,set.up=FALSE)# plot 3: Estimates of log load versus squared model residuals 
graphics.off()

setSweave("wwTHg_Road102_lr1_plot4",5,5)
plot(wwTHg_Road102_lr1,which=4,set.up=FALSE) # plot 4: Standardized Serial Correlation
graphics.off()

setSweave("wwTHg_Road102_lr1_plot5",5,5)
plot(wwTHg_Road102_lr1,which=5,set.up=FALSE) # plot 5: Normal probability plot for the model residuals (Quantile plot)
graphics.off()

#############################################################################################
#predict concntrations
###############################################################################################
preds_conc_lr1 <- predConc(wwTHg_Road102_lr1, Road102Q, by= "day", allow.incomplete= TRUE )
preds_conc_lr1
exportCSV(preds_conc_lr1, file.name = "Road102_wwTHg_conc_lr1_2010-2017.cvs")

###############################################################################################
##We plot the estimated unite conc Vs the obsereved unite conc in xls
###############################################################################################

###############################################################################################
#load calculations using selected model 
###############################################################################################

preds_Flux_lr1day<-predLoad(wwTHg_Road102_lr1,Road102Q,load.units="kg",by="day",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr1day
exportCSV(preds_Flux_lr1day, file.name = "wwTHgFlux_lr1_Day2010-2017.cvs")


preds_Flux_lr1WY<-predLoad(wwTHg_Road102_lr1,Road102Q,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr1WY
exportCSV(preds_Flux_lr1WY, file.name = "wwTHg_Flux_lr1_WY2010-2017.cvs")
