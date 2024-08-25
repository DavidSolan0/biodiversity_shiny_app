# Map Module

mapUI <- function(id) {
  ns <- NS(id)
  leafletOutput(ns("mymap"))
}

mapServer <- function(id, filter_inputs) {
  moduleServer(id, function(input, output, session) {
    output$mymap <- renderLeaflet({
      req(filter_inputs$filter_column())
      standard_colors <- c("#1f77b4", "#ff7f0e", "#2ca02c", "#d62728", "#9467bd")
      
      if (is.null(filter_inputs$filter_value()) || length(filter_inputs$filter_value()) == 0) {
        leaflet() %>% addTiles() %>% setView(lng = 0, lat = 0, zoom = 2)
      } else {
        map_data <- filter_inputs$filtered_data() %>% filter(!!sym(filter_inputs$filter_column()) %in% filter_inputs$filter_value())
        if (nrow(map_data) == 0) {
          leaflet() %>% addTiles() %>% setView(lng = 0, lat = 0, zoom = 2) %>% addMarkers(lng = 0, lat = 0, popup = "No data available")
        } else {
          leaflet(map_data) %>% addTiles() %>% addMarkers(~longitudeDecimal, ~latitudeDecimal, popup = ~paste("Scientific Name:", scientificName, "<br>Vernacular Name:", vernacularName, "<br>Event Date:", eventDate))
        }
      }
    })
  })
}