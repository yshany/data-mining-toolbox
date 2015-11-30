# data-mining-toolbox
cat2freq<-function(x)
{
return (as.data.frame(table(x)))  
  
  
}

cat2logfreq<-function(x)
{
m=as.data.frame(table(x))
m[,2]=log(m[,2])
return (m)  
  
  
}

cat2freqrank<-function(x)
{
  m=as.data.frame(sort(table(x)))
  
  m[,1]=rev(c(1:length(m[,1])))
  m$key=row.names(m)
  return (m)  
  
  
}
