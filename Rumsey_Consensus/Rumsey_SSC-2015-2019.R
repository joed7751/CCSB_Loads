library(rloadest)
library(dataRetrieval)
library(ggplot2)
library(loadflex)
##############################################################################################
#Importing DATA for Cache Creek at Rumsey
##############################################################################################
# Interpolation data:Rumsey SSC data grab sample observations

SSC_Rumsey <- importRDB("Rum_SSC.txt")
SSC_Rumsey
### Reading in Flow Data
RumseyQ <- importRDB("Rumsey_QDaily_2015_2019.txt")
RumseyQ$Dates <- with(RumseyQ, as.POSIXct(paste(Dates), format= "%Y-%m-%d"))


RumseyQ 

##############################################################################################
#Runing Load Models 
##############################################################################################

###Selecting best fit model###############

app1.lr <- selBestModel("SSC", data = SSC_Rumsey, 
                        flow = "Flow", dates = "Dates", conc.units="mg/L",
                        station="Cache Creek at Rumsey")
print(app1.lr)
#####################################################################################################
# Extract the fitted values look at the output and evaluate the AIC and SPPC stats, the SelBestModel will 
#always pick the model with the lowest AIC, but we need to look at the SPPC also if there is a modle with 
#a lower SPPC then we need to evaluate that model also and decide which model we will used based on the 
#p-values of the perameters and the Bias (BP, needs to be as lower that 25%, and the E value needs to be high)
###############################################################################################
#Run the recomended model, and any other model we might think is good based on the Bp and E values
###############################################################################################
SSC_Rumsey_lr1 <- loadReg(SSC ~ model(1), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr1

SSC_Rumsey_lr2 <- loadReg(SSC ~ model(2), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr2

SSC_Rumsey_lr3 <- loadReg(SSC ~ model(3), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr3

SSC_Rumsey_lr4 <- loadReg(SSC ~ model(4), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr4

SSC_Rumsey_lr5 <- loadReg(SSC ~ model(5), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr5

SSC_Rumsey_lr6 <- loadReg(SSC ~ model(6), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr6

SSC_Rumsey_lr7 <- loadReg(SSC ~ model(7), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr7

SSC_Rumsey_lr8 <- loadReg(SSC ~ model(8), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr8

SSC_Rumsey_lr9 <- loadReg(SSC ~ model(9), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="mg/L",load.units="kg",
                         station="Cache Creek at Rumsey")
SSC_Rumsey_lr9

###############################################################################################
###############################################################################################
#Once we decide on the model we want to use we can run some diagnostic plots
#In order to look at some diagnostic plots that are only availble in  we need to run the model we 
#selected (we feel best fitted) outside of the loadflex routine (by rinignloadReg only)
#the most usful plots are plot 1, plot 2, and plot 5
###############################################################################################
###############################################################################################
SSC_Rumsey_lr4 <- loadReg(SSC ~ model(4), data=SSC_Rumsey,
                         flow="Flow", date="Dates", time.step="day", 
                         flow.units="cfs", conc.units="mg/L", load.units="kg",
                         station="Cache Creek at Rumsey")

setSweave("SSC_Rumsey_lr4_plot2",5,5)
plot(SSC_Rumsey_lr4,which=1,set.up=FALSE) #plot 1: Calibrated regression model
graphics.off()

setSweave("SSC_Rumsey_lr4_plot1",5,5)
plot(SSC_Rumsey_lr4,which=2,set.up=FALSE) #plot 2:Estimates of log load versus model residuals from AMLE regression
graphics.off()

setSweave("SSC_Rumsey_lr4_plot3",5,5)
plot(SSC_Rumsey_lr4,which=3,set.up=FALSE)# plot 3: Estimates of log load versus squared model residuals 
graphics.off()

setSweave("SSC_Rumsey_lr4_plot4",5,5)
plot(SSC_Rumsey_lr4,which=4,set.up=FALSE) # plot 4: Standardized Serial Correlation
graphics.off()

setSweave("SSC_Rumsey_lr4_plot5",5,5)
plot(SSC_Rumsey_lr4,which=5,set.up=FALSE) # plot 5: Normal probability plot for the model residuals (Quantile plot)
graphics.off()

#############################################################################################
#predict concntrations
###############################################################################################
preds_conc_lr4 <- predConc(SSC_Rumsey_lr4, RumseyQ, by= "day", allow.incomplete= TRUE )
preds_conc_lr4
exportCSV(preds_conc_lr4, file.name = "Rumsey_SSC_conc_lr4_2015-2019.cvs")

###############################################################################################
##We plot the estimated unite conc Vs the obsereved unite conc in xls
###############################################################################################

###############################################################################################
#load calculations using selected model 
###############################################################################################

preds_Flux_lr4day<-predLoad(SSC_Rumsey_lr4,RumseyQ,load.units="kg",by="day",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr4day
exportCSV(preds_Flux_lr4day, file.name = "Rumsey_SSCFlux_lr4_Day2015-2019.cvs")


preds_Flux_lr4WY<-predLoad(SSC_Rumsey_lr4,RumseyQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr4WY
exportCSV(preds_Flux_lr4WY, file.name = "Rumsey_SSC_Flux_lr4_WY2015-2019.cvs")
