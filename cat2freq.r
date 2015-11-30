# data-mining-toolbox
cat2freq<-function(x,key)
{
m=as.data.frame(table(x))
names(m)[1]=key
x=merge(m,x,by=key)
x[,key]=NULL
return (x)  
  
  
}

cat2logfreq<-function(x,key)
{
m=as.data.frame(table(x[,key]))
m[,2]=log(m[,2])
names(m)[1]=key
x=merge(m,x,by=key)
x[,key]=NULL
return (x)  
  
  
}

cat2freqrank<-function(x,key)
{
  m=as.data.frame(sort(table(x[,key])))
  
  m[,1]=rev(c(1:length(m[,1])))
  m[,key]=row.names(m)
  x=merge(m,x,by=key)
x[,key]=NULL
  return (x)  
  
  
}
