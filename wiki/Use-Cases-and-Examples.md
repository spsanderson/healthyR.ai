# Use Cases and Examples

Real-world healthcare analytics scenarios and complete examples using `healthyR.ai`.

---

## 📚 Table of Contents

1. [Predicting Length of Stay](#predicting-length-of-stay)
2. [Readmission Risk Assessment](#readmission-risk-assessment)
3. [Patient Segmentation](#patient-segmentation)
4. [Quality Metrics Monitoring](#quality-metrics-monitoring)
5. [Cost Prediction](#cost-prediction)
6. [Resource Utilization Analysis](#resource-utilization-analysis)

---

## 🏥 Predicting Length of Stay

### Problem
Predict hospital length of stay to optimize bed management and resource allocation.

### Complete Solution

```r
library(healthyR.ai)
library(tidymodels)
library(dplyr)

# 1. Load and prepare data
# Assuming patient_data has: age, diagnosis, comorbidities, lab_values, length_of_stay
set.seed(123)
data_split <- initial_split(patient_data, prop = 0.8, strata = length_of_stay)
train_data <- training(data_split)
test_data <- testing(data_split)

# 2. Exploratory Analysis
# Check distribution of target
hai_density_hist_plot(train_data, length_of_stay)

# Identify skewed features
skewed_features <- hai_skewed_features(train_data, .threshold = 0.5)
print(skewed_features)

# 3. Create preprocessing recipe
rec <- recipe(length_of_stay ~ ., data = train_data) %>%
  # Handle missing data
  step_impute_median(all_numeric_predictors()) %>%
  step_impute_mode(all_nominal_predictors()) %>%
  
  # Handle outliers in cost and labs
  step_hai_winsorized_truncate(
    total_cost, lab_value_1, lab_value_2,
    fraction = 0.05
  ) %>%
  
  # Transform skewed features
  step_hai_hyperbolic(
    all_of(skewed_features$feature),
    .scale_type = "asinh"
  ) %>%
  
  # Encode categorical
  step_dummy(all_nominal_predictors()) %>%
  
  # Remove zero-variance
  step_zv(all_predictors())

# 4. Try multiple models
xgb_model <- hai_auto_xgboost(
  .data = train_data,
  .rec_obj = rec,
  .best_metric = "rmse",
  .model_type = "regression",
  .grid_size = 20,
  .num_cores = 4
)

rf_model <- hai_auto_ranger(
  .data = train_data,
  .rec_obj = rec,
  .best_metric = "rmse",
  .model_type = "regression",
  .grid_size = 20
)

# 5. Compare models
comparison <- bind_rows(
  xgb_model$model_info %>% 
    filter(model_spec == xgb_model$best_model_spec) %>%
    mutate(model = "XGBoost"),
  rf_model$model_info %>% 
    filter(model_spec == rf_model$best_model_spec) %>%
    mutate(model = "Random Forest")
) %>%
  select(model, mean, std_err) %>%
  arrange(mean)

print(comparison)

# 6. Use best model for predictions
best_model <- if(comparison$mean[1] == xgb_model$model_info$mean[1]) {
  xgb_model
} else {
  rf_model
}

cat("Best model:", comparison$model[1], "\n")
cat("RMSE:", comparison$mean[1], "\n")
```

### Key Insights
- Transform skewed cost and lab values
- Winsorize extreme values
- XGBoost or Random Forest typically perform well
- RMSE < 2 days is generally good performance

---

## 🔄 Readmission Risk Assessment

### Problem
Identify patients at high risk of 30-day readmission.

### Complete Solution

```r
library(healthyR.ai)
library(tidymodels)

# 1. Prepare data
set.seed(456)
data_split <- initial_split(patient_data, prop = 0.8, strata = readmitted_30day)
train_data <- training(data_split)
test_data <- testing(data_split)

# 2. Create recipe
rec <- recipe(readmitted_30day ~ ., data = train_data) %>%
  # Previous admissions, chronic conditions are important
  step_impute_median(all_numeric_predictors()) %>%
  step_hai_winsorized_truncate(num_previous_admissions, fraction = 0.1) %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())

# 3. Try multiple classifiers
# Logistic with elastic net
glmnet_model <- hai_auto_glmnet(
  .data = train_data,
  .rec_obj = rec,
  .best_metric = "roc_auc",
  .model_type = "classification",
  .grid_size = 20
)

# SVM
svm_model <- hai_auto_svm_rbf(
  .data = train_data,
  .rec_obj = rec,
  .best_metric = "roc_auc",
  .model_type = "classification",
  .grid_size = 15
)

# Random Forest
rf_model <- hai_auto_ranger(
  .data = train_data,
  .rec_obj = rec,
  .best_metric = "roc_auc",
  .model_type = "classification"
)

# 4. Compare ROC AUC
comparison <- bind_rows(
  glmnet_model$model_info %>% 
    filter(model_spec == glmnet_model$best_model_spec) %>%
    mutate(model = "GLMnet"),
  svm_model$model_info %>% 
    filter(model_spec == svm_model$best_model_spec) %>%
    mutate(model = "SVM RBF"),
  rf_model$model_info %>% 
    filter(model_spec == rf_model$best_model_spec) %>%
    mutate(model = "Random Forest")
) %>%
  select(model, mean, std_err) %>%
  arrange(desc(mean))

print(comparison)
```

### Key Insights
- ROC AUC > 0.75 is good for readmission prediction
- Important features: prior admissions, chronic conditions, discharge disposition
- Consider cost-sensitive learning if false negatives are costly

---

## 👥 Patient Segmentation

### Problem
Segment patients into cohorts for targeted interventions.

### Complete Solution

```r
library(healthyR.ai)
library(h2o)
library(dplyr)

# 1. Select features for clustering
patient_features <- patient_data %>%
  select(
    age, bmi, num_chronic_conditions, 
    num_medications, num_er_visits, 
    total_annual_cost
  ) %>%
  na.omit()

# 2. Perform K-Means clustering
h2o.init()

kmeans_obj <- hai_kmeans_automl(
  .data = patient_features,
  .predictors = names(patient_features),
  .standardize = TRUE,
  .centers = 10,  # Test up to 10 clusters
  .max_iterations = 100
)

# 3. Determine optimal clusters
hai_kmeans_scree_plot(kmeans_obj)

# Based on elbow (let's say k=4)
optimal_k <- 4

# 4. Get cluster assignments
cluster_assignments <- hai_kmeans_user_item_tbl(kmeans_obj) %>%
  filter(k == optimal_k) %>%
  select(centers_tbl)

# 5. Analyze segments
patient_segments <- bind_cols(patient_features, segment = cluster_assignments$centers_tbl)

segment_profiles <- patient_segments %>%
  group_by(segment) %>%
  summarise(
    n = n(),
    avg_age = mean(age),
    avg_chronic_conditions = mean(num_chronic_conditions),
    avg_er_visits = mean(num_er_visits),
    avg_cost = mean(total_annual_cost)
  ) %>%
  arrange(desc(avg_cost))

print(segment_profiles)

# 6. Visualize with UMAP
umap_obj <- hai_umap_list(
  .data = patient_segments,
  segment ~ .,
  .num_neighbors = 15,
  .min_dist = 0.1
)

hai_umap_plot(
  umap_obj,
  .point_size = 2,
  .plot_title = "Patient Segments in UMAP Space"
)

h2o.shutdown(prompt = FALSE)
```

### Typical Segments Found
1. **High-Risk/High-Cost**: Multiple chronic conditions, frequent ER visits
2. **Moderate-Risk**: Some chronic conditions, moderate utilization
3. **Low-Risk/Healthy**: Few conditions, low utilization
4. **Elderly/Frail**: High age, moderate conditions

---

## 📊 Quality Metrics Monitoring

### Problem
Monitor hospital quality metrics to detect issues early.

### Complete Solution

```r
library(healthyR.ai)
library(dplyr)
library(patchwork)

# 1. Prepare monthly metrics
monthly_metrics <- quality_data %>%
  group_by(month) %>%
  summarise(
    adverse_events = n(),
    infection_rate = sum(infection) / n(),
    mortality_rate = sum(mortality) / n(),
    readmission_rate = sum(readmission_30day) / n()
  )

# 2. Create control charts for each metric
p1 <- hai_control_chart(
  monthly_metrics,
  adverse_events,
  month,
  .plt_title = "Adverse Events",
  .std_dev = 3
) + theme_minimal()

p2 <- hai_control_chart(
  monthly_metrics,
  infection_rate,
  month,
  .plt_title = "Hospital-Acquired Infection Rate",
  .std_dev = 3
) + theme_minimal()

p3 <- hai_control_chart(
  monthly_metrics,
  readmission_rate,
  month,
  .plt_title = "30-Day Readmission Rate",
  .std_dev = 3
) + 
  geom_hline(yintercept = 0.15, color = "red", linetype = "dashed") +
  annotate("text", x = -Inf, y = 0.15, label = "Target: 15%", 
           hjust = -0.1, vjust = -0.5, color = "red") +
  theme_minimal()

# 3. Combine into dashboard
dashboard <- (p1 | p2) / p3
print(dashboard)

# 4. Identify out-of-control points
check_control <- function(data, value_col, x_col, std_dev = 3) {
  value_var <- enquo(value_col)
  x_var <- enquo(x_col)
  
  data %>%
    mutate(
      mean_val = mean(!!value_var),
      sd_val = sd(!!value_var),
      ucl = mean_val + std_dev * sd_val,
      lcl = mean_val - std_dev * sd_val,
      out_of_control = !!value_var > ucl | !!value_var < lcl
    ) %>%
    filter(out_of_control) %>%
    select(!!x_var, !!value_var, mean_val, ucl, lcl)
}

# Check each metric
ooc_adverse <- check_control(monthly_metrics, adverse_events, month)
ooc_infection <- check_control(monthly_metrics, infection_rate, month)
ooc_readmission <- check_control(monthly_metrics, readmission_rate, month)

cat("Out of control points:\n")
print(ooc_adverse)
print(ooc_infection)
print(ooc_readmission)
```

### Key Insights
- Use 3-sigma limits (standard)
- Investigate any out-of-control points
- Look for trends even within control limits
- Update limits periodically as processes improve

---

## 💰 Cost Prediction

### Problem
Predict patient care costs for budgeting and resource planning.

### Complete Solution

```r
library(healthyR.ai)
library(tidymodels)

# 1. Analyze cost distribution
hai_density_hist_plot(patient_data, total_cost)
cat("Cost Skewness:", hai_skewness_vec(patient_data$total_cost), "\n")

# 2. Prepare data
set.seed(789)
data_split <- initial_split(patient_data, prop = 0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

# 3. Recipe with log transformation for cost
rec <- recipe(total_cost ~ ., data = train_data) %>%
  # Transform target (cost is usually right-skewed)
  step_log(total_cost, base = 10) %>%
  
  # Handle missing
  step_impute_median(all_numeric_predictors()) %>%
  
  # Outliers
  step_hai_winsorized_truncate(
    length_of_stay, num_procedures,
    fraction = 0.05
  ) %>%
  
  # Transform skewed predictors
  step_hai_hyperbolic(all_numeric_predictors(), .scale_type = "asinh") %>%
  
  # Encode
  step_dummy(all_nominal_predictors())

# 4. Multiple models
earth_model <- hai_auto_earth(
  train_data, rec, "rmse", "regression",
  .grid_size = 20
)

xgb_model <- hai_auto_xgboost(
  train_data, rec, "rmse", "regression",
  .grid_size = 20
)

# 5. Compare (remember: we log-transformed, so RMSE is in log scale)
comparison <- bind_rows(
  earth_model$model_info %>% 
    filter(model_spec == earth_model$best_model_spec) %>%
    mutate(model = "Earth"),
  xgb_model$model_info %>% 
    filter(model_spec == xgb_model$best_model_spec) %>%
    mutate(model = "XGBoost")
) %>%
  arrange(mean)

print(comparison)

# Note: To get predictions in original scale, use 10^predictions
```

### Key Insights
- Cost is almost always right-skewed
- Log transformation often improves models
- Important predictors: length of stay, procedures, diagnosis
- Consider quantile regression for prediction intervals

---

## 🛏️ Resource Utilization Analysis

### Problem
Optimize bed utilization and staffing based on patient flow patterns.

### Complete Solution

```r
library(healthyR.ai)
library(dplyr)
library(lubridate)

# 1. Prepare temporal features
patient_flow <- admissions_data %>%
  mutate(
    day_of_week = wday(admission_date),
    day_of_month = day(admission_date),
    day_of_year = yday(admission_date),
    hour = hour(admission_datetime)
  )

# 2. Aggregate by day
daily_admissions <- patient_flow %>%
  group_by(admission_date, day_of_week, day_of_year) %>%
  summarise(
    admissions = n(),
    avg_severity = mean(severity_score),
    .groups = "drop"
  )

# 3. Create recipe with cyclical features
rec <- recipe(admissions ~ ., data = daily_admissions) %>%
  # Fourier for weekly seasonality
  step_hai_fourier(day_of_week, period = 7, order = 1) %>%
  # Fourier for annual seasonality
  step_hai_fourier(day_of_year, period = 365, order = 2) %>%
  # Lag features
  step_lag(admissions, lag = 1:7) %>%
  # Remove original cyclical vars
  step_rm(day_of_week, day_of_year) %>%
  # Handle missing from lags
  step_naomit(all_predictors())

# 4. Train model
admissions_model <- hai_auto_xgboost(
  daily_admissions %>% slice(8:n()),  # Remove first 7 days (lag)
  rec,
  "rmse",
  "regression"
)

# 5. Visualize patterns
# Weekly pattern
patient_flow %>%
  group_by(day_of_week) %>%
  summarise(avg_admissions = n() / n_distinct(admission_date)) %>%
  ggplot(aes(x = day_of_week, y = avg_admissions)) +
  geom_col(fill = color_blind()[1]) +
  scale_x_continuous(breaks = 1:7, 
                     labels = c("Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat")) +
  labs(title = "Average Admissions by Day of Week",
       x = "Day of Week",
       y = "Average Admissions") +
  theme_minimal()

# Hourly pattern
patient_flow %>%
  group_by(hour) %>%
  summarise(avg_admissions = n() / n_distinct(admission_date)) %>%
  ggplot(aes(x = hour, y = avg_admissions)) +
  geom_line(color = color_blind()[2], size = 1) +
  geom_point(color = color_blind()[2], size = 2) +
  labs(title = "Average Admissions by Hour",
       x = "Hour of Day",
       y = "Average Admissions") +
  theme_minimal()
```

### Key Insights
- Weekly patterns: Often lower on weekends
- Annual patterns: Seasonal variations (flu season, etc.)
- Hourly patterns: ER admissions peak in evenings
- Use predictions for staffing optimization

---

## 🎯 Best Practices Across Use Cases

### 1. Always Split Your Data
```r
set.seed(123)
split <- initial_split(data, prop = 0.8, strata = target_var)
train <- training(split)
test <- testing(split)
```

### 2. Explore Before Modeling
```r
# Check distributions
hai_skewed_features(train)
hai_density_hist_plot(train, target_var)

# Check for outliers
summary(train)
```

### 3. Use Appropriate Metrics
- **Regression**: RMSE, MAE, R²
- **Classification**: ROC AUC, Accuracy, F1
- **Imbalanced**: Precision, Recall, F1

### 4. Try Multiple Models
- Different algorithms have different strengths
- Ensemble or average predictions for better results

### 5. Validate and Monitor
- Use holdout test set
- Monitor model performance over time
- Retrain when performance degrades

---

## 📚 Additional Resources

- **[AutoML Functions](AutoML-Functions.md)** - Detailed model documentation
- **[Data Preprocessing](Data-Preprocessing.md)** - Preprocessing techniques
- **[Visualization Functions](Visualization-Functions.md)** - Creating visualizations
- **Package Vignettes**: `browseVignettes("healthyR.ai")`

---

*Last Updated: 2024-11-04*
