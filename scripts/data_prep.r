library(readr)
library(dplyr)
library(lubridate)
library(zoo)

data_dir <- "data/"
file_paths <- list.files(path = data_dir, pattern = "*.csv", full.names = TRUE)

specific_dates <- dmy(c("20/12/2018", "3/1/2019", "19/3/2020", "26/3/2020",
                        "29/6/2020", "10/11/2020", "20/12/2020", "3/1/2021", "29/11/2021", "25/7/2022",
                        "24/7/2023"))
preprocess_file <- function(file_path) {
  data <- read_csv(file_path, skip = 4)
  data <- mutate(data, 
                 Date = dmy(Date), 
                 PM10 = na.approx(`PM<sub>10</sub> particulate matter (Hourly measured)`, na.rm = FALSE),
                 NitricOxide = na.approx(`Nitric oxide`, na.rm = FALSE),
                 NOx_as_NO2 = na.approx(`Nitrogen oxides as nitrogen dioxide`, na.rm = FALSE))
  data <- select(data, Date, time, PM10, NitricOxide, NOx_as_NO2)
  data <- arrange(data, Date, time)
  data <- filter(data, Date %in% specific_dates)
  return(data)
}
combined_data_list <- lapply(file_paths, preprocess_file)
# Continue from the previous part of the data_prep script
combined_data <- do.call("bind_rows", combined_data_list)



