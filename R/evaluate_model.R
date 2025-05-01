library(caret)
library(pROC)
library(readr)
library(yaml)

# Load model and test data
model <- readRDS("models/trained_models/latest_model.rds")
test_data <- read_csv("data/test_data.csv")  # You should have separate test data

# Generate predictions
preds <- predict(model, newdata = test_data)
probs <- predict(model, newdata = test_data, type = "prob")[,2]

# Calculate metrics
cm <- confusionMatrix(preds, test_data$target)
f1 <- cm$byClass["F1"]
roc_obj <- roc(test_data$target, probs)
auc <- auc(roc_obj)

# Save metrics
metrics <- list(
  timestamp = Sys.time(),
  f1_score = f1,
  auc_roc = as.numeric(auc),
  confusion_matrix = cm$table
)

write_yaml(metrics, "outputs/metrics/latest_metrics.yaml")