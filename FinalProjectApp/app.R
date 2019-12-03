
library(shiny)
library(tidyverse)
Spotify_Big <- read_csv("SpotifyFeatures.csv")

ui <- fluidPage(
    titlePanel("Spotify Data App"),
    selectInput(inputId = "genre", label = "Genre of Music",
                choices = list("Pop", "Rap", "Rock", "Hip-Hop", "Dance", "Indie",
                               "Children's Music", "R&B", "Alternative",
                               "Folk", "Soul", "Country", "Jazz", "Electronic",
                               "Reggaeton", "Reggae", "World", "Blues",
                               "Soundtrack", "Classical", "Ska", "Anime",
                               "Comedy", "Opera", "Movie", "A Capella")),
    selectInput(inputId = "xaxis", label = "Measure of Music",
                choices = list("danceability", "acousticness", "duration_ms",
                               "energy", "intrumentalness", "liveness",
                               "loudness", "speechiness", "tempo", "valence")),
    plotOutput(outputId = "spotplot"))


server <- function(input, output){
  output$spotplot <- renderPlot({
    Spotify_Big %>%
      filter(genre == input$genre) %>%
      ggplot() +
      geom_hex(aes(y=popularity, x= input$xaxis)) +
      labs(y="Popularity", x="Danceability", fill = "Distribution of Popularity")
    })
}


shinyApp(ui = ui, server = server)
