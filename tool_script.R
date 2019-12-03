
library(shiny)
library(dplyr)
monthStart <- function(x) {
  x <- as.POSIXlt(x)
  x$mday <- 1
  as.Date(x)
}

mindate <- "2020-08-01"
maxdate <- "2021-7-31"

ui <- fluidPage(
  radioButtons("dataset", "Choose a zone configuration",
              c("Two zones"="two","Three zones"="three")),
  sliderInput(inputId = "Order",
              label = "Choose a fishing season",  
              min = as.Date(mindate, origin='1970-01-01'), max = as.Date(maxdate, origin='1970-01-01'), value = c(as.Date(mindate, origin='1970-01-01'),as.Date(maxdate, origin='1970-01-01')),
              timeFormat='%m-%d-%y', dragRange = TRUE, width='700px'),
  plotOutput("plot")
)

server <- function(input, output){
  y_data <- reactive({
    if (input$dataset == "two")
      two
    else if (input$dataset == "three")
      three
  })
  output$plot <- renderPlot({
    y_data() %>% group_by(y_data()$zones) %>%
      mutate(Harvest = cumsum(landings)) %>%
      ggplot(y_data()[as.Date(y_data()$day) == input$Order ], mapping=aes(color = zones)) +
      geom_line(aes(x=day, y = Harvest))
    
  })
   
}
shinyApp(ui = ui, server = server)
