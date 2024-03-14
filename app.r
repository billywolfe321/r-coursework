library(shiny)
library(plotly)
library(dplyr)

source("scripts/data_prep.R")
source("scripts/vis_pm10.R")


ui <- fluidPage(
  titlePanel("Air Quality Visualizations for Portsmouth's CAZ"),
  sidebarLayout(
    sidebarPanel(
      selectInput("visualization", "Choose a Visualization:",
                  choices = list("PM10 Levels" = "pm10"))
    ),
    mainPanel(
      plotlyOutput("plot")
    )
  )
)

server <- function(input, output) {
  output$plot <- renderPlotly({
    req(input$visualization)
    if (input$visualization == "pm10") {
      generatePM10Plot(combined_data)
    }
  })
}
shinyApp(ui = ui, server = server)
