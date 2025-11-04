# Changelog and Versioning

Version history and release notes for `healthyR.ai`.

---

## 📋 Version Numbering

`healthyR.ai` uses [Semantic Versioning](https://semver.org/):

**MAJOR.MINOR.PATCH** (e.g., 0.1.1)

- **MAJOR**: Incompatible API changes
- **MINOR**: New features, backwards-compatible
- **PATCH**: Bug fixes, backwards-compatible

Development versions: `MAJOR.MINOR.PATCH.9000` (e.g., 0.1.1.9000)

---

## 🚀 Latest Versions

### Current CRAN Release: 0.1.1
### Current Development: 0.1.1.9000

---

## 📝 Detailed Changelog

### healthyR.ai 0.1.1.9000 (Development)

**Release Date**: In Development

#### Breaking Changes
- Fix #355: Ensure all `hai_data_*` functions return recipe object with consistent name `new_rec_obj`

#### New Features
None

#### Minor Fixes and Improvements
None

---

### healthyR.ai 0.1.1

**Release Date**: 2023

#### Breaking Changes
None

#### New Features
None

#### Minor Fixes and Improvements
- Fix #349: Update `hai_c50_data_prepper()` based on feedback from @EmilHvitfeldt

---

### healthyR.ai 0.1.0

**Release Date**: 2023

#### Breaking Changes
None

#### New Features
- Fix #340: Add mesh generator function `generate_mesh_data()`

#### Minor Fixes and Improvements
- Fix #337: Fix typo in `hai_earth_data_prepper()` that prevented full processing

---

### healthyR.ai 0.0.13

**Release Date**: 2023

#### Breaking Changes
- Fix #326: Require R >= 3.3

#### New Features
None

#### Minor Fixes and Improvements
None

---

### healthyR.ai 0.0.12

**Release Date**: 2023

#### Breaking Changes
None

#### New Features
None

#### Minor Fixes and Improvements
- Fix #319: Fix `.name_repair` error in `hai_umap_list()` function (@VladPerervenko)

---

### healthyR.ai 0.0.11

**Release Date**: 2023

#### Breaking Changes
None

#### New Features
None

#### Minor Fixes and Improvements
- Fix #312: Fix typo in `hai_kmeans_automl()` that caused function failure

---

### healthyR.ai 0.0.10

**Release Date**: 2023

#### Breaking Changes
None

#### New Features
- Fix #303: Export data processing functions as public functions (no longer need `healthyR.ai:::`)

#### Minor Fixes and Improvements
- Fix #306: Fix failing custom recipe steps due to type checks

---

### healthyR.ai 0.0.9

**Release Date**: 2023

#### Breaking Changes
None

#### New Features
- Fix #286: Add `hai_umap_list()` and alias `umap_list()`
- Fix #287: Add `hai_umap_plot()` and alias `umap_plt()`

#### Minor Fixes and Improvements
- Fix #289: Add `uwot` package to DESCRIPTION
- Fix #288: Alias all kmeans hai functions to mirror healthyR for API compatibility
- Fix #290: Add kmeans-umap vignette

---

### healthyR.ai 0.0.8

**Release Date**: 2023

#### Breaking Changes
None

#### New Features
- Fix #219: Add color-blind friendly functions:
  - `color_blind()`
  - `hai_scale_color_colorblind()`
  - `hai_scale_fill_colorblind()`
- Fix #227: Add `hai_auto_wflw_metrics()`
- Fix #243: Add C5.0 functions:
  - `hai_c50_data_prepper()`
  - `hai_auto_c50()`
- Fix #246: Add GLMnet functions:
  - `hai_glmnet_data_prepper()`
  - `hai_auto_glmnet()`
- Fix #249: Add Cubist functions:
  - `hai_cubist_data_prepper()`
  - `hai_auto_cubist()`
- Fix #256: Add Earth functions:
  - `hai_earth_data_prepper()`
  - `hai_auto_earth()`
- Fix #259: Add SVM Polynomial functions:
  - `hai_svm_poly_data_prepper()`
  - `hai_auto_svm_poly()`
- Fix #265: Add SVM RBF functions:
  - `hai_svm_rbf_data_prepper()`
  - `hai_auto_svm_rbf()`
- Fix #269: Add Ranger functions:
  - `hai_ranger_data_prepper()`
  - `hai_auto_ranger()`
- Fix #274: Add XGBoost functions:
  - `hai_xgboost_data_prepper()`
  - `hai_auto_xgboost()`

#### Minor Fixes and Improvements
- Fix #240: Add parameter arguments as attributes to list output for boilerplate functions
- Fix #273: Update `step_hyperbolic()` to reflect fix in tidymodels/recipes#932 (Thanks @juliasilge)

---

### healthyR.ai 0.0.7

**Release Date**: 2022

#### Breaking Changes
None

#### New Features
- Fix #209: Add `hai_skewed_features()`
- Fix #210: Export internal functions
- Fix #206: Add z-score functions:
  - `hai_scale_zscore_vec()`
  - `hai_scale_zscore_augment()`
  - `step_hai_scale_zscore()`
- Fix #207: Add `hai_knn_data_prepper()`
- Fix #220: Add `hai_default_regression_metric_set()`
- Fix #222: Add `hai_default_classification_metric_set()`
- Fix #205 and #223: Add `hai_auto_knn()`

#### Minor Fixes and Improvements
- Fix #208: Enhance `hai_histogram_facet_plot()`:
  - Returns list with plot and data
  - Add `.scale_data` parameter using `hai_scale_zero_one_vec()`
- Fix #221: Add yardstick (>= 0.0.8) to DESCRIPTION

---

### healthyR.ai 0.0.6

**Release Date**: 2022

#### Breaking Changes
None

#### New Features
- Fix #132: Add statistical functions:
  - `hai_kurtosis_vec()`
  - `hai_skewness_vec()`
- Fix #133: Add `hai_distribution_comparison_tbl()`
- Fix #138: Add `hai_get_dist_data_tbl()`
- Fix #140: Add `hai_get_density_data_tbl()`
- Fix #146: Add `hai_density_plot()`
- Fix #141: Add `hai_density_qq_plot()`
- Fix #139: Add `hai_density_hist_plot()`
- Fix #56: Add `hai_histogram_facet_plot()`
- Fix #178: Add loadings plots to `pca_your_recipe()` output with `.top_n` parameter

#### Minor Fixes and Improvements
- Fix #180: Move `cli` and `crayon` to Imports from Suggest
- Fix #182: Drop need for `cli`, `crayon`, and `rstudioapi`
- Fix #187: Update step print methods per tidymodels team recommendations

---

### healthyR.ai 0.0.5

**Release Date**: 2022

#### Breaking Changes
None

#### New Features
- Fix #118: Add zero-one scaling functions:
  - `hai_scale_zero_one_vec()`
  - `hai_scale_zero_one_augment()`
  - `step_hai_scale_zero_one()`
- Fix #119: Add `hai_range_statistic()`

#### Minor Fixes and Improvements
None

---

### healthyR.ai 0.0.4

**Release Date**: 2022

#### Breaking Changes
None

#### New Features
- Fix #108: Add winsorized move functions:
  - `hai_winsorized_move_vec()`
  - `hai_winsorized_move_augment()`
  - `step_hai_winsorized_move()`
- Fix #107: Add winsorized truncate functions:
  - `hai_winsorized_truncate_vec()`
  - `hai_winsorized_truncate_augment()`
  - `step_hai_winsorized_truncate()`

#### Minor Fixes and Improvements
None

---

### healthyR.ai 0.0.3

**Release Date**: 2022

#### Breaking Changes
None

#### New Features
- Fix #61: Add internal function `hai_data_scale()`
- Fix #63: Add internal function `hai_data_impute()`
- Fix #58: Add `hai_data_trig()` and `step_hai_hyperbolic()`
- Fix #68: Add `hai_hyperbolic_vec()`
- Fix #70: Add `hai_hyperbolic_augment()`
- Fix #75: Add Fourier functions:
  - `hai_fourier_vec()`
  - `hai_fourier_augment()`
  - `step_hai_fourier()`
- Fix #89: Add discrete Fourier functions:
  - `hai_fourier_discrete_vec()`
  - `hai_fourier_discrete_augment()`
  - `step_hai_fourier_discrete()`
- Fix #57: Add `hai_polynomial_augment()`
- Fix #60: Add internal function `hai_data_transform()`
- Fix #93: Add internal function `hai_data_poly()`

#### Minor Fixes and Improvements
- Fix #81: Add process to register S3 methods for `tune` objects

---

### healthyR.ai 0.0.2

**Release Date**: 2021

#### Breaking Changes
None

#### New Features
- Fix #22: Add K-means functions:
  - `hai_kmeans_mapped_tbl()`
  - `hai_kmeans_obj()`
  - `hai_kmeans_scree_data_tbl()`
  - `hai_kmeans_scree_plt()`
  - `hai_kmeans_tidy_tbl()`
  - `hai_kmeans_user_item_tbl()`
- Fix #29: Add `pca_your_recipe()`
- Fix #32: Add `hai_kmeans_automl()`
- Fix #49: Add `hai_kmeans_automl_predict()`

#### Minor Fixes and Improvements
None

---

### healthyR.ai 0.0.1

**Release Date**: 2021

#### Breaking Changes
None

#### New Features
- Fix #9: Add `hai_control_chart()`

#### Minor Fixes and Improvements
None

---

### healthyR.ai 0.0.0.9000

**Release Date**: 2021

**Initial Development Release**

- Added NEWS.md file to track changes
- Basic package structure
- Initial functions and documentation

---

## 📊 Version Statistics

### Total Releases
- **CRAN Releases**: 14
- **Development Versions**: Ongoing

### Functions Added by Version
- **0.0.0.9000**: Package initialization
- **0.0.1**: 1 function
- **0.0.2**: 6 functions
- **0.0.3**: 13 functions
- **0.0.4**: 6 functions
- **0.0.5**: 4 functions
- **0.0.6**: 14 functions
- **0.0.7**: 10 functions
- **0.0.8**: 18 functions (Major expansion of AutoML)
- **0.0.9**: 4 functions
- **0.0.10-0.1.1**: Bug fixes and refinements

**Total Functions**: 70+ exported functions

---

## 🔮 Future Roadmap

### Planned Features
- Additional AutoML algorithms
- More statistical transformations
- Enhanced visualization options
- Time series specific functions
- Deep learning integration
- Model explainability tools

### Under Consideration
- Automated feature engineering
- Model deployment helpers
- Real-time monitoring tools
- Additional healthcare-specific functions

---

## 📦 Upgrading

### From 0.0.x to 0.1.x

Generally backwards compatible. Key change:
- Recipe object names standardized to `new_rec_obj` in `hai_data_*` functions

```r
# Update code if you were using specific names
result <- hai_data_scale(...)
# Old: result$recipe_object
# New: result$new_rec_obj
```

### Checking Your Version

```r
# Check installed version
packageVersion("healthyR.ai")

# Check for updates
old.packages()

# Update
install.packages("healthyR.ai")
```

---

## 📚 Additional Resources

- **CRAN**: https://CRAN.R-project.org/package=healthyR.ai
- **GitHub Releases**: https://github.com/spsanderson/healthyR.ai/releases
- **NEWS.md**: Full changelog in package
- **GitHub Issues**: https://github.com/spsanderson/healthyR.ai/issues

---

## 🙏 Contributors

Thank you to all contributors across versions:
- Steven P. Sanderson II, MPH (Author, Maintainer)
- @EmilHvitfeldt
- @VladPerervenko
- @juliasilge (tidymodels team)
- And all community contributors!

---

*Last Updated: 2024-11-04*
