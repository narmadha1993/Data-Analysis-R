install.packages("gdata")
install.packages("plyr")
install.packages("ggplot2")
library("ggplot2")
library("plyr")
library("gdata")
require(gdata)
setwd("C:\\Users\\Narmadha\\Desktop\\ub sem 2\\dic\\doing_data_science-master\\dds_datasets\\rs")
#data1="C:\\Users\\Narmadha\\Desktop\\ub sem 2\\dic\\doing_data_science-master\\dds_datasets\\rs\\rollingsales"
data2= ".xls"
arr <- c("bronx", "brooklyn","manhattan","queens","statenisland")
max_saleprice <- vector()
mean_saleprice <- vector()
sd_saleprice <- vector()
priceperfeet <- vector()
files<-(1:5)
for(i in 1:length(arr))
{
  fullurl=paste(paste("rollingsales_",arr[i],sep=""),data2,sep="") 
  dataframe <-read.xls(fullurl,perl="C:\\Strawberry\\perl\\bin\\perl.exe",pattern="BOROUGH") 
  head(dataframe)
  summary(dataframe)
  attach(dataframe)
  dataframe$SALE.PRICE.N <- as.numeric(gsub("[^[:digit:]]","",dataframe$SALE.PRICE))
  #count(is.na(data1$SALE.PRICE.N))
  names(dataframe) <- tolower(names(dataframe))
  ## clean/format the data with regular expressions
  dataframe$gross.sqft <- as.numeric(gsub("[^[:digit:]]","",dataframe$gross.square.feet))
  dataframe$land.sqft <- as.numeric(gsub("[^[:digit:]]","",dataframe$land.square.feet))
  dataframe$sale.date <- as.Date(dataframe$sale.date)
  dataframe$year.built <- as.numeric(as.character(dataframe$year.built))
  dataframe.sale <- dataframe[dataframe$sale.price.n!=0,]
  max_saleprice <- c(max_saleprice,max(dataframe$SALE.PRICE))
  mean_saleprice <- c(mean_saleprice,sum(dataframe$sale.price.n)/nrow(subset(dataframe,dataframe$sale.price.n>0)))
  sd_saleprice <- c(sd_saleprice,sd(dataframe$SALE.PRICE))
  priceperfeet <- c(priceperfeet,(dataframe$SALE.PRICE)/(dataframe$land.square.feet))
}  
    ## do a bit of exploration to make sure there's not anything
    #data1.homes[which(data1.homes$sale.price.n<100000),][order(data1.homes[which(data1.homes$sale.price.n<100000),]$sale.price.n),]
    ## weird going on with sale prices
  
#adding to dataframe
View(dataframe)
frame1=data.frame(files,max_saleprice)
frame2=data.frame(files,mean_saleprice)
frame3=data.frame(files,sd_saleprice)
frame4=data.frame(files,priceperfeet)
## keep only the actual sales
plot(dataframe.sale$gross.sqft,dataframe.sale$sale.price.n)
plot(log(dataframe.sale$gross.sqft),log(dataframe.sale$sale.price.n))
## for now, let's look at 1-, 2-, and 3-family homes
dataframe.homes <- dataframe.sale[which(grepl("FAMILY",
                                              dataframe.sale$building.class.category)),]
plot(log(dataframe.homes$gross.sqft),log(dataframe.homes$sale.price.n))

## remove outliers that seem like they weren't actual sales
dataframe.homes$outliers <- (log(dataframe.homes$sale.price.n) <=5) + 0
dataframe.homes <- dataframe.homes[which(dataframe.homes$outliers==0),]
plot(log(dataframe.homes$gross.sqft),log(dataframe.homes$sale.price.n))
ggplot(dataframe.sale,aes(x=sale.date,y=sale.price.n,fill=sale.date)) + geom_line()
ggplot(frame2,aes(x=frame2$files,y=frame2$mean_saleprice)) + geom_bar(stat="identity")
#ggplot(frame1,aes(x=frame1$files,y=frame1$meax_saleprice)) + geom_bar(stat="identity")
#ggplot(frame3,aes(x=frame3$files,y=frame3$sd_saleprice)) + geom_bar(stat="identity")
#ggplot(frame4,aes(x=frame4$files,y=frame4$priceperfect)) + geom_bar(stat="identity")







