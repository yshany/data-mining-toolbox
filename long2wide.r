long2wide<-function(x)
{
library(plyr)
library(reshape2)
x=ddply(x,.(id),mutate,index=paste0('v',1:length(id)))
x=reshape(event,timevar='index',idvar='id',direction='wide')


}
