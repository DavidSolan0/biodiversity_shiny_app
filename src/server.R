library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(plotly)  
library(RColorBrewer)

# Define server logic
server <- function(input, output, session) {
  filter_inputs <- filterServer("filter", data)
  mapServer("map", filter_inputs)
  timelineServer("timeline", filter_inputs)
  defaultMessageServer("default_message")
}
