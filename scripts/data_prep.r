library(readr)
library(dplyr)
library(lubridate)

data_dir <- "data/"
file_paths <- list.files(path = data_dir, pattern = "*.csv", full.names = TRUE)

specific_dates <- dmy(c("20/12/2018", "3/1/2019", "19/3/2020", "26/3/2020",
                        "29/6/2020", "10/11/2020", "20/12/2020", "3/1/2021",
                        "29/11/2021", "25/7/2022", "24/7/2023"))

preprocess_file <- function(file_path) {
  read_csv(file_path, skip = 4) %>%
    mutate(Date = dmy(Date),
           PM10 = `PM<sub>10</sub> particulate matter (Hourly measured)`,
           NitricOxide = `Nitric oxide`,
           NOx_as_NO2 = `Nitrogen oxides as nitrogen dioxide`) %>%
    select(Date, PM10, NitricOxide, NOx_as_NO2) %>%
    filter(Date %in% specific_dates)
}

combined_data <- lapply(file_paths, preprocess_file) %>% bind_rows()

weighted_monthly_avg_2020 <- combined_data %>%
  filter(year(Date) == 2020) %>%
  group_by(Month = month(Date), .drop = FALSE) %>%
  summarize(DaysWithData = n_distinct(Date[!is.na(PM10)]),
            TotalPM10 = sum(PM10, na.rm = TRUE),  
            WeightedAvgPM10 = TotalPM10 / DaysWithData)  

write.csv(weighted_monthly_avg_2020, "weighted_monthly_avg_2020.csv", row.names = FALSE)
