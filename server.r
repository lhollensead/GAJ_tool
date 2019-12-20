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
        choices = c("50% fall: 50% spring","60% fall: 40% spring","70% fall: 30% spring")}else
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
  
  west2<-reactive({if(input$dataset=="two")
    x<-subset(two,zones=="west"&day>=input$Order3[1]&day<=input$Order3[2])
  
  })
  
  west3<-reactive({if(input$dataset=="three")
    x<-subset(three,zones=="west"&day>=input$Order5[1]&day<=input$Order5[2])
  
  })
  
  w2sum<-reactive({
    x1<-west2()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  w2num<-reactive({
    x1<-west2()
  })
  
  w3sum<-reactive({
    x1<-west3()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  w3num<-reactive({
    x1<-west3()
  })
  

  output$valuebox4<-renderValueBox({
    if(input$dataset=="none"){
      valueBox(
        "Fall harvest total",
        value=format(round(fasum(),0),nsmall=0,big.mark = ","))
    } else
      if(input$dataset=="two"){
        valueBox(
          "West zone harvest total",
          value=format(round(w2sum(),0),nsmall=0,big.mark = ","))
      }else
        if(input$dataset=="three"){
          valueBox(
            "West zone harvest total",
            value=format(round(w3sum(),0),nsmall=0,big.mark = ","))
        }
    
  })
  
  
  #####################################
  output$valuebox3x <- renderUI({
    if(input$dataset=="three"){
      valueBox(
        "South zone harvest total",
        value=format(round(sosum(),0),nsmall=0,big.mark = ","))
      
    }
    
  })
  
  output$valuebox4x <- renderUI({
    if(input$dataset=="three"){
      valueBox(
        "Days in south zone season",
        value=nrow(sonum()))
      
    }
    
  })
  
  output$valuebox5x <- renderUI({
    if(input$dataset=="three"){
      if(input$allocationoption=="33% west: 33% north: 33% south")
        y<-ACT*0.33
      if (input$allocationoption=="20% west: 60% north: 20% south")
        y<-ACT*0.2
      else if (input$allocationoption=="25% west: 50% north: 25% south")
        y<-ACT*0.25
        valueBox("Percent of south zone ACT",
        value=percent((sosum()/y)))
      
    }
    
  })
  ####################################
  
  output$valuebox5<-renderValueBox({
    if(input$dataset=="none"){
      valueBox(
        "Days in fall season",
        value=nrow(fanum()))
    } else
      if(input$dataset=="two"){
        valueBox(
          "Days in west zone season",
          value=nrow(w2num()))
      } else
        if(input$dataset=="three"){
          valueBox(
            "Days in west zone season",
            value=nrow(w3num()))
        }
  })
  
  output$valuebox6<-renderValueBox({
    if(input$dataset=="none"){
      if(input$allocationoption=="50% fall: 50% spring")
        y<-ACT*0.5
      if (input$allocationoption=="60% fall: 40% spring")
        y<-ACT*0.6
      else if (input$allocationoption=="70% fall: 30% spring")
        y<-ACT*0.7
      valueBox("Percent of fall ACT",
               value=percent((fasum()/y)))
    } else
      if(input$dataset=="two"){
        if(input$allocationoption=="50% west: 50% east")
          y<-ACT*0.5
        if (input$allocationoption=="40% west: 60% east")
          y<-ACT*0.4
        else if (input$allocationoption=="30% west: 70% east")
          y<-ACT*0.3
        valueBox("Percent of west ACT",
                 value=percent((w2sum()/y)))
      } else
        if(input$dataset=="three"){
          if(input$allocationoption=="33% west: 33% north: 33% south")
            y<-ACT*0.33
          if (input$allocationoption=="20% west: 60% north: 20% south")
            y<-ACT*0.2
          else if (input$allocationoption=="25% west: 50% north: 25% south")
            y<-ACT*0.25
          valueBox("Percent of west zone ACT",
                   value=percent((w3sum()/y)))
        }
  })
  
  
  
  spring<-reactive({if(input$dataset=="none"){
    x<-subset(none,day>=input$Order2[1]&day<=input$Order2[2])
    
  }
  })
  
  east<-reactive({if(input$dataset=="two"){
    x<-subset(two,zones=="east"&day>=input$Order4[1]&day<=input$Order4[2])
    
  }
  })
  
  north<-reactive({if(input$dataset=="three"){
    x<-subset(three,zones=="north"&day>=input$Order6[1]&day<=input$Order6[2])
    
  }
  })
  
  south<-reactive({if(input$dataset=="three"){
    x<-subset(three,zones=="south"&day>=input$Order7[1]&day<=input$Order7[2])
    
  }
  })
  
  spsum<-reactive({
    x1<-spring()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  esum<-reactive({
    x1<-east()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  nsum<-reactive({
    x1<-north()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  sosum<-reactive({
    x1<-south()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  spnum<-reactive({
    x1<-spring()
  })
  
  enum<-reactive({
    x1<-east()
  })
  
  nnum<-reactive({
    x1<-north()
  })
  
  sonum<-reactive({
    x1<-south()
  })
  
  output$valuebox1<-renderValueBox({
    if(input$dataset=="none"){
      valueBox(
        "Spring harvest total",
        value=format(round(spsum(),0),nsmall=0,big.mark = ","))} else
          if(input$dataset=="two"){
            valueBox(
              "East zone harvest total",
              value=format(round(esum(),0),nsmall=0,big.mark = ","))
          } else
            if(input$dataset=="three"){
              valueBox(
                "North zone harvest total",
                value=format(round(nsum(),0),nsmall=0,big.mark = ","))
            }
  })
  
  output$valuebox2<-renderValueBox({
    if(input$dataset=="none"){
      valueBox(
        "Days in spring season",
        value=nrow(spnum()))} else
          if(input$dataset=="two"){
            valueBox(
              "Days in east zone season",
              value=nrow(enum()))
          } else
            if(input$dataset=="three"){
              valueBox(
                "Days in north zone season",
                value=nrow(nnum()))
            }
  })
  
  
  output$valuebox3<-renderValueBox({
    if(input$dataset=="none"){
      if(input$allocationoption=="50% fall: 50% spring")
        y<-ACT*0.5
      if (input$allocationoption=="60% fall: 40% spring")
        y<-ACT*0.4
      else if (input$allocationoption=="70% fall: 30% spring")
        y<-ACT*0.3
      valueBox("Percent of spring ACT",
               value=percent((spsum()/y)))
    } else
      
      if(input$dataset=="two"){
        if(input$allocationoption=="50% west: 50% east")
          y<-ACT*0.5
        if (input$allocationoption=="40% west: 60% east")
          y<-ACT*0.6
        else if (input$allocationoption=="30% west: 70% east")
          y<-ACT*0.7
        valueBox("Percent of east ACT",
                 value=percent((esum()/y)))
      } else
        if(input$dataset=="three"){
          if(input$allocationoption=="33% west: 33% north: 33% south")
            y<-ACT*0.33
          if (input$allocationoption=="20% west: 60% north: 20% south")
            y<-ACT*0.6
          else if (input$allocationoption=="25% west: 50% north: 25% south")
            y<-ACT*0.5
          valueBox("Percent of north zone ACT",
                   value=percent((nsum()/y)))
        }
  })

  
  output$table <- renderTable({
    if(input$dataset=="none")
      t<-gulf_dcr
    if (input$dataset=="two")
      t<-two_dcr
    else if (input$dataset=="three")
      t<-three_dcr
    t 
  })
  
none_sum<-reactive(c(tail(fasum(),n=1),tail(spsum(),n=1)))
two_sum<-reactive(c(tail(w2sum(),n=1),tail(esum(),n=1)))
three_sum<-reactive(c(tail(w3sum(),n=1),tail(nsum(),n=1),tail(sosum(),n=1)))

output$plot<-renderPlot({
  if(input$dataset=="none"){
    if(input$allocationoption=="50% fall: 50% spring")
      y<-c(ACT*0.5,ACT*0.5) 
    if (input$allocationoption=="60% fall: 40% spring")
      y<-c(ACT*0.6,ACT*0.4)
    else if (input$allocationoption=="70% fall: 30% spring")
      y<-c(ACT*0.7,ACT*0.3)
  p<-barplot(none_sum(),col=c("blue","gray"), ylim=c(0,ACT*0.7))
     abline(h=y,col=c("blue","gray"),lwd=4)}
  if(input$dataset=="two"){
    if(input$allocationoption=="50% west: 50% east")
      y<-c(ACT*0.5,ACT*0.5) 
    if (input$allocationoption=="40% west: 60% east")
      y<-c(ACT*0.4,ACT*0.6)
    else if (input$allocationoption=="30% west: 70% east")
      y<-c(ACT*0.3,ACT*0.7)
    p<-barplot(two_sum(), col=c("blue","gray"),ylim=c(0,ACT*0.7))
    abline(h=y,col=c("blue","gray"),lwd=4)}
   if (input$dataset=="three"){
    if(input$allocationoption=="33% west: 33% north: 33% south")
      y<-c(ACT*0.33,ACT*0.33,ACT*0.33) 
    if (input$allocationoption=="20% west: 60% north: 20% south")
      y<-c(ACT*0.20,ACT*0.60,ACT*0.20)
    else if (input$allocationoption=="25% west: 50% north: 25% south")
      y<-c(ACT*0.25,ACT*0.5,ACT*0.25)
    p<-barplot(three_sum(),col=c("blue","gray","yellow"), ylim=c(0,ACT*0.6))
    abline(h=y,col=c("blue","gray","yellow"),lwd=4)}
  p
})

}
