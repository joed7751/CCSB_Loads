library(smwrBase)
library(smwrGraphs)
library(smwrStats)
library(dataRetrieval)
library(EGRE)
library(smwrData)
# Goal - synthetic hydrograph for 11452600 given mmt coincident w/ Q at 11452500, 
#estimate 11452600 hydrograph given cal dataset and MOVE.1 regression. May add terms for antecedent condition.
# In subsequent MLR with hystersis terms
siteNumbers<-"11452600"  
rd102mmt<-readNWISmeas(siteNumbers,tz="UTC")
parameterCd<-c('00060')
startDate<-"2007-09-01"
endDate<-"2017-10-31"
siteNumbers<-'11452500'#Cache at Yolo
yoloIVQ<-readNWISuv(siteNumbers,parameterCd,startDate,endDate,tz="UTC")
#confirmed both datasets are in UTC compared to NWIS in local time
plot(yoloIVQ$dateTime, yoloIVQ$X_00060_00000)
# Are there gaps in the TS w/ missing df rows or are there NA rows datestamped?
yoloIVQ$gap<-c(NA, with(yoloIVQ,dateTime[-1]-dateTime[-nrow(yoloIVQ)]))
gap_threshold<-15
yoloIVQ$lg_gap<-yoloIVQ$gap>gap_threshold
gap<-subset(yoloIVQ,gap>15,select=c(dateTime,gap,lg_gap))

############# CREATE DATESEQUENCE WITH NA ROWS TO FILL TS GAPS############
library(lubridate)
dateTime<-as.POSIXct(seq(ymd_hm('2007-09-01 08:00'),ymd_hm('2017-10-31 07:45'), by = '15 mins'))
dateTime<-setTZ(dateTime, TZ="UTC")
dateTime<-as.data.frame(dateTime)
#IVQ now has timestamps to fill gaps w/ coincident NAs; TZ = UTC
yoloIVQ<-merge(dateTime,yoloIVQ,by="dateTime", all.x = TRUE)

yoloDVQ<-readNWISDaily(siteNumbers, parameterCd,startDate, endDate, convert = FALSE)

#### Creating a UNIFORM TIMESTEP IN INPUT TS FOR Q #####
## Copied Approved Q record into new TS in AQUARIUS TSQA (sandbox instance of AQ)
# Copied rating-derived Approved Q into separate record
# This was used to resolve issue on AQ migration when >2hr gaps in record
# resulted in 1-day gaps in record. Good data were deleted.
# appended good data where it existed in gaps
# used estimated qualifier on gaps filled with linear interpolation while Q was changing
# filled gaps w/ zero flow, did not used estimated qualifer (flow was zero, but there was a gap)
# download gap-free IV record from AQ and import to R from csv.
# note - I did not change approval status to Approved, but this was derived from approved record.
library(readr)
Discharge_copy_Apv_Q_11452500_20100901 <- read_csv("Discharge.copy_Apv_Q11452500.20070901.csv",  col_names = FALSE, skip = 15)
#Parsed with column specification:
#  cols(
#    X1 = col_datetime(format = ""),
#    X2 = col_datetime(format = ""),
#    X3 = col_double(),
#    X4 = col_character(),
#    X5 = col_integer(),
#    X6 = col_character()

yoloIVQ_1<-Discharge_copy_Apv_Q_11452500_20070901 
rm(Discharge_copy_Apv_Q_11452500_20070901)
names(yoloIVQ_1)[1]<-"dateTime"
names(yoloIVQ_1)[2]<-"dateTime_local"
names(yoloIVQ_1)[3]<-"Q"
yoloIVQ_1$X4<-NULL
yoloIVQ_1$X5<-NULL
names(yoloIVQ_1)[4]<-"qual"

yoloIVQ_1$gap<-c(NA, with(yoloIVQ_1,dateTime[-1]-dateTime[-nrow(yoloIVQ_1)]))
gap_threshold<-15
yoloIVQ_1$lg_gap<-yoloIVQ_1$gap>gap_threshold
gap_1<-subset(yoloIVQ_1,gap>15,select=c(dateTime,gap,lg_gap))

####Zero gaps in this dataset
## Similar to EGRET, force zero values to 0.3093446 cfs 
## prior to natural log transformation and derivation of hysteresis terms
yoloIVQ_1$Q[yoloIVQ_1$Q<0.00001]<-0.3093446
yoloIVQ_1$lnQ<-log(yoloIVQ_1$Q)

#hysteresis terms REFERENCE
# Wang, P., and Linker, L.C., 2008, Improvement of regression simulation 
# in fluvial sediment loads: Journal of Hydraulic Engineering, v. 134, no. 10, p. 1,527–1,531.
yoloIVQ_1$lnQ1<-hysteresis(yoloIVQ_1$lnQ,step=96)
yoloIVQ_1$lnQ3<-hysteresis(yoloIVQ_1$lnQ,step=288)
yoloIVQ_1$lnQ7<-hysteresis(yoloIVQ_1$lnQ,step=672)
yoloIVQ_1$lnQ30<-hysteresis(yoloIVQ_1$lnQ,step=2880)
# check out the hysteresis plots
with(yoloIVQ_1, plot(lnQ, lnQ1, type="p"))
with(yoloIVQ_1, plot(lnQ, lnQ3, type="p"))
with(yoloIVQ_1, plot(lnQ, lnQ7, type="p"))
with(yoloIVQ_1, plot(lnQ, lnQ30, type="p"))

