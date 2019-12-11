
ui <- 
  
  
  dashboardPage(
    
    dashboardHeader(title="Greater amberjack decision tool"),
    dashboardSidebar(disable=TRUE,
                     
                     sidebarMenu(disable = TRUE)),
dashboardBody(
  tabPanel("Dashboard",
           fluidRow(width=3),
           fluidPage(
             radioButtons("dataset", "Choose a zone configuration",
                          c("No zones: Gulf-wide season allocation"="none","Two zones: West (TX,LA,MS) & East (AL,FL)"="two","Three zones: West (TX,LA,MS), North (AL to FL Dixie/Levy County, South (south of FL Dixie/Levy County)"="three"))
  ),
  uiOutput("allocationoption"),
  uiOutput("Order"),
  uiOutput("Order2"),
  uiOutput("Order3"),
  uiOutput("Order4"),
  uiOutput("Order5"),
  uiOutput("Order6"),
  uiOutput("Order7"),
  plotOutput("plot")
)
)
)