library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(plotly)
library(RColorBrewer)

# setwd("C:/Users/Dsola/OneDrive/Documentos/appsilon/biodiversity_shiny_app")

# Load data
load("data/normalized/ocurrence.RData")

# Load custom modules
source("src/modules/filterModule.R")
source("src/modules/mapModule.R")
source("src/modules/timelinePlotModule.R")
source("src/modules/defaultMessageModule.R")

# Define UI for application
ui <- dashboardPage(
  dashboardHeader(title = "Biodiversity Dashboard"),
  dashboardSidebar(sidebarMenu(
    menuItem("Map", tabName = "map", icon = icon("map")),
    filterUI("filter", occurence_data)
  )),
  dashboardBody(tabItems(
    tabItem(
      tabName = "map",
      fluidRow(
        box(
          title = "Instructions",
          status = "warning",
          solidHeader = TRUE,
          defaultMessageUI("default_message")
        ),
        box(
          title = "Map",
          status = "primary",
          solidHeader = TRUE,
          mapUI("map")
        )
      ),
      fluidRow(
        box(
          title = "Timeline Plot",
          width = 10,
          status = "primary",
          solidHeader = TRUE,
          collapsible = TRUE,
          collapsed = TRUE,
          timelineUI("timeline")
        )
      ),
      fluidRow(column(
        width = 12,
        p("Hover over the plot to see detailed point events.", style = "color: gray;"),
        p("Click and drag to zoom in on specific areas of the plot.", style = "color: gray;"),
        p("Uncollapse the plot and play rock and roll!", style = "color: gray;")
      ))
    )
  ))
)