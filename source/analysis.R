# This analysis file is not used within the index file. However, it is the combined
# code of all of my documents that I used to make my webpage
library(tidyverse)
country_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
juristidction_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends_jail_jurisdiction.csv")
summaryinfo <- list()
race_info <- list()
summaryinfo$average_jail_pop_per_county <- mean(country_level$total_jail_pop, na.rm = TRUE)
summaryinfo$average_pop_per_county <- mean(country_level$total_pop)
summaryinfo$number_of_jails <- length(unique(country_level$fips))
summaryinfo$amount_of_rows <- nrow(country_level)
summaryinfo$number_of_years <- length(unique(country_level$year))
summaryinfo$largest_jail_location <- country_level %>%
  filter(total_jail_pop == max(total_jail_pop, na.rm = TRUE)) %>%
  pull(county_name)
summaryinfo$largest_jail_pop <- country_level %>%
  filter(total_jail_pop == max(total_jail_pop, na.rm = TRUE)) %>%
  pull(total_jail_pop)

# The code above was used so that I could understand the scope and variability in
# the data. The code below was the data I used to create my summary paragraph

# The four lines below are ratios of jail and overall population to black and white population
race_info$avg_black_jail_prop <- sum(country_level$black_jail_pop, na.rm = TRUE) / sum(country_level$total_jail_pop, na.rm = TRUE)

race_info$avg_black_pop_prop <- sum(country_level$black_pop_15to64, na.rm = TRUE) / sum(country_level$total_pop_15to64, na.rm = TRUE)

race_info$avg_white_jail_prop <- sum(country_level$white_jail_pop, na.rm = TRUE) / sum(country_level$total_jail_pop, na.rm = TRUE)

race_info$avg_white_pop_prop <- sum(country_level$white_pop_15to64, na.rm = TRUE) / sum(country_level$total_pop_15to64, na.rm = TRUE)

# The data below is ratio split in ten year intervals that are a ratio of
# the amount of black people in prison compared to the black population itself
country_level_1980_1990 <- country_level %>%
  filter(year > 1979) %>%
  filter(year < 1991)

race_info$black_jail_amount_1980 <- sum(country_level_1980_1990$black_jail_pop, na.rm = TRUE) / sum(country_level_1980_1990$black_pop_15to64, na.rm = TRUE)

country_level_1990_2000 <- country_level %>%
  filter(year > 1989) %>%
  filter(year < 2001)

race_info$black_jail_amount_1990 <- sum(country_level_1990_2000$black_jail_pop, na.rm = TRUE) / sum(country_level_1990_2000$black_pop_15to64, na.rm = TRUE)

country_level_2000_2010 <- country_level %>%
  filter(year > 1999) %>%
  filter(year < 2011)

race_info$black_jail_amount_2000 <- sum(country_level_2000_2010$black_jail_pop, na.rm = TRUE) / sum(country_level_2000_2010$black_pop_15to64, na.rm = TRUE)

race_info$white_jail_amount_2000 <- sum(country_level_2000_2010$white_jail_pop, na.rm = TRUE) / sum(country_level_2000_2010$white_pop_15to64, na.rm = TRUE)

#The following code describes the variables needed for the graph
country_level <- country_level %>%
  mutate(black_jail_prop = black_jail_pop / black_pop_15to64, na.rm = TRUE)
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

# The following code creates the variables necessary for the variable comparison chart

yearly_data <- country_level %>%
  group_by(year) %>%
  summarise(
    white_pop_15_to_64 = sum(white_pop_15to64, na.rm = TRUE),
    white_jail_pop = sum(white_jail_pop, na.rm = TRUE),
    black_pop_15_to_64 = sum(black_pop_15to64, na.rm = TRUE),
    black_jail_pop = sum(black_jail_pop, na.rm = TRUE),
  )

# These four variables can be used to create a black_jail_prop 
# and white_jail_prop by year

yearly_data <- Yearly_data %>%
  filter(year > 1989)
# Data for black and white populations only appear after 1989, so all years
# before this are removed

yearly_data <- Yearly_data %>%
  mutate(white_jail_prop = white_jail_pop / white_pop_15_to_64)%>%
  mutate(black_jail_prop = black_jail_pop / black_pop_15_to_64)
# These proportions are what will be compared in the chart

library(usmap)
library(ggplot2)
country_level <- country_level %>%
  filter(year == 2018)

# Filter to 2018 only for current data

summary <- country_level %>%
  group_by(state) %>%
  summarise(black_jail_pop = sum(black_jail_pop, na.rm = TRUE), black_pop_15to64 = sum(black_pop_15to64, na.rm = TRUE))
summary <- summary %>%
  mutate(black_prop = black_jail_pop / black_pop_15to64)

# The map will measure this black_prop

library(lintr)
getwd()
lint("C:/Users/jacob/Documents/info201code/a3-jacobdsk/source/analysis.R")
