
library(dplyr)

data1 <- read.csv("data/newdata.csv")

data1$affairs2 <- ifelse(data1$affairs == 0, 0, ifelse(is.na(data1$affairs), NA, 1))


cleaned_data <- data1

write_csv(cleaned_data, "data/processed_data.csv")