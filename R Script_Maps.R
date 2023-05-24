library(naijR)

library(dplyr)

# data vaccination

data <- read.csv("Vaccination.csv")[,-1]

Newdata <- data %>% 
  filter(state != "Nigeria")

# vaccine measles

Measle_df <- filter(Newdata, vaccine == "Measles")[,-2]

# vaccine any

Any_df <- filter(Newdata, vaccine == "Any")[,-2]

# vaccine Penta 1

Penta1_df <- filter(Newdata, vaccine == "Penta 1")[,-2]

# vaccine Penta 2

Penta2_df <- filter(Newdata, vaccine == "Penta 2")[,-2]

# vaccine Penta 3

Penta3_df <- filter(Newdata, vaccine == "Penta 3")[,-2]

# map

map_ng(data = Measle_df, breaks = c(10,40,70,100),col= "green", show.text = TRUE, leg.title = "Measle Vaccination rate")

# map -penta3

map_ng(data = Penta3_df, breaks = c(10,40,70,100),col= "green", show.text = TRUE, leg.title = "Penta 3 Vaccination rate")
