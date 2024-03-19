library(shiny)
library(plotly)
library(dplyr)
library(tidyr)

# Source all required scripts
source("scripts/data_prep.r")
source("scripts/vis_pm10.r")
source("scripts/vis_nitric_oxide.R") 
source("scripts/vis_nox_as_no2.R")
#source("scripts/vis_monthly_avg_2020.R")  # Source the script for monthly averages visualization

ui <- fluidPage(
  titlePanel("Air Quality Visualization for 2020"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("visualization", "Choose a Visualization:",
                  choices = list("PM10 Levels" = "pm10",
                                 "Nitric Oxide Levels" = "nitric_oxide",
                                 "NOx as NO2 Levels" = "nox_as_no2")),
      checkboxInput("showAverage", "Show Daily Averages", FALSE)
    ),
    
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    req(input$visualization)
    
    switch(input$visualization,
           "pm10" = if(input$showAverage) AvgPM10Plot(combined_data) else PM10Plot(combined_data),
           "nitric_oxide" = if(input$showAverage) AvgNitricOxidePlot(combined_data) else NitricOxidePlot(combined_data),
           "nox_as_no2" = if(input$showAverage) AvgNOxAsNO2Plot(combined_data) else NOxAsNO2Plot(combined_data),
    )
  })
}

shinyApp(ui = ui, server = server)
