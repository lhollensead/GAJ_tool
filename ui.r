ui <- dashboardPage(
  
  dashboardHeader(title="Greater amberjack recreational fishery decision tool",titleWidth = 480),
  dashboardSidebar(disable=TRUE,
                   
                   sidebarMenu(disable = TRUE)),
  dashboardBody(
    tabPanel("Dashboard",
             fluidRow(column(width=4,
                             box(width=12,solidHeader = TRUE,status = "primary",style = "font-size: 120%;",title="Step 1: Choose a survey method",
                                 radioButtons("survey", "Survey options",
                                              c("Coastal home telephone survey (Old MRIP)"="old","Fishing effort survey (New MRIP)"="new"))),
                             
                             box(width=12,solidHeader = TRUE,status = "primary",style = "font-size: 120%;",title="Step 2: Choose a zone configuration",
                                 radioButtons("dataset", "Zone options",
                                              c("No zones: Gulf-wide season allocation"="none","Two zones: West (TX,LA,MS) & East (AL,FL)"="two","Three zones: West (TX,LA,MS), North (AL to FL Dixie/Levy County, South (south of FL Dixie/Levy County)"="three")),
                                 uiOutput("maps")),
                             box(width=12,solidHeader=TRUE,status = "primary",style = "font-size: 120%;", title="Step 3: Choose an allocation option",uiOutput("allocationoption")), 
                             box(width=12,solidHeader=TRUE,status = "primary",style = "font-size: 120%;", title="Step 4: Choose a fishing season",uiOutput("Order"),
                                 tags$style(mycss),uiOutput("Order2"),
                                 uiOutput("Order3"),
                                 uiOutput("Order4"),
                                 uiOutput("Order5"),
                                 uiOutput("Order6"),
                                 uiOutput("Order7"))) ,
                      column(width=8,
                             
                             box(width=12, solidHeader = TRUE, status = "primary",
                                 title = "Harvest totals, number of fishing days, and percent of ACT",
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
                                 valueBoxOutput("valueboxtotal")),
                             column(width=8,
                                    plotOutput("plot")),
                             #tableOutput("demo"),
                             #plotOutput("plot")),
                             column(width=4,
                                    box(width=12, solidHeader = TRUE, status="primary",title = "Estimated daily catch (lb) by month",
                                        uiOutput("table"))))
             )
             
    )
  )
)