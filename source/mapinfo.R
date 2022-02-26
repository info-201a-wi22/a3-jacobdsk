country_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
juristidction_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends_jail_jurisdiction.csv")

library(usmap)
library(ggplot2)
library(tidyverse)
country_level <- country_level %>%
  filter(year == 2018)

summary <- country_level %>% 
  group_by(state) %>% 
  summarise(black_jail_pop = sum(black_jail_pop, na.rm = TRUE), black_pop_15to64 = sum(black_pop_15to64, na.rm = TRUE))
summary <- summary %>%
  mutate(black_prop = black_jail_pop/black_pop_15to64)

