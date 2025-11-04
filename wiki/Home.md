# Welcome to the healthyR.ai Wiki

<img src="https://raw.githubusercontent.com/spsanderson/healthyR.ai/master/man/figures/logo.png" width="150" align="right" />

**The Machine Learning and AI Modeling Companion to healthyR**

`healthyR.ai` is a comprehensive R package designed to streamline machine learning and AI workflows for healthcare data analysis. It provides an intuitive, consistent verb-based framework that simplifies data exploration, transformation, and modeling—taking the guesswork out of healthcare analytics.

---

## 📚 Wiki Contents

### Getting Started
- **[Installation Guide](Installation-Guide.md)** - How to install healthyR.ai and its dependencies
- **[Quick Start Guide](Quick-Start-Guide.md)** - Your first steps with healthyR.ai
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world healthcare analytics scenarios

### Core Features

#### Machine Learning
- **[AutoML Functions](AutoML-Functions.md)** - Automated machine learning with hyperparameter tuning
  - C5.0, Cubist, Random Forest (Ranger), XGBoost
  - Support Vector Machines (Polynomial & RBF)
  - GLMnet (elastic net regression)
  - K-Nearest Neighbors (KNN)
  - MARS (Earth)

#### Unsupervised Learning
- **[Clustering and Dimensionality Reduction](Clustering-and-Dimensionality-Reduction.md)**
  - K-Means AutoML with automatic optimal cluster detection
  - UMAP (Uniform Manifold Approximation and Projection)
  - PCA (Principal Component Analysis)

#### Data Processing
- **[Data Preprocessing](Data-Preprocessing.md)** - Scaling, transformations, and data preparation
- **[Recipe Steps](Recipe-Steps.md)** - Custom tidymodels recipe steps for seamless integration

#### Visualization & Analysis
- **[Visualization Functions](Visualization-Functions.md)** - Control charts, density plots, histograms
- **[Statistical Functions](Statistical-Functions.md)** - Skewness, kurtosis, distribution analysis

### Reference & Support
- **[API Reference](API-Reference.md)** - Complete function reference
- **[Troubleshooting and FAQ](Troubleshooting-and-FAQ.md)** - Common issues and solutions
- **[Contributing Guide](Contributing-Guide.md)** - How to contribute to healthyR.ai
- **[Changelog and Versioning](Changelog-and-Versioning.md)** - Version history and updates

---

## 🎯 Package Overview

### Key Features at a Glance

#### 🤖 AutoML Capabilities
Automated machine learning with intelligent hyperparameter tuning for multiple algorithms, making advanced modeling accessible without extensive expertise.

#### 📊 Healthcare-Focused
Designed specifically for healthcare analytics use cases:
- Predicting length of stay
- Forecasting readmission rates
- Monitoring quality metrics
- Identifying patient cohorts

#### 🔧 Tidymodels Integration
Seamless integration with the tidymodels ecosystem through custom recipe steps and consistent verb-based syntax.

#### 📈 Production-Ready
Built-in tools for:
- Statistical process control (control charts)
- Distribution analysis and outlier detection
- Model evaluation and comparison
- Color-blind friendly visualizations

---

## 🚀 Quick Example

```r
library(healthyR.ai)
library(recipes)

# Prepare your data
data_split <- rsample::initial_split(mtcars, prop = 0.8)
train_data <- rsample::training(data_split)

# Create a recipe
rec_obj <- recipe(mpg ~ ., data = train_data)

# Run AutoML KNN with hyperparameter tuning
knn_results <- hai_auto_knn(
  .data = train_data,
  .rec_obj = rec_obj,
  .best_metric = "rmse",
  .model_type = "regression"
)

# Access best model
best_model <- knn_results$model_info %>%
  filter(model_spec == knn_results$best_model_spec) %>%
  pull(model)
```

---

## 📦 Package Information

- **Current Version**: 0.1.1.9000 (development)
- **CRAN Version**: 0.1.1
- **License**: MIT
- **Author**: Steven P. Sanderson II, MPH
- **GitHub**: https://github.com/spsanderson/healthyR.ai
- **Website**: https://www.spsanderson.com/healthyR.ai/

---

## 🤝 Community & Support

### Getting Help
- **Issues**: Report bugs or request features at [GitHub Issues](https://github.com/spsanderson/healthyR.ai/issues)
- **Documentation**: Visit the [package website](https://www.spsanderson.com/healthyR.ai/)
- **Examples**: Check out the [vignettes](https://www.spsanderson.com/healthyR.ai/articles/)

### Contributing
We welcome contributions! See the [Contributing Guide](Contributing-Guide.md) for details on how to:
- Report bugs
- Suggest features
- Submit pull requests
- Improve documentation

### Citation
If you use `healthyR.ai` in your research, please cite it:

```r
citation("healthyR.ai")
```

---

## 📊 Package Statistics

- **Total Functions**: 70+ exported functions
- **AutoML Algorithms**: 8 algorithms with hyperparameter tuning
- **Recipe Steps**: 7 custom tidymodels recipe steps
- **Visualization Functions**: 10+ plotting functions
- **Statistical Functions**: Multiple distribution and descriptive statistics

---

## 🗺️ Navigation Tips

- Use the sidebar to navigate between wiki pages
- Each major feature has its own dedicated page with detailed examples
- The [API Reference](API-Reference.md) provides a complete function listing
- Start with the [Quick Start Guide](Quick-Start-Guide.md) if you're new to the package

---

## 📝 Recent Updates

See the [Changelog and Versioning](Changelog-and-Versioning.md) page for detailed version history.

**Latest Development Version (0.1.1.9000)**:
- Fixed consistency in `hai_data_*` function return names
- All updated recipe objects now use the name `new_rec_obj`

**Latest CRAN Release (0.1.1)**:
- Updated `hai_c50_data_prepper()` function
- Various bug fixes and improvements

---

*Last Updated: 2024-11-04*
