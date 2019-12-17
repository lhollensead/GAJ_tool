#server
server <- function(input, output, session){
  
output$maps<-renderUI({
  inputId="maps"
  if(input$dataset == "none"){
    m<- "no_zone.png"
  }
  else if(input$dataset == "two"){
    m<- "two_zones.png"
  }
  else if(input$dataset == "three"){
    m<- "three_zones.png"
  }
    img(src=m, width="100%")
})
  

  


output$allocationoption <- renderUI({
  radioButtons(
    inputId = "allocationoption",
    if(input$dataset=="none"){
      label = "Gulf-wide seasonal allocation"}else
        label="Zone allocation",
    if(input$dataset=="none"){
      choices = c("50% fall: 50% spring","40% fall: 60% spring","30% fall: 70% spring")}else
        if(input$dataset=="two"){
          choices = c("50% west: 50% east","40% west: 60% east","30% west: 70% east")}else
      if(input$dataset=="three"){
        choices = c("33% west: 33% north: 33% south","20% west: 60% north: 20% south","25% west: 50% north: 25% south")}
  )
})


output$Order <- renderUI({
  if(input$dataset=="none"){
    sliderInput(inputId = "Order",
                label = "Choose a fall fishing season",  
                min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2020-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2020-12-31', origin='1970-01-01')),
                timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
    
  }
  
})

output$Order2 <- renderUI({
  if(input$dataset=="none"){
    sliderInput(inputId = "Order2",
                label = "Choose a spring fishing season",  
                min = as.Date('2021-01-01', origin='1970-01-01'), max = as.Date('2021-05-31', origin='1970-01-01'), value = c(as.Date('2021-05-01', origin='1970-01-01'),as.Date('2021-05-31', origin='1970-01-01')),
                timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
    
  }
  
})
  
  
  
  output$Order3 <- renderUI({
    if(input$dataset=="two"){
      sliderInput(inputId = "Order3",
                  label = "West zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-7-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-7-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order4 <- renderUI({
    if(input$dataset=="two"){
      sliderInput(inputId = "Order4",
                  label = "East zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order5 <- renderUI({
    if(input$dataset=="three"){
      sliderInput(inputId = "Order5",
                  label = "West zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order6 <- renderUI({
    if(input$dataset=="three"){
      sliderInput(inputId = "Order6",
                  label = "North zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order7 <- renderUI({
    if(input$dataset=="three"){
      sliderInput(inputId = "Order7",
                  label = "South zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  
######No zones: Fall and spring#######
  fall<-reactive({if(input$dataset=="none")
    x<-subset(none,day>=input$Order[1]&day<=input$Order[2])
    
  })
  

  fasum<-reactive({
    x1<-fall()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fanum<-reactive({
    x1<-fall()
  })
  
  output$valuebox4<-renderValueBox({
    valueBox(
      "Fall harvest total",
      value=format(round(fasum(),0),nsmall=0,big.mark = ","))
  })
  
  output$valuebox5<-renderValueBox({
    valueBox(
      "Days in fall season",
      value=nrow(fanum()))
  })
  
  output$valuebox6<-renderValueBox({
    if(input$allocationoption=="50% fall: 50% spring")
      y<-ACT*0.5
    if (input$allocationoption=="40% fall: 60% spring")
      y<-ACT*0.4
    else if (input$allocationoption=="30% fall: 70% spring")
      y<-ACT*0.3
    valueBox("Percent of fall ACT",
             value=percent((fasum()/y)))
  })
  
  output$plot1<-renderPlot({
    if(input$allocationoption=="50% fall: 50% spring")
      y<-ACT*0.5
    if (input$allocationoption=="40% fall: 60% spring")
      y<-ACT*0.4
    else if (input$allocationoption=="30% fall: 70% spring")
      y<-ACT*0.3
    plot(x=fall()[,4],y=cumsum(fall()[,3]),type="l",xlab="Date",ylab="Harvest",main="Fall season")
    abline(h=y,lty=2)
  })
  
spring<-reactive({if(input$dataset=="none"){
  x<-subset(none,day>=input$Order2[1]&day<=input$Order2[2])

}
})

spsum<-reactive({
  x1<-spring()
  x1$SUM<-cumsum(x1[,3])
  x2<-tail(x1[,5],n=1)
})

spnum<-reactive({
  x1<-spring()
})

output$valuebox1<-renderValueBox({
  valueBox(
    "Spring harvest total",
    value=format(round(spsum(),0),nsmall=0,big.mark = ","))
})

output$valuebox2<-renderValueBox({
  valueBox(
    "Days in spring season",
    value=nrow(spnum()))
})


output$valuebox3<-renderValueBox({
  if(input$allocationoption=="50% fall: 50% spring")
    y<-ACT*0.5
  if (input$allocationoption=="40% fall: 60% spring")
    y<-ACT*0.6
  else if (input$allocationoption=="30% fall: 70% spring")
    y<-ACT*0.7
valueBox("Percent of spring ACT",
 value=percent((spsum()/y)))
 })

output$plot<-renderPlot({
  if(input$allocationoption=="50% fall: 50% spring")
    y<-ACT*0.5
  if (input$allocationoption=="40% fall: 60% spring")
    y<-ACT*0.6
  else if (input$allocationoption=="30% fall: 70% spring")
    y<-ACT*0.7
  plot(x=spring()[,4],y=cumsum(spring()[,3]),type="l",color="black",xlab="Date",ylab="Harvest",main="Spring season")
  abline(h=y,lty=2)
})

}
