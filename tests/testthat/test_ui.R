library(testthat)
library(shiny)
library(shinydashboard)
library(leaflet)
library(dplyr)
library(plotly)
library(RColorBrewer)

# Mock data and modules for testing
occurence_data <- data.frame(
  scientificName = c("Species1", "Species2"),
  vernacularName = c("Common1", "Common2"),
  longitudeDecimal = c(10, 20),
  latitudeDecimal = c(50, 60),
  eventDate = as.Date(c("2020-01-01", "2021-01-01"))
)

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

# Define server logic
server <- function(input, output, session) {
  filter_inputs <- filterServer("filter", occurence_data)
  mapServer("map", filter_inputs)
  timelineServer("timeline", filter_inputs)
  defaultMessageServer("default_message")
}


# Simple test to check if the app can render whitout errors
test_that("UI can be rendered", {
  expect_silent(shinyApp(ui = ui, server = server))
})
