# API Reference

Complete reference of all exported functions in `healthyR.ai`.

---

## 📚 Function Categories

### AutoML Functions
Functions for automated machine learning with hyperparameter tuning.

| Function | Description | Model Type |
|----------|-------------|------------|
| `hai_auto_c50()` | C5.0 decision tree AutoML | Classification |
| `hai_auto_cubist()` | Cubist regression AutoML | Regression |
| `hai_auto_earth()` | Earth/MARS AutoML | Regression/Classification |
| `hai_auto_glmnet()` | Elastic net AutoML | Regression/Classification |
| `hai_auto_knn()` | K-nearest neighbors AutoML | Regression/Classification |
| `hai_auto_ranger()` | Random forest AutoML | Regression/Classification |
| `hai_auto_svm_poly()` | SVM polynomial kernel AutoML | Regression/Classification |
| `hai_auto_svm_rbf()` | SVM RBF kernel AutoML | Regression/Classification |
| `hai_auto_xgboost()` | XGBoost AutoML | Regression/Classification |

**Usage**: `hai_auto_*(data, recipe, metric, model_type, ...)`

---

### Data Preparation Functions
Prepare data for specific algorithms.

| Function | Description |
|----------|-------------|
| `hai_c50_data_prepper()` | Prepare data for C5.0 |
| `hai_cubist_data_prepper()` | Prepare data for Cubist |
| `hai_earth_data_prepper()` | Prepare data for Earth |
| `hai_glmnet_data_prepper()` | Prepare data for GLMnet |
| `hai_knn_data_prepper()` | Prepare data for KNN |
| `hai_ranger_data_prepper()` | Prepare data for Ranger |
| `hai_svm_poly_data_prepper()` | Prepare data for SVM polynomial |
| `hai_svm_rbf_data_prepper()` | Prepare data for SVM RBF |
| `hai_xgboost_data_prepper()` | Prepare data for XGBoost |

---

### Clustering Functions
K-means clustering with H2O.

| Function | Description |
|----------|-------------|
| `hai_kmeans_automl()` | Automatic K-means clustering |
| `hai_kmeans_automl_predict()` | Predict clusters for new data |
| `hai_kmeans_mapped_tbl()` | Get all fitted K-means models |
| `hai_kmeans_obj()` | Extract specific K-means model |
| `hai_kmeans_scree_data_tbl()` | Get scree plot data |
| `hai_kmeans_scree_plot()` | Visualize elbow/scree plot |
| `hai_kmeans_tidy_tbl()` | Get tidy cluster summaries |
| `hai_kmeans_user_item_tbl()` | Get cluster assignments |

**Aliases**: `kmeans_*()` functions mirror `hai_kmeans_*()` for compatibility.

---

### Dimensionality Reduction

| Function | Description |
|----------|-------------|
| `pca_your_recipe()` | PCA on recipe-preprocessed data |
| `hai_umap_list()` / `umap_list()` | UMAP projection |
| `hai_umap_plot()` / `umap_plt()` | Plot UMAP results |

---

### Scaling Functions

#### Vector Functions
| Function | Description |
|----------|-------------|
| `hai_scale_zscore_vec()` | Z-score standardization (mean=0, sd=1) |
| `hai_scale_zero_one_vec()` | Min-max normalization [0, 1] |

#### Augment Functions
| Function | Description |
|----------|-------------|
| `hai_scale_zscore_augment()` | Add z-score column to data frame |
| `hai_scale_zero_one_augment()` | Add normalized column to data frame |

#### Recipe Steps
| Function | Description |
|----------|-------------|
| `step_hai_scale_zscore()` | Z-score recipe step |
| `step_hai_scale_zero_one()` | Min-max recipe step |

---

### Transformation Functions

#### Fourier Transforms

**Vector Functions**:
- `hai_fourier_vec()` - Create sine/cosine features
- `hai_fourier_discrete_vec()` - Discrete Fourier transform

**Augment Functions**:
- `hai_fourier_augment()` - Add Fourier columns
- `hai_fourier_discrete_augment()` - Add discrete Fourier columns

**Recipe Steps**:
- `step_hai_fourier()` - Fourier recipe step
- `step_hai_fourier_discrete()` - Discrete Fourier recipe step

#### Hyperbolic Transforms

**Vector Functions**:
- `hai_hyperbolic_vec()` - sinh, cosh, tanh, asinh, logit transformations

**Augment Functions**:
- `hai_hyperbolic_augment()` - Add hyperbolic columns

**Recipe Steps**:
- `step_hai_hyperbolic()` - Hyperbolic recipe step

#### Polynomial Features

**Augment Functions**:
- `hai_polynomial_augment()` - Add polynomial features

---

### Winsorization Functions

#### Truncate Method

**Vector Functions**:
- `hai_winsorized_truncate_vec()` - Cap extreme values

**Augment Functions**:
- `hai_winsorized_truncate_augment()` - Add truncated column

**Recipe Steps**:
- `step_hai_winsorized_truncate()` - Truncate recipe step

#### Move Method

**Vector Functions**:
- `hai_winsorized_move_vec()` - Move extreme values

**Augment Functions**:
- `hai_winsorized_move_augment()` - Add moved column

**Recipe Steps**:
- `step_hai_winsorized_move()` - Move recipe step

---

### Statistical Functions

