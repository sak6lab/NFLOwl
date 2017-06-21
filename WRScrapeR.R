library(rvest)
library(dplyr)
get_WR_stats <- function(year){
  html <- paste("http://www.espn.com/nfl/statistics/player/_/stat/receiving/sort/receivingYards/year", as.character(year),sep = "/")
  stats_pg <- read_html(html)
  wr_stats_table <- html_nodes(stats_pg, 'table')
  wr <- html_table(wr_stats_table)
  wr_table <- data.frame(wr)
  wr_concise_table <- subset(wr_table,X2 != "PLAYER")
  wr_concise_table <- rename(wr_concise_table,RK=X1,Player=X2,Team=X3,REC=X4,TAR=X5,YDS=X6,AVG=X7,TD=X8,LONG=X9,TwentyPlus=X10,YDSPERGAME=X11,FUM=X12,YAC=X13,FIRSTDN=X14)
  return (wr_concise_table)
}

