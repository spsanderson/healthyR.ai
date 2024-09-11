# healthyR.ai 0.1.0

## Breaking Changes
None

## New Features
1. Fix #340 - Add mesh generator function.

## Minor Fixes and Improvements
1. Fix #337 - Fix typo in `hai_earth_data_prepper()` that caused it to not fully
process.

# healthyR.ai 0.0.13

## Breaking Changes
1. Fix #326 - Require R >= 3.3

## New Features
None

## Minor Fixes and Improvements
None

# healthyR.ai 0.0.12

## Breaking Changes
None

## New Features
None

## Minor Fixes and Improvements
1. Fix #319 - Fix the `.name_repair` error stemming from the `hai_umap_list()` 
`hai_umap_list()` / `umap_list()` function. (@VladPerervenko)

# healthyR.ai 0.0.11

## Breaking Changes
None

## New Features
None

## Minor Fixes and Improvements
1. Fix #312 - Fix a typo in `hai_kmeans_automl()` that caused the function to fail 
before any modeling even occurred.

# healthyR.ai 0.0.10

## Breaking Changes
None

## New Features
1. Fix #303 - Export data processing functions to be exposed as function insted of internally only. This means you no longer need to use `healthyR.ai:::` to access the functions.

## Minor Fixes and Improvements
1, Fix #306 - Fix failing custom recipe steps due to type checks

# healthyR.ai 0.0.9

## Breaking Changes
None

## New Features
1. Fix #286 - Add function `hai_umap_list()` and alias `umap_list()` this helps
users who transition from the `healthyR` functionality of the same name, while
also creating distinct functionality related to `healthyR.ai`
2. Fix #287 - Add function `hai_umap_plot()` and alias `umap_plt()` this helps the 
same as Fix #286.

## Minor Fixes and Improvments
1. Fix #289 - Add the `uwot` package to the `DESCRIPTION` file in order to make
`umap_` functions.
2. Fix #288 - Alias all kmeans hai functions to mirror healthyR for api compatability.
3. Fix #290 - Add kmeans-umap vignette.

# healthyR.ai 0.0.8

## Breaking Changes
None

## New Features
1. Fix #219 - Add functions `color_blind()` `hai_scale_color_colorblind()` and
`hai_scale_fill_colorblind()`
2. Fix #227 - Add function `hai_auto_wflw_metrics()`
3. Fix #243 - Add boilerplate functions for C5.0 `hai_c50_data_prepper()` and
`hai_auto_c50()`
4. Fix #246 - Add boilerplate functions for glmnet `hai_glmnet_data_prepper()` and
`hai_auto_glmnet()`
5. Fix #249 - Add boilerplate functions for cubist `hai_cubist_data_prepper()` and
`hai_auto_cubist()`
6. Fix #256 - Add boilerplate functions for Earth `hai_earth_data_prepper()` and
`hai_auto_earth()`
7. Fix #259 - Add boilerplate functions for Kernlab `hai_svm_poly_data_prepper()` and
`hai_auto_svm_poly()`
8. Fix #265 - Add boilerplate functions for Kernlab `hai_svm_rbf_data_prepper()` and
`hai_auto_svm_rbf()`
9. Fix #269 - Add boilerplate functions for ranger `hai_ranger_data_prepper()` and
`hai_auto_ranger()`
10. Fix #274 - Add boilerplate functions for xgboost `hai_xgboost_data_prepper()` and
`hai_auto_xgboost()`

## Minor Fixes and Improvements
1. Fix #240 - Add parameter arguments as attributes to list output for boilerplate
functions.
2. Fix #273 - We fixed a bug 🐛 in step_hyperbolic() in tidymodels/recipes#932 and this PR updates healthyR.ai to reflect that fix. Thank you @juliasilge

# healthyR.ai 0.0.7

## Breaking Changes
None

## New Features
1. Fix #209 - Add function `hai_skewed_features()`
2. Fix #210 - Export current internal functions.
3. Fix #206 - Add functions `hai_scale_zscore_vec()` and `hai_scale_zscore_augment()` 
and add `step_hai_scale_zscore()`
4. Fix #207 - Add function `hai_knn_data_prepper()`
5. Fix #220 - Add function `hai_default_regression_metric_set()`
6. Fix #222 - Add function `hai_default_classification_metric_set()`
7. Fix #205 and #223 - Add function `hai_auto_knn()`

