# Clustering and Dimensionality Reduction

Comprehensive guide to unsupervised learning functions in `healthyR.ai`, including K-Means clustering, UMAP, and PCA.

---

## 📚 Table of Contents

1. [K-Means Clustering](#k-means-clustering)
2. [UMAP (Uniform Manifold Approximation and Projection)](#umap)
3. [PCA (Principal Component Analysis)](#pca)
4. [Use Cases](#use-cases)
5. [Best Practices](#best-practices)

---

## 🎯 K-Means Clustering

### Overview

K-Means clustering automatically groups similar observations together. `healthyR.ai` provides `hai_kmeans_automl()` which automatically tests multiple cluster sizes and helps you find the optimal number of clusters.

### Core Functions

- `hai_kmeans_automl()` - Main AutoML function for K-Means
- `hai_kmeans_automl_predict()` - Predict cluster assignments for new data
- `hai_kmeans_scree_plot()` - Visualize elbow/scree plot
- `hai_kmeans_tidy_tbl()` - Get tidy cluster summaries
- `hai_kmeans_user_item_tbl()` - Get cluster assignments
- `hai_kmeans_mapped_tbl()` - Get all fitted models
- `hai_kmeans_obj()` - Get specific k-means object
- `hai_kmeans_scree_data_tbl()` - Get scree plot data

### Basic K-Means Workflow

```r
library(healthyR.ai)
library(h2o)
library(dplyr)

# Initialize H2O
h2o.init()

# Prepare data - select numeric columns for clustering
data_tbl <- iris %>%
  select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)

# Run K-Means AutoML
# Tests multiple cluster numbers and returns all results
kmeans_obj <- hai_kmeans_automl(
  .data = data_tbl,
  .predictors = c("Sepal.Length", "Sepal.Width", "Petal.Length", "Petal.Width"),
  .standardize = TRUE,
  .centers = 10,           # Maximum number of clusters to test
  .max_iterations = 100,
  .categorical_encoding = "auto"
)

# Shutdown H2O when done
h2o.shutdown(prompt = FALSE)
```

### Determining Optimal Clusters

#### Method 1: Scree/Elbow Plot

```r
# Visualize the elbow plot
scree_plot <- hai_kmeans_scree_plot(kmeans_obj)
print(scree_plot)

# Look for the "elbow" where adding more clusters gives diminishing returns
# The optimal k is typically at the elbow point
```

#### Method 2: Examine Total Within-Cluster Sum of Squares

```r
# Get scree data
scree_data <- hai_kmeans_scree_data_tbl(kmeans_obj)

# View total within-cluster sum of squares by k
scree_data %>%
  select(k, tot.withinss) %>%
  arrange(k)

# Calculate percentage decrease
scree_data %>%
  arrange(k) %>%
  mutate(
    pct_decrease = (lag(tot.withinss) - tot.withinss) / lag(tot.withinss) * 100
  ) %>%
  select(k, tot.withinss, pct_decrease)
```

### Analyzing Cluster Results

#### Get Cluster Assignments

```r
# Get data with cluster assignments
user_item_tbl <- hai_kmeans_user_item_tbl(kmeans_obj)

# View first few rows
head(user_item_tbl)

# Count observations per cluster
user_item_tbl %>%
  count(k, centers_tbl)

# For specific k (e.g., k=3)
user_item_tbl %>%
  filter(k == 3) %>%
  count(centers_tbl)
```

#### Get Cluster Statistics

```r
# Get tidy cluster summaries
cluster_stats <- hai_kmeans_tidy_tbl(kmeans_obj)

# View cluster centers for k=3
cluster_stats %>%
  filter(k == 3) %>%
  select(cluster, size, withinss, variable, value)

# Compare cluster sizes
cluster_stats %>%
  filter(k == 3) %>%
  distinct(cluster, size) %>%
  arrange(desc(size))
```

### Predicting on New Data

```r
# Split data for demonstration
set.seed(123)
train_idx <- sample(1:nrow(data_tbl), 0.8 * nrow(data_tbl))
train_data <- data_tbl[train_idx, ]
new_data <- data_tbl[-train_idx, ]

# Train K-Means
h2o.init()
kmeans_model <- hai_kmeans_automl(
  .data = train_data,
  .predictors = names(train_data),
  .standardize = TRUE,
  .centers = 5
)

# Predict clusters for new data
# Choose optimal k (e.g., k=3 based on elbow plot)
predictions <- hai_kmeans_automl_predict(
  .object = kmeans_model,
  .centers = 3,
  .new_data = new_data
)

h2o.shutdown(prompt = FALSE)
```

### Advanced K-Means Options

```r
# Full parameter specification
kmeans_obj <- hai_kmeans_automl(
  .data = data_tbl,
  .predictors = c("var1", "var2", "var3"),
  
  # Clustering parameters
  .centers = 15,                      # Max clusters to test
  .standardize = TRUE,                # Standardize features
  .max_iterations = 100,              # Max iterations per k
  
  # Initialization
  .initialization_mode = "Furthest",  # or "Random", "PlusPlus"
  .seed = 1234,                       # For reproducibility
  
  # Data handling
  .split_ratio = 0.80,                # Train/validation split
  .categorical_encoding = "auto",     # Encoding method
  
  # Output control
  .print_model_summary = TRUE         # Print summaries
)
```

### Categorical Encoding Options

When your data has categorical variables:

```r
kmeans_obj <- hai_kmeans_automl(
  .data = data_with_categoricals,
  .predictors = c("numeric_var1", "numeric_var2", "categorical_var"),
  .categorical_encoding = "one_hot_explicit",  # Options:
  # "auto" - Automatic selection
  # "enum" - Integer encoding
  # "one_hot_explicit" - One-hot encoding
  # "binary" - Binary encoding
  # "eigen" - Eigen decomposition
  # "label_encoder" - Label encoding
  # "sort_by_response" - Sort by response
  # "enum_limited" - Limited enum encoding
)
```

---

## 🗺️ UMAP (Uniform Manifold Approximation and Projection)

### Overview

UMAP is a dimensionality reduction technique that projects high-dimensional data into 2D or 3D space while preserving local and global structure. It's excellent for visualization and identifying clusters.

### Core Functions

- `hai_umap_list()` (alias: `umap_list()`) - Create UMAP projection
- `hai_umap_plot()` (alias: `umap_plt()`) - Visualize UMAP results

### Basic UMAP Workflow

```r
library(healthyR.ai)
library(dplyr)

# Prepare data (numeric features only)
data_tbl <- iris %>%
  select(Sepal.Length, Sepal.Width, Petal.Length, Petal.Width)

# Create UMAP projection
umap_obj <- hai_umap_list(
  .data = data_tbl,
  Species ~ .,              # Formula: color by Species
  .num_neighbors = 15,      # Number of neighbors
  .min_dist = 0.1,          # Minimum distance between points
  .scale = "center_scale"   # Scaling method
)

# Create visualization
umap_plot <- hai_umap_plot(
  .data = umap_obj,
  .point_size = 2,
  .alpha = 0.8,
  .plot_title = "UMAP Projection of Iris Dataset",
  .plot_subtitle = "Colored by Species",
  .interactive = FALSE
)

print(umap_plot)
```

### UMAP Parameters Explained

#### Number of Neighbors (`num_neighbors`)

Controls how UMAP balances local vs global structure:

```r
# Small value (5-15): Emphasizes local structure, more clusters
umap_local <- hai_umap_list(
  .data = data_tbl,
  Species ~ .,
  .num_neighbors = 5,
  .min_dist = 0.1
)

# Large value (50-100): Emphasizes global structure, broader patterns
umap_global <- hai_umap_list(
  .data = data_tbl,
  Species ~ .,
  .num_neighbors = 50,
  .min_dist = 0.1
)
```

#### Minimum Distance (`min_dist`)

Controls how tightly points are packed:

```r
# Small value (0.01-0.1): Tightly packed, more structure visible
umap_tight <- hai_umap_list(
  .data = data_tbl,
  Species ~ .,
  .num_neighbors = 15,
  .min_dist = 0.01
)

# Large value (0.5-0.99): Loosely packed, smoother embedding
umap_loose <- hai_umap_list(
  .data = data_tbl,
  Species ~ .,
  .num_neighbors = 15,
  .min_dist = 0.5
)
```

### Scaling Options

```r
# No scaling
umap_no_scale <- hai_umap_list(data_tbl, Species ~ ., .scale = "none")

# Center only (mean = 0)
umap_center <- hai_umap_list(data_tbl, Species ~ ., .scale = "center")

# Scale only (variance = 1)
umap_scale <- hai_umap_list(data_tbl, Species ~ ., .scale = "scale")

# Center and scale (recommended for most cases)
umap_both <- hai_umap_list(data_tbl, Species ~ ., .scale = "center_scale")
```

### Interactive UMAP Plots

```r
# Create interactive plot using plotly
umap_interactive <- hai_umap_plot(
  .data = umap_obj,
  .point_size = 2,
  .interactive = TRUE,
  .plot_title = "Interactive UMAP"
)

# View in browser
umap_interactive
```

### Combining K-Means and UMAP

Powerful technique: Use K-Means to cluster, then visualize with UMAP:

```r
library(healthyR.ai)
library(h2o)
library(dplyr)

# Prepare data
data_tbl <- mtcars %>%
  select(mpg, cyl, disp, hp, wt)

# Step 1: K-Means clustering
h2o.init()
kmeans_obj <- hai_kmeans_automl(
  .data = data_tbl,
  .predictors = names(data_tbl),
  .standardize = TRUE,
  .centers = 5
)

# Get cluster assignments (e.g., for k=3)
clusters <- hai_kmeans_user_item_tbl(kmeans_obj) %>%
  filter(k == 3) %>%
  select(centers_tbl)

h2o.shutdown(prompt = FALSE)

# Step 2: Add cluster labels to data
data_with_clusters <- bind_cols(data_tbl, cluster = clusters$centers_tbl)

# Step 3: UMAP visualization colored by clusters
umap_obj <- hai_umap_list(
  .data = data_with_clusters,
  cluster ~ .,
  .num_neighbors = 15,
  .min_dist = 0.1
)

hai_umap_plot(
  .data = umap_obj,
  .point_size = 3,
  .plot_title = "UMAP Visualization of K-Means Clusters"
)
```

---

## 📊 PCA (Principal Component Analysis)

### Overview

PCA reduces dimensionality by finding principal components that capture the most variance in your data. It's useful for dimensionality reduction, visualization, and understanding feature relationships.

### Core Function

- `pca_your_recipe()` - Perform PCA on recipe-preprocessed data

### Basic PCA Workflow

```r
library(healthyR.ai)
library(recipes)
library(dplyr)

# Prepare data
data_tbl <- mtcars

# Create recipe
rec_obj <- recipe(~ ., data = data_tbl) %>%
  step_normalize(all_numeric()) %>%
  step_pca(all_numeric(), threshold = 0.80)

# Perform PCA
pca_results <- pca_your_recipe(
  .data = data_tbl,
  .recipe_object = rec_obj,
  .threshold = 0.80,  # Capture 80% of variance
  .top_n = 5          # Show top 5 loadings
)
```

### Understanding PCA Output

```r
# Structure of output
names(pca_results)
# [1] "pca_transform"    - Transformed data
# [2] "variable_loadings" - Variable contributions
# [3] "pca_variance"     - Variance explained
# [4] "pca_juiced_tbl"   - Preprocessed data
# [5] "pca_baked_tbl"    - PCA-transformed data
# [6] "pca_recipe"       - Recipe with PCA
# [7] "top_n_loadings_plt" - Loadings plot
# [8] "scree_plt"        - Scree plot
```

### Examining Variance Explained

```r
# View variance explained by each component
pca_variance <- pca_results$pca_variance
print(pca_variance)

# Plot variance explained
pca_results$scree_plt
```

### Examining Variable Loadings

```r
# View variable loadings (contributions)
loadings <- pca_results$variable_loadings
print(loadings)

# View loadings plot for top N variables
pca_results$top_n_loadings_plt
```

### Using PCA-Transformed Data

```r
# Get transformed data
pca_data <- pca_results$pca_baked_tbl

# Use for modeling
model_data <- pca_data %>%
  bind_cols(outcome = original_data$outcome)

# Train model on PCA components
model <- lm(outcome ~ ., data = model_data)
```

### Advanced PCA Options

```r
# Custom preprocessing before PCA
rec_obj <- recipe(~ ., data = data_tbl) %>%
  # Remove near-zero variance features
  step_nzv(all_numeric()) %>%
  # Handle missing values
  step_impute_median(all_numeric()) %>%
  # Normalize
  step_normalize(all_numeric()) %>%
  # Perform PCA capturing 90% variance
  step_pca(all_numeric(), threshold = 0.90)

pca_results <- pca_your_recipe(
  .data = data_tbl,
  .recipe_object = rec_obj,
  .threshold = 0.90,
  .top_n = 10
)
```

---

## 🎯 Use Cases

### Patient Segmentation with K-Means

```r
library(healthyR.ai)
library(h2o)

# Patient data: age, length_of_stay, num_procedures, cost
h2o.init()

patient_data <- healthcare_data %>%
  select(age, length_of_stay, num_procedures, total_cost)

# Find patient segments
kmeans_obj <- hai_kmeans_automl(
  .data = patient_data,
  .predictors = names(patient_data),
  .standardize = TRUE,
  .centers = 8
)

# Determine optimal clusters
hai_kmeans_scree_plot(kmeans_obj)

# Get patient segments (e.g., k=4)
segments <- hai_kmeans_user_item_tbl(kmeans_obj) %>%
  filter(k == 4)

# Analyze segment characteristics
patient_data %>%
  bind_cols(segment = segments$centers_tbl) %>%
  group_by(segment) %>%
  summarise(
    n = n(),
    avg_age = mean(age),
    avg_los = mean(length_of_stay),
    avg_cost = mean(total_cost)
  )

h2o.shutdown(prompt = FALSE)
```

### Visualizing High-Dimensional Patient Data with UMAP

```r
# Many features per patient
patient_features <- patient_data %>%
  select(age, bmi, glucose, blood_pressure, cholesterol, 
         medication_count, comorbidity_score)

# UMAP projection
umap_obj <- hai_umap_list(
  .data = patient_features,
  risk_category ~ .,
  .num_neighbors = 20,
  .min_dist = 0.1
)

# Visualize
hai_umap_plot(
  .data = umap_obj,
  .point_size = 2,
  .plot_title = "Patient Risk Categories in UMAP Space"
)
```

### Dimensionality Reduction for Modeling with PCA

```r
# Many correlated features
rec_obj <- recipe(readmission ~ ., data = patient_data) %>%
  step_normalize(all_numeric_predictors()) %>%
  step_pca(all_numeric_predictors(), threshold = 0.95)

# Perform PCA
pca_results <- pca_your_recipe(
  .data = patient_data,
  .recipe_object = rec_obj,
  .threshold = 0.95
)

# Use reduced features for modeling
reduced_data <- pca_results$pca_baked_tbl %>%
  bind_cols(readmission = patient_data$readmission)

# Train model on fewer features
model <- hai_auto_ranger(
  .data = reduced_data,
  .rec_obj = recipe(readmission ~ ., data = reduced_data),
  .best_metric = "accuracy",
  .model_type = "classification"
)
```

---

## 🎓 Best Practices

### K-Means Best Practices

1. **Standardize your data**: Always use `.standardize = TRUE` unless you have a specific reason not to

2. **Test multiple k values**: Set `.centers` high enough to explore different cluster numbers

3. **Use the elbow method**: Look for the "elbow" in the scree plot, not the minimum sum of squares

4. **Validate results**: Check if clusters make sense in your domain context

5. **Handle categorical variables**: Choose appropriate `.categorical_encoding`

### UMAP Best Practices

1. **Experiment with parameters**: 
   - Start with `num_neighbors = 15`, `min_dist = 0.1`
   - Adjust based on your data structure

2. **Scale your data**: Use `.scale = "center_scale"` for most cases

3. **Interpret carefully**: UMAP preserves local structure; distances in UMAP space don't always reflect original distances

4. **Use for visualization**: Great for exploratory analysis, not for precise distance measurements

5. **Combine with clustering**: Use UMAP to visualize clustering results

### PCA Best Practices

1. **Choose appropriate threshold**: 
   - 80-90% variance is typical
   - Higher for modeling, lower for visualization

2. **Examine loadings**: Understand which original features contribute to each component

3. **Check assumptions**: PCA assumes linear relationships

4. **Consider alternatives**: For non-linear relationships, use UMAP instead

5. **Preprocessing matters**: Always normalize/standardize before PCA

---

## 📚 Additional Resources

- **[Quick Start Guide](Quick-Start-Guide.md)** - Basic usage patterns
- **[AutoML Functions](AutoML-Functions.md)** - Use clusters as features
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications
- **Vignettes**: 
  - Auto K-Means: `vignette("auto-kmeans", package = "healthyR.ai")`
  - K-Means and UMAP: `vignette("kmeans-umap", package = "healthyR.ai")`

---

*Last Updated: 2024-11-04*
