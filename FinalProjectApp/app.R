
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
                               "energy", "instrumentalness", "liveness",
                               "loudness", "speechiness", "tempo", "valence")),
    plotOutput(outputId = "spotplot", width = "100%"))


server <- function(input, output){
  output$spotplot <- renderPlot({
    Spotify_Big %>%
      filter(genre == input$genre) %>%
      ggplot(aes(y=popularity)) +
      geom_hex(aes_string(x=input$xaxis)) +
      labs(y="Popularity", fill = "Distribution of Popularity")
    }, height = 600, width = 700)
}


shinyApp(ui = ui, server = server)
