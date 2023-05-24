library(shiny)
library(plotly)
library(shinydashboard)
library(highcharter)
library(purrr)
library(naijR)
library(r2d3) 

# data

data <- read.csv("Vaccination.csv")[,-1]

#state_list <- data %>%
  #select(state) %>% 
  #count(state)
 
vaccine_list <- data %>% 
  select(vaccine) %>% 
  count(vaccine)

dashboardPage(skin = "green",
  dashboardHeader(
    title = "Vaccination Rates analysis for Preventable Childhood Diseases in Nigeria",
    titleWidth = '100%'
  ),
  
  dashboardSidebar(
    selectInput(
      inputId = "geoloc",
      label = "Geolocation:",
      choices = unique(data$state),
      selected = "Abia",
      selectize = FALSE),
    selectInput(
    inputId = "vaccine",
    label = "Vaccine:",
    choices = unique(data$vaccine),
    selected = "Any",
    selectize = FALSE),
    sidebarMenu(
      menuItem("Source Code", icon = icon("github"), href = "https://github.com/Bakti-Siregar/Flights-Dashboard"),
      menuItem("About Me", icon = icon("linkedin"), href = "https://smutuakilai.netlify.app/")
    )
  ),
  
  dashboardBody(
    tabsetPanel(id = "tabs",
                tabPanel(title = "Overall Country Vaccination rates per vaccine",
                         value = "page1",
                         fluidRow(valueBox("79.3%", "Any vaccination Rate",width = 2, icon = icon("vial")),
                                  valueBox("64.7%",icon = icon("vial"), width = 2, color = "teal", subtitle = "Measles vaccination Rate"),
                                  valueBox("69.9%",icon = icon("syringe"),width = 2, color = "green", subtitle = "Penta 1 vaccination Rate"),
                                  valueBox("65.4%",icon = icon("shield-virus"),width = 3,  color = "purple", subtitle = "Penta 2 vaccination Rate"),
                                  valueBox("57.2%",icon = icon("square-virus"), width = 3,color = "fuchsia", subtitle = "Penta 3 vaccination Rate")),
                         fluidRow(column(width = 6,highchartOutput("group_totals")),
                                  column(width = 6, highchartOutput("map"))),
                         fluidRow(column(width = 6,
                                  h2("Key Findings"),
                                  p("The national uptake of any vaccine across Nigeria as a country is 79.3%."),
                                  p("The states of Lagos, Osun, Ekiti had the highest vaccination rates for measles"),
                                  p("Penta 1, Penta 2 and Penta 3 respectively"),
                                  p("The state of Zamfara had the lowest vaccination rates of any vaccine"),
                                  p("Katsina and Zamfara ahd the lowest vaccination rates of measles, Penta 1, Penta 2 and Penta 3")),
                                  column(width = 6,
                                         h2("Recommendations"),
                                         p("Targeted Vaccination campaigns in the states with low vaccination rates"),
                                         p("Improving vaccine accessibility in remote areas"),
                                         p("Data Monitoring and Evaluation to ensure real time data driven decision making"),
                                         p("Additional allocation of health care resources (personnel and infrastructure)"))))
  )
  
)
)