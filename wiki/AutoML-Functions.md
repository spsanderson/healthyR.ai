# AutoML Functions

Comprehensive guide to automated machine learning functions in `healthyR.ai`. These functions automatically handle hyperparameter tuning, cross-validation, and model selection.

---

## 📚 Table of Contents

1. [Overview](#overview)
2. [Available Algorithms](#available-algorithms)
3. [Common Parameters](#common-parameters)
4. [Function-Specific Guides](#function-specific-guides)
5. [Model Comparison](#model-comparison)
6. [Best Practices](#best-practices)

---

## 🎯 Overview

AutoML functions in `healthyR.ai` follow a consistent pattern:

1. **Data Preparation**: Use `hai_*_data_prepper()` to prepare your data
2. **Automated Tuning**: Use `hai_auto_*()` to train models with hyperparameter optimization
3. **Evaluation**: Compare models using returned metrics
4. **Selection**: Choose the best model based on your metric of choice

### General Workflow

```r
# 1. Prepare data
data_split <- rsample::initial_split(your_data, prop = 0.8)
train_data <- rsample::training(data_split)
test_data <- rsample::testing(data_split)

# 2. Create recipe
rec_obj <- recipes::recipe(outcome ~ ., data = train_data)

# 3. Prepare data for specific algorithm (optional but recommended)
prepped_data <- hai_knn_data_prepper(
  .data = train_data,
  .recipe_obj = rec_obj
)

# 4. Run AutoML
model_results <- hai_auto_knn(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression"
)

# 5. Extract best model
best_model <- model_results$model_info %>%
  dplyr::filter(model_spec == model_results$best_model_spec)
```

---

## 🤖 Available Algorithms

### Tree-Based Models

#### 1. Random Forest (Ranger)
- **Function**: `hai_auto_ranger()`
- **Data Prepper**: `hai_ranger_data_prepper()`
- **Use Cases**: General-purpose classification and regression, feature importance
- **Strengths**: Handles non-linear relationships, robust to outliers
- **Key Hyperparameters**: `mtry`, `min_n`, `trees`

#### 2. XGBoost
- **Function**: `hai_auto_xgboost()`
- **Data Prepper**: `hai_xgboost_data_prepper()`
- **Use Cases**: Structured data, competitions, high accuracy needs
- **Strengths**: Excellent performance, handles missing data
- **Key Hyperparameters**: `mtry`, `min_n`, `tree_depth`, `learn_rate`, `loss_reduction`, `trees`

#### 3. C5.0 (Classification)
- **Function**: `hai_auto_c50()`
- **Data Prepper**: `hai_c50_data_prepper()`
- **Use Cases**: Classification tasks, interpretable models
- **Strengths**: Fast training, produces rule sets
- **Key Hyperparameters**: `trees`, `min_n`

#### 4. Cubist (Regression)
- **Function**: `hai_auto_cubist()`
- **Data Prepper**: `hai_cubist_data_prepper()`
- **Use Cases**: Regression with linear models in tree leaves
- **Strengths**: Combines trees and linear models
- **Key Hyperparameters**: `committees`, `neighbors`

### Support Vector Machines

#### 5. SVM with Polynomial Kernel
- **Function**: `hai_auto_svm_poly()`
- **Data Prepper**: `hai_svm_poly_data_prepper()`
- **Use Cases**: Non-linear classification and regression
- **Strengths**: Effective in high dimensions
- **Key Hyperparameters**: `cost`, `degree`, `scale_factor`

#### 6. SVM with RBF Kernel
- **Function**: `hai_auto_svm_rbf()`
- **Data Prepper**: `hai_svm_rbf_data_prepper()`
- **Use Cases**: Non-linear patterns, small to medium datasets
- **Strengths**: Flexible decision boundaries
- **Key Hyperparameters**: `cost`, `rbf_sigma`

### Linear Models

#### 7. GLMnet (Elastic Net)
- **Function**: `hai_auto_glmnet()`
- **Data Prepper**: `hai_glmnet_data_prepper()`
- **Use Cases**: High-dimensional data, feature selection
- **Strengths**: Regularization prevents overfitting
- **Key Hyperparameters**: `penalty`, `mixture`

### Instance-Based

#### 8. K-Nearest Neighbors (KNN)
- **Function**: `hai_auto_knn()`
- **Data Prepper**: `hai_knn_data_prepper()`
- **Use Cases**: Simple baseline, non-parametric learning
- **Strengths**: No training phase, simple interpretation
- **Key Hyperparameters**: `neighbors`, `weight_func`, `dist_power`

### MARS Models

#### 9. Earth (Multivariate Adaptive Regression Splines)
- **Function**: `hai_auto_earth()`
- **Data Prepper**: `hai_earth_data_prepper()`
- **Use Cases**: Regression with automatic feature interactions
- **Strengths**: Captures non-linearities, automatic interaction detection
- **Key Hyperparameters**: `num_terms`, `prod_degree`, `prune_method`

---

## 📋 Common Parameters

All `hai_auto_*` functions share these common parameters:

### Required Parameters

- `.data` - Training data (data frame or tibble)
- `.rec_obj` - Recipe object from the `recipes` package
- `.best_metric` - Metric to optimize (e.g., "rmse", "accuracy", "roc_auc")
- `.model_type` - Either "regression" or "classification"

### Optional Parameters

- `.tune_type` - Type of tuning:
  - `"grid_search"` (default) - Systematic grid search
  - `"bayes"` - Bayesian optimization
  
- `.grid_size` - Number of hyperparameter combinations (default: 10)
- `.num_cores` - Number of cores for parallel processing (default: 1)
- `.cv_folds` - Number of cross-validation folds (default: 5)

### Example Usage

```r
model <- hai_auto_ranger(
  .data = train_data,
  .rec_obj = my_recipe,
  .best_metric = "rmse",
  .model_type = "regression",
  .tune_type = "grid_search",
  .grid_size = 20,
  .num_cores = 4,
  .cv_folds = 10
)
```

---

## 🔧 Function-Specific Guides

### K-Nearest Neighbors (KNN)

**Best for**: Baseline models, non-parametric learning, small to medium datasets

```r
library(healthyR.ai)
library(recipes)
library(rsample)

# Prepare data
data_split <- initial_split(mtcars, prop = 0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

# Create recipe with scaling (important for KNN!)
rec_obj <- recipe(mpg ~ ., data = train_data) %>%
  step_normalize(all_numeric_predictors())

# Run KNN AutoML
knn_results <- hai_auto_knn(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression",
  .grid_size = 15,
  .num_cores = 2
)

# View results
knn_results$best_params
knn_results$model_info %>%
  arrange(mean) %>%
  select(model_spec, neighbors, weight_func, mean, std_err)
```

**Tuned Hyperparameters**:
- `neighbors`: Number of neighbors to consider (1-20)
- `weight_func`: Weighting function ("rectangular", "triangular", "epanechnikov", etc.)
- `dist_power`: Minkowski distance parameter

---

### Random Forest (Ranger)

**Best for**: General-purpose modeling, feature importance, robust predictions

```r
# Prepare data
rec_obj <- recipe(mpg ~ ., data = train_data)

# Optional: Use data prepper
prepped <- hai_ranger_data_prepper(
  .data = train_data,
  .recipe_obj = rec_obj
)

# Run Random Forest AutoML
rf_results <- hai_auto_ranger(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression",
  .grid_size = 20,
  .num_cores = 4
)

# Access best model
best_rf <- rf_results$model_info %>%
  filter(model_spec == rf_results$best_model_spec)

# View hyperparameters
rf_results$best_params
```

**Tuned Hyperparameters**:
- `mtry`: Number of variables randomly sampled at each split
- `min_n`: Minimum number of data points in a node for splitting
- `trees`: Number of trees in the forest

---

### XGBoost

**Best for**: Highest accuracy, structured data, competition-level performance

```r
# Create comprehensive preprocessing recipe
rec_obj <- recipe(mpg ~ ., data = train_data) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())

# Run XGBoost AutoML
xgb_results <- hai_auto_xgboost(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression",
  .tune_type = "bayes",  # Use Bayesian optimization
  .grid_size = 25,
  .num_cores = 4
)

# Analyze results
xgb_results$tuned_results %>%
  collect_metrics() %>%
  filter(.metric == "rmse") %>%
  arrange(mean)
```

**Tuned Hyperparameters**:
- `mtry`: Number of predictors sampled
- `min_n`: Minimum data points per node
- `tree_depth`: Maximum depth of trees
- `learn_rate`: Learning rate (shrinkage)
- `loss_reduction`: Minimum loss reduction for split
- `trees`: Number of boosting iterations

---

### GLMnet (Elastic Net)

**Best for**: High-dimensional data, feature selection, linear relationships

```r
# Recipe with many features
rec_obj <- recipe(outcome ~ ., data = train_data) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())

# Run GLMnet AutoML
glmnet_results <- hai_auto_glmnet(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression",
  .grid_size = 20
)

# Extract coefficient information
best_glmnet <- glmnet_results$model_info %>%
  filter(model_spec == glmnet_results$best_model_spec)
```

**Tuned Hyperparameters**:
- `penalty`: L1/L2 regularization strength (lambda)
- `mixture`: Balance between L1 and L2 (alpha)
  - 0 = Ridge regression (L2)
  - 1 = Lasso regression (L1)
  - 0.5 = Elastic net

---

### SVM with RBF Kernel

**Best for**: Non-linear classification, medium-sized datasets

```r
# Recipe with scaling (important for SVM!)
rec_obj <- recipe(Species ~ ., data = iris) %>%
  step_normalize(all_numeric_predictors())

# Run SVM RBF AutoML
svm_results <- hai_auto_svm_rbf(
  .data = iris,
  .rec_obj = rec_obj,
  .best_metric = "accuracy",
  .model_type = "classification",
  .grid_size = 15
)

# View results
svm_results$best_params
```

**Tuned Hyperparameters**:
- `cost`: Cost of constraint violation (C parameter)
- `rbf_sigma`: Kernel width parameter (gamma)

---

### Earth (MARS)

**Best for**: Automatic interaction detection, interpretable non-linear models

```r
# Prepare recipe
rec_obj <- recipe(mpg ~ ., data = train_data)

# Run Earth AutoML
earth_results <- hai_auto_earth(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression",
  .grid_size = 20
)

# Examine model terms
earth_results$best_params
```

**Tuned Hyperparameters**:
- `num_terms`: Maximum number of terms in model
- `prod_degree`: Maximum degree of interaction
- `prune_method`: Method for pruning terms

---

## 📊 Model Comparison

### Comparing Multiple Algorithms

```r
# Prepare once
rec <- recipe(mpg ~ ., data = train_data) %>%
  step_normalize(all_numeric_predictors())

# Train multiple models
knn_model <- hai_auto_knn(train_data, rec, "rmse", "regression")
rf_model <- hai_auto_ranger(train_data, rec, "rmse", "regression")
xgb_model <- hai_auto_xgboost(train_data, rec, "rmse", "regression")
earth_model <- hai_auto_earth(train_data, rec, "rmse", "regression")

# Combine results
comparison <- bind_rows(
  knn_model$model_info %>% 
    filter(model_spec == knn_model$best_model_spec) %>%
    mutate(algorithm = "KNN"),
  rf_model$model_info %>% 
    filter(model_spec == rf_model$best_model_spec) %>%
    mutate(algorithm = "Random Forest"),
  xgb_model$model_info %>% 
    filter(model_spec == xgb_model$best_model_spec) %>%
    mutate(algorithm = "XGBoost"),
  earth_model$model_info %>% 
    filter(model_spec == earth_model$best_model_spec) %>%
    mutate(algorithm = "Earth")
) %>%
  arrange(mean)

# View comparison
print(comparison %>% select(algorithm, mean, std_err))
```

### Visualization of Model Performance

```r
# Create comparison plot
comparison %>%
  ggplot(aes(x = reorder(algorithm, mean), y = mean)) +
  geom_col(fill = "steelblue") +
  geom_errorbar(aes(ymin = mean - std_err, ymax = mean + std_err), 
                width = 0.2) +
  coord_flip() +
  labs(
    title = "Model Performance Comparison",
    x = "Algorithm",
    y = "RMSE (lower is better)"
  ) +
  theme_minimal()
```

---

## 🎯 Best Practices

### 1. Data Preprocessing

Always preprocess appropriately for each algorithm:

```r
# For distance-based methods (KNN, SVM)
rec_distance <- recipe(y ~ ., data = train) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())

# For tree-based methods (Ranger, XGBoost)
rec_tree <- recipe(y ~ ., data = train) %>%
  step_dummy(all_nominal_predictors())  # Trees don't need scaling

# For linear methods (GLMnet)
rec_linear <- recipe(y ~ ., data = train) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors())  # Remove zero-variance
```

### 2. Metric Selection

Choose appropriate metrics for your problem:

**Regression Metrics**:
- `"rmse"` - Root Mean Squared Error (most common)
- `"rsq"` - R-squared
- `"mae"` - Mean Absolute Error
- `"mape"` - Mean Absolute Percentage Error

**Classification Metrics**:
- `"accuracy"` - Overall accuracy
- `"roc_auc"` - Area under ROC curve
- `"f_meas"` - F1 score
- `"precision"` - Precision
- `"recall"` - Recall

### 3. Tuning Strategy

Start with grid search, move to Bayesian for refinement:

```r
# Phase 1: Coarse grid search
initial_model <- hai_auto_ranger(
  train_data, rec, "rmse", "regression",
  .tune_type = "grid_search",
  .grid_size = 10
)

# Phase 2: Fine-tune with Bayesian optimization
refined_model <- hai_auto_ranger(
  train_data, rec, "rmse", "regression",
  .tune_type = "bayes",
  .grid_size = 25
)
```

### 4. Cross-Validation

Use sufficient CV folds for reliable estimates:

```r
# Standard: 5-fold CV
model <- hai_auto_knn(train, rec, "rmse", "regression", .cv_folds = 5)

# More rigorous: 10-fold CV (slower but more reliable)
model <- hai_auto_knn(train, rec, "rmse", "regression", .cv_folds = 10)

# Small data: Leave-one-out CV
model <- hai_auto_knn(train, rec, "rmse", "regression", .cv_folds = nrow(train))
```

### 5. Parallel Processing

Speed up training with multiple cores:

```r
# Check available cores
parallel::detectCores()

# Use multiple cores (leave one for system)
model <- hai_auto_ranger(
  train, rec, "rmse", "regression",
  .num_cores = parallel::detectCores() - 1,
  .grid_size = 20
)
```

---

## 🔍 Interpreting Results

### Understanding Output Structure

```r
model_results <- hai_auto_knn(...)

# Components:
names(model_results)
# [1] "model_info"      - Performance metrics DataFrame
# [2] "best_model_spec" - Specification of best model
# [3] "best_params"     - Best hyperparameters found
# [4] "tuned_results"   - Full tune::tune_grid() output
# [5] "tuning_grid"     - Parameter grid searched
# [6] "preprocessor"    - Recipe object used
```

### Extracting Best Model

```r
# Get best model information
best_model <- model_results$model_info %>%
  filter(model_spec == model_results$best_model_spec)

# View metrics
best_model %>%
  select(model_spec, mean, std_err, n)

# Get hyperparameters
best_params <- model_results$best_params
print(best_params)
```

### Analyzing Tuning Results

```r
# View all combinations tried
model_results$tuned_results %>%
  collect_metrics() %>%
  filter(.metric == "rmse") %>%
  arrange(mean)

# Visualize hyperparameter effects
model_results$tuned_results %>%
  autoplot() +
  theme_minimal()
```

---

## 📚 Additional Resources

- **[Data Preprocessing](Data-Preprocessing.md)** - Prepare your data optimally
- **[Recipe Steps](Recipe-Steps.md)** - Custom preprocessing steps
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications
- **Package Vignettes**: `browseVignettes("healthyR.ai")`

---

## 💡 Algorithm Selection Guide

| Use Case | Recommended Algorithm | Reason |
|----------|----------------------|---------|
| General purpose | Random Forest (Ranger) | Robust, good default choice |
| Highest accuracy needed | XGBoost | Top performance on structured data |
| Quick baseline | KNN | Simple, fast to train |
| High-dimensional data | GLMnet | Built-in feature selection |
| Feature importance | Random Forest or XGBoost | Provide importance scores |
| Interpretable model | C5.0 or Earth | Produce interpretable rules/equations |
| Small dataset | KNN or SVM | Work well with limited data |
| Non-linear patterns | SVM RBF or XGBoost | Flexible decision boundaries |
| Automatic interactions | Earth | Detects interactions automatically |

---

*Last Updated: 2024-11-04*
