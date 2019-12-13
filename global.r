#global

library(shiny)
library(shinydashboard)
library(highcharter)
library(tidyverse)
library(dplyr)
library(shinyWidgets)
library(Rcpp)

dat<-read.csv('rec_dt_12_3.csv', header=T, stringsAsFactors = FALSE)
dat$day<-as.Date(dat$date, format = "%m/%d/%y")
ACT<-543492.5
none<- subset(dat, dat[[2]] =="gulf", drop=TRUE)
two <- subset(dat, dat[[2]] %in% c("east","west"), drop=TRUE)
three <- subset(dat, dat[[2]] %in% c("west","north","south"), drop=TRUE)
mindate <- "2020-08-01"
maxdate <- "2021-7-31"


cppFunction('NumericVector cumsumCPP(NumericVector x, int y = 0){
            
            // y = 0 is the default
            // Need to do this in order to avoid modifying the original x
            int n = x.size();
            NumericVector res(n);
            res[0] = x[0];
            
            for (int i = 1 ; i < n ; i++) {
            res[i] = res[i - 1] + x[i];
            if (res[i] > y && (y != 0)) { 
            // This breaks the loop if condition met
            return res[seq(0, i - 1)];
            }
            }
            
            // This handles cases when y== 0 OR y != 0 and y > cumsum(res)
            return res;
            }')