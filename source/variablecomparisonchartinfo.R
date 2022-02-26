# This file creates the variables necessary for the variable comparison chart
country_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
juristidction_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends_jail_jurisdiction.csv")
library(tidyverse)


Yearly_data <- country_level %>%
  group_by(year) %>%
  summarise(
    white_pop_15to64 = sum(white_pop_15to64, na.rm = TRUE),
    white_jail_pop = sum(white_jail_pop, na.rm = TRUE),
    black_pop_15to64 = sum(black_pop_15to64, na.rm = TRUE),
    black_jail_pop = sum(black_jail_pop, na.rm = TRUE),
  )

# These four variables can be used to create a black_jail_prop and white_jail_prop
# by year

Yearly_data <- Yearly_data %>%
  filter(year > 1989)
# Data for black and white populations only appear after 1989, so all years
# before this are removed

Yearly_data <- Yearly_data %>%
  mutate(white_jail_prop = white_jail_pop/white_pop_15to64)%>%
  mutate(black_jail_prop = black_jail_pop/black_pop_15to64)
# These proportions are what will be compared in the chart