# Default Message Module

defaultMessageUI <- function(id) {
  ns <- NS(id)
  uiOutput(ns("default_message"))
}

defaultMessageServer <- function(id) {
  moduleServer(id, function(input, output, session) {
    output$default_message <- renderUI({
      tagList(
        h3("Welcome to the Geographical Coordinates Map"),
        p(
          "This dashboard is designed to help you visualize biodiversity observations on a map and analyze how frequently species are observed over time."
        ),
        p("To get started, follow these steps:"),
        tags$ul(
          tags$li(
            "Select a column to filter by either 'scientificName' or 'vernacularName' from the sidebar."
          ),
          tags$li(
            "Once a column is selected, the box below will update to show the possible values for that column."
          ),
          tags$li(
            "You can select one or multiple values from this box to filter the data."
          ),
          tags$li(
            "After selecting filter values, a new dropdown will appear allowing you to choose species for timeline analysis."
          ),
          tags$li(
            "The map will then display the locations of the selected species observations, and the plot will show the frequency of observations over time."
          ),
          tags$li(
            "Click on each coordinate in the map to view additional information about the observation."
          )
        ),
        p(
          "Use these tools to explore the data and gain insights into species distribution and observation trends."
        )
      )
    })
  })
}
