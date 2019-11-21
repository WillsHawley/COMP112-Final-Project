
library(shiny)
library(tidyverse)

ui <- fluidPage(
    titlePanel("Spotify Data App"),
    selectInput(inputId = "genre", label = "Genre of Music",
                choices = list("Pop", "Rap", "Rock", "Hip-Hop", "Dance", "Indie",
                               "Children's Music", "R&B", "Alternative",
                               "Folk", "Soul", "Country", "Jazz", "Electronic",
                               "Reggaeton", "Reggae", "World", "Blues",
                               "Soundtrack", "Classical", "Ska", "Anime",
                               "Comedy", "Opera", "Movie", "A Capella")),
    selectInput(inputId = "xaxis", label = "X-Variable", 
                choices = list("valence", "danceability")),
    plotOutput(outputId = "spotplot"))


server <- function(input, output){
  output$spotplot <- renderPlot({
    Spotify_Big %>%
      filter(genre == input$genre) %>%
      ggplot() +
      geom_bin2d(aes(y=popularity, x= input$xaxis))
    })
}


shinyApp(ui = ui, server = server)
