library(naijR)

library(dplyr)

library(shiny)

library(plotly)

library(shinydashboard)

library(highcharter)

library(purrr)

library(naijR)

# data vaccination

data <- read.csv("Vaccination.csv")[,-1]

Newdata <- data %>% 
  filter(state != "Nigeria")

# Define server logic required to draw a histogram

function(input, output, session) {

  output$group_totals <- renderHighchart({
    Vaccine_df <- select(data,vaccine, total, state) %>% 
      filter(state == input$geoloc) %>% 
      arrange(desc(total)) %>% 
      hchart('column',hcaes(x = vaccine,y = total, color = vaccine)) %>% 
      hc_yAxis(title = list(text = "Vaccination rate(%)")) %>% 
      hc_title( text = "Vaccination rates") %>% 
      hc_plotOptions(
        series = list(
          boderWidth = 0,
          dataLabels = list(enabled = TRUE)
        ))
    
    
  })
  
  output$map <- renderHighchart(
    {
      
      mapdata <- get_data_from_map(download_map_data("https://code.highcharts.com/mapdata/countries/ng/ng-all.js"))
      
      vacc_data <- mapdata %>% 
        select(code = `hc-a2`, name)
      
      Newdata <- data %>% 
        filter(state != "Nigeria")
      
      names(Newdata) <- c("name", "vaccine", "total")
      
      # merge
      
      merged_df <- full_join(vacc_data, Newdata, by = "name")
      
      
      # filtering
      
      filterdata <- merged_df %>% 
        filter(vaccine == input$vaccine)
      
      hcmap(
        "https://code.highcharts.com/mapdata/countries/ng/ng-all.js",
        data = filterdata,
        value = "total",
        name = "Vaccination rates",
        dataLabels = list(enabled = TRUE, format = "{point.name}"),
        borderColor = "#FAFAFA",
        borderWidth = 0.1,
        tooltip = list(
          valueDecimals = 2,
          valuePrefix = "",
          valueSuffix = "%"
        )
      )
        
    }
  )

}
