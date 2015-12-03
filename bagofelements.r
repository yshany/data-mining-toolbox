library(plyr)
library(reshape)
library(dplyr)
library(tidyr)
library(tm)
trial=train[,c(2,5)] #some data with id and target variable to create bag of elements 
trial[,2]=gsub(' ','',trial[,2],)
trial2 <- ddply(trial, .(VisitNumber), mutate, 
               index = paste0('d', 1:length(VisitNumber)))  
trial3<-reshape(trial2,idvar="VisitNumber",timevar="index",direction="wide")
trial4=unite_(trial3, col='dep',names(trial3)[2:210], sep=' ')
corpus <- Corpus(VectorSource(trial4[,2]))
dtm <- DocumentTermMatrix(corpus)
dtmsparse <- as.data.frame(as.matrix(dtm))
