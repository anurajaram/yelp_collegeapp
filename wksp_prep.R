# Start by cleaning up memory of current R session:
rm(list=ls(all=TRUE))

# i prefer <5 decimal places
options(digits=4)

# suppress scientific notation e.g.: 2.4e5 instead 2,400,367 
options(scipen = 999)


# load required library packages:
library(data.table)   # for fread() 
library(sqldf)
library(bit64)
library(plyr)
library(sqldf)

library(heatmaply)
library(plotly)
library(htmltools)
library(ggvis)

library('dplyr')      # for data manipulation
library('tidyr')      # for reshaping data

library('ggplot2')    # plotting data
library('scales')     # for scale_y_continuous(label = percent)
library('ggthemes')   # for scale_fill_few('medium')

library('ztable')     # format tables for reporting
library("maps")
library(leaflet)

library(wordcloud)
library(qdap)
library(tm)
library(stringr)


# saldata = fread("C:/anu/data analytics/us edu scorecard/salary_data.csv")
# saldata$case_date = as.Date(saldata$CASE_RECEIVED_DATE, "%m/%d/%Y")
# saldata$caseyr = as.numeric(format(saldata$case_date, "%Y"))