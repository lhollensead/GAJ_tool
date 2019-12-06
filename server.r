#server
server <- function(input, output){
  y_data <- reactive({
    if (input$dataset == "two")
      two
    else if (input$dataset == "three")
      three
  })
  y_data2<-reactive({
    x <- y_data()
    x2 <- subset(x, day>input$Order[1]& day<input$Order[2])
  })
  output$plot <- renderPlot({
    y_data2() %>% group_by(y_data2()$zones) %>%
      mutate(Harvest = cumsum(landings)) %>%
      ggplot(y_data2()[as.Date(y_data2()$day) == input$Order ], mapping=aes(color = zones)) +
      geom_line(aes(x=day, y = Harvest))
    
  })
  
}
#shinyApp(ui = ui, server = server)