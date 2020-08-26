library(rloadest)
library(dataRetrieval)
library(ggplot2)
library(loadflex)
##############################################################################################
#Importing DATA for Cache Creek at Yolo
##############################################################################################
# Interpolation data:Yolo fMeHg data grab sample observations

fMeHg_Yolo <- importRDB("Yolo_fMeHg.txt")
fMeHg_Yolo
### Reading in Flow Data
YoloQ <- importRDB("YoloQDaily_2017_2019.txt")
YoloQ$Dates <- with(YoloQ, as.POSIXct(paste(Dates), format= "%Y-%m-%d"))


YoloQ 

##############################################################################################
#Runing Load Models 
##############################################################################################

###Selecting best fit model###############

app1.lr <- selBestModel("fMeHg", data = fMeHg_Yolo, 
                        flow = "Flow", dates = "Dates", conc.units="ng/L",
                        station="Cache Creek at Yolo")
print(app1.lr)
#####################################################################################################
# Extract the fitted values look at the output and evaluate the AIC and SPPC stats, the SelBestModel will 
#always pick the model with the lowest AIC, but we need to look at the SPPC also if there is a modle with 
#a lower SPPC then we need to evaluate that model also and decide which model we will used based on the 
#p-values of the perameters and the Bias (BP, needs to be as lower that 25%, and the E value needs to be high)
###############################################################################################
#Run the recomended model, and any other model we might think is good based on the Bp and E values
###############################################################################################
fMeHg_Yolo_lr1 <- loadReg(fMeHg ~ model(1), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr1

fMeHg_Yolo_lr2 <- loadReg(fMeHg ~ model(2), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr2

fMeHg_Yolo_lr3 <- loadReg(fMeHg ~ model(3), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr3

fMeHg_Yolo_lr4 <- loadReg(fMeHg ~ model(4), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr4

fMeHg_Yolo_lr5 <- loadReg(fMeHg ~ model(5), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr5

fMeHg_Yolo_lr6 <- loadReg(fMeHg ~ model(6), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr6

fMeHg_Yolo_lr7 <- loadReg(fMeHg ~ model(7), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr7

fMeHg_Yolo_lr8 <- loadReg(fMeHg ~ model(8), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr8

fMeHg_Yolo_lr9 <- loadReg(fMeHg ~ model(9), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day",
                         flow.units="cfs", conc.units="ng/L",load.units="kg",
                         station="Cache Creek at Yolo")
fMeHg_Yolo_lr9

###############################################################################################
###############################################################################################
#Once we decide on the model we want to use we can run some diagnostic plots
#In order to look at some diagnostic plots that are only availble in  we need to run the model we 
#selected (we feel best fitted) outside of the loadflex routine (by rinignloadReg only)
#the most usful plots are plot 1, plot 2, and plot 5
###############################################################################################
###############################################################################################
fMeHg_Yolo_lr4 <- loadReg(fMeHg ~ model(4), data=fMeHg_Yolo,
                         flow="Flow", date="Dates", time.step="day", 
                         flow.units="cfs", conc.units="ng/L", load.units="kg",
                         station="Cache Creek at Yolo")

setSweave("fMeHg_Yolo_lr4_plot2",5,5)
plot(fMeHg_Yolo_lr4,which=1,set.up=FALSE) #plot 1: Calibrated regression model
graphics.off()

setSweave("fMeHg_Yolo_lr4_plot1",5,5)
plot(fMeHg_Yolo_lr4,which=2,set.up=FALSE) #plot 2:Estimates of log load versus model residuals from AMLE regression
graphics.off()

setSweave("fMeHg_Yolo_lr4_plot3",5,5)
plot(fMeHg_Yolo_lr4,which=3,set.up=FALSE)# plot 3: Estimates of log load versus squared model residuals 
graphics.off()

setSweave("fMeHg_Yolo_lr4_plot4",5,5)
plot(fMeHg_Yolo_lr4,which=4,set.up=FALSE) # plot 4: Standardized Serial Correlation
graphics.off()

setSweave("fMeHg_Yolo_lr4_plot5",5,5)
plot(fMeHg_Yolo_lr4,which=5,set.up=FALSE) # plot 5: Normal probability plot for the model residuals (Quantile plot)
graphics.off()

#############################################################################################
#predict concntrations
###############################################################################################
preds_conc_lr4 <- predConc(fMeHg_Yolo_lr4, YoloQ, by= "day", allow.incomplete= TRUE )
preds_conc_lr4
exportCSV(preds_conc_lr4, file.name = "Yolo_fMeHg_conc_lr4_2017-2019.cvs")

###############################################################################################
##We plot the estimated unite conc Vs the obsereved unite conc in xls
###############################################################################################

###############################################################################################
#load calculations using selected model 
###############################################################################################

preds_Flux_lr4day<-predLoad(fMeHg_Yolo_lr4,YoloQ,load.units="kg",by="day",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr4day
exportCSV(preds_Flux_lr4day, file.name = "Yolo_fMeHgFlux_lr4_Day2017-2019.cvs")


preds_Flux_lr4WY<-predLoad(fMeHg_Yolo_lr4,YoloQ,load.units="kg",by="water year",allow.incomplete = TRUE,conf.int = 0.95,print = TRUE)
preds_Flux_lr4WY
exportCSV(preds_Flux_lr4WY, file.name = "Yolo_fMeHg_Flux_lr4_WY2017-2019.cvs")
