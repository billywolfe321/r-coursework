library(ggplot2)
library(plotly)

NitricOxidePlot <- function(data) {
  # Basic Nitric Oxide plot with individual measurements and a trend line
  p <- ggplot(data, aes(x = Date, y = NitricOxide)) +  
    geom_point(aes(color = NitricOxide), size = 3, alpha = 0.6) +  # Points for Nitric Oxide levels
    geom_smooth(method = "loess", color = "blue", se = FALSE) +  # Add a loess smoothed line to indicate the trend
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
    labs(title = "Nitric Oxide Levels Over Time", x = "Date", y = "Nitric Oxide (µg/m³)") +
    scale_color_gradient(low = "green", high = "blue")  # Use a color gradient for Nitric Oxide values
  
  # Convert the ggplot object to a plotly object for interactivity
  ggplotly(p, tooltip = c("x", "y", "color"))
}

# Example usage, assuming 'data' is your dataframe
# visNitricOxidePlot(data)



NitricOxideAvgPlot <- function(data) {
  daily_averages <- summarise(group_by(data, Date), 
                              AvgNitricOxide = mean(NitricOxide, na.rm = TRUE))
  p <- ggplot(daily_averages, aes(x = Date, y = AvgNitricOxide)) +
    geom_line(color = "blue", size = 1) +
    geom_point(color = "red", size = 1, alpha = 1) +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust=1)) +
    labs(title = "Daily Average Nitric Oxide Levels", x = "Date", y = "Average Nitric Oxide (µg/m³)")

  ggplotly(p)
}






