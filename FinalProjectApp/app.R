
library(shiny)
library(tidyverse)
library(ggthemes)
library(ggplot2)
Spotify_Big <- read_csv("SpotifyFeatures.csv") 

ui <- fluidPage(
  navbarPage("Spotify Data Analysis App",
             tabPanel("Plot 1",
  titlePanel("Geometric Hexagon Plot"),
    sidebarLayout(
      sidebarPanel(
        selectInput(inputId = "genre", label = "Genre of Music",
                              choices = list("A Capella", "Alternative", "Anime", "Blues", "Children's Music", "Classical", "Comedy",
                                             "Country", "Dance", "Electronic", "Folk", "Hip-Hop", "Indie", "Jazz", "Movie", "Opera",
                                             "Pop", "R&B", "Rap", "Reggae", "Reggaeton", "Rock", "Ska", "Soul", "Soundtrack", "World")),
                  selectInput(inputId = "xaxis", label = "Measure of Music",
                              choices = list("danceability", "acousticness", "duration_ms",
                                             "energy", "instrumentalness", "liveness",
                                             "loudness", "speechiness", "tempo", "valence")),
                  submitButton(text="Apply Changes")),
    mainPanel(plotOutput(outputId = "spotplot")))),
    tabPanel("Plot 2",
             titlePanel("Boxplot Distribution"),
             sidebarLayout(
               sidebarPanel(
                 checkboxGroupInput(inputId = "genre1", label = "Genre of Music",
                                                    choices = list("A Capella", "Alternative", "Anime", "Blues", "Children's Music", "Classical", "Comedy",
                                                                   "Country", "Dance", "Electronic", "Folk", "Hip-Hop", "Indie", "Jazz", "Movie", "Opera",
                                                                   "Pop", "R&B", "Rap", "Reggae", "Reggaeton", "Rock", "Ska", "Soul", "Soundtrack", "World")),
                                        selectInput(inputId = "xaxis1", label = "Measure of Music",
                                                    choices = list("danceability", "acousticness", "duration_ms",
                                                                   "energy", "instrumentalness", "liveness",
                                                                   "loudness", "speechiness", "tempo", "valence")),
                                        submitButton(text="Apply Changes")),
                           mainPanel(plotOutput(outputId = "boxplot")))
                                        )
    )
  )


server <- function(input, output){
  output$spotplot <- renderPlot({
    Spotify_Big %>%
      filter(genre == input$genre) %>%
      ggplot(aes(y=popularity)) +
      geom_hex(aes_string(x=input$xaxis)) +
      labs(y="Popularity", fill = "Distribution of Popularity") +
      theme_clean() +
      scale_fill_viridis_c()
    }, height = 700, width = 800)
  
  output$boxplot <- renderPlot({
    Spotify_Big %>%
      filter(genre %in% input$genre1) %>%
      ggplot(aes(x=genre, fill = genre)) +
      geom_boxplot(aes_string(
                       y=input$xaxis1
                       ))
  })
}


shinyApp(ui = ui, server = server)
