library(rio)
library(dplyr)

df <- read.csv('ari_base_dash/data/server_data/ACS_data_base.csv')
data <- rio::import('ari_base_dash/data/server_data/test_map.csv')
base_df <- rio::import('ari_base_dash/data/server_data/base_df.csv')
county <- read.csv('ari_base_dash/data/server_data/ACS_data_county.csv')
df_big <- read.csv('ari_base_dash/data/server_data/ACS_data_zctas.csv')
