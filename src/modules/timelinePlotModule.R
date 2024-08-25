# Timeline Module

timelineUI <- function(id) {
  ns <- NS(id)
  plotlyOutput(ns("timeline_plot"))
}

timelineServer <- function(id, filter_inputs) {
  moduleServer(id, function(input, output, session) {
    output$timeline_plot <- renderPlotly({
      req(filter_inputs$species_value())
      timeline_data <- filter_inputs$filtered_data() %>% filter(!!sym(filter_inputs$filter_column()) %in% filter_inputs$species_value())
      
      if (nrow(timeline_data) == 0) {
        plot_ly() %>% layout(title = "No data available", xaxis = list(title = NULL), yaxis = list(title = NULL))
      } else {
        timeline_data <- timeline_data %>% group_by(eventDate, !!sym(filter_inputs$filter_column())) %>% summarize(count = n(), .groups = 'drop')
        standard_colors <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd")
        unique_values <- unique(timeline_data[[filter_inputs$filter_column()]])
        num_values <- length(unique_values)
        
        if (num_values <= length(standard_colors)) {
          color_map <- sample(standard_colors, num_values, replace = FALSE)
        } else {
          color_map <- RColorBrewer::brewer.pal(num_values, "Set1")
        }
        
        names(color_map) <- unique_values
        
        plot_ly(timeline_data, x = ~eventDate, y = ~count, color = ~get(filter_inputs$filter_column()), type = 'scatter', mode = 'lines', colors = color_map, line = list(width = 0.7)) %>% layout(title = "Timeline of Observations by Species", xaxis = list(title = "Date"), yaxis = list(title = "Number of Observations", range = c(0, max(timeline_data$count, na.rm = TRUE) + 1)))
      }
    })
  })
}