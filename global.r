#global

library(shiny)
library(shinydashboard)
library(highcharter)
library(tidyverse)
library(dplyr)

dat<-read.csv('rec_dt_12_3.csv', header=T, stringsAsFactors = FALSE)
dat$day<-as.Date(dat$date, format = "%m/%d/%y")
two <- dat[1:730, ]
three <- dat[c(1:365,731:1460), ]
