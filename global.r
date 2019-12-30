#global

library(shiny)
library(shinydashboard)
library(highcharter)
library(tidyverse)
library(dplyr)
library(shinyWidgets)
library(scales)
library(plotly)
library(ggthemes)

dat<-read.csv('rec_dt_12_30.csv', header=T, stringsAsFactors = FALSE)
fes_dat<-read.csv('fes_rec_dt_12_30.csv', header=T, stringsAsFactors = FALSE)
dat$day<-as.Date(dat$date, format = "%m/%d/%Y")
fes_dat$day<-as.Date(fes_dat$date, format = "%m/%d/%Y")



ACT<-543492.5

none<- subset(dat, dat[[2]] =="gulf", drop=TRUE)
two <- subset(dat, dat[[2]] %in% c("east","west"), drop=TRUE)
three <- subset(dat, dat[[2]] %in% c("west","north","south"), drop=TRUE)

fes_none<- subset(fes_dat, fes_dat[[2]] =="gulf", drop=TRUE)
fes_two <- subset(fes_dat, fes_dat[[2]] %in% c("east","west"), drop=TRUE)
fes_three <- subset(fes_dat, fes_dat[[2]] %in% c("west","north","south"), drop=TRUE)

mycss <- "
.irs-bar,
.irs-bar-edge,
.irs-single,
.irs-grid-pol,
.irs-max,
.irs-min,{
background: black;
border-color: black;
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
      axis.text = element_text(color = "#3e3a3a"),
      axis.title.y = element_text(color = "#3e3a3a", size = 14, angle=90)
    )
}