## Minor Fixes and Improvements
1. Fix #208 - Enhance `hai_histogram_facet_plot()` It now returns a list output
invisible while printing the plot out. The list includes the original data and
the factored data along with the plot. There has been a parameter addition of 
`.scale_data` which is set to FALSE and uses `hai_scale_zero_one_vec()` to do 
the work.
2. Fix #221 - Add yardstick (>= 0.0.8) to DESCRIPTION file.

## Breaking Changes
None

# healthyR.ai 0.0.6

## New Features
1. Fix #132 - Add functions:
-  `hai_kurtosis_vec()`
-  `hai_skewness_vec()`
2. Fix #133 - Add function `hai_distribution_comparison_tbl()`
3. Fix #138 - Add function `hai_get_dist_data_tbl()`
4. Fix #140 - Add function `hai_get_density_data_tbl()`
5. Fix #146 - Add function `hai_density_plot()`
6. Fix #141 - Add function `hai_density_qq_plot()`
7. Fix #139 - Add function `hai_density_hist_plot()`
8. Fix #56 - Add function `hai_histogram_facet_plot()`
9. Fix #178 - Add loadings plots to `pca_your_recipe()` output. Added a parameter
of `.top_n` to get how many vairable loadings you want returned.

## Minor Fixes and Improvements
1. Fix #180 - Move `cli` and `crayon` to Imports from Suggest due to `pillar` 
not importing anymore.
2. Fix #182 - Drop need for `cli`, `crayon`, and `rstudioapi`
3. Fix #187 - Update step print methods as described by the tidymodels team.

## Breaking Changes
None

# healthyR.ai 0.0.5

## New Features
1. Fix #118 - Add functions:
-  `hai_scale_zero_one_vec()`
-  `hai_scale_zero_one_augment()`
-  `step_hai_scale_zero_one()`
2. Fix #119 - Add function: `hai_range_statistic()`

## Minor Fixes and Improvements
None

# healthyR.ai 0.0.4

## Breaking Changes
None

## New Features
1. Fix #108 - Add functions:
-  `hai_winsorized_move_vec()`
-  `hai_winsorized_move_augment()`
-  `step_hai_winsorized_move()`
2. Fix #107 - Add functions:
-  `hai_winsorized_truncate_vec()`
-  `hai_winsorized_truncate_augment()`
-  `step_hai_winsorized_truncate()`

## Minor Fixes and Improvements
None

# healthyR.ai 0.0.3

## Breaking Changes
None

## New Features
1. Fix #61 - Add internal function `hai_data_scale()`
2. Fix #63 - Add internal function `hai_data_impute()`
3. Fix #58 - Add internal function `hai_data_trig()`, Exported Func `step_hai_hyperbolic()`
4. Fix #68 - Add `hai_hyperbolic_vec()` function.
5. Fix #70 - Add `hai_hyperbolic_augment()` function.
6. Fix #75 - Add `hai_fourier_vec()`,`hai_fourier_augment()`,`step_hai_fourier()` functions.
7. Fix #89 - Add `hai_fourier_discrete_vec()`, `hai_fourier_discrete_augment()`, `step_hai_fourier_discrete()`
8. Fix #57 - Add `hai_polynomial_augment()`
9. Fix #60 - Add internal function `hai_data_transform()`
10. Fix #93 - Add internal function `hai_data_poly()`

## Minor Fixes and Improvments
1. Fix #81 - Add process to register s3 methods to work with `tune` objects.

# healthyR.ai 0.0.2

## Breaking Changes
None

## New Features
1. Fix #22 - Add functions:
  +  `hai_kmeans_mapped_tbl()`
  +  `hai_kmeans_obj()`
  +  `hai_kmeans_scree_data_tbl()`
  +  `hai_kmeans_scree_plt()`
  +  `hai_kmeans_tidy_tbl()`
  +  `hai_kmeans_user_item_tbl()`
2. Fix #29 - Add function `pca_your_recipe()`
3. Fix #32 - Add function `hai_kmeans_automl()`
4. Fix #49 - Add function `hai_kmeans_automl_predict()`

## Minor Fixes and Improvements
None

# healthyR.ai 0.0.1

## Breaking Changes
None

## New Features
1. Fix #9 - Add function `hai_control_chart`

## Minor Fixes and Improvments
None

# healthyR.ai 0.0.0.9000

* Added a `NEWS.md` file to track changes to the package.
