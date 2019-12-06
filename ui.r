#ui
#line with comment


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


