# Recipe Steps

Guide to using `healthyR.ai` custom recipe steps with the tidymodels ecosystem.

---

## 📚 Table of Contents

1. [Overview](#overview)
2. [Available Recipe Steps](#available-recipe-steps)
3. [Basic Usage](#basic-usage)
4. [Integration with Tidymodels](#integration-with-tidymodels)
5. [Common Patterns](#common-patterns)

---

## 🎯 Overview

`healthyR.ai` provides custom recipe steps that integrate seamlessly with the tidymodels `recipes` package. These steps allow you to build reproducible preprocessing pipelines for machine learning.

### Why Use Recipe Steps?

1. **Reproducible**: Same transformations on train and test data
2. **Portable**: Save and reuse preprocessing pipelines
3. **Composable**: Chain multiple transformations together
4. **Safe**: Prevents data leakage by fitting only on training data

### Recipe Step Naming

All healthyR.ai recipe steps follow the pattern: `step_hai_*`

---

## 📋 Available Recipe Steps

### Scaling and Normalization

#### `step_hai_scale_zscore()`
Z-score standardization (mean = 0, sd = 1)

```r
recipe(y ~ ., data = train) %>%
  step_hai_scale_zscore(all_numeric_predictors())
```

**Parameters**:
- `...`: Variable selection (tidyselect)
- `role`: Role for new variables (default: "predictor")
- `trained`: Logical, has step been trained?
- `columns`: Selected column names

**Returns**: All numeric columns standardized to z-scores

---

#### `step_hai_scale_zero_one()`
Min-max normalization to [0, 1] range

```r
recipe(y ~ ., data = train) %>%
  step_hai_scale_zero_one(all_numeric_predictors())
```

**Parameters**: Same as `step_hai_scale_zscore()`

**Returns**: All numeric columns scaled to [0, 1]

---

### Statistical Transformations

#### `step_hai_fourier()`
Create Fourier (sine/cosine) features for cyclical patterns

```r
recipe(sales ~ ., data = train) %>%
  step_hai_fourier(
    day_of_year,
    period = 365,  # Annual cycle
    order = 2      # Number of sine/cosine pairs
  )
```

**Parameters**:
- `...`: Variables to transform
- `period`: Length of one cycle
- `order`: Number of sine/cosine pairs to create
- `role`: "predictor" (default)
- `trained`: Logical

**Returns**: Adds `order * 2` columns per variable (sin1, cos1, sin2, cos2, ...)

**Example Use Cases**:
- `period = 7, order = 1` for day of week
- `period = 12, order = 1` for month of year
- `period = 24, order = 2` for hour of day
- `period = 365, order = 2` for day of year

---

#### `step_hai_fourier_discrete()`
Fourier transform for discrete cyclical categories

```r
recipe(y ~ ., data = train) %>%
  step_hai_fourier_discrete(
    day_of_week_num,
    period = 7,
    order = 1
  )
```

**Parameters**: Same as `step_hai_fourier()`

**Use When**: You have numbered categories representing cyclical data (1-7 for days, 1-12 for months)

---

#### `step_hai_hyperbolic()`
Hyperbolic transformations (sinh, cosh, tanh, asinh, logit)

```r
recipe(y ~ ., data = train) %>%
  step_hai_hyperbolic(
    all_numeric_predictors(),
    .scale_type = "asinh"  # or "sinh", "cosh", "tanh", "logit"
  )
```

**Parameters**:
- `...`: Variables to transform
- `.scale_type`: Type of transformation
  - `"sinh"`: Hyperbolic sine
  - `"cosh"`: Hyperbolic cosine
  - `"tanh"`: Hyperbolic tangent (bounds to [-1, 1])
  - `"asinh"`: Inverse hyperbolic sine (log-like, handles negatives)
  - `"logit"`: Logit transformation (for probabilities)
- `role`, `trained`, `columns`

**Returns**: Transformed columns

**When to Use**:
- `"asinh"`: Skewed data, alternative to log (works with negatives)
- `"tanh"`: Need bounded transformation [-1, 1]
- `"sinh"/"cosh"`: Specific functional relationships

---

### Winsorization

#### `step_hai_winsorized_truncate()`
Cap extreme values at specified percentiles

```r
recipe(y ~ ., data = train) %>%
  step_hai_winsorized_truncate(
    all_numeric_predictors(),
    fraction = 0.05  # 5% from each tail
  )
```

**Parameters**:
- `...`: Variables to winsorize
- `fraction`: Fraction to trim from each tail (0.05 = 5%)
- `role`, `trained`, `columns`

**Returns**: Variables with extreme values capped at percentiles

---

#### `step_hai_winsorized_move()`
Move extreme values to specified percentiles

```r
recipe(y ~ ., data = train) %>%
  step_hai_winsorized_move(
    all_numeric_predictors(),
    fraction = 0.05
  )
```

**Parameters**: Same as `step_hai_winsorized_truncate()`

**Returns**: Variables with extreme values moved to percentiles

**Truncate vs Move**: Move is gentler, truncate is more aggressive

---

## 💡 Basic Usage

### Simple Recipe

```r
library(healthyR.ai)
library(recipes)
library(rsample)

# Split data
data_split <- initial_split(mtcars, prop = 0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

# Create recipe
rec <- recipe(mpg ~ ., data = train_data) %>%
  step_hai_scale_zscore(all_numeric_predictors())

# Prep (fit) the recipe on training data
prepped_rec <- prep(rec, training = train_data)

# Apply (bake) to training data
train_processed <- bake(prepped_rec, new_data = train_data)

# Apply to test data (uses training statistics!)
test_processed <- bake(prepped_rec, new_data = test_data)
```

### Recipe with Multiple Steps

```r
rec <- recipe(mpg ~ ., data = train_data) %>%
  # 1. Winsorize outliers
  step_hai_winsorized_truncate(hp, wt, fraction = 0.05) %>%
  
  # 2. Transform skewed features
  step_hai_hyperbolic(disp, .scale_type = "asinh") %>%
  
  # 3. Standardize
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  
  # 4. Encode categorical
  step_dummy(all_nominal_predictors())

# Prep and bake
prepped <- prep(rec)
processed <- bake(prepped, new_data = test_data)
```

---

## 🔗 Integration with Tidymodels

### With Workflows

```r
library(workflows)
library(parsnip)

# Define model
rf_model <- rand_forest(mode = "regression") %>%
  set_engine("ranger")

# Create preprocessing recipe
rec <- recipe(mpg ~ ., data = train_data) %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())

# Combine in workflow
wflow <- workflow() %>%
  add_model(rf_model) %>%
  add_recipe(rec)

# Fit
fitted_wflow <- fit(wflow, data = train_data)

# Predict
predictions <- predict(fitted_wflow, new_data = test_data)
```

### With Tune for Hyperparameter Tuning

```r
library(tune)
library(dials)

# Model with tuning parameters
rf_tune <- rand_forest(
  mtry = tune(),
  trees = tune()
) %>%
  set_mode("regression") %>%
  set_engine("ranger")

# Recipe (no tuning needed here, but could add)
rec <- recipe(mpg ~ ., data = train_data) %>%
  step_hai_scale_zscore(all_numeric_predictors())

# Workflow
wflow <- workflow() %>%
  add_model(rf_tune) %>%
  add_recipe(rec)

# Tune
cv_folds <- vfold_cv(train_data, v = 5)
tuning_results <- tune_grid(
  wflow,
  resamples = cv_folds,
  grid = 10
)
```

### With healthyR.ai AutoML Functions

```r
# healthyR.ai AutoML functions accept recipes directly
rec <- recipe(mpg ~ ., data = train_data) %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_hai_fourier(cyl, period = 8, order = 1)

# Use in AutoML
knn_results <- hai_auto_knn(
  .data = train_data,
  .rec_obj = rec,  # Pass recipe here
  .best_metric = "rmse",
  .model_type = "regression"
)
```

---

## 🎨 Common Patterns

### Pattern 1: Healthcare Data Preprocessing

```r
# Typical healthcare data pipeline
rec_healthcare <- recipe(readmission ~ ., data = patient_data) %>%
  # Missing data (use recipes built-in steps)
  step_impute_median(age, length_of_stay, lab_values) %>%
  step_impute_mode(all_nominal_predictors()) %>%
  
  # Outliers in cost and length of stay
  step_hai_winsorized_truncate(total_cost, length_of_stay, fraction = 0.05) %>%
  
  # Skewed distributions
  step_hai_hyperbolic(total_cost, num_procedures, .scale_type = "asinh") %>%
  
  # Cyclical features
  step_hai_fourier(admission_day_of_week, period = 7, order = 1) %>%
  step_hai_fourier(admission_month, period = 12, order = 1) %>%
  
  # Standardize
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  
  # Encode categorical
  step_dummy(all_nominal_predictors()) %>%
  
  # Remove zero-variance
  step_zv(all_predictors())
```

### Pattern 2: Time Series Features

```r
rec_timeseries <- recipe(sales ~ ., data = sales_data) %>%
  # Lag features (recipes built-in)
  step_lag(sales, lag = 1:7) %>%
  
  # Fourier for multiple seasonalities
  step_hai_fourier(day_of_week, period = 7, order = 1) %>%
  step_hai_fourier(day_of_month, period = 30, order = 1) %>%
  step_hai_fourier(day_of_year, period = 365, order = 2) %>%
  
  # Standardize
  step_hai_scale_zscore(all_numeric_predictors())
```

### Pattern 3: High-Dimensional Data

```r
rec_highdim <- recipe(y ~ ., data = train_data) %>%
  # Handle outliers
  step_hai_winsorized_truncate(all_numeric_predictors(), fraction = 0.05) %>%
  
  # Transform skewness
  step_hai_hyperbolic(all_numeric_predictors(), .scale_type = "asinh") %>%
  
  # Standardize
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  
  # Remove correlated features (recipes built-in)
  step_corr(all_numeric_predictors(), threshold = 0.9) %>%
  
  # PCA (recipes built-in)
  step_pca(all_numeric_predictors(), threshold = 0.95)
```

### Pattern 4: Minimal Preprocessing for Trees

```r
# Tree models don't need scaling
rec_tree <- recipe(y ~ ., data = train_data) %>%
  # Just handle missing and encode
  step_impute_median(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors())
```

### Pattern 5: Maximum Preprocessing for Linear Models

```r
rec_linear <- recipe(y ~ ., data = train_data) %>%
  # Missing
  step_impute_knn(all_numeric_predictors(), neighbors = 5) %>%
  
  # Outliers
  step_hai_winsorized_move(all_numeric_predictors(), fraction = 0.05) %>%
  
  # Skewness
  step_hai_hyperbolic(all_numeric_predictors(), .scale_type = "asinh") %>%
  
  # Polynomial features (recipes built-in)
  step_poly(all_numeric_predictors(), degree = 2) %>%
  
  # Interactions (recipes built-in)
  step_interact(~ all_numeric_predictors():all_numeric_predictors()) %>%
  
  # Normalize
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  
  # Encode
  step_dummy(all_nominal_predictors()) %>%
  
  # Remove problematic features
  step_zv(all_predictors()) %>%
  step_corr(all_numeric_predictors(), threshold = 0.9)
```

---

## 🔍 Variable Selection

Recipe steps work with tidyselect helpers:

```r
recipe(y ~ ., data = train) %>%
  # All numeric predictors
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  
  # All nominal predictors
  step_dummy(all_nominal_predictors()) %>%
  
  # Specific variables
  step_hai_fourier(day, period = 7, order = 1) %>%
  
  # By name pattern
  step_hai_winsorized_truncate(starts_with("cost_")) %>%
  
  # By type
  step_hai_hyperbolic(all_numeric(), .scale_type = "asinh") %>%
  
  # Combine selectors
  step_hai_scale_zero_one(all_numeric_predictors(), -id, -date) %>%
  
  # Everything
  step_normalize(all_predictors())
```

---

## ⚠️ Important Notes

### 1. Order Matters

Steps are applied in order. This matters:

```r
# ✅ Correct: Impute before transform
recipe(y ~ ., data = train) %>%
  step_impute_median(all_numeric()) %>%
  step_hai_scale_zscore(all_numeric())

# ❌ Wrong: Transform with missing values
recipe(y ~ ., data = train) %>%
  step_hai_scale_zscore(all_numeric()) %>%  # Fails with NA
  step_impute_median(all_numeric())
```

### 2. Prep Before Bake

```r
# ✅ Correct workflow
rec <- recipe(y ~ ., data = train)
prepped <- prep(rec, training = train)  # Fit on train
result <- bake(prepped, new_data = test) # Apply to test

# ❌ Wrong: Baking without prep
rec <- recipe(y ~ ., data = train)
result <- bake(rec, new_data = test)  # Error!
```

### 3. Save Prepped Recipes

```r
# Save for later use
saveRDS(prepped_rec, "preprocessing_recipe.rds")

# Load and use
prepped_rec <- readRDS("preprocessing_recipe.rds")
new_data_processed <- bake(prepped_rec, new_data = new_data)
```

### 4. Inspect Intermediate Results

```r
# Create recipe
rec <- recipe(y ~ ., data = train) %>%
  step_hai_scale_zscore(x1) %>%
  step_hai_fourier(x2, period = 7, order = 1)

# Prep
prepped <- prep(rec)

# Inspect what happened
tidy(prepped, number = 1)  # Details of step 1
tidy(prepped, number = 2)  # Details of step 2

# See transformed data
juice(prepped)  # Results on training data
```

---

## 🎯 Best Practices

1. **Start Simple**: Begin with basic preprocessing, add complexity as needed

2. **Match to Algorithm**: Different algorithms need different preprocessing

3. **Test Each Step**: Verify each transformation works as expected

4. **Document Choices**: Comment why you chose specific steps

5. **Validate on Holdout**: Always validate final pipeline on test data

6. **Version Your Recipes**: Save recipes alongside models for reproducibility

7. **Check for Data Leakage**: Ensure all fitting happens on training data only

---

## 📚 Additional Resources

- **[Data Preprocessing](Data-Preprocessing.md)** - Detailed guide to preprocessing functions
- **[AutoML Functions](AutoML-Functions.md)** - Using recipes with AutoML
- **recipes Package**: https://recipes.tidymodels.org/
- **tidymodels**: https://www.tidymodels.org/

---

## 📖 Example: Complete ML Pipeline

```r
library(healthyR.ai)
library(tidymodels)
library(workflows)

# 1. Split data
set.seed(123)
data_split <- initial_split(mtcars, prop = 0.8)
train_data <- training(data_split)
test_data <- testing(data_split)

# 2. Create preprocessing recipe
rec <- recipe(mpg ~ ., data = train_data) %>%
  step_hai_winsorized_truncate(all_numeric_predictors(), fraction = 0.05) %>%
  step_hai_hyperbolic(disp, hp, .scale_type = "asinh") %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())

# 3. Define model
rf_model <- rand_forest(
  mtry = tune(),
  trees = 500
) %>%
  set_mode("regression") %>%
  set_engine("ranger")

# 4. Create workflow
wflow <- workflow() %>%
  add_model(rf_model) %>%
  add_recipe(rec)

# 5. Tune
cv_folds <- vfold_cv(train_data, v = 5)
tuning_results <- tune_grid(
  wflow,
  resamples = cv_folds,
  grid = 10
)

# 6. Finalize
best_params <- select_best(tuning_results, metric = "rmse")
final_wflow <- finalize_workflow(wflow, best_params)
final_fit <- fit(final_wflow, data = train_data)

# 7. Evaluate
predictions <- predict(final_fit, new_data = test_data)
metrics <- bind_cols(test_data, predictions) %>%
  metrics(truth = mpg, estimate = .pred)

print(metrics)
```

---

*Last Updated: 2024-11-04*
