library(ggplot2)
library(plotly)

generateNitricOxidePlot <- function(combined_data) {
  p <- ggplot(combined_data, aes(x = Date, y = `NOx_as_NO2`)) +
    geom_area(fill = "skyblue", alpha = 0.5) +
    geom_line(color = "blue") +
    labs(title = "Cumulative Nitric Oxide Levels Over Time",
         x = "Date",
         y = "Cumulative Nitric Oxide (µg/m³)") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1))
  
  ggplotly(p)
}




