# Troubleshooting and FAQ

Common issues, solutions, and frequently asked questions for `healthyR.ai`.

---

## 📚 Table of Contents

1. [Installation Issues](#installation-issues)
2. [H2O Related Issues](#h2o-related-issues)
3. [AutoML Issues](#automl-issues)
4. [Recipe and Preprocessing Issues](#recipe-and-preprocessing-issues)
5. [Performance Issues](#performance-issues)
6. [Common Errors](#common-errors)
7. [FAQ](#faq)

---

## 🔧 Installation Issues

### Issue: Package won't install from CRAN

**Error**: `package 'healthyR.ai' is not available`

**Solutions**:
```r
# 1. Update R
version  # Check current version
# Update from https://www.r-project.org/

# 2. Try specific CRAN mirror
options(repos = c(CRAN = "https://cloud.r-project.org/"))
install.packages("healthyR.ai")

# 3. Install dependencies first
install.packages("tidymodels")
install.packages("h2o")
install.packages("healthyR.ai")
```

### Issue: Compilation errors on Linux

**Error**: `installation of package 'X' had non-zero exit status`

**Solution**:
```bash
# Ubuntu/Debian
sudo apt-get install r-base-dev libcurl4-openssl-dev libssl-dev libxml2-dev

# Fedora/CentOS
sudo yum install R-devel libcurl-devel openssl-devel libxml2-devel
```

---

## 💧 H2O Related Issues

### Issue: H2O won't start

**Error**: `H2O failed to start`

**Solutions**:
```r
# 1. Check Java version
system("java -version")  # Need Java 8+

# 2. Reinstall H2O
remove.packages("h2o")
install.packages("h2o", type = "source",
                 repos = "http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")

# 3. Initialize with more memory
library(h2o)
h2o.init(max_mem_size = "4G")
```

### Issue: H2O connection lost

**Error**: `Connection refused`

**Solution**:
```r
# Shutdown and restart
h2o.shutdown(prompt = FALSE)
Sys.sleep(2)
h2o.init()
```

### Issue: Can't use hai_kmeans_automl()

**Error**: `could not find function "h2o.init"`

**Solution**:
```r
# Always initialize H2O first
library(h2o)
h2o.init()

# Then use K-means functions
result <- hai_kmeans_automl(...)

# Shutdown when done
h2o.shutdown(prompt = FALSE)
```

---

## 🤖 AutoML Issues

### Issue: AutoML functions take too long

**Problem**: Training is very slow

**Solutions**:
```r
# 1. Reduce grid size
hai_auto_knn(..., .grid_size = 5)  # Instead of 10

# 2. Use fewer CV folds
hai_auto_knn(..., .cv_folds = 3)  # Instead of 5

# 3. Use more cores
hai_auto_knn(..., .num_cores = 4)

# 4. Use grid search instead of Bayes
hai_auto_knn(..., .tune_type = "grid_search")
```

### Issue: Out of memory during AutoML

**Error**: `cannot allocate vector of size`

**Solutions**:
```r
# 1. Use fewer cores
hai_auto_knn(..., .num_cores = 1)

# 2. Reduce data size
train_sample <- train_data %>% sample_frac(0.5)

# 3. Reduce grid size
hai_auto_knn(..., .grid_size = 5)

# 4. Close other applications
# 5. Restart R session
.rs.restartR()
```

### Issue: Wrong metric type error

**Error**: `metric should be one of...`

**Solution**:
```r
# For regression, use:
hai_auto_knn(..., .best_metric = "rmse")  # or "rsq", "mae"

# For classification, use:
hai_auto_knn(..., .best_metric = "accuracy")  # or "roc_auc", "f_meas"

# Match metric to model_type!
```

---

## 🔄 Recipe and Preprocessing Issues

### Issue: Recipe step fails with NA values

**Error**: `missing values in object`

**Solution**:
```r
# Add imputation BEFORE other steps
rec <- recipe(y ~ ., data = train) %>%
  step_impute_median(all_numeric_predictors()) %>%  # FIRST
  step_hai_scale_zscore(all_numeric_predictors())   # THEN scale
```

### Issue: "Cannot prep a trained recipe"

**Error**: `cannot prep a trained recipe`

**Solution**:
```r
# ❌ Wrong - trying to prep twice
rec <- recipe(y ~ ., data = train)
prepped <- prep(rec)
prepped2 <- prep(prepped)  # Error!

# ✅ Correct - prep once
rec <- recipe(y ~ ., data = train)
prepped <- prep(rec)
result <- bake(prepped, new_data = test)
```

### Issue: Variables not found after recipe

**Error**: `object 'x' not found`

**Solution**:
```r
# Make sure all variables in formula exist in data
rec <- recipe(y ~ x1 + x2, data = train)  # x1, x2 must exist

# Or use . for all variables
rec <- recipe(y ~ ., data = train)
```

### Issue: Fourier step creates too many columns

**Problem**: Too many Fourier features

**Solution**:
```r
# Reduce order parameter
step_hai_fourier(day, period = 7, order = 1)  # Creates 2 columns (sin, cos)
step_hai_fourier(day, period = 7, order = 2)  # Creates 4 columns

# Use order = 1 unless you need more complexity
```

---

## ⚡ Performance Issues

### Issue: Code runs slowly on large datasets

**Solutions**:
```r
# 1. Sample data for initial exploration
train_sample <- train_data %>% sample_n(10000)

# 2. Use data.table for large data
library(data.table)
train_dt <- as.data.table(train_data)

# 3. Use parallel processing
hai_auto_ranger(..., .num_cores = parallel::detectCores() - 1)

# 4. Use fewer features
rec <- recipe(y ~ ., data = train) %>%
  step_corr(all_predictors(), threshold = 0.9) %>%
  step_pca(all_numeric_predictors(), threshold = 0.95)
```

### Issue: Running out of memory

**Solutions**:
```r
# 1. Clear workspace
rm(list = ls())
gc()

# 2. Use fewer models
# Instead of trying all 9 AutoML functions, pick 2-3

# 3. Process in batches
# Split data and process separately

# 4. Increase system memory or use cloud computing
```

---

## ❌ Common Errors

### Error: "could not find function"

```r
# Make sure package is loaded
library(healthyR.ai)

# Check function name spelling
?hai_auto_knn  # Should open help
```

### Error: "argument is of length zero"

```r
# Check that data isn't empty
nrow(data)  # Should be > 0
ncol(data)  # Should be > 0

# Check variables exist
names(data)
```

### Error: "subscript out of bounds"

```r
# Check column names
names(data)

# Make sure you're using correct column reference
data$column_name  # Not data$wrong_name
```

### Error: "non-numeric argument to mathematical function"

```r
# Check data types
str(data)

# Convert to numeric if needed
data$column <- as.numeric(data$column)

# Or use recipe steps
rec <- recipe(y ~ ., data = train) %>%
  step_mutate(x = as.numeric(x))
```

---

## ❓ FAQ

### Q: Which AutoML function should I use?

**A**: Depends on your problem:
- **General purpose**: `hai_auto_ranger()` or `hai_auto_xgboost()`
- **High accuracy needed**: `hai_auto_xgboost()`
- **Fast baseline**: `hai_auto_knn()`
- **Interpretability**: `hai_auto_c50()` or `hai_auto_glmnet()`
- **High-dimensional**: `hai_auto_glmnet()`

See [AutoML Functions](AutoML-Functions.md) for detailed comparison.

---

### Q: Do I need to scale my data?

**A**: Depends on algorithm:
- **Need scaling**: KNN, SVM, Neural Networks, GLMnet
- **Don't need**: Random Forest, XGBoost, C5.0, Cubist

```r
# For distance-based models
rec <- recipe(y ~ ., data = train) %>%
  step_hai_scale_zscore(all_numeric_predictors())

# For tree-based models
rec <- recipe(y ~ ., data = train)  # No scaling needed
```

---

### Q: How do I choose the best metric?

**A**: 
- **Regression**: 
  - `"rmse"` (most common) - penalizes large errors
  - `"mae"` - more robust to outliers
  - `"rsq"` - proportion of variance explained

- **Classification**:
  - `"roc_auc"` (most common) - overall discrimination
  - `"accuracy"` - overall correctness
  - `"f_meas"` - balance of precision and recall

---

### Q: What's the difference between truncate and move?

**A**:
- **Truncate**: Hard cap at percentiles
  ```r
  step_hai_winsorized_truncate(x, fraction = 0.05)
  ```

- **Move**: Gentler, moves values to percentiles
  ```r
  step_hai_winsorized_move(x, fraction = 0.05)
  ```

Use truncate for more aggressive outlier handling.

---

### Q: How many CV folds should I use?

**A**:
- **Standard**: 5-fold (good balance)
- **More rigorous**: 10-fold (slower but more reliable)
- **Small data**: Leave-one-out (very slow)
- **Large data**: 3-fold (faster)

```r
hai_auto_knn(..., .cv_folds = 5)  # Most common choice
```

---

### Q: How do I save my trained model?

**A**:
```r
# Save the best model object
model_results <- hai_auto_knn(...)
saveRDS(model_results, "my_model.rds")

# Load later
loaded_model <- readRDS("my_model.rds")

# Also save the prepped recipe
prepped_rec <- prep(rec)
saveRDS(prepped_rec, "my_recipe.rds")
```

---

### Q: Can I use healthyR.ai with Spark?

**A**: Not directly. `healthyR.ai` is designed for in-memory R operations. For Spark:
1. Use sparklyr for distributed processing
2. Collect samples to R for healthyR.ai modeling
3. Or use Spark ML for distributed modeling

---

### Q: How do I handle imbalanced classification?

**A**:
```r
# 1. Use stratified sampling
data_split <- initial_split(data, strata = target_var)

# 2. Use appropriate metric
hai_auto_ranger(..., .best_metric = "roc_auc")  # Not accuracy

# 3. Consider oversampling/undersampling
library(themis)
rec <- recipe(y ~ ., data = train) %>%
  step_smote(y)  # Synthetic oversampling
```

---

### Q: Can I tune preprocessing hyperparameters?

**A**: Yes, using tune packages:
```r
# Mark recipe step for tuning
rec <- recipe(y ~ ., data = train) %>%
  step_hai_fourier(day, period = 7, order = tune())

# Tune both recipe and model
workflow() %>%
  add_model(model_spec) %>%
  add_recipe(rec) %>%
  tune_grid(...)
```

---

## 🐛 Reporting Bugs

If you encounter a bug:

1. **Check** if it's a known issue: [GitHub Issues](https://github.com/spsanderson/healthyR.ai/issues)

2. **Create reproducible example**:
```r
library(healthyR.ai)

# Minimal code that reproduces the error
data <- mtcars
result <- hai_auto_knn(...)
```

3. **Include**:
   - R version: `version`
   - Package version: `packageVersion("healthyR.ai")`
   - Error message
   - Expected behavior

4. **File issue**: https://github.com/spsanderson/healthyR.ai/issues/new

---

## 💡 Getting More Help

- **Stack Overflow**: Tag questions with `[r]` and `[healthyr.ai]`
- **GitHub Discussions**: For general questions
- **Package Website**: https://www.spsanderson.com/healthyR.ai/
- **Vignettes**: `browseVignettes("healthyR.ai")`

---

*Last Updated: 2024-11-04*