# converted posix.ct to JD from 2010-09-01 start
yoloIVQ_1$JD<-julian(yoloIVQ_1$dateTime, origin = as.POSIXct("2007-10-01", tz = "UTC"))
yoloIVQ_1$JD<-as.numeric(yoloIVQ_1$JD)
yoloIVQ_f<-as.data.frame(yoloIVQ_1)
yoloIVQ_f<-subset(yoloIVQ_f, select=c(dateTime,Q,qual,lnQ,lnQ1,lnQ3,lnQ7,lnQ30,JD))
# drop zero flow mmts from mmt at rd 102
rd102mmt_f<-rd102mmt[which(rd102mmt$discharge_va!=0), ] 
rd102mmt_f<-subset(rd102mmt_f, select=c(measurement_dateTime,discharge_va,tz_cd,site_no))
calSet<-mergeNearest(rd102mmt_f,dates.left="measurement_dateTime",all.left=TRUE,
                     suffix.left = "lft",yoloIVQ_f,dates.right="dateTime",
                     suffix.right="rt",Date.noon=FALSE,max.diff="8 mins")

## Cleanup & documentation
rm(gap)
rm(gap_1)
#rd102mmt = original retrieval of mmts as above from rd 102
#road102mmt_f zero mmts removed, subsetted, UTZ tz
#yoloIVQ = original retrieval from NWIS, with NAs for missing/gaps in 15min data
#yoloIVQ_1 = copy of approved ts with gaps filled using linear interpolation or good data that dropped from 
#  NWIS during migration to AQ - whole day gaps created when gaps were >2hrs.
#  added 0.309 cfs to zero cfs for log transform, similar to EGRET approach
#  hystersis and log transform terms + JD centered on 10/1/07 as t=0 added to dataset as potential EXPvars
#yoloIVQ_f = final IVQ dataset, gaps linearly interpolated, 
#  non-zero estimates across >2hr gaps qualified as such in "qual"

#### Trying out regresion - stepwise to test hysteresis terms and others
synth102step<-with(calSet,allReg(cbind(lnQ,lnQ1,lnQ3,lnQ7,lnQ30,JD,fourier(dateTime)),log(calSet$discharge_va),nmax=8,nbst=2,lin.dep=8))
synth102step #print and review stepwise regressions
## reviewed and took out a few expVars
synth102step<-with(calSet,allReg(cbind(lnQ,lnQ7,lnQ30,JD),log(calSet$discharge_va),nmax=5,nbst=2,lin.dep=8))
synth102step #print and review stepwise regressions
synth102.lm<-lm(log(discharge_va) ~ lnQ+lnQ30, data=calSet)##SELECTED 
synth102.reg<-multReg(synth102.lm)##Selected
#### Diagnostics
print(synth102.reg)
setSweave("regplot01",5,5)
plot(synth102.reg,which=1)
plot(synth102.reg,which=2)
plot(synth102.reg,which=3)
plot(synth102.reg,which=4)
plot(synth102.reg,which=5)
plot(synth102.reg,which=6)
plot(synth102.reg,which="PERIM")
#### decided to remove a low-flow mmt 7 cfs w/ coincident zero flow at yolo from calSet (happened to be row 37, original mmt #43)
calSet_f<-calSet[-c(37),]
#### retry regression
synth102step_f<-with(calSet_f,allReg(cbind(lnQ,lnQ1,lnQ3,lnQ7,lnQ30,JD),log(calSet_f$discharge_va),nmax=6,nbst=2,lin.dep=8))
synth102step_f
# same model selected, much better diagnostic numbers Cp = 0.9626345 down from ~3
synth102_f.lm<-lm(log(discharge_va) ~ lnQ+lnQ30, data=calSet_f)##SELECTED 
synth102_f.reg<-multReg(synth102_f.lm)##Selected
print(synth102_f.reg)
setSweave("regplot01",5,5)
plot(synth102_f.reg,which=1)
plot(synth102_f.reg,which=2)
plot(synth102_f.reg,which=3)
plot(synth102_f.reg,which=4)
plot(synth102_f.reg,which=5)
plot(synth102_f.reg,which=6)
plot(synth102_f.reg,which="PERIM")
##### BCF
BCF_synth102_f<-mean(2.7183^synth102_f.lm$residuals)
##### RMSE backtransformed to cfs
RMSE_synth102cfs_f<-(2.7183^(rmse(synth102_f.lm)))*BCF_synth102_f
predict102<-predictDuan(synth102_f.lm, yoloIVQ_f,back.trans=exp)
#exp means it is backtransforming as above 2.7183^x
predict102<-as.data.frame(predict102)
exportCSV(predict102,file.name="pred102.csv")
exportCSV(dateTime,file.name="dateTime.csv")
#### compare to move.1###
synth102.move.1<-move.1(log(discharge_va)~lnQ,calSet_f, distribution="lognormal")
synth102.move.1
##### BCF
BCF_synth102_move1<-mean(2.7183^synth102.move.1$residuals)
##### RMSE backtransformed to cfs
RMSE_synth102_move1<-(2.7183^(rmse(synth102.move.1)))*BCF_synth102_move1
##
predict102.move.1<-predict(synth102.move.1,yoloIVQ_f,type="response")
predict102.move.1<-as.data.frame(predict102.move.1)
exportCSV(predict102.move.1,file.name="pred102mv1.csv")
