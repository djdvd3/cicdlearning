library(caret)

library(readr)

# Load cleaned data
data <- read_csv("data/training_data.csv")

# Train logistic model
train_logistic_model <- function(df) {
  set.seed(42)
  train_control <- trainControl(
    method = "cv",
    number = 5,
    classProbs = TRUE,
    summaryFunction = twoClassSummary
  )
  
  model <- train(
    affairs2 ~ children,
    data = df,
    method = "glm",
    family = "binomial",
    trControl = train_control,
    metric = "ROC"
  )
  
  return(model)
}

# Train and save
model <- train_logistic_model(data)
saveRDS(model, "models/trained_models/latest_model.rds")
