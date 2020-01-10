ui <- dashboardPage(
  
  dashboardHeader(title="Greater amberjack recreational fishery decision tool",titleWidth = 490),
  dashboardSidebar(disable=TRUE,
                   
                   sidebarMenu(disable = TRUE)),
  dashboardBody(
    tabsetPanel(tabPanel("Dashboard",
             fluidRow(introjsUI(),mainPanel(bsModal(id='modal',title='Gulf of Mexico greater amberjack recreational decision support tool',trigger='',size='large',p("<b>The Council</b> is considering alternatvies to modify recreational management of greater amberjack.  This tool is intended to support the decision making process.  This process is still in the early stages and all options presented in this tool are subject to change.  After reviewing the proposed options in the tool, please contact us through the Council website to provide comment.")),width=12),
                      column(width=4,
                             column(width=12,introBox(actionButton("btn",HTML('<h4>How do I use this decision tool?</h4>'), width=300,
                                          style="background-color: #0066ff;border-color: #0066ff; color: #fff;margin: 6px 0px 6px 0px;" ),data.step=1,data.intro="Welcome to the Gulf of Mexico greater amberjack recreational decision tool!  This tool estimates the length of the greater amberjack recreational season based on different management strategies.  Specifically, it considers a variety of ways to manage the recreational sector with zones and split seasons.
                                          Greater amberjack is managed with a Gulf-wide, recreational Annual Catch Target of 1,086,985 pounds.  The sum of estimated daily catch rates can be used to estimate the recreational fishing season length under different management options.   Zone or season specific allocations can be created to increase access while still achieving stock rebuilding goals.")),
                             # column(width=12,introBox(box(width=12,solidHeader = TRUE,status = "primary",style = "font-size: 120%;",title="Step 1: Choose a survey method",
                             #     radioButtons("survey", "Survey options",
                             #                  c("Coastal home telephone survey (Old MRIP)"="old","Fishing effort survey (New MRIP)"="new"))),data.step=2,data.intro="This button allows you to select between recreational survey methods.  The Coastal Home Telephone Survey (‘Old MRIP’) was discontinued at the end of 2017.  This survey relied heavily on landline phone communication which has decline over time.  The Fishing Effort Survey (‘New MRIP’) uses a mail survey to collect recreational effort data.   Currently, the fishery is monitored using the 'Old MRIP.' However, it is possible that ‘New MRIP’ data could be used in a future greater amberjack stock assessment.")),
                             column(width=12,introBox(box(width=12,solidHeader = TRUE,status = "primary",style = "font-size: 120%;",title="Step 1: Choose a zone configuration",
                                 radioButtons("dataset", "Zone options",
                                              c("No zones: Gulf-wide season allocation"="none","Two zones: West (TX,LA,MS) & East (AL,FL)"="two","Three zones: West (TX,LA,MS), North (AL to FL Dixie/Levy County, South (south of FL Dixie/Levy County)"="three")),
                                 uiOutput("maps")),data.step=2,data.intro="This button allows you to select between zone options.  Note that by selecting 'No zones' a Gulf-wide allocation would be implemented.  In this case, a seasonal (fall and spring) split quota could be applied to the entire Gulf.")),
                             column(width=12,introBox(box(width=12,solidHeader=TRUE,status = "primary",style = "font-size: 120%;", title="Step 2: Choose an allocation option",uiOutput("allocationoption")),data.step=3,data.intro="This button allows you to select different zone options. Creating different zones requires allocations to be created for each zone.  Note that by selecting 'No zones' a Gulf-wide allocation could be implemented.  In this case, a seasonal (fall and spring) split quota would be applied to the entire Gulf.")), 
                             column(width=12,introBox(box(width=12,solidHeader=TRUE,status = "primary",style = "font-size: 120%;", title="Step 3: Choose a fishing season (optional when selecting any zone management approach)",uiOutput("Order"),
                                 uiOutput("Order2"),
                                 uiOutput("Order3"),
                                 uiOutput("Order4"),
                                 uiOutput("Order5"),
                                 uiOutput("Order6"),
                                 uiOutput("Order7")),data.step=4,data.intro="These sliders allow you to select when each season will be open during the fishing year."))),
                      column(width=8,
                             introBox(box(width=12, solidHeader = TRUE, status = "primary",
                                 title = "Harvest totals (lbs.), length of fishing season (days), and percent of ACT",
                                 valueBoxOutput("valuebox4"),
                                 valueBoxOutput("valuebox5"),
                                 valueBoxOutput("valuebox6"),
                                 valueBoxOutput("valuebox1"),
                                 valueBoxOutput("valuebox2"),
                                 valueBoxOutput("valuebox3"),
                                 ##jf inserted this
                                 uiOutput("valuebox3x"),
                                 uiOutput("valuebox4x"),
                                 uiOutput("valuebox5x"),
                                 ##
                                 valueBoxOutput("valueboxtotal")),data.step=5,data.intro="These value boxes are calculated based on your management selections on the left.  They include total harvest (lbs.) for a season or zone, days available for harvest, and the percent of the seasonal or zone ACT that is expected to be harvested."),
                             column(width=8,
                                    introBox(width=12,plotOutput("plot"),data.step=6,data.intro="This bar chart represents the expected harvest totals from each season or zone and the total Gulf-wide harvest.  The horizontal lines represent the associated ACT for a particular season or zone and the total stock ACT."),
                                    br(),
                             introBox(box(width=12,solidHeader = TRUE, status = "primary",title="A visualization tool",
                                            #### About the data

                                            HTML(
                                              '<div id="about-the-data" class="section level4">
                                              <h4>Caveats about the tool</h4>
                                              <ul>
                                              <li>Fishing seasons within zones may be chosen using the tool (optional Step 3) but this consideration is not currently mandated in the draft framework.</li>
                                              <li>The tool does not take into account any effort overlap between potential zones. </li>
                                              <li>Allocation options are based on equal division of the quota, or an option informed by historical landings for each area.  The Council may decided to explore other plausible allocation options informed by historical landings.</li>
                                              <li>Due to a number of recent management changes, many assumptions have to be made to estimate daily catch rates.  Check out the "About the Data" tab to learn more.</li>
                                              <li>The tool is designed to investigate several management approaches for greater amberjack but contains an uknown amount of error. It is not to be used for forecast or predictive analysis. </li>
                                              </ul>
                                              <p>If you have any questions, contact us at <a href = "mailto: gulfcouncil@gulfcouncil.org">gulfcouncil@gulfcouncil.org</a><p>
                                              <p>This tool was last updated <script> document.write(new Date().toLocaleDateString()); </script> <p>
                                              </div>')
                                            ),data.step=8, data.intro="The tool has a number of caveats that should be considered when using the tool.")),
                                    
                             #tableOutput("demo"),
                             column(width=4,
                                    introBox(box(width=12, solidHeader = TRUE, status="primary",title = "Estimated daily catch (lb) by month",
                                        uiOutput("table")),data.step=7,data.intro="This table reports the estimated daily catch rate by month for each zone and the entire Gulf.  The sum of these daily catch rates is used to estimate the length of the fishing season. More information on how these catch rates were determined can be found in the “About the data” tab."))
                             
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
                 <p>The results of this decision tool are based on estimated daily catch rates, and there are three considerations that must be taken into account when estimating daily catch rates for greater amberjack:</p>
                 <ul>
                <li>First, an increase to the size limit to 34 inches fork length in 2016 increased the rate of harvest since bigger fish weigh more.  Therefore, only historical landings from 2016 to 2018 can be used to generate daily catch rate estimates.</li>
                 <li>Second, MRIP collects recreational fishing data in two-month periods called ‘waves’.  Due to this survey design months within the same ‘wave’ have the same daily catch rate.</li>
                 <li>Third, there are several months that have no recent landings data as the fishery was closed to harvest at that time and assumptions about those data had to be made.</li>
                 </ul>
                <p>The table below summaries the years of data used to inform the daily catch rate for each month and the reasoning for their inclusion.<p>
                </div>
                 <img src="data_text.jpg", width="100%">')
               )
           ),
    column(width = 2)
           ))))
)