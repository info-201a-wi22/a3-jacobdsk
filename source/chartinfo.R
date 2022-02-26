country_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
juristidction_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends_jail_jurisdiction.csv")
library(tidyverse)

country_level <- country_level %>%
  mutate(black_jail_prop = black_jail_pop/black_pop_15to64, na.rm = TRUE)
# black_jail_prop is the variable I will track in this graph

los_angeles_data <- country_level %>%
  filter(county_name == "Los Angeles County") %>%
  filter(year > 1989)
new_york_data <- country_level %>%
  filter(county_name == "New York County") %>%
  filter(year > 1989)
cook_data <- country_level %>%
  filter(county_name == "Cook County") %>%
  filter(year > 1989) %>%
  filter(state == "IL")

# These 3 counties are the highest population counties, so they will be the
# main focus of the graph
