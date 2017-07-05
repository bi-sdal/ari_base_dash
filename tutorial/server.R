library(shiny)
library(leaflet)
library(ggplot2)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
    
    output$map <- renderLeaflet({
        leaflet(data = df) %>%
            addTiles(
                urlTemplate = "//{s}.tiles.mapbox.com/v3/jcheng.map-5ebohr46/{z}/{x}/{y}.png",
                attribution = 'Maps by <a href="http://www.mapbox.com/">Mapbox</a>'
            ) %>%
            clearShapes() %>%
            addCircles(~long, ~lat, radius=~log(total_population) * 10000, layerId=~X,
                       stroke=FALSE, fillOpacity=0.4, fillColor='blue') %>%
            setView(lng = -93.85, lat = 37.45, zoom = 4)
    })
    
    output$zip <- renderPlot({
        ggplot(data = df, aes_string(x = 'zip_code', y = 'total_population')) +
            geom_bar(stat = 'identity', position='dodge')
    })
    
})
