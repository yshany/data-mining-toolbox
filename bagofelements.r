library(plyr)
library(reshape)
library(tm)
unit2<-function(x,key)
{
return(paste(x[,key][1:length(x)],collapse=" "))  
  
  }
trial=train[,c(2,5)] #some data with id and target variable to create bag of elements 
trial$key=gsub(' ','',trial$key)
vec <- ddply(trial, .(VisitNumber), unit2, key)  
trial3<-reshape(trial2,idvar="VisitNumber",timevar="index",direction="wide")
corpus <- Corpus(VectorSource(vec))
dtm <- DocumentTermMatrix(corpus)
dtmsparse <- as.data.frame(as.matrix(dtm))
