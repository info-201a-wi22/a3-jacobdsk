library(tidyverse)
country_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends.csv")
juristidction_level <- read.csv("https://raw.githubusercontent.com/vera-institute/incarceration-trends/master/incarceration_trends_jail_jurisdiction.csv")
summaryinfo <- list()
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
summaryinfo$smallest_jail_pop <- country_level %>%
  filter(total_jail_pop == min(total_jail_pop, na.rm = TRUE)) %>%
  length(unique(country_level$county_name))
