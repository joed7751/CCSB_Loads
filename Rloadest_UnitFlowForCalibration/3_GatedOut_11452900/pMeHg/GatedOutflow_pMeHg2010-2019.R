library(rloadest)
library(dataRetrieval)
library(ggplot2)
library(loadflex)
##############################################################################################
#Importing DATA for Cache Creek at Gated
##############################################################################################
# Interpolation data:Gated pMeHg data grab sample observations

pMeHg_Gated <- importRDB("GatedOut_pMeHg.txt")
pMeHg_Gated
### Reading in Flow Data
GatedQ <- importRDB("GatedOutflow_DQ.txt")
GatedQ$Dates <- with(GatedQ, as.POSIXct(paste(Dates), format= "%Y-%m-%d"))


GatedQ 

##############################################################################################
#Runing Load Models 
##############################################################################################

###Selecting best fit model###############

app1.lr <- selBestModel("pMeHg", data = pMeHg_Gated, 
                        flow = "Flow", dates = "Dates", conc.units="ng/L",
                        station="Cache Creek at Gated")
print(app1.lr)
#####################################################################################################
# Extract the fitted values look at the output and evaluate the AIC and SPPC stats, the SelBestModel will 
#always pick the model with the lowest AIC, but we need to look at the SPPC also if there is a modle with 
#a lower SPPC then we need to evaluate that model also and decide which model we will used based on the 
#p-values of the perameters and the Bias (BP, needs to be as lower that 25%, and the E value needs to be high)
###############################################################################################
#Run the recomended model, and any other model we might think is good based on the Bp and E values
###############################################################################################
pMeHg_Gated_lr1<- loadReg(pMeHg ~ model(1), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr1

pMeHg_Gated_lr2 <- loadReg(pMeHg ~ model(2), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr2

pMeHg_Gated_lr3 <- loadReg(pMeHg ~ model(3), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr3

pMeHg_Gated_lr4 <- loadReg(pMeHg ~ model(4), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr4

pMeHg_Gated_lr5 <- loadReg(pMeHg ~ model(5), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr5

pMeHg_Gated_lr6 <- loadReg(pMeHg ~ model(6), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr6

pMeHg_Gated_lr7 <- loadReg(pMeHg ~ model(7), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr7

pMeHg_Gated_lr8 <- loadReg(pMeHg ~ model(8), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr8

pMeHg_Gated_lr9 <- loadReg(pMeHg ~ model(9), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Gated")
pMeHg_Gated_lr9

###############################################################################################
###############################################################################################
#Once we decide on the model we want to use we can run some diagnostic plots
#In order to look at some diagnostic plots that are only availble in  we need to run the model we 
#selected (we feel best fitted) outside of the loadflex routine (by rinignloadReg only)
#the most usful plots are plot 1, plot 2, and plot 5
###############################################################################################
###############################################################################################
pMeHg_Gated_lr5 <- loadReg(pMeHg ~ model(5), data=pMeHg_Gated,
                         flow="Flow", date="Dates", time.step="day", 
                         flow.units="cfs", conc.units="ng/L", load.units="kg",
                         station="Cache Creek at Gated")

setSweave("pMeHg_Gated_lr5_plot2",5,5)
plot(pMeHg_Gated_lr5,which=1,set.up=FALSE) #plot 1: Calibrated regression model
graphics.off()

setSweave("pMeHg_Gated_lr5_plot1",5,5)
plot(pMeHg_Gated_lr5,which=2,set.up=FALSE) #plot 2:Estimates of log load versus model residuals from AMLE regression
graphics.off()

setSweave("pMeHg_Gated_lr5_plot3",5,5)
plot(pMeHg_Gated_lr5,which=3,set.up=FALSE)# plot 3: Estimates of log load versus squared model residuals 
graphics.off()

setSweave("pMeHg_Gated_lr5_plot4",5,5)
plot(pMeHg_Gated_lr5,which=4,set.up=FALSE) # plot 4: Standardized Serial Correlation
graphics.off()

setSweave("pMeHg_Gated_lr5_plot5",5,5)
plot(pMeHg_Gated_lr5,which=5,set.up=FALSE) # plot 5: Normal probability plot for the model residuals (Quantile plot)
graphics.off()

#############################################################################################
#predict concntrations
###############################################################################################
preds_conc_lr5 <- predConc(pMeHg_Gated_lr5, GatedQ, by= "day", allow.incomplete= TRUE )
preds_conc_lr5
exportCSV(preds_conc_lr5, file.name = "Gated_pMeHg_conc_lr5_2010-2019.cvs")

###############################################################################################
##We plot the estimated unite conc Vs the obsereved unite conc in xls
###############################################################################################

###############################################################################################
#load calculations will be done outside Loadest 
#But this load calculated will be used to estimate SE for the xlxs calculation
###############################################################################################
preds_Flux_lr5day<-predLoad(pMeHg_Gated_lr5,GatedQ,load.units="kg",by="day",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr5day
exportCSV(preds_Flux_lr5day, file.name = "Gated_pMeHgFlux_lr5_Day2010-2019.cvs")

preds_Flux_lr5WY<-predLoad(pMeHg_Gated_lr5,GatedQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr5WY
exportCSV(preds_Flux_lr5WY, file.name = "Gated_pMeHgFlux_lr5_WY2010-2019.cvs")


