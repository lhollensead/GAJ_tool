#global

library(shiny)
library(shinydashboard)
library(highcharter)
library(tidyverse)
library(dplyr)
library(shinyWidgets)
library(scales)

dat<-read.csv('rec_dt_12_3.csv', header=T, stringsAsFactors = FALSE)
dat$day<-as.Date(dat$date, format = "%m/%d/%Y")
gulf_dcr<-read.csv('gulf_dcr.csv', header=T, stringsAsFactors = FALSE)
two_dcr<-read.csv('two_dcr.csv', header=T, stringsAsFactors = FALSE)
three_dcr<-read.csv('three_dcr.csv', header=T, stringsAsFactors = FALSE)
ACT<-543492.5
none<- subset(dat, dat[[2]] =="gulf", drop=TRUE)
two <- subset(dat, dat[[2]] %in% c("east","west"), drop=TRUE)
three <- subset(dat, dat[[2]] %in% c("west","north","south"), drop=TRUE)

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
