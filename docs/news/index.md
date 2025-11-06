# Changelog

## healthyR.ai (development version)

### Breaking Changes

1.  Fix [\#355](https://github.com/spsanderson/healthyR.ai/issues/355) -
    Ensure that all `hai_data_*` functions that return a new recipe
    object all have the same name. The new name for the updated recipe
    object is: `new_rec_obj`.

### New Features

None

### Minor Fixes and Improvements

None

## healthyR.ai 0.1.1

CRAN release: 2025-04-24

### Breaking Changes

None

### New Features

None

### Minor Fixes and Improvements

- Fix [\#349](https://github.com/spsanderson/healthyR.ai/issues/349) -
  Update
  [`hai_c50_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_c50_data_prepper.md)
  from [@EmilHvitfeldt](https://github.com/EmilHvitfeldt)

## healthyR.ai 0.1.0

CRAN release: 2024-09-11

### Breaking Changes

None

### New Features

1.  Fix [\#340](https://github.com/spsanderson/healthyR.ai/issues/340) -
    Add mesh generator function.

### Minor Fixes and Improvements

1.  Fix [\#337](https://github.com/spsanderson/healthyR.ai/issues/337) -
    Fix typo in
    [`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md)
    that caused it to not fully process.

## healthyR.ai 0.0.13

CRAN release: 2023-04-02

### Breaking Changes

1.  Fix [\#326](https://github.com/spsanderson/healthyR.ai/issues/326) -
    Require R \>= 3.3

### New Features

None

### Minor Fixes and Improvements

None

## healthyR.ai 0.0.12

CRAN release: 2023-02-01

### Breaking Changes

None

### New Features

None

### Minor Fixes and Improvements

1.  Fix [\#319](https://github.com/spsanderson/healthyR.ai/issues/319) -
    Fix the `.name_repair` error stemming from the
    [`hai_umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)
    [`hai_umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)
    /
    [`umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)
    function. ([@VladPerervenko](https://github.com/VladPerervenko))

## healthyR.ai 0.0.11

CRAN release: 2023-01-12

### Breaking Changes

None

### New Features

None

### Minor Fixes and Improvements

1.  Fix [\#312](https://github.com/spsanderson/healthyR.ai/issues/312) -
    Fix a typo in
    [`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md)
    that caused the function to fail before any modeling even occurred.

## healthyR.ai 0.0.10

CRAN release: 2022-11-16

### Breaking Changes

None

### New Features

1.  Fix [\#303](https://github.com/spsanderson/healthyR.ai/issues/303) -
    Export data processing functions to be exposed as function insted of
    internally only. This means you no longer need to use
    `healthyR.ai:::` to access the functions.

### Minor Fixes and Improvements

1, Fix [\#306](https://github.com/spsanderson/healthyR.ai/issues/306) -
Fix failing custom recipe steps due to type checks

## healthyR.ai 0.0.9

CRAN release: 2022-10-04

### Breaking Changes

None

### New Features

1.  Fix [\#286](https://github.com/spsanderson/healthyR.ai/issues/286) -
    Add function
    [`hai_umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)
    and alias
    [`umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)
    this helps users who transition from the `healthyR` functionality of
    the same name, while also creating distinct functionality related to
    `healthyR.ai`
2.  Fix [\#287](https://github.com/spsanderson/healthyR.ai/issues/287) -
    Add function
    [`hai_umap_plot()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_plot.md)
    and alias
    [`umap_plt()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_plot.md)
    this helps the same as Fix
    [\#286](https://github.com/spsanderson/healthyR.ai/issues/286).

### Minor Fixes and Improvments

1.  Fix [\#289](https://github.com/spsanderson/healthyR.ai/issues/289) -
    Add the `uwot` package to the `DESCRIPTION` file in order to make
    `umap_` functions.
2.  Fix [\#288](https://github.com/spsanderson/healthyR.ai/issues/288) -
    Alias all kmeans hai functions to mirror healthyR for api
    compatability.
3.  Fix [\#290](https://github.com/spsanderson/healthyR.ai/issues/290) -
    Add kmeans-umap vignette.

## healthyR.ai 0.0.8

CRAN release: 2022-07-04

### Breaking Changes

None

### New Features

1.  Fix [\#219](https://github.com/spsanderson/healthyR.ai/issues/219) -
    Add functions
    [`color_blind()`](https://www.spsanderson.com/healthyR.ai/reference/color_blind.md)
    [`hai_scale_color_colorblind()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_color_colorblind.md)
    and
    [`hai_scale_fill_colorblind()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_fill_colorblind.md)
2.  Fix [\#227](https://github.com/spsanderson/healthyR.ai/issues/227) -
    Add function
    [`hai_auto_wflw_metrics()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_wflw_metrics.md)
3.  Fix [\#243](https://github.com/spsanderson/healthyR.ai/issues/243) -
    Add boilerplate functions for C5.0
    [`hai_c50_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_c50_data_prepper.md)
    and
    [`hai_auto_c50()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_c50.md)
4.  Fix [\#246](https://github.com/spsanderson/healthyR.ai/issues/246) -
    Add boilerplate functions for glmnet
    [`hai_glmnet_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_glmnet_data_prepper.md)
    and
    [`hai_auto_glmnet()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_glmnet.md)
5.  Fix [\#249](https://github.com/spsanderson/healthyR.ai/issues/249) -
    Add boilerplate functions for cubist
    [`hai_cubist_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_cubist_data_prepper.md)
    and
    [`hai_auto_cubist()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_cubist.md)
6.  Fix [\#256](https://github.com/spsanderson/healthyR.ai/issues/256) -
    Add boilerplate functions for Earth
    [`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md)
    and
    [`hai_auto_earth()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_earth.md)
7.  Fix [\#259](https://github.com/spsanderson/healthyR.ai/issues/259) -
    Add boilerplate functions for Kernlab
    [`hai_svm_poly_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_poly_data_prepper.md)
    and
    [`hai_auto_svm_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_svm_poly.md)
8.  Fix [\#265](https://github.com/spsanderson/healthyR.ai/issues/265) -
    Add boilerplate functions for Kernlab
    [`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md)
    and
    [`hai_auto_svm_rbf()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_svm_rbf.md)
9.  Fix [\#269](https://github.com/spsanderson/healthyR.ai/issues/269) -
    Add boilerplate functions for ranger
    [`hai_ranger_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_ranger_data_prepper.md)
    and
    [`hai_auto_ranger()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_ranger.md)
10. Fix [\#274](https://github.com/spsanderson/healthyR.ai/issues/274) -
    Add boilerplate functions for xgboost
    [`hai_xgboost_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_xgboost_data_prepper.md)
    and
    [`hai_auto_xgboost()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_xgboost.md)

### Minor Fixes and Improvements

1.  Fix [\#240](https://github.com/spsanderson/healthyR.ai/issues/240) -
    Add parameter arguments as attributes to list output for boilerplate
    functions.
2.  Fix [\#273](https://github.com/spsanderson/healthyR.ai/issues/273) -
    We fixed a bug 🐛 in step_hyperbolic() in tidymodels/recipes#932 and
    this PR updates healthyR.ai to reflect that fix. Thank you
    [@juliasilge](https://github.com/juliasilge)

## healthyR.ai 0.0.7

CRAN release: 2022-04-29

### Breaking Changes

None

### New Features

1.  Fix [\#209](https://github.com/spsanderson/healthyR.ai/issues/209) -
    Add function
    [`hai_skewed_features()`](https://www.spsanderson.com/healthyR.ai/reference/hai_skewed_features.md)
2.  Fix [\#210](https://github.com/spsanderson/healthyR.ai/issues/210) -
    Export current internal functions.
3.  Fix [\#206](https://github.com/spsanderson/healthyR.ai/issues/206) -
    Add functions
    [`hai_scale_zscore_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_vec.md)
    and
    [`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md)
    and add
    [`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md)
4.  Fix [\#207](https://github.com/spsanderson/healthyR.ai/issues/207) -
    Add function
    [`hai_knn_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_knn_data_prepper.md)
5.  Fix [\#220](https://github.com/spsanderson/healthyR.ai/issues/220) -
    Add function
    [`hai_default_regression_metric_set()`](https://www.spsanderson.com/healthyR.ai/reference/hai_default_regression_metric_set.md)
6.  Fix [\#222](https://github.com/spsanderson/healthyR.ai/issues/222) -
    Add function
    [`hai_default_classification_metric_set()`](https://www.spsanderson.com/healthyR.ai/reference/hai_default_classification_metric_set.md)
7.  Fix [\#205](https://github.com/spsanderson/healthyR.ai/issues/205)
    and [\#223](https://github.com/spsanderson/healthyR.ai/issues/223) -
    Add function
    [`hai_auto_knn()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_knn.md)

### Minor Fixes and Improvements

1.  Fix [\#208](https://github.com/spsanderson/healthyR.ai/issues/208) -
    Enhance
    [`hai_histogram_facet_plot()`](https://www.spsanderson.com/healthyR.ai/reference/hai_histogram_facet_plot.md)
    It now returns a list output invisible while printing the plot out.
    The list includes the original data and the factored data along with
    the plot. There has been a parameter addition of `.scale_data` which
    is set to FALSE and uses
    [`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md)
    to do the work.
2.  Fix [\#221](https://github.com/spsanderson/healthyR.ai/issues/221) -
    Add yardstick (\>= 0.0.8) to DESCRIPTION file.

### Breaking Changes

None

## healthyR.ai 0.0.6

CRAN release: 2022-02-27

### New Features

1.  Fix [\#132](https://github.com/spsanderson/healthyR.ai/issues/132) -
    Add functions:

- [`hai_kurtosis_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kurtosis_vec.md)
- [`hai_skewness_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_skewness_vec.md)

2.  Fix [\#133](https://github.com/spsanderson/healthyR.ai/issues/133) -
    Add function
    [`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md)
3.  Fix [\#138](https://github.com/spsanderson/healthyR.ai/issues/138) -
    Add function
    [`hai_get_dist_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_get_dist_data_tbl.md)
4.  Fix [\#140](https://github.com/spsanderson/healthyR.ai/issues/140) -
    Add function
    [`hai_get_density_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_get_density_data_tbl.md)
5.  Fix [\#146](https://github.com/spsanderson/healthyR.ai/issues/146) -
    Add function
    [`hai_density_plot()`](https://www.spsanderson.com/healthyR.ai/reference/hai_density_plot.md)
6.  Fix [\#141](https://github.com/spsanderson/healthyR.ai/issues/141) -
    Add function
    [`hai_density_qq_plot()`](https://www.spsanderson.com/healthyR.ai/reference/hai_density_qq_plot.md)
7.  Fix [\#139](https://github.com/spsanderson/healthyR.ai/issues/139) -
    Add function
    [`hai_density_hist_plot()`](https://www.spsanderson.com/healthyR.ai/reference/hai_density_hist_plot.md)
8.  Fix [\#56](https://github.com/spsanderson/healthyR.ai/issues/56) -
    Add function
    [`hai_histogram_facet_plot()`](https://www.spsanderson.com/healthyR.ai/reference/hai_histogram_facet_plot.md)
9.  Fix [\#178](https://github.com/spsanderson/healthyR.ai/issues/178) -
    Add loadings plots to
    [`pca_your_recipe()`](https://www.spsanderson.com/healthyR.ai/reference/pca_your_recipe.md)
    output. Added a parameter of `.top_n` to get how many vairable
    loadings you want returned.

### Minor Fixes and Improvements

1.  Fix [\#180](https://github.com/spsanderson/healthyR.ai/issues/180) -
    Move `cli` and `crayon` to Imports from Suggest due to `pillar` not
    importing anymore.
2.  Fix [\#182](https://github.com/spsanderson/healthyR.ai/issues/182) -
    Drop need for `cli`, `crayon`, and `rstudioapi`
3.  Fix [\#187](https://github.com/spsanderson/healthyR.ai/issues/187) -
    Update step print methods as described by the tidymodels team.

### Breaking Changes

None

## healthyR.ai 0.0.5

CRAN release: 2022-01-07

### New Features

1.  Fix [\#118](https://github.com/spsanderson/healthyR.ai/issues/118) -
    Add functions:

- [`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md)
- [`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md)
- [`step_hai_scale_zero_one()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zero_one.md)

2.  Fix [\#119](https://github.com/spsanderson/healthyR.ai/issues/119) -
    Add function:
    [`hai_range_statistic()`](https://www.spsanderson.com/healthyR.ai/reference/hai_range_statistic.md)

### Minor Fixes and Improvements

None

## healthyR.ai 0.0.4

CRAN release: 2021-12-08

### Breaking Changes

None

### New Features

1.  Fix [\#108](https://github.com/spsanderson/healthyR.ai/issues/108) -
    Add functions:

- [`hai_winsorized_move_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_vec.md)
- [`hai_winsorized_move_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_augment.md)
- [`step_hai_winsorized_move()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_winsorized_move.md)

2.  Fix [\#107](https://github.com/spsanderson/healthyR.ai/issues/107) -
    Add functions:

- [`hai_winsorized_truncate_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_vec.md)
- [`hai_winsorized_truncate_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_augment.md)
- [`step_hai_winsorized_truncate()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_winsorized_truncate.md)

### Minor Fixes and Improvements

None

## healthyR.ai 0.0.3

CRAN release: 2021-11-23

### Breaking Changes

None

### New Features

1.  Fix [\#61](https://github.com/spsanderson/healthyR.ai/issues/61) -
    Add internal function
    [`hai_data_scale()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_scale.md)
2.  Fix [\#63](https://github.com/spsanderson/healthyR.ai/issues/63) -
    Add internal function
    [`hai_data_impute()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_impute.md)
3.  Fix [\#58](https://github.com/spsanderson/healthyR.ai/issues/58) -
    Add internal function
    [`hai_data_trig()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_trig.md),
    Exported Func
    [`step_hai_hyperbolic()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_hyperbolic.md)
4.  Fix [\#68](https://github.com/spsanderson/healthyR.ai/issues/68) -
    Add
    [`hai_hyperbolic_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_vec.md)
    function.
5.  Fix [\#70](https://github.com/spsanderson/healthyR.ai/issues/70) -
    Add
    [`hai_hyperbolic_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_augment.md)
    function.
6.  Fix [\#75](https://github.com/spsanderson/healthyR.ai/issues/75) -
    Add
    [`hai_fourier_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_vec.md),[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),[`step_hai_fourier()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier.md)
    functions.
7.  Fix [\#89](https://github.com/spsanderson/healthyR.ai/issues/89) -
    Add
    [`hai_fourier_discrete_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_vec.md),
    [`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
    [`step_hai_fourier_discrete()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier_discrete.md)
8.  Fix [\#57](https://github.com/spsanderson/healthyR.ai/issues/57) -
    Add
    [`hai_polynomial_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_polynomial_augment.md)
9.  Fix [\#60](https://github.com/spsanderson/healthyR.ai/issues/60) -
    Add internal function
    [`hai_data_transform()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_transform.md)
10. Fix [\#93](https://github.com/spsanderson/healthyR.ai/issues/93) -
    Add internal function
    [`hai_data_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_poly.md)

### Minor Fixes and Improvments

1.  Fix [\#81](https://github.com/spsanderson/healthyR.ai/issues/81) -
    Add process to register s3 methods to work with `tune` objects.

## healthyR.ai 0.0.2

CRAN release: 2021-09-02

### Breaking Changes

None

### New Features

1.  Fix [\#22](https://github.com/spsanderson/healthyR.ai/issues/22) -
    Add functions:

- [`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md)
- [`hai_kmeans_obj()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_obj.md)
- [`hai_kmeans_scree_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_data_tbl.md)
- [`hai_kmeans_scree_plt()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_plt.md)
- [`hai_kmeans_tidy_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_tidy_tbl.md)
- [`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)

2.  Fix [\#29](https://github.com/spsanderson/healthyR.ai/issues/29) -
    Add function
    [`pca_your_recipe()`](https://www.spsanderson.com/healthyR.ai/reference/pca_your_recipe.md)
3.  Fix [\#32](https://github.com/spsanderson/healthyR.ai/issues/32) -
    Add function
    [`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md)
4.  Fix [\#49](https://github.com/spsanderson/healthyR.ai/issues/49) -
    Add function
    [`hai_kmeans_automl_predict()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl_predict.md)

### Minor Fixes and Improvements

None

## healthyR.ai 0.0.1

CRAN release: 2021-08-20

### Breaking Changes

None

### New Features

1.  Fix [\#9](https://github.com/spsanderson/healthyR.ai/issues/9) - Add
    function `hai_control_chart`

### Minor Fixes and Improvments

None

## healthyR.ai 0.0.0.9000

- Added a `NEWS.md` file to track changes to the package.
