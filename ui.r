ui <- dashboardPage(
  
  dashboardHeader(title="Greater amberjack recreational fishery decision tool",titleWidth = 490),
  dashboardSidebar(disable=TRUE,
                   
                   sidebarMenu(disable = TRUE)),
  dashboardBody(
    tabsetPanel(tabPanel("Dashboard",
             fluidRow(introjsUI(),column(width=4,
                             column(width=12,introBox(actionButton("btn",HTML('<h4>How do I use this decision tool?</h4>'), width=300,
                                          style="background-color: #0066ff;border-color: #0066ff; color: #fff;margin: 6px 0px 6px 0px;" ),data.step=1,data.intro="Welcome to the Gulf greater amberjack recreational decision tool!  This tool is designed to estimate the length of the Gulf greater amberjack recreational season based on a number of management strategies.  Specifically, this tool considers a number of options related to potential zone allocation or split season quotas.  Currently, the fishery is monitored relative to the Gulf-wide Annual Catch Target (ACT).  The cumulative sum of the estimated daily catch rates, relative to the ACT, can be used to estimate a recreational fishing season length.  Zone ACTs or split-season allocations can be used to monitor harvest relative to the stock ACT of 543,492.5 lbs.")),
                             column(width=12,introBox(box(width=12,solidHeader = TRUE,status = "primary",style = "font-size: 120%;",title="Step 1: Choose a survey method",
                                 radioButtons("survey", "Survey options",
                                              c("Coastal home telephone survey (Old MRIP)"="old","Fishing effort survey (New MRIP)"="new"))),data.step=2,data.intro="This button allows you to select between recreational survey methods.  Currently, the fishery is monitored using the 'Old MRIP' currency.")),
                             column(width=12,introBox(box(width=12,solidHeader = TRUE,status = "primary",style = "font-size: 120%;",title="Step 2: Choose a zone configuration",
                                 radioButtons("dataset", "Zone options",
                                              c("No zones: Gulf-wide season allocation"="none","Two zones: West (TX,LA,MS) & East (AL,FL)"="two","Three zones: West (TX,LA,MS), North (AL to FL Dixie/Levy County, South (south of FL Dixie/Levy County)"="three")),
                                 uiOutput("maps")),data.step=3,data.intro="This button allows you to select between zone options.  Note that by selecting 'No zones' a Gulf-wide allocation would be implmented.  In this case, a seasonal (fall and spring) split quota would be applied to the entire Gulf.")),
                             column(width=12,introBox(box(width=12,solidHeader=TRUE,status = "primary",style = "font-size: 120%;", title="Step 3: Choose an allocation option",uiOutput("allocationoption")),data.step=4,data.intro="This button allows you to select various allocation options between seasons or zones.")), 
                             column(width=12,introBox(box(width=12,solidHeader=TRUE,status = "primary",style = "font-size: 120%;", title="Step 4: Choose a fishing season",uiOutput("Order"),
                                 tags$style(mycss),uiOutput("Order2"),
                                 uiOutput("Order3"),
                                 uiOutput("Order4"),
                                 uiOutput("Order5"),
                                 uiOutput("Order6"),
                                 uiOutput("Order7")),data.step=5,data.intro="These sliders allow you to select what time during the fishing year (season) would be open to harvest."))),
                      column(width=8,
                             introBox(box(width=12, solidHeader = TRUE, status = "primary",
                                 title = "Harvest totals (lbs.), length of fishing season (days), and percent of ACT",
                                 valueBoxOutput("valuebox4"),
                                 valueBoxOutput("valuebox5"),
                                 valueBoxOutput("valuebox6"),
                                 valueBoxOutput("valuebox1"),
                                 valueBoxOutput("valuebox2"),
                                 valueBoxOutput("valuebox3"),
                                 # valueBoxOutput("valuebox7"),
                                 # valueBoxOutput("valuebox8"),
                                 # valueBoxOutput("valuebox9"),
                                 ##jf inserted this
                                 uiOutput("valuebox3x"),
                                 uiOutput("valuebox4x"),
                                 uiOutput("valuebox5x"),
                                 ##
                                 valueBoxOutput("valueboxtotal")),data.step=6,data.intro="These value boxes are calculated as the result of your management inputs on the left.  These values include total harvest (lbs.) for a season or zone (left column), days available for harvest (center column), and the percent of the seasonal or zone ACT that is expected to be harvested (right column)."),
                             column(width=8,
                                    introBox(width=12,plotOutput("plot"),data.step=7,data.intro="This bar chart represents the expected harvest totals from each season or zone along with the total Gulf-wide harvest (far right bar).  The horizontal lines represent the associated ACT for a particular season or zone along with the total stock ACT (solid line).")),
                             #tableOutput("demo"),
                             #plotOutput("plot")),
                             column(width=4,
                                    introBox(box(width=12, solidHeader = TRUE, status="primary",title = "Estimated daily catch (lb) by month",
                                        uiOutput("table")),data.step=8,data.intro="This table reports the estimated daily catch rate by month for each zone and the entire Gulf.  The cumulative sum of these daily catch rates are used to estimate the length of the fishing season relative to the ACT."))
             )
             
    ))
  ,
  tabPanel("About the data",fluidRow(
    column(width = 2
           
    ),
    column(width = 8, 
           box(width=12,
               #### About the data
               
               HTML(
                 '<div id="about-the-data" class="section level4">
                 <h4>About the data</h4>
                 <p>The specific approach used to estimate the number of total discards differs from fleet to fleet; however, generally speaking the process involves using observed data to calculate a rate of discard (number of fish discarded per unit fishing effort) and then multiplying that rate by an estimate of total effort to obtain an estimate of total discards.</p>
                 <p>The recreational landings from 2016 to 2018 were examined to determine when the fishery was open.  Predicted landings for January and February were determined from the average landings from 2016 and 2017 since the recreational sector was open for this time period in these two years.  The only time the recreational sector was open in March and April since the size limit change was in 2016, therefore, the landings in March and April of 2016 were used to predict future March and April landings.  The recreational sector was open in May in 2016 and 2018 and the average from May in these two years was used to predict future May landings.  The recreational sector has been closed in June for the past three years so it was assumed the landings in June are the same as the predicted landings in May.  A similar situation occurred in July and August where the recreational sector was closed from 2016-2018 in July and only open in August of 2018.  Landings from August of 2018 were used to predict future August landings and it was assumed the landings in July have the same catch rate as August.  The only time the recreational sector was open in September and October since the size limit change was in 2018, therefore, the landings in September and October of 2018 were used to predict future September and October landings.  The last time the greater amberjack recreational sector was open in November and December was in 2011, 2012, and 2013.  The landings from 2011, 2012, and 2013 were first reduced to adjust for the decrease in landings from the change in the size limit and the percent reductions (16.73% reduction in landings) came from the 2015 Framework Action.  Then average landings from 2011-2013 were used to predict future November and December landings.</p>
                 <p>The weight of discarded red snapper (Discards (lbs.) on Table 2-3) were calculated by multiplying discards (numbers) by a year and fleet-specific estimate of average weight per discard obtained from the most recent stock assessment model. Dead discards, in both number and weight were obtained by multiplying discards (numbers) and discards (lbs.) by the fleet and year specific discard mortality rates shown in Table 1.</p>
                 <img src="details_landings.png", width="100%">
                 </div>
                 <div id="assumptions" class="section level4">
                 <h4>Assumptions</h4>
                 <ul>
                 <li>Recreational estimates were provided in MRIP units with charter and APAIS calibrations. The FES calibration was not applied.</li>
                 <li>Discards in pounds were computed using the average weight, by fishing mode and year, computed within the stock assessment.</li>
                 <li>Dead discards in numbers and weight were estimated by applying the release mortality used for that assessment.</li>
                 </ul>
                 </div>')
               
               )
           ),
    column(width = 2)
           ))))
)