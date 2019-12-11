#server
server <- function(input, output, session){
  y_data <- reactive({
  if(input$dataset=="No zones: Gulf-wide season allocation")
  none
  if (input$dataset == "Two zones: West (TX,LA,MS) & East (AL,FL)")
  two
  else if (input$dataset == "Three zones: West (TX,LA,MS), North (AL to FL Dixie/Levy County, South (south of FL Dixie/Levy County)")
  three
  })
  

output$allocationoption <- renderUI({
  radioButtons(
    inputId = "allocationoption",
    if(input$dataset=="none"){
      label = "Gulf-wide seasonal allocation"}else
        label="Zone allocation",
    if(input$dataset=="none"){
      choices = c("50-50","60-40","70-30")}else
        if(input$dataset=="two"){
          choices = c("50-50","60-40","70-30")}else
      if(input$dataset=="three"){
        choices = c("33-33-33","60-20-20","50-25-25")}
  )
})


  output$Order <- renderUI({
    if(input$dataset=="none"){
    sliderInput(inputId = "Order",
                label = "Choose a spring fishing season",  
                min = as.Date('2020-05-01', origin='1970-01-01'), max = as.Date('2020-05-31', origin='1970-01-01'), value = c(as.Date('2020-05-01', origin='1970-01-01'),as.Date(maxdate, origin='1970-01-01')),
                timeFormat='%m-%d-%y', dragRange = TRUE, width='700px')
  
    }

  })
  
  output$Order2 <- renderUI({
    if(input$dataset=="none"){
      sliderInput(inputId = "Order2",
                  label = "Choose a fall fishing season",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2020-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2020-12-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%y', dragRange = TRUE, width='700px')
      
    }
    
  })
  
  output$Order3 <- renderUI({
    if(input$dataset=="two"){
      sliderInput(inputId = "Order3",
                  label = "West zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-12-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order4 <- renderUI({
    if(input$dataset=="two"){
      sliderInput(inputId = "Order4",
                  label = "East zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-12-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order5 <- renderUI({
    if(input$dataset=="three"){
      sliderInput(inputId = "Order5",
                  label = "West zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-12-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order6 <- renderUI({
    if(input$dataset=="three"){
      sliderInput(inputId = "Order6",
                  label = "North zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-12-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order7 <- renderUI({
    if(input$dataset=="three"){
      sliderInput(inputId = "Order7",
                  label = "South zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-12-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%y', dragRange = TRUE, width='700px')
      
    }
    
  })
                               
}
  #y_data <- reactive({
    #if(input$dataset=="No zones")
      #none
    #if (input$dataset == "Two zones")
      #two
    #else if (input$dataset == "Three zones")
      #three
  #})
  #y_data2<-reactive({
    #x <- y_data()
    #x2 <- subset(x, day>input$Order[1]& day<input$Order[2])
  #})
  #output$plot <- renderPlot({
    #y_data2() %>% group_by(y_data2()$zones) %>%
     # mutate(Harvest = cumsum(landings)) %>%
      #ggplot(y_data2()[as.Date(y_data2()$day) == input$Order ], mapping=aes(color = zones)) +
      #geom_line(aes(x=day, y = Harvest))
    
  #})
  
#}
#shinyApp(ui = ui, server = server)

#w<- which(cumsum(x) <= thresholdValue); sum(x[w])
#if (Harvest <=thresholdValue)
  #print(Harvest)
  #else if
  #"ACT exceed"