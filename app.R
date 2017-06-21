library(shiny)
library(ggplot2)
library(plotly)
source("WRScrapeR.R")

ui <- fluidPage(
  titlePanel("Top NFL Recievers"),
  sidebarLayout(
    sidebarPanel(sliderInput(inputId = "year",label = "Choose a year", value = 2009, min = 2009, max = 2017,sep = ""),
                 selectInput(inputId = "xaxis", "Select the x axis", 
                    choices = list("Receptions"="REC","Targets"="TAR","Yards"="YDS","Average yards"="AVG","Touchdowns"="TD","Longest Carry"="LONG","Receptions over 20"="TwentyPlus","Yards per Game"="YDSPERGAME","Fumbles"="FUM", "First Downs"="FIRSTDN"),selected = "REC"),
                 selectInput(inputId = "yaxis", "Select the y axis", 
                    choices = list("Receptions"="REC","Targets"="TAR","Yards"="YDS","Average yards"="AVG","Touchdowns"="TD","Longest Carry"="LONG","Receptions over 20"="TwentyPlus","Yards per Game"="YDSPERGAME","Fumbles"="FUM", "First Downs"="FIRSTDN"),selected = "YDS")
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

server <- function(input, output){
  players <- get_WR_stats(2009)
  output$plot <- renderPlotly({
    players <- get_WR_stats(input$year)
    x <- gsub(",","",players[,input$xaxis])
    xaxis <- as.numeric(as.character(x))
    y <- gsub(",","",players[,input$yaxis])
    yaxis <- as.numeric(as.character(y))
    
    color <- "#2C5AC4"
    
    ggplot(
      players, 
      aes(x=xaxis,y=yaxis)
    ) + geom_point(colour=color,alpha=.5,size=3,aes(text = paste("Player:",players$Player))) + xlab(input$xaxis) + ylab(input$yaxis) + coord_cartesian() + theme_bw() + geom_smooth(method=lm)
  })
}

shinyApp(ui = ui, server = server)
