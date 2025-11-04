# Quick Start Guide

Get up and running with `healthyR.ai` in minutes. This guide covers the essential concepts and basic usage patterns.

---

## 📚 Table of Contents

1. [Package Philosophy](#package-philosophy)
2. [Loading the Package](#loading-the-package)
3. [Basic Workflow](#basic-workflow)
4. [Quick Examples](#quick-examples)
5. [Core Concepts](#core-concepts)
6. [Common Patterns](#common-patterns)

---

## 🎯 Package Philosophy

`healthyR.ai` follows three core principles:

1. **Consistent Verb Framework**: Functions follow a `hai_*` naming convention
2. **Tidymodels Integration**: Seamless integration with the tidymodels ecosystem
3. **Healthcare-Focused**: Designed specifically for healthcare data analytics

---

## 📦 Loading the Package

```r
# Load healthyR.ai
library(healthyR.ai)

# Commonly used alongside
library(dplyr)      # Data manipulation
library(ggplot2)    # Visualization
library(recipes)    # Preprocessing
library(rsample)    # Data splitting
```

---

## 🔄 Basic Workflow

The typical `healthyR.ai` workflow follows this pattern:

```r
# 1. Prepare your data
data <- your_data_source

# 2. Split into training and testing
data_split <- rsample::initial_split(data, prop = 0.8)
train_data <- rsample::training(data_split)
test_data <- rsample::testing(data_split)

# 3. Create a preprocessing recipe
rec_obj <- recipes::recipe(outcome ~ ., data = train_data) %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_hai_fourier(date_column, period = 365, order = 1)

# 4. Run AutoML model
model_results <- hai_auto_knn(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression"
)

# 5. Evaluate results
best_model <- model_results$model_info %>%
  filter(model_spec == model_results$best_model_spec)
```

---

## 🚀 Quick Examples

### Example 1: Control Chart for Quality Monitoring

Monitor healthcare quality metrics using statistical process control:

```r
library(healthyR.ai)

# Create sample adverse events data
data_tbl <- tibble::tibble(
  day = sample(c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"), 100, TRUE),
  person = sample(c("Tom", "Jane", "Alex"), 100, TRUE),
  count = rbinom(100, 20, ifelse(day == "Friday", .5, .2)),
  date = Sys.Date() - sample.int(100)
)

# Generate control chart
my_chart <- hai_control_chart(
  .data = data_tbl, 
  .value_col = count, 
  .x_col = date
)

# Customize the chart
my_chart +
  ylab("Number of Adverse Events") +
  scale_x_date(name = "Week of...", date_breaks = "week") +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust = 1))
```

**What this does**: Creates a Shewhart control chart to identify when processes are out of statistical control, helping detect quality issues early.

---

### Example 2: K-Means Clustering for Patient Segmentation

Automatically find optimal patient clusters:

```r
library(healthyR.ai)
library(dplyr)

# Prepare data (example with mtcars, but works with patient data)
data_tbl <- mtcars %>%
  select(mpg, hp, wt) %>%
  filter(mpg < 30)

# Auto K-Means - automatically finds optimal number of clusters
kmeans_obj <- hai_kmeans_automl(
  .data = data_tbl,
  .max_clusters = 10,
  .centers = 5,
  .standardize = TRUE
)

# Visualize the elbow/scree plot
hai_kmeans_scree_plot(kmeans_obj)

# Get cluster assignments
cluster_assignments <- hai_kmeans_user_item_tbl(kmeans_obj)

# View cluster summary
hai_kmeans_tidy_tbl(kmeans_obj)
```

**What this does**: Automatically performs k-means clustering with multiple cluster sizes, helping identify distinct patient groups for targeted interventions.

---

### Example 3: AutoML with K-Nearest Neighbors

Predict outcomes with automatic hyperparameter tuning:

```r
library(healthyR.ai)
library(recipes)

# Prepare data
data_split <- rsample::initial_split(mtcars, prop = 0.8)
train_data <- rsample::training(data_split)
test_data <- rsample::testing(data_split)

# Create preprocessing recipe
rec_obj <- recipes::recipe(mpg ~ ., data = train_data) %>%
  step_normalize(all_numeric_predictors())

# Run AutoML KNN
knn_results <- hai_auto_knn(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression",
  .tune_type = "grid_search",
  .num_cores = 1
)

# Explore results
names(knn_results)

# Get best model details
best_model_spec <- knn_results$best_model_spec
best_params <- knn_results$best_params

# Access tuning results
tuning_results <- knn_results$tuned_results

# Get model metrics
knn_results$model_info %>%
  select(model_spec, mean, std_err)
```

**What this does**: Automatically searches for the best k-nearest neighbors hyperparameters using cross-validation.

---

### Example 4: Data Preprocessing with Custom Recipe Steps

Transform and scale your data for modeling:

```r
library(healthyR.ai)
library(recipes)

# Create recipe with custom preprocessing
rec <- recipe(mpg ~ ., data = mtcars) %>%
  # Z-score standardization
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  # Fourier transformation for cyclical features
  step_hai_fourier(disp, period = 100, order = 1) %>%
  # Hyperbolic transformations
  step_hai_hyperbolic(hp, wt) %>%
  # Winsorization to handle outliers
  step_hai_winsorized_truncate(all_numeric_predictors(), fraction = 0.05)

# Prep the recipe
prepped_rec <- prep(rec)

# Apply to data
transformed_data <- bake(prepped_rec, new_data = mtcars)

# View transformed data
glimpse(transformed_data)
```

**What this does**: Applies multiple preprocessing transformations that are commonly needed for healthcare data modeling.

---

### Example 5: Distribution Analysis

Analyze and visualize data distributions:

```r
library(healthyR.ai)

# Get distribution statistics
dist_comparison <- hai_distribution_comparison_tbl(mtcars, mpg, hp, wt)
print(dist_comparison)

# Create density plot
hai_density_plot(
  .data = mtcars,
  .value_col = mpg,
  .fill = "steelblue"
)

# Create combined density and histogram
hai_density_hist_plot(
  .data = mtcars,
  .value_col = mpg,
  .fill = "lightblue"
)

# Q-Q plot for normality assessment
hai_density_qq_plot(
  .data = mtcars,
  .value_col = mpg
)

# Faceted histogram for multiple groups
hai_histogram_facet_plot(
  .data = iris,
  .value_col = Sepal.Length,
  .bins = 10,
  .scale_data = FALSE
)
```

**What this does**: Provides comprehensive distribution analysis to understand your data before modeling.

---

### Example 6: UMAP Dimensionality Reduction

Visualize high-dimensional data in 2D:

```r
library(healthyR.ai)

# Prepare data
data_tbl <- iris[, 1:4]

# Create UMAP projection
umap_obj <- hai_umap_list(
  .data = data_tbl,
  Species ~ .,
  .num_neighbors = 15,
  .min_dist = 0.1
)

# Plot UMAP
hai_umap_plot(
  .data = umap_obj,
  .point_size = 2,
  .plot_title = "UMAP Projection of Iris Dataset"
)
```

**What this does**: Reduces high-dimensional patient or healthcare data to 2D for visualization and pattern identification.

---

## 🧠 Core Concepts

### 1. **Function Naming Convention**

All main functions follow the `hai_*` pattern:
- `hai_auto_*` - AutoML functions with hyperparameter tuning
- `hai_kmeans_*` - K-means clustering functions
- `hai_scale_*` - Scaling and normalization functions
- `hai_*_vec` - Vector functions for transformations
- `hai_*_augment` - Functions that augment data with new columns
- `step_hai_*` - Recipe steps for tidymodels integration

### 2. **Data Preprocessors**

Each AutoML function has a corresponding data prepper:
- `hai_knn_data_prepper()` → `hai_auto_knn()`
- `hai_ranger_data_prepper()` → `hai_auto_ranger()`
- `hai_xgboost_data_prepper()` → `hai_auto_xgboost()`
- And more...

### 3. **Recipe Steps**

Custom recipe steps integrate with tidymodels:
```r
recipe(outcome ~ ., data = data) %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_hai_fourier(date_var, period = 365) %>%
  step_hai_winsorized_truncate(all_numeric(), fraction = 0.05)
```

### 4. **AutoML Structure**

All `hai_auto_*` functions return a list with:
- `model_info` - Model performance metrics
- `best_model_spec` - Specification of best model
- `best_params` - Best hyperparameters found
- `tuned_results` - Full tuning results
- `tuning_grid` - Parameter grid used
- `preprocessor` - Recipe/preprocessor used

---

## 🎨 Common Patterns

### Pattern 1: Quick Model Comparison

```r
# Prepare once
rec <- recipe(y ~ ., data = train_data)

# Try multiple algorithms
knn_model <- hai_auto_knn(train_data, rec, "rmse", "regression")
rf_model <- hai_auto_ranger(train_data, rec, "rmse", "regression")
xgb_model <- hai_auto_xgboost(train_data, rec, "rmse", "regression")

# Compare metrics
compare_df <- bind_rows(
  knn_model$model_info %>% mutate(algorithm = "KNN"),
  rf_model$model_info %>% mutate(algorithm = "Random Forest"),
  xgb_model$model_info %>% mutate(algorithm = "XGBoost")
)
```

### Pattern 2: Pipeline with Preprocessing

```r
# Define preprocessing
my_recipe <- recipe(outcome ~ ., data = train) %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_hai_winsorized_truncate(all_numeric(), fraction = 0.02) %>%
  step_dummy(all_nominal_predictors())

# Apply and model
prepped_recipe <- prep(my_recipe)
processed_data <- bake(prepped_recipe, new_data = train)
model <- hai_auto_ranger(processed_data, my_recipe, "rmse", "regression")
```

### Pattern 3: Monitoring Metrics Over Time

```r
# Monthly adverse events
monthly_data <- healthcare_data %>%
  group_by(month) %>%
  summarise(adverse_events = n(), .groups = "drop")

# Create control chart
hai_control_chart(
  .data = monthly_data,
  .value_col = adverse_events,
  .x_col = month,
  .std_dev = 3
)
```

---

## 📊 Understanding Output

### AutoML Function Output

```r
model_results <- hai_auto_knn(...)

# Structure:
# $model_info          - Performance metrics for all models
# $best_model_spec     - Best model specification
# $best_params         - Best hyperparameters
# $tuned_results       - Full tune::tune_grid() results
# $tuning_grid         - Parameter grid used
# $preprocessor        - Recipe object used
```

### Clustering Function Output

```r
kmeans_obj <- hai_kmeans_automl(...)

# Extract information:
hai_kmeans_tidy_tbl(kmeans_obj)        # Cluster summaries
hai_kmeans_user_item_tbl(kmeans_obj)  # Cluster assignments
hai_kmeans_scree_plot(kmeans_obj)     # Elbow plot
hai_kmeans_mapped_tbl(kmeans_obj)     # All cluster models
```

---

## 🎓 Next Steps

Now that you understand the basics:

1. **[AutoML Functions](AutoML-Functions.md)** - Deep dive into automated machine learning
2. **[Clustering and Dimensionality Reduction](Clustering-and-Dimensionality-Reduction.md)** - Explore unsupervised learning
3. **[Data Preprocessing](Data-Preprocessing.md)** - Master data transformation techniques
4. **[Use Cases and Examples](Use-Cases-and-Examples.md)** - See real-world healthcare applications
5. **Browse Vignettes**:
   ```r
   browseVignettes("healthyR.ai")
   ```

---

## 💡 Tips for Success

1. **Start Simple**: Begin with basic functions like control charts and distribution analysis
2. **Use Recipes**: Leverage tidymodels recipes for consistent preprocessing
3. **Validate Often**: Always split your data and validate model performance
4. **Explore Parameters**: AutoML functions have many parameters - experiment!
5. **Check Examples**: Every function has examples in its documentation:
   ```r
   ?hai_auto_knn
   ```

---

## 🐛 Common Beginner Mistakes

### Mistake 1: Not Splitting Data
```r
# ❌ Wrong - using all data for training
model <- hai_auto_knn(all_data, recipe, "rmse", "regression")

# ✅ Correct - split first
split <- initial_split(all_data, prop = 0.8)
train <- training(split)
test <- testing(split)
model <- hai_auto_knn(train, recipe, "rmse", "regression")
```

### Mistake 2: Forgetting to Load H2O for K-Means
```r
# ❌ Wrong - H2O not initialized
kmeans <- hai_kmeans_automl(data, ...)

# ✅ Correct
library(h2o)
h2o.init()
kmeans <- hai_kmeans_automl(data, ...)
h2o.shutdown(prompt = FALSE)  # When done
```

### Mistake 3: Wrong Metric for Model Type
```r
# ❌ Wrong - using classification metric for regression
model <- hai_auto_knn(data, recipe, "accuracy", "regression")

# ✅ Correct - use appropriate metric
model <- hai_auto_knn(data, recipe, "rmse", "regression")  # For regression
model <- hai_auto_knn(data, recipe, "accuracy", "classification")  # For classification
```

---

## 📞 Getting Help

- **Function Help**: `?hai_function_name`
- **Examples**: Most functions have multiple examples
- **Vignettes**: `browseVignettes("healthyR.ai")`
- **GitHub Issues**: [Report bugs or ask questions](https://github.com/spsanderson/healthyR.ai/issues)

---

*Last Updated: 2024-11-04*
