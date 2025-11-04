# Data Preprocessing

Comprehensive guide to data preprocessing and transformation functions in `healthyR.ai`.

---

## 📚 Table of Contents

1. [Overview](#overview)
2. [Scaling and Normalization](#scaling-and-normalization)
3. [Statistical Transformations](#statistical-transformations)
4. [Winsorization](#winsorization)
5. [Missing Data Handling](#missing-data-handling)
6. [Preprocessing Pipelines](#preprocessing-pipelines)

---

## 🎯 Overview

`healthyR.ai` provides three types of preprocessing functions:

1. **Vector Functions** (`hai_*_vec()`) - Transform vectors directly
2. **Augment Functions** (`hai_*_augment()`) - Add transformed columns to data frames
3. **Recipe Steps** (`step_hai_*()`) - Integrate with tidymodels recipes

### Function Naming Pattern

```r
# Vector transformation
transformed_vec <- hai_scale_zscore_vec(x)

# Augment data frame with new column
augmented_df <- hai_scale_zscore_augment(df, .value = x)

# Recipe step for pipelines
recipe(y ~ ., data = df) %>%
  step_hai_scale_zscore(all_numeric())
```

---

## 📏 Scaling and Normalization

### Z-Score Standardization

Transform data to have mean = 0 and standard deviation = 1.

#### Vector Function

```r
library(healthyR.ai)

# Transform a vector
x <- c(1, 2, 3, 4, 5, 10, 15, 20)
z_scores <- hai_scale_zscore_vec(x)
print(z_scores)

# Verify: mean ~ 0, sd ~ 1
mean(z_scores)  # Should be ~ 0
sd(z_scores)    # Should be ~ 1
```

#### Augment Function

```r
# Add z-score column to data frame
df <- tibble::tibble(
  id = 1:10,
  value = rnorm(10, mean = 100, sd = 15)
)

# Add transformed column
df_augmented <- hai_scale_zscore_augment(
  .data = df,
  .value = value
)

print(df_augmented)
# Shows: id, value, value_hai_scale_zscore_vec
```

#### Recipe Step

```r
library(recipes)

# In a preprocessing recipe
rec <- recipe(y ~ ., data = train_data) %>%
  step_hai_scale_zscore(all_numeric_predictors())

# Prep and apply
prepped <- prep(rec)
transformed <- bake(prepped, new_data = test_data)
```

**When to use**: 
- Most machine learning algorithms (especially SVM, KNN, neural networks)
- When features have different scales
- For algorithms sensitive to feature magnitude

---

### Zero-One Normalization

Scale data to range [0, 1].

#### Vector Function

```r
# Transform to [0, 1] range
x <- c(10, 20, 30, 40, 50)
normalized <- hai_scale_zero_one_vec(x)
print(normalized)
# [1] 0.00 0.25 0.50 0.75 1.00

# Verify range
range(normalized)  # Should be [0, 1]
```

#### Augment Function

```r
# Add normalized column
df_augmented <- hai_scale_zero_one_augment(
  .data = df,
  .value = value
)
```

#### Recipe Step

```r
rec <- recipe(y ~ ., data = train_data) %>%
  step_hai_scale_zero_one(all_numeric_predictors())
```

**When to use**:
- Neural networks (especially with sigmoid/tanh activation)
- Algorithms sensitive to outliers
- When you need interpretable [0, 1] scale
- Distance-based algorithms

---

## 🔄 Statistical Transformations

### Fourier Transform

Create sine and cosine features for cyclical patterns.

#### Vector Function

```r
# Transform with Fourier
x <- 1:365  # Days of year
fourier_result <- hai_fourier_vec(
  .x = x,
  .period = 365,  # Annual cycle
  .order = 2      # Number of sine/cosine pairs
)

# Returns matrix with sine and cosine columns
print(head(fourier_result))
```

#### Augment Function

```r
# Add Fourier features to data frame
df <- tibble::tibble(
  date = seq.Date(as.Date("2020-01-01"), as.Date("2020-12-31"), by = "day"),
  day_of_year = 1:365,
  sales = rnorm(365, 100, 20)
)

df_fourier <- hai_fourier_augment(
  .data = df,
  .value = day_of_year,
  .period = 365,
  .order = 2
)

# New columns: day_of_year_sin1, day_of_year_cos1, day_of_year_sin2, day_of_year_cos2
```

#### Recipe Step

```r
rec <- recipe(sales ~ ., data = df) %>%
  step_hai_fourier(
    day_of_year,
    period = 365,
    order = 2
  )
```

**When to use**:
- Cyclical time features (daily, weekly, monthly, yearly patterns)
- Seasonal modeling
- Time series analysis
- Better than raw day-of-week or month numbers

**Parameters**:
- `.period`: Length of one complete cycle (e.g., 7 for weekly, 365 for yearly)
- `.order`: Number of sine/cosine pairs (higher = more flexibility, but risk overfitting)

---

### Discrete Fourier Transform

For discrete cyclical categories.

```r
# For categorical cyclical data
categories <- c("Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun")
category_nums <- rep(1:7, length.out = 100)

df <- tibble::tibble(
  day_num = category_nums,
  value = rnorm(100)
)

# Augment with discrete Fourier
df_fourier <- hai_fourier_discrete_augment(
  .data = df,
  .value = day_num,
  .period = 7,
  .order = 1
)

# Recipe step
rec <- recipe(value ~ ., data = df) %>%
  step_hai_fourier_discrete(day_num, period = 7, order = 1)
```

---

### Hyperbolic Transformations

Create sinh, cosh, and tanh transformations.

#### Vector Function

```r
x <- seq(-2, 2, length.out = 20)

# Hyperbolic sine
sinh_x <- hai_hyperbolic_vec(x, .scale_type = "sinh")

# Hyperbolic cosine
cosh_x <- hai_hyperbolic_vec(x, .scale_type = "cosh")

# Hyperbolic tangent (bounds to [-1, 1])
tanh_x <- hai_hyperbolic_vec(x, .scale_type = "tanh")

# Logit
logit_x <- hai_hyperbolic_vec(x, .scale_type = "logit")

# Inverse hyperbolic sine (asinh) - handles negative values
asinh_x <- hai_hyperbolic_vec(x, .scale_type = "asinh")
```

#### Augment Function

```r
df <- tibble::tibble(
  x = rnorm(100, 10, 5),
  y = rnorm(100, 50, 20)
)

# Add hyperbolic transformations
df_hyper <- hai_hyperbolic_augment(
  .data = df,
  .value = x,
  .scale_type = "sinh"
)
```

#### Recipe Step

```r
rec <- recipe(y ~ ., data = df) %>%
  step_hai_hyperbolic(
    x,
    .scale_type = "asinh"  # Good default for skewed data
  )
```

**When to use**:
- Skewed distributions
- Data with extreme values
- When you need bounded transformations (tanh)
- Alternative to log transformation (asinh works with negative values)

**Scale Types**:
- `"sinh"`: Unbounded, handles negatives
- `"cosh"`: Always positive, symmetric
- `"tanh"`: Bounded to [-1, 1], sigmoid-like
- `"asinh"`: Inverse sinh, log-like but handles negatives
- `"logit"`: For probabilities [0, 1]

---

### Polynomial Features

Create polynomial and interaction features.

```r
# Create polynomial features
df <- tibble::tibble(
  x1 = rnorm(100),
  x2 = rnorm(100),
  y = rnorm(100)
)

# Augment with polynomial
df_poly <- hai_polynomial_augment(
  .data = df,
  .value = x1,
  .degree = 3  # x^2 and x^3
)

# This adds: x1_hai_poly_2, x1_hai_poly_3
```

**When to use**:
- Non-linear relationships
- Interaction effects
- Curve fitting

---

## 🔧 Winsorization

Handle outliers by capping extreme values.

### Truncate Method

Caps values at specified percentiles.

#### Vector Function

```r
# Data with outliers
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 100, 200)

# Truncate at 5th and 95th percentiles
truncated <- hai_winsorized_truncate_vec(
  .x = x,
  .fraction = 0.05  # 5% from each tail
)

print(truncated)
# Extreme values are capped at percentiles
```

#### Augment Function

```r
df <- tibble::tibble(
  patient_cost = c(100, 200, 300, 400, 500, 10000, 50000)
)

df_truncated <- hai_winsorized_truncate_augment(
  .data = df,
  .value = patient_cost,
  .fraction = 0.1  # 10% from each tail
)
```

#### Recipe Step

```r
rec <- recipe(y ~ ., data = train_data) %>%
  step_hai_winsorized_truncate(
    all_numeric_predictors(),
    fraction = 0.05
  )
```

---

### Move Method

Moves extreme values to specified percentiles.

#### Vector Function

```r
x <- c(1, 2, 3, 4, 5, 6, 7, 8, 9, 100, 200)

# Move extreme values to percentiles
moved <- hai_winsorized_move_vec(
  .x = x,
  .fraction = 0.05
)
```

#### Augment Function

```r
df_moved <- hai_winsorized_move_augment(
  .data = df,
  .value = patient_cost,
  .fraction = 0.1
)
```

#### Recipe Step

```r
rec <- recipe(y ~ ., data = train_data) %>%
  step_hai_winsorized_move(
    all_numeric_predictors(),
    fraction = 0.05
  )
```

**Truncate vs Move**:
- **Truncate**: Hard cap at percentile values
- **Move**: Moves outliers to percentile values (smoother)

**When to use**:
- Presence of extreme outliers
- Robust modeling required
- Healthcare data with occasional extreme values
- Before distance-based algorithms

**Fraction Guidelines**:
- `0.01` (1%): Very mild winsorization
- `0.05` (5%): Standard winsorization
- `0.10` (10%): Aggressive outlier handling

---

## 🔍 Missing Data Handling

### Imputation

```r
# Impute missing values
df <- tibble::tibble(
  x1 = c(1, 2, NA, 4, 5),
  x2 = c(10, NA, 30, 40, 50),
  y = c(100, 200, 300, 400, 500)
)

# Using internal function
imputed_df <- hai_data_impute(
  .recipe_object = recipe(y ~ ., data = df),
  .data = df,
  .seed_value = 123
)
```

For recipe-based imputation, use recipes package steps:

```r
rec <- recipe(y ~ ., data = df) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_impute_mode(all_nominal_predictors())
```

---

## 🔗 Preprocessing Pipelines

### Example 1: Complete Preprocessing Pipeline

```r
library(healthyR.ai)
library(recipes)
library(dplyr)

# Healthcare data preprocessing
rec <- recipe(readmission ~ ., data = patient_data) %>%
  # 1. Handle missing data
  step_impute_median(all_numeric_predictors()) %>%
  step_impute_mode(all_nominal_predictors()) %>%
  
  # 2. Handle outliers
  step_hai_winsorized_truncate(
    length_of_stay, total_cost, 
    fraction = 0.05
  ) %>%
  
  # 3. Transform skewed features
  step_hai_hyperbolic(
    all_numeric_predictors(),
    .scale_type = "asinh"
  ) %>%
  
  # 4. Create cyclical features
  step_hai_fourier(
    admission_day_of_week,
    period = 7,
    order = 1
  ) %>%
  
  # 5. Normalize
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  
  # 6. Encode categoricals
  step_dummy(all_nominal_predictors())

# Prep and apply
prepped_rec <- prep(rec)
transformed_data <- bake(prepped_rec, new_data = patient_data)
```

### Example 2: Minimal Preprocessing for Tree Models

```r
# Trees don't need scaling/normalization
rec_tree <- recipe(outcome ~ ., data = train_data) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors())  # Remove zero-variance
```

### Example 3: Aggressive Preprocessing for Linear Models

```r
# Linear models benefit from transformations
rec_linear <- recipe(outcome ~ ., data = train_data) %>%
  # Missing data
  step_impute_knn(all_numeric_predictors()) %>%
  
  # Outliers
  step_hai_winsorized_move(all_numeric_predictors(), fraction = 0.05) %>%
  
  # Skewness
  step_hai_hyperbolic(all_numeric_predictors(), .scale_type = "asinh") %>%
  
  # Interactions
  step_interact(~ all_numeric_predictors():all_numeric_predictors()) %>%
  
  # Scaling
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  
  # Encoding
  step_dummy(all_nominal_predictors()) %>%
  
  # Remove problematic features
  step_zv(all_predictors()) %>%
  step_corr(all_numeric_predictors(), threshold = 0.9)
```

### Example 4: Time Series Preprocessing

```r
rec_ts <- recipe(sales ~ ., data = sales_data) %>%
  # Lag features
  step_lag(sales, lag = 1:7) %>%
  
  # Rolling statistics
  step_mutate(
    sales_ma7 = slider::slide_dbl(sales, mean, .before = 7, .complete = TRUE)
  ) %>%
  
  # Cyclical features
  step_hai_fourier(day_of_week, period = 7, order = 1) %>%
  step_hai_fourier(day_of_year, period = 365, order = 2) %>%
  
  # Scale
  step_hai_scale_zscore(all_numeric_predictors())
```

---

## 🎯 Preprocessing by Algorithm Type

### Distance-Based (KNN, SVM)

```r
rec_distance <- recipe(y ~ ., data = train) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_hai_winsorized_truncate(all_numeric_predictors(), fraction = 0.05) %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors())
```

### Tree-Based (Random Forest, XGBoost)

```r
rec_tree <- recipe(y ~ ., data = train) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors())
```

### Linear Models (GLM, GLMnet)

```r
rec_linear <- recipe(y ~ ., data = train) %>%
  step_impute_knn(all_numeric_predictors()) %>%
  step_hai_hyperbolic(all_numeric_predictors(), .scale_type = "asinh") %>%
  step_hai_scale_zscore(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors()) %>%
  step_corr(all_numeric_predictors(), threshold = 0.9)
```

### Neural Networks

```r
rec_nn <- recipe(y ~ ., data = train) %>%
  step_impute_median(all_numeric_predictors()) %>%
  step_hai_scale_zero_one(all_numeric_predictors()) %>%
  step_dummy(all_nominal_predictors()) %>%
  step_zv(all_predictors())
```

---

## 📊 Choosing Transformations

### Decision Tree

```
Does your algorithm need scaled features?
├─ Yes (SVM, KNN, Neural Networks, Linear Models)
│  ├─ Use hai_scale_zscore for most cases
│  └─ Use hai_scale_zero_one for neural networks
└─ No (Tree-based models)
   └─ Skip scaling

Are there outliers?
├─ Yes
│  ├─ Mild: hai_winsorized_truncate, fraction = 0.05
│  └─ Severe: hai_winsorized_truncate, fraction = 0.10
└─ No
   └─ Skip winsorization

Is data skewed?
├─ Yes
│  ├─ hai_hyperbolic with asinh (handles negatives)
│  └─ log transform (for positive values)
└─ No
   └─ Skip transformations

Are there cyclical features?
├─ Yes (time, angles, etc.)
│  └─ hai_fourier with appropriate period
└─ No
   └─ Skip Fourier transforms
```

---

## 🎓 Best Practices

1. **Always split before preprocessing**: Fit preprocessing on training data only

```r
# ✅ Correct
data_split <- initial_split(data)
train <- training(data_split)
test <- testing(data_split)

rec <- recipe(y ~ ., data = train)  # Only use train
prepped <- prep(rec, training = train)
train_proc <- bake(prepped, new_data = train)
test_proc <- bake(prepped, new_data = test)

# ❌ Wrong - data leakage
rec <- recipe(y ~ ., data = data)  # Uses all data
```

2. **Order matters in recipes**: Apply steps in logical order

```r
# ✅ Correct order
recipe(y ~ ., data = train) %>%
  step_impute_median() %>%      # 1. Handle missing
  step_winsorized_truncate() %>% # 2. Handle outliers
  step_hyperbolic() %>%          # 3. Transform
  step_normalize() %>%           # 4. Scale
  step_dummy()                   # 5. Encode

# ❌ Wrong - scaling before imputation
recipe(y ~ ., data = train) %>%
  step_normalize() %>%           # Wrong: has missing values
  step_impute_median()
```

3. **Test preprocessing separately**: Verify transformations work as expected

```r
# Test each step
rec <- recipe(y ~ ., data = train) %>%
  step_hai_scale_zscore(x)

prepped <- prep(rec)
result <- bake(prepped, new_data = train)

# Verify mean ~ 0, sd ~ 1
mean(result$x)
sd(result$x)
```

4. **Document your choices**: Comment why you chose specific transformations

5. **Use appropriate transformations**: Match preprocessing to your algorithm

---

## 📚 Additional Resources

- **[Recipe Steps](Recipe-Steps.md)** - Detailed guide to recipe step integration
- **[AutoML Functions](AutoML-Functions.md)** - Using preprocessing with AutoML
- **[Statistical Functions](Statistical-Functions.md)** - Understanding your data before preprocessing
- **tidymodels recipes**: https://recipes.tidymodels.org/

---

*Last Updated: 2024-11-04*
