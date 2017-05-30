shinyUI(fluidPage( 
  titlePanel("Election Trend"), #Title
  textOutput("currentTime"),   #Here, I show a real time clock
  h4("Tweets:"),   #Sidebar title
  sidebarLayout(
    sidebarPanel
    (
      dataTableOutput('tweets_table') #Here I show the users and the sentiment
    ),
    mainPanel(
      plotOutput("distPlot"), #Here I will show the bars graph
      sidebarPanel
      (
        plotOutput("positive_wordcloud") #Cloud for positive words
      ),
      sidebarPanel
      (
        plotOutput("negative_wordcloud") #Cloud for negative words
      )
     
      )
    )
  ))