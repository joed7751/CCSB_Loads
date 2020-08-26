library(rloadest)
library(dataRetrieval)
library(ggplot2)
library(loadflex)
##############################################################################################
#Importing DATA for Cache Creek at Road102
##############################################################################################
# Interpolation data:Road102 fTHg data grab sample observations

fTHg_Road102 <- importRDB("Road102_fTHg.txt")
fTHg_Road102
### Reading in Flow Data
Road102Q <- importRDB("Road102_DailyQ.txt")
Road102Q$Dates <- with(Road102Q, as.POSIXct(paste(Dates), format= "%Y-%m-%d"))


Road102Q 

##############################################################################################
#Runing Load Models 
##############################################################################################

###Selecting best fit model###############

app1.lr <- selBestModel("fTHg", data = fTHg_Road102, 
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
fTHg_Road102_lr1 <- loadReg(fTHg ~ model(1), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr1

fTHg_Road102_lr2 <- loadReg(fTHg ~ model(2), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr2

fTHg_Road102_lr3 <- loadReg(fTHg ~ model(3), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr3

fTHg_Road102_lr4 <- loadReg(fTHg ~ model(4), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr4

fTHg_Road102_lr5 <- loadReg(fTHg ~ model(5), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr5

fTHg_Road102_lr6 <- loadReg(fTHg ~ model(6), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr6

fTHg_Road102_lr7 <- loadReg(fTHg ~ model(7), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr7

fTHg_Road102_lr8 <- loadReg(fTHg ~ model(8), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr8

fTHg_Road102_lr9 <- loadReg(fTHg ~ model(9), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Road102")
fTHg_Road102_lr9
###############################################################################################
###############################################################################################
#Once we decide on the model we want to use we can run some diagnostic plots
#In order to look at some diagnostic plots that are only availble in  we need to run the model we 
#selected (we feel best fitted) outside of the loadflex routine (by rinignloadReg only)
#the most usful plots are plot 1, plot 2, and plot 5
###############################################################################################
###############################################################################################
fTHg_Road102_lr4 <- loadReg(fTHg ~ model(4), data=fTHg_Road102,
                         flow="Flow", date="Dates", time.step="day", 
                         flow.units="cfs", conc.units="ng/L", load.units="kg",
                         station="Cache Creek at Road102")

setSweave("fTHg_Road102_lr4_plot2",5,5)
plot(fTHg_Road102_lr4,which=1,set.up=FALSE) #plot 1: Calibrated regression model
graphics.off()

setSweave("fTHg_Road102_lr4_plot1",5,5)
plot(fTHg_Road102_lr4,which=2,set.up=FALSE) #plot 2:Estimates of log load versus model residuals from AMLE regression
graphics.off()

setSweave("fTHg_Road102_lr4_plot3",5,5)
plot(fTHg_Road102_lr4,which=3,set.up=FALSE)# plot 3: Estimates of log load versus squared model residuals 
graphics.off()

setSweave("fTHg_Road102_lr4_plot4",5,5)
plot(fTHg_Road102_lr4,which=4,set.up=FALSE) # plot 4: Standardized Serial Correlation
graphics.off()

setSweave("fTHg_Road102_lr4_plot5",5,5)
plot(fTHg_Road102_lr4,which=5,set.up=FALSE) # plot 5: Normal probability plot for the model residuals (Quantile plot)
graphics.off()

#############################################################################################
#predict concntrations
###############################################################################################
preds_conc_lr4 <- predConc(fTHg_Road102_lr4, Road102Q, by= "day", allow.incomplete= TRUE )
preds_conc_lr4
exportCSV(preds_conc_lr4, file.name = "Road102_fTHg_conc_lr4_2010-2017.cvs")

###############################################################################################
##We plot the estimated unite conc Vs the obsereved unite conc in xls
###############################################################################################

###############################################################################################
#load calculations using selected model 
###############################################################################################

preds_Flux_lr4day<-predLoad(fTHg_Road102_lr4,Road102Q,load.units="kg",by="day",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr4day
exportCSV(preds_Flux_lr4day, file.name = "fTHgFlux_lr4_Day2010-2017.cvs")


preds_Flux_lr4WY<-predLoad(fTHg_Road102_lr4,Road102Q,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr4WY
exportCSV(preds_Flux_lr4WY, file.name = "fTHg_Flux_lr4_WY2010-2017.cvs")
