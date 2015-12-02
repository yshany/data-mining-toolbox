options( java.parameters = "-Xmx3g" )
library(xgboost)
library(h2o)
library(extraTrees)

percent=0.15
round=100
rf_round=300
ef_round=300
xgb_round=1000
rf_mtry=60
ef_mtry=60
predz=rep(0,nrow(test))
param=list{
(booster = 'gbtree', 
             "objective"="reg:linear",
             'nthreads' = 4,
             #'lambda' = 0.00005,
             #'alpha' = 0.000001,
             #min_child_weight = min_child_weight,
             #subsample = 0.7,
             gamma = 0.9,
             #colsample_bytree = 0.8,
             max.depth = 8,
             eta = 0.01

}
data$target=target
data$target=NULL
for(i in 1:round)
{
h=sample(nrow(data),floor(percent*(nrow(data))))
bag_data=data[-h,]
oob_data=data[h,]
ef=extraTrees(x = oob_data, y = target[h], ntree = ef_round, mtry = ef_mtry, numRandomCuts = 3)
efbag_pred=predict(ef,bag_data)
eftest_pred=predict(ef,test)
h2o.init(nthreads=-1)
trainHex<-as.h2o(data.frame(cbind(oob_data,target[h])),destination_frame="train.hex")

rfHex<-h2o.randomForest(x=names(data.frame(oob_data)[1:(ncol(oob_data)-1)]),
    y=names(data.frame(oob_data)[ncol(oob_data)],training_frame=trainHex,model_id="rfStarter.hex", ntrees=rf_round, sample_rate = 0.7,mtry=rf_mtry)
testHex<-as.h2o(data.frame(test),destination_frame="test.hex")
bagHex<-as.h2o(data.frame(bag_data),destination_frame="test.hex")
rftest_pred<-as.data.frame(h2o.predict(rfHex,testHex))$predict
rfbag_pred<-as.data.frame(h2o.predict(rfHex,bagHex))$predict
bag=xgb.DMatrix(data=cbind(bag_data,efbag_pred,rfbag,pred),label=target[-h])
xgb=xgboost(bag,param=param,nround=xgb_round)
predz=predz+predict(xbg,cbind(test,eftest_pred,rfbag_pred))
}
prediction=predz/round