| Function | Description |
|----------|-------------|
| `hai_skewness_vec()` | Calculate skewness |
| `hai_kurtosis_vec()` | Calculate kurtosis |
| `hai_range_statistic()` | Calculate min, max, range |
| `hai_skewed_features()` | Identify skewed features in dataset |

---

### Distribution Analysis

| Function | Description |
|----------|-------------|
| `hai_distribution_comparison_tbl()` | Compare data to distributions |
| `hai_get_density_data_tbl()` | Extract density data |
| `hai_get_dist_data_tbl()` | Extract distribution data |

---

### Visualization Functions

#### Control Charts
| Function | Description |
|----------|-------------|
| `hai_control_chart()` | Create Shewhart control chart |

#### Distribution Plots
| Function | Description |
|----------|-------------|
| `hai_density_plot()` | Density plot |
| `hai_density_hist_plot()` | Combined density and histogram |
| `hai_density_qq_plot()` | Q-Q plot for normality |
| `hai_histogram_facet_plot()` | Faceted histograms |

#### Color Palettes
| Function | Description |
|----------|-------------|
| `color_blind()` | Get color-blind friendly colors |
| `hai_scale_color_colorblind()` | Apply to ggplot color scale |
| `hai_scale_fill_colorblind()` | Apply to ggplot fill scale |

---

### Utility Functions

| Function | Description |
|----------|-------------|
| `hai_auto_wflw_metrics()` | Get workflow metrics |
| `hai_default_classification_metric_set()` | Default classification metrics |
| `hai_default_regression_metric_set()` | Default regression metrics |
| `get_juiced_data()` | Extract juiced data from recipe |
| `generate_mesh_data()` | Generate mesh grid for predictions |

#### Internal Data Functions
| Function | Description |
|----------|-------------|
| `hai_data_impute()` | Impute missing data (internal) |
| `hai_data_poly()` | Add polynomial features (internal) |
| `hai_data_scale()` | Scale data (internal) |
| `hai_data_transform()` | Transform data (internal) |
| `hai_data_trig()` | Trigonometric transformations (internal) |

---

## 🔍 Function Naming Conventions

### Patterns

1. **`hai_*`**: All main functions start with `hai_`
2. **`hai_auto_*`**: AutoML functions with tuning
3. **`hai_*_vec()`**: Vector transformations
4. **`hai_*_augment()`**: Add columns to data frames
5. **`step_hai_*`**: Recipe steps for tidymodels
6. **`hai_*_data_prepper()`**: Data preparation for algorithms
7. **`hai_kmeans_*`**: K-means clustering functions

### Aliases

Some functions have shorter aliases for convenience:
- `umap_list()` → `hai_umap_list()`
- `umap_plt()` → `hai_umap_plot()`
- `kmeans_*()` → `hai_kmeans_*()`

---

## 📖 Getting Help

### Function Documentation

```r
# View help for any function
?hai_auto_knn
?hai_scale_zscore_vec
?step_hai_fourier

# View examples
example(hai_control_chart)
```

### Browse All Functions

```r
# List all exported functions
ls("package:healthyR.ai")

# Search for functions
apropos("hai_auto")
apropos("hai_scale")
```

### Vignettes

```r
# List available vignettes
browseVignettes("healthyR.ai")

# Open specific vignette
vignette("getting-started", package = "healthyR.ai")
vignette("auto-kmeans", package = "healthyR.ai")
vignette("kmeans-umap", package = "healthyR.ai")
```

---

## 🔗 Function Relationships

### Preprocessing Pipeline

```
Data → hai_*_vec() → Vector transformation
    ↓
    → hai_*_augment() → Add columns
    ↓
    → step_hai_*() → Recipe integration
    ↓
    → recipe → Preprocessing pipeline
    ↓
    → hai_auto_*() → AutoML modeling
```

### Clustering Workflow

```
Data → hai_kmeans_automl() → Fit multiple K-means
    ↓
    → hai_kmeans_scree_plot() → Visualize elbow
    ↓
    → hai_kmeans_user_item_tbl() → Get assignments
    ↓
    → hai_umap_list() → Visualize in 2D
    ↓
    → hai_umap_plot() → Create UMAP plot
```

---

## 📊 Common Parameter Patterns

### AutoML Functions

```r
hai_auto_*(
  .data,              # Training data
  .rec_obj,           # Recipe object
  .best_metric,       # Metric to optimize
  .model_type,        # "regression" or "classification"
  .tune_type,         # "grid_search" or "bayes"
  .grid_size,         # Number of combinations
  .num_cores,         # Parallel cores
  .cv_folds           # CV folds
)
```

### Vector Functions

```r
hai_*_vec(
  .x,                 # Input vector
  ...                 # Function-specific parameters
)
```

### Augment Functions

```r
hai_*_augment(
  .data,              # Data frame
  .value,             # Column to transform
  ...                 # Function-specific parameters
)
```

### Recipe Steps

```r
step_hai_*(
  recipe,
  ...,                # Columns to apply to (tidyselect)
  role = "predictor",
  trained = FALSE,
  ...                 # Function-specific parameters
)
```

---

## 🌐 Online Resources

- **Package Website**: https://www.spsanderson.com/healthyR.ai/
- **Function Reference**: https://www.spsanderson.com/healthyR.ai/reference/
- **GitHub Repository**: https://github.com/spsanderson/healthyR.ai
- **Issue Tracker**: https://github.com/spsanderson/healthyR.ai/issues

---

## 📝 Citation

```r
# Get citation information
citation("healthyR.ai")
```

---

*Last Updated: 2024-11-04*
