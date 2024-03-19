library(ggplot2)
library(plotly)
library(dplyr)

PM10Plot <- function(data) {
  # Check if 'time' column exists and is not empty
  if("time" %in% names(data) && nrow(data[data$time != "", ]) > 0) {
    data$time <- as.character(data$time)
  }
  
  # Ensure Date is in a proper format
  data$Date <- as.Date(data$Date)
  
  # Basic PM10 plot without relying on 'time' column
  p <- ggplot(data, aes(x = Date, y = PM10)) +  
    geom_point(aes(color = PM10), size = 3, alpha = 0.6) +
    geom_smooth(method = "loess", color = "blue", se = FALSE) +  # Add a loess smoothed line
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +
    labs(title = "PM10 Levels Over Time", x = "Date", y = "PM10 (µg/m³)") +
    scale_color_gradient(low = "yellow", high = "red")  # Use a color gradient for PM10 values
  
  return(ggplotly(p))
}


AvgPM10Plot <- function(data) {
  # Calculate daily averages, ensuring 'Date' is in the correct format and handling missing values
  daily_averages <- data %>%
    group_by(Date) %>%
    summarize(AvgPM10 = mean(PM10, na.rm = TRUE)) %>%
    ungroup()  # Make sure the data frame is ungrouped after summarization
  
  # Create a bar chart for daily averages
  p <- ggplot(daily_averages, aes(x = Date, y = AvgPM10)) +
    geom_bar(stat = "identity", fill = "steelblue") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 90, vjust = 0.5, hjust = 1)) +
    labs(title = "Daily Average PM10 Levels", x = "Date", y = "Average PM10 (µg/m³)")
  
  # Convert to an interactive plotly graph for enhanced interactivity
  ggplotly(p, tooltip = "text")
}


