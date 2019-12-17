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
ACT<-543492.5
none<- subset(dat, dat[[2]] =="gulf", drop=TRUE)
two <- subset(dat, dat[[2]] %in% c("east","west"), drop=TRUE)
three <- subset(dat, dat[[2]] %in% c("west","north","south"), drop=TRUE)


