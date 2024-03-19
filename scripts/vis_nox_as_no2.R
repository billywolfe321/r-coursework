library(ggplot2)
library(plotly)

NOxAsNO2Plot <- function(data) {
  # Basic NOx as NO2 plot
  p <- ggplot(data, aes(x = Date, y = NOx_as_NO2)) +  
    geom_point(aes(color = NOx_as_NO2), size = 3, alpha = 0.6) +  # Points for NOx as NO2 levels
    geom_smooth(method = "loess", color = "blue", se = FALSE) +  # Add a loess smoothed line
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
    labs(title = "NOx as NO2 Levels Over Time", x = "Date", y = "NOx as NO2 (µg/m³)") +
    scale_color_gradient(low = "yellow", high = "red")  # Use a color gradient for NOx as NO2 values
  
  # Convert the ggplot object to a plotly object for interactivity
  ggplotly(p, tooltip = c("x", "y", "color"))
}

# Example usage, assuming 'data' is your dataframe
# visNOxAsNO2Plot(data)



NOxAsNO2AveragePlot <- function(data) {

  daily_averages <- aggregate(NOx_as_NO2 ~ Date, data = data, FUN = function(x) mean(x, na.rm = TRUE))
  names(daily_averages)[2] <- "AverageNOx_as_NO2"

  p <- ggplot(daily_averages, aes(x = Date, y = AverageNOx_as_NO2)) +
    geom_line(color = "darkblue", size = 1) +
    geom_point(color = "darkred", size = 2, alpha = 0.8) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    labs(title = "Daily Average NOx as NO2 Levels", x = "Date", y = "Average NOx as NO2 (µg/m³)")

  ggplotly(p)
}
