install.packages("shiny","streamR","RCurl","ROAuth","RJSONIO","ggplot2")
library("ggplot2")
library("shiny")
library("streamR")
library("RCurl")
library("ROAuth")
library("RJSONIO")
library("stringr")
library("plotly")
  shinyServer(function(input,output){
    consumerKey <- "68VFPnNNriCpICTb1gso01Sk7"
    consumerSecret <- "	KPXJjCk5uEe5hVg5i0hBLf0jm6E1mdcxslud3aXqmH8v8YpIUd" 
    acces <-"3632441303-PdZ48wevJ7Wo06tgXJ5KrIAm1jRAZhEZhyo2jBg"
    accessec <- "	bHS1LfPJFRnjh9LzWsZX32HrEfnYk4fZweH4qGaQf8ZKU"
    credential <- OAuthFactory$new(consumerKey=consumerKey,consumerSecret=consumerSecret, requestURL=requestURL,accessURL=accessURL,authURL=authURL)
    options(RCurlOptions = list(cainfo = system.file("CurlSSL", "cacert.pem", package = "RCurl")))
    download.file(url="http://curl.haxx.se/ca/cacert.pem",destfile="cacert.pem")
    credential$handshake(cainfo="cacert.pem")
    tweets<-searchTwitter("US elections",n=500,lang="en",since="2016-02-27",until="2016-03-02")
    tweet.df<-twListToDF(tweets)
    tweets1<-searchTwitter("US elections",n=500,lang="en",since="2016-03-03",until="2016-03-05")
    tweet1.df<-twListToDF(tweets1)
    new<-rbind(tweet.df,tweet1.df)
    output$trendPlot <- renderPlotly({
      ggplot(new,aes(x=new$created,y=new$retweetCount)) + geom_line(stat="identity")
      #p <- plot_ly(new, x =created, autobinx = F, type = "histogram")
      # style the xaxis
      #layout(p, xaxis = list(title = "created", autorange = F,
                             #autotick = F))
    })
  })
  
  
   
  