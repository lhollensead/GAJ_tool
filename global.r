#global

library(shiny)
library(shinydashboard)
library(RSQLite)
#library(highcharter)
library(tidyverse)
library(dplyr)
#library(shinyWidgets)
library(scales)
#library(plotly)
#library(ggthemes)
#library(scales)
library(htmltools)
library(rintrojs)

dat<-read.csv('rec_dt_12_30.csv', header=T, stringsAsFactors = FALSE)
fes_dat<-read.csv('fes_rec_dt_12_30.csv', header=T, stringsAsFactors = FALSE)
dat$day<-as.Date(dat$date, format = "%m/%d/%Y")
fes_dat$day<-as.Date(fes_dat$date, format = "%m/%d/%Y")

gulf_dcr<-read.csv('gulf_dcr.csv', header=T, stringsAsFactors = FALSE)
two_dcr<-read.csv('two_dcr.csv', header=T, stringsAsFactors = FALSE)
three_dcr<-read.csv('three_dcr.csv', header=T, stringsAsFactors = FALSE)
fes_gulf_dcr<-read.csv('fes_gulf_dcr.csv', header=T, stringsAsFactors = FALSE)
fes_two_dcr<-read.csv('fes_two_dcr.csv', header=T, stringsAsFactors = FALSE)
fes_three_dcr<-read.csv('fes_three_dcr.csv', header=T, stringsAsFactors = FALSE)


ACT<-1086985

none<- subset(dat, dat[[2]] =="gulf", drop=TRUE)
two <- subset(dat, dat[[2]] %in% c("east","west"), drop=TRUE)
three <- subset(dat, dat[[2]] %in% c("west","north","south"), drop=TRUE)

fes_none<- subset(fes_dat, fes_dat[[2]] =="gulf", drop=TRUE)
fes_two <- subset(fes_dat, fes_dat[[2]] %in% c("east","west"), drop=TRUE)
fes_three <- subset(fes_dat, fes_dat[[2]] %in% c("west","north","south"), drop=TRUE)

"
.center {
  display: block;
margin-left: auto;
margin-right: auto;
width: 90%;
}
"



# Create a new theme
theme_bluewhite <- function (base_size = 11, base_family = "") {
  theme_bw() %+replace% 
    theme(
      panel.grid.major  = element_line(color = "white"),
      panel.background = element_rect(fill = "white"),
      panel.border = element_rect(color = "#3e3a3a", fill = NA),
      axis.line = element_line(color = "#3e3a3a"),
      axis.ticks = element_line(color = "#3e3a3a"),
      axis.text = element_text(color = "#3e3a3a",size=16,face="bold"),
      axis.title.y = element_text(color = "#3e3a3a", size = 14,face="bold", angle=90,margin = margin(t = 0, r = 20, b = 0, l = 0)),
      legend.position = "bottom",
      legend.text = element_text(size=14),
      legend.spacing.x = unit(1, 'cm'),
      legend.key.size = unit(1, "cm"),
      legend.background = element_rect(fill="gray97"),
      plot.margin = margin(.5,.5, .5, .5, "cm"),
      plot.background=element_rect( color = "cornflowerblue", inherit.blank = FALSE, size=1)
    )
}