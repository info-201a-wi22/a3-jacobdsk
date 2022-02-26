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
race_info$avg_black_jail_prop <- sum(country_level$black_jail_pop, na.rm = TRUE)/sum(country_level$total_jail_pop, na.rm = TRUE)

race_info$avg_black_pop_prop <- sum(country_level$black_pop_15to64, na.rm = TRUE)/sum(country_level$total_pop_15to64, na.rm = TRUE)

race_info$avg_white_jail_prop <- sum(country_level$white_jail_pop, na.rm = TRUE)/sum(country_level$total_jail_pop, na.rm = TRUE)

race_info$avg_white_pop_prop <- sum(country_level$white_pop_15to64, na.rm = TRUE)/sum(country_level$total_pop_15to64, na.rm = TRUE)

# The data below is ratio split in ten year intervals that are a ratio of
# the amount of black people in prison compared to the black population itself
country_level_1980_1990 <- country_level %>%
  filter(year > 1979) %>%
  filter(year < 1991)

race_info$black_jail_amount_1980 <- sum(country_level_1980_1990$black_jail_pop, na.rm = TRUE)/sum(country_level_1980_1990$black_pop_15to64, na.rm = TRUE)

country_level_1990_2000 <- country_level %>%
  filter(year > 1989) %>%
  filter(year < 2001)

race_info$black_jail_amount_1990 <- sum(country_level_1990_2000$black_jail_pop, na.rm = TRUE)/sum(country_level_1990_2000$black_pop_15to64, na.rm = TRUE)

country_level_2000_2010 <- country_level %>%
  filter(year > 1999) %>%
  filter(year < 2011)

race_info$black_jail_amount_2000 <- sum(country_level_2000_2010$black_jail_pop, na.rm = TRUE)/sum(country_level_2000_2010$black_pop_15to64, na.rm = TRUE)

race_info$white_jail_amount_2000 <- sum(country_level_2000_2010$white_jail_pop, na.rm = TRUE)/sum(country_level_2000_2010$white_pop_15to64, na.rm = TRUE)
