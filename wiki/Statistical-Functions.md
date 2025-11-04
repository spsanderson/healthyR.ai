# Statistical Functions

Guide to statistical analysis functions in `healthyR.ai` for understanding data distributions and characteristics.

---

## 📚 Table of Contents

1. [Distribution Statistics](#distribution-statistics)
2. [Range Statistics](#range-statistics)
3. [Skewness and Kurtosis](#skewness-and-kurtosis)
4. [Feature Analysis](#feature-analysis)

---

## 📊 Distribution Statistics

### `hai_distribution_comparison_tbl()`

Compare your data against multiple theoretical distributions.

```r
library(healthyR.ai)

# Scale data to [0, 1]
scaled_data <- hai_scale_zero_one_vec(mtcars$mpg)

# Compare distributions
dist_comparison <- hai_distribution_comparison_tbl(scaled_data)
print(dist_comparison)
```

**Returns**: Tibble with distribution fits and statistics

**Use Cases**:
- Identify best-fitting distribution
- Understand data characteristics
- Choose appropriate statistical tests
- Model selection

---

### `hai_get_density_data_tbl()`

Extract density estimates from distribution comparison.

```r
# Get density data
density_data <- hai_get_density_data_tbl(dist_comparison)

# Use for plotting
hai_density_plot(
  density_data,
  distribution,
  x,
  y
)
```

---

### `hai_get_dist_data_tbl()`

Get distribution data for analysis.

```r
dist_data <- hai_get_dist_data_tbl(dist_comparison)
print(dist_data)
```

---

## 📏 Range Statistics

### `hai_range_statistic()`

Calculate range statistics (min, max, range) for vectors.

```r
# Calculate range statistics
x <- c(1, 5, 10, 15, 20, 25, 100)

range_stats <- hai_range_statistic(x)
print(range_stats)
# Returns: min, max, range
```

**Formula**: 
- Range = max(x) - min(x)

**Use Cases**:
- Quick data summary
- Outlier detection preparation
- Data quality checks

---

## 📈 Skewness and Kurtosis

### `hai_skewness_vec()`

Calculate the skewness (asymmetry) of a distribution.

```r
# Calculate skewness
x <- rnorm(100, mean = 50, sd = 10)
skewness <- hai_skewness_vec(x)
print(skewness)
```

**Formula**: 
```
((1/n) * sum(x - mu)^3) / ((1/n) * sum(x - mu)^2)^(3/2)
```

**Interpretation**:
- **Skewness ≈ 0**: Symmetric distribution (normal-like)
- **Skewness > 0**: Right-skewed (long tail on right)
- **Skewness < 0**: Left-skewed (long tail on left)
- **|Skewness| > 1**: Highly skewed
- **|Skewness| > 2**: Extremely skewed

**Requirements**: Vector must have length ≥ 4

**Use Cases**:
- Assess normality
- Decide on transformations
- Understand distribution shape
- Choose appropriate models

---

### `hai_kurtosis_vec()`

Calculate the kurtosis (tailedness) of a distribution.

```r
# Calculate kurtosis
x <- rnorm(100, mean = 50, sd = 10)
kurtosis <- hai_kurtosis_vec(x)
print(kurtosis)
```

**Formula**:
```
((1/n) * sum(x - mu)^4) / ((1/n) * sum(x - mu)^2)^2 - 3
```

**Interpretation**:
- **Kurtosis ≈ 0**: Normal distribution (mesokurtic)
- **Kurtosis > 0**: Heavy tails, more outliers (leptokurtic)
- **Kurtosis < 0**: Light tails, fewer outliers (platykurtic)
- **Kurtosis > 3**: Very heavy tails
- **Kurtosis < -1**: Very light tails

**Requirements**: Vector must have length ≥ 4

**Use Cases**:
- Assess outlier presence
- Understand tail behavior
- Risk assessment (in finance/healthcare)
- Model selection

---

## 🔍 Feature Analysis

### `hai_skewed_features()`

Identify skewed features in your dataset.

```r
library(dplyr)

# Identify skewed features
skewed_features <- hai_skewed_features(
  .data = mtcars,
  .threshold = 0.5  # Absolute skewness threshold
)

print(skewed_features)
```

**Parameters**:
- `.data`: Data frame
- `.threshold`: Absolute skewness threshold (default: 0.5)

**Returns**: Data frame with:
- `feature`: Column name
- `skewness`: Skewness value
- `abs_skewness`: Absolute skewness

**Use Cases**:
- Preprocessing decisions
- Identify which features need transformation
- Data quality assessment
- Feature engineering guidance

**Example with Interpretation**:

```r
# Find highly skewed features
skewed <- hai_skewed_features(patient_data, .threshold = 1.0)

# Features needing transformation
highly_skewed <- skewed %>%
  filter(abs_skewness > 1.0) %>%
  arrange(desc(abs_skewness))

print(highly_skewed)

# Apply appropriate transformations
patient_data_transformed <- patient_data %>%
  mutate(
    cost_transformed = hai_hyperbolic_vec(total_cost, .scale_type = "asinh"),
    los_transformed = log1p(length_of_stay)
  )
```

---

## 🎯 Complete Distribution Analysis

### Workflow for Understanding Your Data

```r
library(healthyR.ai)
library(dplyr)

# 1. Calculate basic statistics
summary_stats <- patient_data %>%
  summarise(
    mean_age = mean(age),
    median_age = median(age),
    min_age = min(age),
    max_age = max(age),
    range_age = max(age) - min(age),
    skewness_age = hai_skewness_vec(age),
    kurtosis_age = hai_kurtosis_vec(age)
  )

print(summary_stats)

# 2. Identify skewed features
skewed_features <- hai_skewed_features(patient_data, .threshold = 0.5)
print(skewed_features)

# 3. Compare distributions for key variables
age_scaled <- hai_scale_zero_one_vec(patient_data$age)
age_dist_comp <- hai_distribution_comparison_tbl(age_scaled)
print(age_dist_comp)

# 4. Visualize
density_data <- hai_get_density_data_tbl(age_dist_comp)
hai_density_plot(density_data, distribution, x, y)

# 5. Q-Q plot for normality
hai_density_qq_plot(patient_data, age)
```

---

## 📊 Decision Trees for Analysis

### Should I Transform This Feature?

```
Calculate skewness with hai_skewness_vec()
│
├─ |Skewness| < 0.5?
│  └─ Fairly symmetric - transformation probably not needed
│
├─ 0.5 < |Skewness| < 1?
│  └─ Moderately skewed - consider transformation for:
│     ├─ Linear models: Yes
│     ├─ Tree models: No
│     └─ Neural networks: Yes
│
└─ |Skewness| > 1?
   └─ Highly skewed - transformation recommended:
      ├─ Positive skew (right tail): log, sqrt, asinh
      └─ Negative skew (left tail): square, cube
```

### Do I Have Outliers?

```
Calculate kurtosis with hai_kurtosis_vec()
│
├─ Kurtosis > 3?
│  └─ Heavy tails - likely outliers present
│     └─ Use hai_winsorized_truncate() or examine outliers
│
├─ -1 < Kurtosis < 3?
│  └─ Normal tail behavior
│
└─ Kurtosis < -1?
   └─ Light tails - uniform-like distribution
```

---

## 💡 Practical Examples

### Example 1: Healthcare Cost Analysis

```r
# Analyze healthcare costs
cost_data <- patient_data$total_cost

# Calculate statistics
cat("Mean:", mean(cost_data), "\n")
cat("Median:", median(cost_data), "\n")
cat("Skewness:", hai_skewness_vec(cost_data), "\n")
cat("Kurtosis:", hai_kurtosis_vec(cost_data), "\n")

# Typically, healthcare costs are right-skewed
# Skewness > 1 indicates need for transformation

if (hai_skewness_vec(cost_data) > 1) {
  cat("Cost is highly skewed - consider log or asinh transformation\n")
  
  # Apply transformation
  cost_transformed <- hai_hyperbolic_vec(cost_data, .scale_type = "asinh")
  
  # Verify improvement
  cat("Transformed Skewness:", hai_skewness_vec(cost_transformed), "\n")
}
```

### Example 2: Batch Feature Assessment

```r
# Assess all numeric features
patient_data %>%
  select(where(is.numeric)) %>%
  summarise(across(
    everything(),
    list(
      skew = ~hai_skewness_vec(.),
      kurt = ~hai_kurtosis_vec(.)
    ),
    .names = "{.col}_{.fn}"
  )) %>%
  pivot_longer(everything()) %>%
  separate(name, into = c("feature", "statistic"), sep = "_(?=[^_]+$)") %>%
  pivot_wider(names_from = statistic, values_from = value) %>%
  mutate(
    needs_transform = abs(skew) > 0.5,
    has_outliers = abs(kurt) > 1
  ) %>%
  arrange(desc(abs(skew)))
```

### Example 3: Before/After Transformation Comparison

```r
# Original data
original_skew <- hai_skewness_vec(patient_data$length_of_stay)
original_kurt <- hai_kurtosis_vec(patient_data$length_of_stay)

cat("Original - Skewness:", original_skew, "Kurtosis:", original_kurt, "\n")

# Apply transformation
transformed <- hai_hyperbolic_vec(
  patient_data$length_of_stay,
  .scale_type = "asinh"
)

# Check improvement
new_skew <- hai_skewness_vec(transformed)
new_kurt <- hai_kurtosis_vec(transformed)

cat("Transformed - Skewness:", new_skew, "Kurtosis:", new_kurt, "\n")
cat("Improvement: ", 
    abs(original_skew) - abs(new_skew), 
    "reduction in skewness\n")
```

---

## 🎓 Best Practices

### 1. Always Calculate Both Skewness and Kurtosis

```r
# ✅ Complete picture
skew <- hai_skewness_vec(x)
kurt <- hai_kurtosis_vec(x)
cat("Skewness:", skew, "Kurtosis:", kurt)

# ❌ Incomplete analysis
skew <- hai_skewness_vec(x)  # Missing kurtosis info
```

### 2. Use in Preprocessing Pipeline

```r
# Identify features needing transformation
skewed <- hai_skewed_features(train_data, .threshold = 0.5)

# Create recipe based on analysis
rec <- recipe(y ~ ., data = train_data)

# Add transformations for skewed features
for (feat in skewed$feature) {
  rec <- rec %>%
    step_hai_hyperbolic(!!sym(feat), .scale_type = "asinh")
}
```

### 3. Document Your Findings

```r
# Create analysis report
analysis_report <- train_data %>%
  select(where(is.numeric)) %>%
  summarise(across(
    everything(),
    list(
      mean = mean,
      median = median,
      skew = hai_skewness_vec,
      kurt = hai_kurtosis_vec
    )
  ))

# Save for reference
write.csv(analysis_report, "distribution_analysis.csv")
```

### 4. Visualize Statistics

```r
# Visualize skewness across features
skewed_features <- hai_skewed_features(train_data)

ggplot(skewed_features, aes(x = reorder(feature, abs_skewness), 
                             y = skewness)) +
  geom_col(aes(fill = abs_skewness > 0.5)) +
  geom_hline(yintercept = c(-0.5, 0.5), linetype = "dashed") +
  coord_flip() +
  labs(title = "Feature Skewness Analysis",
       x = "Feature",
       y = "Skewness") +
  theme_minimal()
```

---

## 📚 Additional Resources

- **[Data Preprocessing](Data-Preprocessing.md)** - Transform based on statistics
- **[Visualization Functions](Visualization-Functions.md)** - Visualize distributions
- **[Quick Start Guide](Quick-Start-Guide.md)** - Basic usage examples
- **Wikipedia - Skewness**: https://en.wikipedia.org/wiki/Skewness
- **Wikipedia - Kurtosis**: https://en.wikipedia.org/wiki/Kurtosis

---

*Last Updated: 2024-11-04*
