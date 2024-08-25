# Filter Module

filterUI <- function(id) {
  ns <- NS(id)
  tagList(
    selectInput(ns("filter_column"), "Select column to filter:", choices = c("scientificName", "vernacularName")),
    selectInput(ns("filter_value"), "Select value(s):", choices = NULL, multiple = TRUE),
    selectInput(ns("species_value"), "Select species for timeline:", choices = NULL, multiple = TRUE),
    dateRangeInput(ns("date_range"), "Select Date Range:", start = min(data$eventDate, na.rm = TRUE), end = max(data$eventDate, na.rm = TRUE)),
    actionButton(ns("reset_date"), "Reset Date Filter", icon = icon("refresh"))
  )
}

filterServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    observe({
      req(input$filter_column)
      updateSelectInput(session, "filter_value", choices = sort(unique(data[[input$filter_column]])))
    })
    
    observe({
      req(input$filter_value)
      updateSelectInput(session, "species_value", choices = sort(input$filter_value))
    })
    
    observeEvent(input$reset_date, {
      updateDateRangeInput(session, "date_range", start = min(data$eventDate, na.rm = TRUE), end = max(data$eventDate, na.rm = TRUE))
    })
    
    filtered_data <- reactive({
      data %>% filter(eventDate >= input$date_range[1] & eventDate <= input$date_range[2])
    })
    
    return(list(
      filter_column = reactive(input$filter_column),
      filter_value = reactive(input$filter_value),
      species_value = reactive(input$species_value),
      filtered_data = filtered_data
    ))
  })
}