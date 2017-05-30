install.packages("twitteR")
install.packages("ROAuth")
install.packages("jsonlite")
library("twitteR")
library("ROAuth")
library("rjson")
library("jsonlite")
conskey <- "68VFPnNNriCpICTb1gso01Sk7"
conssecret <- "	KPXJjCk5uEe5hVg5i0hBLf0jm6E1mdcxslud3aXqmH8v8YpIUd"
accesstok <- "3632441303-PdZ48wevJ7Wo06tgXJ5KrIAm1jRAZhEZhyo2jBg"
accesssec <- "bHS1LfPJFRnjh9LzWsZX32HrEfnYk4fZweH4qGaQf8ZKU"
setup_twitter_oauth(conskey,conssecret,accesstok,accesssec)
tweet <-searchTwitter("President elections",n=100, lang="en")
df <- do.call("rbind", lapply(tweet,as.data.frame))
obj_json <- toJSON(df)
write(obj_json,"C:\\Users\\Narmadha\\Desktop\\apt1.json")

