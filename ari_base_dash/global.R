library(rio)
library(dplyr)

df <- read.csv('/home/sdal/projects/ari_base_char/final/ACS_data_base.csv')
data <- rio::import('/home/aerogers/git/ari_base_char/data/ari_base_char/working/test_map.csv')
base_df <- rio::import('/home/aerogers/git/ari_base_char/data/ari_base_char/original/base_df.csv')
county <-read.csv('/home/sdal/projects/ari_base_char/final/ACS_data_county.csv')
df_big <- read.csv('/home/sdal/projects/ari_base_char/final/ACS_data_zctas.csv')


  #read.csv('/home/git/ari_base_char/src/aerogers/Graph_Data-Sheet1.csv')
#source('~/git/ari_base_char/Exploratory_Analysis/Functions.R')

# #select bases (only forts) for selective comparison based off of quantiles
# base_fourth <- df[which(df$population>=52632),]
# base_third <- df[which(df$population>=26888 & df$population<=52632),]
# base_second <- df[which(df$population>=9296 & df$population<=26888),]
# base_first <- df[which(df$population<=9296),]
# compare_fourth <- sample_n(base_fourth,5)
# #Fort Lewis, Fort Knox, Tripler AMC, Helemano Military Reservation, Fort Hood
# compare_third <- sample_n(base_third,5)
# #Tooele Army Depot, Rock Island Arsenal, Fort Myer, Letterkenny Army Depot, Fort Lee
# compare_second <- sample_n(base_second,5)
# #Detroit Arsenal, Presidio of Monterey Umatilla Chem Depot, Carlisle Barracks, Stewart Annex
# compare_first <- sample_n(base_first,5)
# #Brown Stagefield, Toth Stagefield, Cairns Basefield, Kawaihae Military Reserve Skelly Stagefield
