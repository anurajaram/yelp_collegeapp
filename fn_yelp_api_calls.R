# Anu Rajaram
# yelp api calls

# load libraries
source("wksp_prep.R")
library(jsonlite)
library("twitteR")
library("data.table")
library(httr)
library(leaflet)


# yelp api keys
Consumer_Key <- 	"sS"
Consumer_Secret	<- "O7H"
Token <-	"Fm3"
Token_Secret <-	"rM"

myapp <- oauth_app("YELP", key=Consumer_Key, secret=Consumer_Secret)
sig <- sign_oauth1.0(myapp, token=Token, token_secret=Token_Secret)


# default variables for yelp search
locn <- "19104"  # location variable
radius_miles<- 1 # radius of search in miles

# create the custom search url to send with the api call
api_part1 <- "https://api.yelp.com/v2/search/?location="
api_part2 <- "&radius_filter="
api_part3 <- "&category_filter=collegeuniv"


# function for searching yelp and getting tabular data
yelp_srch <- function( radius_miles, locn, n )
{
  # convert search radius into metres
  radius_meters <- radius_miles*1609.34
  
  # create composite Yelp API query
  querycomposite2 <- paste0(api_part1, locn, api_part2, radius_meters, api_part3, sep = '')
  resultsout <- GET(querycomposite2, sig)
  
  collegeDataContent = content(resultsout)
  collegelist=jsonlite::fromJSON(toJSON(collegeDataContent))
  collegeresultsp <- data.frame(collegelist)
  
  colnames(collegeresultsp) = c("lat_delta", "long_delta", "latitude", "longitude", 
                                "total", "claim_biz", "yelp_rating", "mobile_url", 
                                "image_url", "No_of_reviews", "College", "image_url_small", 
                                "main_weblink", "categories", "phone", "short_text", 
                                "biz_image_url", "snippet_url", "display_phone", 
                                "rating_image_url", "biz_id", "closed", "location_city")
  
  varseln <- c(11,7,10,19 )
  collegeset <- subset(collegeresultsp, select = varseln)
  
  tk <- subset(collegeset, No_of_reviews > n)
  rownames( tk ) <- seq_len( nrow( tk ) )
  
  return(tk)
} 



# function for searching yelp and getting map data
yelp_map <- function( radius_miles, locn, n )
{
  # convert search radius into metres
  radius_meters <- radius_miles*1609.34
  
  # create composite Yelp API query
  querycomposite2 <- paste0(api_part1, locn, api_part2, radius_meters, api_part3, sep = '')
  resultsout <- GET(querycomposite2, sig)
  
  collegeDataContent = content(resultsout)
  collegelist=jsonlite::fromJSON(toJSON(collegeDataContent))
  collegeresultsp <- data.frame(collegelist)
  
  colnames(collegeresultsp) = c("lat_delta", "long_delta", "latitude", "longitude", 
                                "total", "claim_biz", "yelp_rating", "mobile_url", 
                                "image_url", "No_of_reviews", "College", "image_url_small", 
                                "main_weblink", "categories", "phone", "short_text", 
                                "biz_image_url", "snippet_url", "display_phone", 
                                "rating_image_url", "biz_id", "closed", "location_city")
  
  tk <- subset(collegeresultsp, No_of_reviews > n)
  rownames( tk ) <- seq_len( nrow( tk ) )
  
  return(tk)
} 







