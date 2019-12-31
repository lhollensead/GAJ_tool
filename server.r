#server
server <- function(input, output, session){
  
  output$maps<-renderUI({
    inputId="maps"
    if(input$dataset == "none" & input$survey=="old"|input$dataset == "none"& input$survey=="new"){
      m<- "no_zone.png"
    }
    else if(input$dataset == "two"& input$survey=="old"|input$dataset == "two"& input$survey=="new"){
      m<- "two_zones.png"
    }
    else if(input$dataset == "three"& input$survey=="old"|input$dataset == "three"& input$survey=="new"){
      m<- "three_zones.png"
    }
    img(src=m, width="100%")
  })
  
  
  output$allocationoption <- renderUI({
    radioButtons(
      inputId = "allocationoption",
      if(input$dataset == "none" & input$survey=="old"|input$dataset == "none"& input$survey=="new"){
        label = "Gulf-wide seasonal allocation"}else
          label="Zone allocation",
      if(input$dataset == "none" & input$survey=="old"|input$dataset == "none"& input$survey=="new"){
        choices = c("50% fall: 50% spring","60% fall: 40% spring","70% fall: 30% spring")}else
          if(input$dataset == "two"& input$survey=="old"|input$dataset == "two"& input$survey=="new"){
            choices = c("50% west: 50% east","40% west: 60% east","30% west: 70% east")}else
              if(input$dataset == "three"& input$survey=="old"|input$dataset == "three"& input$survey=="new"){
                choices = c("33% west: 33% north: 33% south","20% west: 60% north: 20% south","25% west: 50% north: 25% south")}
    )
  })
  
  
  output$Order <- renderUI({
    if(input$dataset == "none" & input$survey=="old"|input$dataset == "none" & input$survey=="new"){
      sliderInput(inputId = "Order",
                  label = "Choose a fall fishing season",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2020-12-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2020-12-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  
  output$Order2 <- renderUI({
    if(input$dataset == "none" & input$survey=="old"|input$dataset == "none" & input$survey=="new"){
      sliderInput(inputId = "Order2",
                  label = "Choose a spring fishing season",  
                  min = as.Date('2021-01-01', origin='1970-01-01'), max = as.Date('2021-05-31', origin='1970-01-01'), value = c(as.Date('2021-05-01', origin='1970-01-01'),as.Date('2021-05-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  
  
  
  output$Order3 <- renderUI({
    if(input$dataset == "two"& input$survey=="old"|input$dataset == "two"& input$survey=="new"){
      sliderInput(inputId = "Order3",
                  label = "West zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-7-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-7-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order4 <- renderUI({
    if(input$dataset == "two"& input$survey=="old"|input$dataset == "two"& input$survey=="new"){
      sliderInput(inputId = "Order4",
                  label = "East zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order5 <- renderUI({
    if(input$dataset == "three"& input$survey=="old"|input$dataset == "three"& input$survey=="new"){
      sliderInput(inputId = "Order5",
                  label = "West zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order6 <- renderUI({
    if(input$dataset == "three"& input$survey=="old"|input$dataset == "three"& input$survey=="new"){
      sliderInput(inputId = "Order6",
                  label = "North zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  output$Order7 <- renderUI({
    if(input$dataset == "three"& input$survey=="old"|input$dataset == "three"& input$survey=="new"){
      sliderInput(inputId = "Order7",
                  label = "South zone",  
                  min = as.Date('2020-08-01', origin='1970-01-01'), max = as.Date('2021-07-31', origin='1970-01-01'), value = c(as.Date('2020-08-01', origin='1970-01-01'),as.Date('2021-07-31', origin='1970-01-01')),
                  timeFormat='%m-%d-%Y', dragRange = TRUE, width='700px')
      
    }
    
  })
  
  ######No zones: Fall and spring#######
  fall<-reactive({if(input$dataset=="none"& input$survey=="old")
    x<-subset(none,day>=input$Order[1]&day<=input$Order[2])
  
  })
  
  fes_fall<-reactive({if(input$dataset=="none"& input$survey=="new")
    x<-subset(fes_none,day>=input$Order[1]&day<=input$Order[2])
  
  })
  
  
  fasum<-reactive({
    x1<-fall()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fes_fasum<-reactive({
    x1<-fes_fall()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fanum<-reactive({
    x1<-fall()
  })
  
  fes_fanum<-reactive({
    x1<-fes_fall()
  })
  
  west2<-reactive({if(input$dataset=="two"& input$survey=="old")
    x<-subset(two,zones=="west"&day>=input$Order3[1]&day<=input$Order3[2])
  
  })
  
  fes_west2<-reactive({if(input$dataset=="two"& input$survey=="new")
    x<-subset(fes_two,zones=="west"&day>=input$Order3[1]&day<=input$Order3[2])
  
  })
  
  west3<-reactive({if(input$dataset=="three"& input$survey=="old")
    x<-subset(three,zones=="west"&day>=input$Order5[1]&day<=input$Order5[2])
  
  })
  
  fes_west3<-reactive({if(input$dataset=="three"& input$survey=="new")
    x<-subset(fes_three,zones=="west"&day>=input$Order5[1]&day<=input$Order5[2])
  
  })
  
  w2sum<-reactive({
    x1<-west2()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fes_w2sum<-reactive({
    x1<-fes_west2()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  w2num<-reactive({
    x1<-west2()
  })
  
  fes_w2num<-reactive({
    x1<-fes_west2()
  })
  
  w3sum<-reactive({
    x1<-west3()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fes_w3sum<-reactive({
    x1<-fes_west3()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  w3num<-reactive({
    x1<-west3()
  })
  
  fes_w3num<-reactive({
    x1<-fes_west3()
  })
  
  
  output$valuebox4<-renderValueBox({
    if(input$dataset=="none"& input$survey=="old"){
      valueBox(
       "Fall harvest total",
        value=format(round(fasum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
    }else if(input$dataset=="none"& input$survey=="new"){
      valueBox(
        "Fall harvest total",
        value=format(round(fes_fasum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
    } else
      if(input$dataset=="two"& input$survey=="old"){
        valueBox(
          "West zone harvest total",
          value=format(round(w2sum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
      }else
        if(input$dataset=="two"& input$survey=="new"){
          valueBox(
            "West zone harvest total",
            value=format(round(fes_w2sum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
        }else
        if(input$dataset=="three"& input$survey=="old"){
          valueBox(
            "West zone harvest total",
            value=format(round(w3sum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
        }else
          if(input$dataset=="three"& input$survey=="new"){
            valueBox(
              "West zone harvest total",
              value=format(round(fes_w3sum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
          }
    
  })
  
  
  #####################################
  output$valuebox3x <- renderUI({
    if(input$dataset=="three"& input$survey=="old"){
      valueBox(
        "South zone harvest total",
        value=format(round(sosum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
      
    } else if(input$dataset=="three"& input$survey=="new"){
      valueBox(
        "South zone harvest total",
        value=format(round(fes_sosum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
      
    }
    
  })
  
  output$valuebox4x <- renderUI({
    if(input$dataset=="three"& input$survey=="old"){
      valueBox(
        "Days in south zone season",
        value=nrow(sonum()), icon=icon("calendar-alt"))
      
    }else if(input$dataset=="three"& input$survey=="new"){
      valueBox(
        "Days in south zone season",
        value=nrow(fes_sonum()), icon=icon("calendar-alt"))
      
    }
    
  })
  
  output$valuebox5x <- renderUI({
    if(input$dataset=="three"& input$survey=="old"){
      if(input$allocationoption=="33% west: 33% north: 33% south")
        y<-ACT*0.33
      if (input$allocationoption=="20% west: 60% north: 20% south")
        y<-ACT*0.2
      else if (input$allocationoption=="25% west: 50% north: 25% south")
        y<-ACT*0.25
      valueBox("Percent of south zone ACT", color=ifelse(sosum()/y <=1, "aqua", "red"),icon=icon(ifelse(sosum()/y <=1, "check", "times")),
               value=percent((sosum()/y)))
      
    }else if(input$dataset=="three"& input$survey=="new"){
      if(input$allocationoption=="33% west: 33% north: 33% south")
        y<-ACT*0.33
      if (input$allocationoption=="20% west: 60% north: 20% south")
        y<-ACT*0.2
      else if (input$allocationoption=="25% west: 50% north: 25% south")
        y<-ACT*0.25
      valueBox("Percent of south zone ACT", color=ifelse(fes_sosum()/y <=1, "aqua", "red"),icon=icon(ifelse(fes_sosum()/y <=1, "check", "times")),
               value=percent((fes_sosum()/y)))
      
    }
    
  })
  ####################################
  
  output$valuebox5<-renderValueBox({
    if(input$dataset=="none"& input$survey=="old"){
      valueBox(
        "Days in fall season",
        value=nrow(fanum()), icon=icon("calendar-alt"))
    } else if(input$dataset=="none"& input$survey=="new"){
      valueBox(
        "Days in fall season",
        value=nrow(fes_fanum()), icon=icon("calendar-alt"))
    } else
      if(input$dataset=="two"& input$survey=="old"){
        valueBox(
          "Days in west zone season",
          value=nrow(w2num()), icon=icon("calendar-alt"))
      } else
        if(input$dataset=="two"& input$survey=="new"){
          valueBox(
            "Days in west zone season",
            value=nrow(fes_w2num()), icon=icon("calendar-alt"))
        }else
        if(input$dataset=="three"& input$survey=="old"){
          valueBox(
            "Days in west zone season",
            value=nrow(w3num()), icon=icon("calendar-alt"))
        }else
          if(input$dataset=="three"& input$survey=="new"){
            valueBox(
              "Days in west zone season",
              value=nrow(fes_w3num()), icon=icon("calendar-alt"))
          }
  })
  
  output$valuebox6<-renderValueBox({
    if(input$dataset=="none"& input$survey=="old"){
      if(input$allocationoption=="50% fall: 50% spring")
        y<-ACT*0.5
      if (input$allocationoption=="60% fall: 40% spring")
        y<-ACT*0.6
      else if (input$allocationoption=="70% fall: 30% spring")
        y<-ACT*0.7
      valueBox("Percent of fall ACT", color=ifelse(fasum()/y <=1, "aqua", "red"),icon=icon(ifelse(fasum()/y <=1, "check", "times")),
               value=percent((fasum()/y)))
    }
    else if(input$dataset=="none"& input$survey=="new"){
      if(input$allocationoption=="50% fall: 50% spring")
        y<-ACT*0.5
      if (input$allocationoption=="60% fall: 40% spring")
        y<-ACT*0.6
      else if (input$allocationoption=="70% fall: 30% spring")
        y<-ACT*0.7
      valueBox("Percent of fall ACT", color=ifelse(fes_fasum()/y <=1, "aqua", "red"),icon=icon(ifelse(fes_fasum()/y <=1, "check", "times")),
               value=percent((fes_fasum()/y)))
    }else
      if(input$dataset=="two"& input$survey=="old"){
        if(input$allocationoption=="50% west: 50% east")
          y<-ACT*0.5
        if (input$allocationoption=="40% west: 60% east")
          y<-ACT*0.4
        else if (input$allocationoption=="30% west: 70% east")
          y<-ACT*0.3
        valueBox("Percent of west ACT", color=ifelse(w2sum()/y <=1, "aqua", "red"),icon=icon(ifelse(w2sum()/y <=1, "check", "times")),
                 value=percent((w2sum()/y)))
      } else
        if(input$dataset=="two"& input$survey=="new"){
          if(input$allocationoption=="50% west: 50% east")
            y<-ACT*0.5
          if (input$allocationoption=="40% west: 60% east")
            y<-ACT*0.4
          else if (input$allocationoption=="30% west: 70% east")
            y<-ACT*0.3
          valueBox("Percent of west ACT", color=ifelse(fes_w2sum()/y <=1, "aqua", "red"),icon=icon(ifelse(fes_w2sum()/y <=1, "check", "times")),
                   value=percent((fes_w2sum()/y)))
        }else
        if(input$dataset=="three"& input$survey=="old"){
          if(input$allocationoption=="33% west: 33% north: 33% south")
            y<-ACT*0.33
          if (input$allocationoption=="20% west: 60% north: 20% south")
            y<-ACT*0.2
          else if (input$allocationoption=="25% west: 50% north: 25% south")
            y<-ACT*0.25
          valueBox("Percent of west zone ACT", color=ifelse(w3sum()/y <=1, "aqua", "red"),icon=icon(ifelse(w3sum()/y <=1, "check", "times")),
                   value=percent((w3sum()/y)))
        }else
          if(input$dataset=="three"& input$survey=="new"){
            if(input$allocationoption=="33% west: 33% north: 33% south")
              y<-ACT*0.33
            if (input$allocationoption=="20% west: 60% north: 20% south")
              y<-ACT*0.2
            else if (input$allocationoption=="25% west: 50% north: 25% south")
              y<-ACT*0.25
            valueBox("Percent of west zone ACT", color=ifelse(fes_w3sum()/y <=1, "aqua", "red"),icon=icon(ifelse(fes_w3sum()/y <=1, "check", "times")),
                     value=percent((fes_w3sum()/y)))
          }
  })
  
  
  
  spring<-reactive({if(input$dataset=="none"& input$survey=="old"){
    x<-subset(none,day>=input$Order2[1]&day<=input$Order2[2])
    
  }
  })
  
  fes_spring<-reactive({if(input$dataset=="none"& input$survey=="new"){
    x<-subset(fes_none,day>=input$Order2[1]&day<=input$Order2[2])
    
  }
  })
  
  east<-reactive({if(input$dataset=="two"& input$survey=="old"){
    x<-subset(two,zones=="east"&day>=input$Order4[1]&day<=input$Order4[2])
    
  }
  })
  
  fes_east<-reactive({if(input$dataset=="two"& input$survey=="new"){
    x<-subset(fes_two,zones=="east"&day>=input$Order4[1]&day<=input$Order4[2])
    
  }
  })
  
  north<-reactive({if(input$dataset=="three"& input$survey=="old"){
    x<-subset(three,zones=="north"&day>=input$Order6[1]&day<=input$Order6[2])
    
  }
  })
  
  fes_north<-reactive({if(input$dataset=="three"& input$survey=="new"){
    x<-subset(fes_three,zones=="north"&day>=input$Order6[1]&day<=input$Order6[2])
    
  }
  })
  
  south<-reactive({if(input$dataset=="three"& input$survey=="old"){
    x<-subset(three,zones=="south"&day>=input$Order7[1]&day<=input$Order7[2])
    
  }
  })
  
  fes_south<-reactive({if(input$dataset=="three"& input$survey=="new"){
    x<-subset(fes_three,zones=="south"&day>=input$Order7[1]&day<=input$Order7[2])
    
  }
  })
  
  spsum<-reactive({
    x1<-spring()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fes_spsum<-reactive({
    x1<-fes_spring()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  esum<-reactive({
    x1<-east()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fes_esum<-reactive({
    x1<-fes_east()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  nsum<-reactive({
    x1<-north()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fes_nsum<-reactive({
    x1<-fes_north()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  sosum<-reactive({
    x1<-south()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  fes_sosum<-reactive({
    x1<-fes_south()
    x1$SUM<-cumsum(x1[,3])
    x2<-tail(x1[,5],n=1)
  })
  
  spnum<-reactive({
    x1<-spring()
  })
  
  fes_spnum<-reactive({
    x1<-fes_spring()
  })
  
  enum<-reactive({
    x1<-east()
  })
  
  fes_enum<-reactive({
    x1<-fes_east()
  })
  
  nnum<-reactive({
    x1<-north()
  })
  
  fes_nnum<-reactive({
    x1<-fes_north()
  })
  
  sonum<-reactive({
    x1<-south()
  })
  
  fes_sonum<-reactive({
    x1<-fes_south()
  })
  
  output$valuebox1<-renderValueBox({
    if(input$dataset=="none"& input$survey=="old"){
      valueBox(
        "Spring harvest total",
        value=format(round(spsum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))}
    else if(input$dataset=="none"& input$survey=="new"){
      valueBox(
        "Spring harvest total",
        value=format(round(fes_spsum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))}else
          if(input$dataset=="two"& input$survey=="old"){
            valueBox(
              "East zone harvest total",
              value=format(round(esum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
          }else
            if(input$dataset=="two"& input$survey=="new"){
              valueBox(
                "East zone harvest total",
                value=format(round(fes_esum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
            }
    else
            if(input$dataset=="three"& input$survey=="old"){
              valueBox(
                "North zone harvest total",
                value=format(round(nsum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
            } else
              if(input$dataset=="three"& input$survey=="new"){
                valueBox(
                  "North zone harvest total",
                  value=format(round(fes_nsum(),0),nsmall=0,big.mark = ","), icon=icon("fish"))
              }
  })
  
  output$valuebox2<-renderValueBox({
    if(input$dataset=="none"& input$survey=="old"){
      valueBox(
        "Days in spring season",
        value=nrow(spnum()), icon=icon("calendar-alt"))} else if(input$dataset=="none"& input$survey=="new"){
          valueBox(
            "Days in spring season",
            value=nrow(fes_spnum()), icon=icon("calendar-alt"))} else
          if(input$dataset=="two"& input$survey=="old"){
            valueBox(
              "Days in east zone season",
              value=nrow(enum()), icon=icon("calendar-alt"))
          } else
            if(input$dataset=="two"& input$survey=="new"){
              valueBox(
                "Days in east zone season",
                value=nrow(fes_enum()), icon=icon("calendar-alt"))
            }else
            if(input$dataset=="three"& input$survey=="old"){
              valueBox(
                "Days in north zone season",
                value=nrow(nnum()), icon=icon("calendar-alt"))
            }else
              if(input$dataset=="three"& input$survey=="new"){
                valueBox(
                  "Days in north zone season",
                  value=nrow(fes_nnum()), icon=icon("calendar-alt"))
              }
  })
  
  
  output$valuebox3<-renderValueBox({
    if(input$dataset=="none"& input$survey=="old"){
      if(input$allocationoption=="50% fall: 50% spring")
        y<-ACT*0.5
      if (input$allocationoption=="60% fall: 40% spring")
        y<-ACT*0.4
      else if (input$allocationoption=="70% fall: 30% spring")
        y<-ACT*0.3
      valueBox("Percent of spring ACT", color= ifelse(spsum()/y <=1, "aqua", "red"),icon=icon(ifelse(spsum()/y <=1, "check", "times")),
               value=percent((spsum()/y)))
    }else if(input$dataset=="none"& input$survey=="new"){
      if(input$allocationoption=="50% fall: 50% spring")
        y<-ACT*0.5
      if (input$allocationoption=="60% fall: 40% spring")
        y<-ACT*0.4
      else if (input$allocationoption=="70% fall: 30% spring")
        y<-ACT*0.3
      valueBox("Percent of spring ACT", color= ifelse(fes_spsum()/y <=1, "aqua", "red"),icon=icon(ifelse(fes_spsum()/y <=1, "check", "times")),
               value=percent((fes_spsum()/y)))
    } else
      
      if(input$dataset=="two"& input$survey=="old"){
        if(input$allocationoption=="50% west: 50% east")
          y<-ACT*0.5
        if (input$allocationoption=="40% west: 60% east")
          y<-ACT*0.6
        else if (input$allocationoption=="30% west: 70% east")
          y<-ACT*0.7
        valueBox("Percent of east ACT", color=ifelse(esum()/y <=1, "aqua", "red"),icon=icon(ifelse(esum()/y <=1, "check", "times")),
                 value=percent((esum()/y)))
      }else
        
        if(input$dataset=="two"& input$survey=="new"){
          if(input$allocationoption=="50% west: 50% east")
            y<-ACT*0.5
          if (input$allocationoption=="40% west: 60% east")
            y<-ACT*0.6
          else if (input$allocationoption=="30% west: 70% east")
            y<-ACT*0.7
          valueBox("Percent of east ACT", color=ifelse(fes_esum()/y <=1, "aqua", "red"),icon=icon(ifelse(fes_esum()/y <=1, "check", "times")),
                   value=percent((fes_esum()/y)))
        } else
        if(input$dataset=="three"& input$survey=="old"){
          if(input$allocationoption=="33% west: 33% north: 33% south")
            y<-ACT*0.33
          if (input$allocationoption=="20% west: 60% north: 20% south")
            y<-ACT*0.6
          else if (input$allocationoption=="25% west: 50% north: 25% south")
            y<-ACT*0.5
          valueBox("Percent of north zone ACT", color=ifelse(nsum()/y <=1, "aqua", "red"),icon=icon(ifelse(nsum()/y <=1, "check", "times")),
                   value=percent((nsum()/y)))
        }else
          if(input$dataset=="three"& input$survey=="new"){
            if(input$allocationoption=="33% west: 33% north: 33% south")
              y<-ACT*0.33
            if (input$allocationoption=="20% west: 60% north: 20% south")
              y<-ACT*0.6
            else if (input$allocationoption=="25% west: 50% north: 25% south")
              y<-ACT*0.5
            valueBox("Percent of north zone ACT", color=ifelse(fes_nsum()/y <=1, "aqua", "red"),icon=icon(ifelse(fes_nsum()/y <=1, "check", "times")),
                     value=percent((fes_nsum()/y)))
          }
  })
  
  
  output$table <- renderTable({
    if(input$dataset=="none"& input$survey=="old")
      t<-gulf_dcr
    if(input$dataset=="none"& input$survey=="new")
      t<-fes_gulf_dcr
    if (input$dataset=="two"& input$survey=="old")
      t<-two_dcr
    if (input$dataset=="two"& input$survey=="new")
      t<-fes_two_dcr
    if (input$dataset=="three"& input$survey=="old")
      t<-three_dcr
    else if (input$dataset=="three"& input$survey=="new")
      t<-fes_three_dcr
    t 
  })
  
  none_sum<-reactive(c(tail(fasum(),n=1),tail(spsum(),n=1)))
  two_sum<-reactive(c(tail(w2sum(),n=1),tail(esum(),n=1)))
  three_sum<-reactive(c(tail(w3sum(),n=1),tail(nsum(),n=1),tail(sosum(),n=1)))
  
  ########### table to see none_sum
  demo1 <- reactive({
    x <-none_sum()
    x <- data.frame(value=x)
    y <- x 
    x$group <- c("Fall", "Spring")
    y$group <- "Total"
    z <- rbind(x,y)
    #colnames(x)
    # total <- sum(x[,1])
    # out <- c(x[,1],total)
    # out <- data.frame(x=out)
    # x<- rbind(x[,1], total)
    # x
  })
  
  
  #################Added by JF for consideration
  output$demo <- renderTable({demo1()})
  
  #######
  output$plot<-renderPlot({
    if(input$dataset=="none"& input$survey=="old"){
      if(input$allocationoption=="50% fall: 50% spring")
        y<-c(ACT*0.5,ACT*0.5) 
      if (input$allocationoption=="60% fall: 40% spring")
        y<-c(ACT*0.6,ACT*0.4)
      else if (input$allocationoption=="70% fall: 30% spring")
        y<-c(ACT*0.7,ACT*0.3)
      
      
      p <-
        ggplot(data=demo1(), mapping=aes(x = group, y = value)) +
        geom_bar(stat='identity', width = 0.5,aes(fill=group)) +

        theme_bluewhite() +
        geom_segment(aes(x=0.5,y=y[1], xend=1.5, yend=y[1], linetype = "Fall ACT"),  color="darkgray",lwd=2) +
        geom_segment(aes(x=1.5,y=y[2], xend=2.5, yend=y[2], linetype = "Spring ACT"), color="blue",lwd=2) +
        geom_segment(aes(x=2.5,y=ACT, xend=3.5, yend=ACT, linetype = "Total ACT"), color="black",lwd=2) +
        # guides(fill=guide_legend(title="New Legend Title"))
        theme(legend.title=element_blank()) +
        ylab("Landings (lbs ww)") +
        xlab(" ") +
        scale_fill_continuous(guide=FALSE)+
        scale_fill_manual(labels=c("Fall ACT","Spring ACT","Total ACT"),values = c("darkgray","blue","black"),guide=F)+
        scale_linetype_manual(" ",labels=c("Fall ACT","Spring ACT","Total ACT"),values=c("Fall ACT"=3,"Spring ACT"=6,"Total ACT"=1))+
        scale_y_continuous(labels = comma)+
        guides(shape = guide_legend(override.aes = list(size = 5)))
    
      
      # p<-barplot(none_sum(),col=c("blue","gray"), ylim=c(0,ACT*0.7))
      #    abline(h=y,col=c("blue","gray"),lwd=4)}
      
      # 
    }
    
    #################End: Added by JF for consideration  
    
    if(input$dataset=="two"& input$survey=="old"){
      if(input$allocationoption=="50% west: 50% east")
        y<-c(ACT*0.5,ACT*0.5) 
      if (input$allocationoption=="40% west: 60% east")
        y<-c(ACT*0.4,ACT*0.6)
      else if (input$allocationoption=="30% west: 70% east")
        y<-c(ACT*0.3,ACT*0.7)
      p<-barplot(two_sum(), col=c("blue","gray"),ylim=c(0,ACT*0.7))
      abline(h=y,col=c("blue","gray"),lwd=4)}
    if (input$dataset=="three"& input$survey=="old"){
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

