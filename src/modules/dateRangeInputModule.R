dateRangeInputModuleUI <- function(id) {
  ns <- NS(id)
  dateRangeInput(ns("date_range"), "Select Date Range:", 
                 start = min(data$eventDate, na.rm = TRUE),
                 end = max(data$eventDate, na.rm = TRUE))
}

dateRangeInputModuleServer <- function(id, data) {
  moduleServer(id, function(input, output, session) {
    ns <- session$ns
    
    observeEvent(input$reset_date, {
      updateDateRangeInput(session, "date_range",
                           start = min(data$eventDate, na.rm = TRUE),
                           end = max(data$eventDate, na.rm = TRUE))
    })
    
    return(reactive({
      data %>%
        filter(eventDate >= input$date_range[1] & eventDate <= input$date_range[2])
    }))
  })
}
