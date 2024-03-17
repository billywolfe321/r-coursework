library(shiny)
library(plotly)
library(dplyr)

source("scripts/data_prep.R")
source("scripts/vis_pm10.R")
source("scripts/vis_nitric_oxide.R") 
source("scripts/vis_nox_as_no2.R")  

ui <- fluidPage(
  titlePanel("Air Quality Visualizations for Portsmouth's CAZ"),
  
  sidebarLayout(
    sidebarPanel(
      selectInput("visualization", "Choose a Visualization:",
                  choices = list("PM10 Levels" = "pm10",
                                 "Nitric Oxide Levels" = "nitric_oxide",
                                 "NOx as NO2" = "nox_as_no2"))
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
           "pm10" = generatePM10Plot(combined_data),
           "nitric_oxide" = generateNitricOxidePlot(combined_data),
           "nox_as_no2" = generateNOxAsNO2Plot(combined_data))
  })
}
shinyApp(ui = ui, server = server)
