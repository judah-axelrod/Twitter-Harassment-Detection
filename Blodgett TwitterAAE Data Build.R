library(tidyverse)
options(scipen=999)
# setwd(['My_Directory'])

####################################
#Import Data
####################################
blodgett_ids <- read_tsv('TwitterAAE-full-v1/twitteraae_limited',col_names = F,)
blodgett_tweets <- read_tsv('TwitterAAE-full-v1/twitteraae_all.tsv',col_names = F,
                   quote='flugen') #Can put any nonsensical string here so that it doesn't treat '\"' as a line delimiter

##########################################
#Limit IDs to pAAE > 0.8 or pWhite > 0.8
##########################################

blodgett_ids_lim <- blodgett_ids %>%
  filter(X3 > 0.8 | X6 > 0.8) %>%
  select(ID = X1, pAAE = X3, pWhite = X6) %>%
  mutate(AAE = as.numeric(pAAE > pWhite))
#Free up RAM
rm(blodgett_ids)

##########################################
#Remove duplicate IDs 
#(have multiple associated probabilities)
##########################################

single_ids <- blodgett_ids_lim %>%
  select(ID) %>%
  group_by_all %>%
  filter(n() == 1)   

blodgett_ids_lim <- inner_join(blodgett_ids_lim, single_ids, by='ID')
  


##########################################
#Join IDs to the full-text tweets
#(Again removing duplicates)
##########################################
c_blodgett <- blodgett_ids_lim %>%
  inner_join(select(blodgett_tweets, X1, X6), by=c('ID'='X1')) %>%
  rename(tweet = X6) %>%
  group_by(ID) %>%
  filter(n()==1)

c_blodgett <- c_blodgett %>% select(ID, tweet, AAE)

##########################################
#Randomly sample 100K of tweets from each race
#so we have same number of both
#(for computational reasons)
##########################################

set.seed(449)
AAE <- c_blodgett %>%
  ungroup() %>%
  filter(AAE == 1) %>%
  slice_sample(n = 50000)


white <- c_blodgett %>%
  ungroup() %>%
  filter(AAE == 0) %>%
  slice_sample(n = 50000)

c_blodgett <- bind_rows(AAE, white)


####################################
#Export Data
####################################
write.csv(c_blodgett, 'c_blodgett.csv')

