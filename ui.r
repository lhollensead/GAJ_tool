
ui <- dashboardPage(
    
    dashboardHeader(title="Greater amberjack decision tool",titleWidth = 400),
    dashboardSidebar(disable=TRUE,
                     
                     sidebarMenu(disable = TRUE)),
dashboardBody(
  tabPanel("Dashboard",
           fluidRow(column(width=4,
           
             radioButtons("dataset", "Choose a zone configuration",
                          c("No zones: Gulf-wide season allocation"="none","Two zones: West (TX,LA,MS) & East (AL,FL)"="two","Three zones: West (TX,LA,MS), North (AL to FL Dixie/Levy County, South (south of FL Dixie/Levy County)"="three")),
             uiOutput("maps"),
             uiOutput("allocationoption"), 
             uiOutput("Order"),
             uiOutput("Order2"),
             uiOutput("Order3"),
             uiOutput("Order4"),
             uiOutput("Order5"),
             uiOutput("Order6"),
             uiOutput("Order7")) ,
  column(width=8,
  
  box(width=12, solidHeader = TRUE, status = "primary",
  title = "Summary of alternative combinations"),
  valueBoxOutput("valuebox4"),
  valueBoxOutput("valuebox5"),
  valueBoxOutput("valuebox6"),
  valueBoxOutput("valuebox1"),
  valueBoxOutput("valuebox2"),
  valueBoxOutput("valuebox3"),
  valueBoxOutput("valuebox7"),
  valueBoxOutput("valuebox8"),
  valueBoxOutput("valuebox9"),
  valueBoxOutput("valueboxtotal"),
  plotOutput("plot1"),
  plotOutput("plot")))

)
)
)