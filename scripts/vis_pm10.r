library(ggplot2)
library(plotly)

generatePM10Plot <- function(data) {
  pm10_data <- data %>% filter(!is.na(PM10))
  
  p <- ggplot(pm10_data, aes(x = Date, y = PM10)) +
    geom_line() + geom_point() +
    labs(title = "PM10 Levels on Specific Dates", x = "Date", y = "PM10 (µg/m³)") +
    theme_minimal()
  
  ggplotly(p)
}
