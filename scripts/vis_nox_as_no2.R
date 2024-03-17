library(ggplot2)
library(plotly)

generateNOxAsNO2Plot <- function(combined_data) {
  nox_data <- combined_data %>%
    filter(!is.na(`NOx_as_NO2`))  
  
  p <- ggplot(nox_data, aes(x = Date, y = `NOx_as_NO2`)) + 
    geom_line(color = '#00BA38') +
    geom_point(color = '#F8766D', size = 2, alpha = 0.7) +
    labs(title = "NOx as NO2 Levels on Specific Dates",
         x = "Date",
         y = "NOx as NO2 (µg/m³)") +
    theme_minimal()
  
  ggplotly(p)
}
