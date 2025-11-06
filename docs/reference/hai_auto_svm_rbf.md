# Boilerplate Workflow

This is a boilerplate function to create automatically the following:

- recipe

- model specification

- workflow

- tuned model (grid ect)

## Usage

``` r
hai_auto_svm_rbf(
  .data,
  .rec_obj,
  .splits_obj = NULL,
  .rsamp_obj = NULL,
  .tune = TRUE,
  .grid_size = 10,
  .num_cores = 1,
  .best_metric = "f_meas",
  .model_type = "classification"
)
```

## Arguments

- .data:

  The data being passed to the function. The time-series object.

- .rec_obj:

  This is the recipe object you want to use. You can use
  [`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md)
  an automatic recipe_object.

- .splits_obj:

  NULL is the default, when NULL then one will be created.

- .rsamp_obj:

  NULL is the default, when NULL then one will be created. It will
  default to creating an
  [`rsample::mc_cv()`](https://rsample.tidymodels.org/reference/mc_cv.html)
  object.

- .tune:

  Default is TRUE, this will create a tuning grid and tuned workflow

- .grid_size:

  Default is 10

- .num_cores:

  Default is 1

- .best_metric:

  Default is "f_meas". You can choose a metric depending on the
  model_type used. If `regression` then see
  [`hai_default_regression_metric_set()`](https://www.spsanderson.com/healthyR.ai/reference/hai_default_regression_metric_set.md),
  if `classification` then see
  [`hai_default_classification_metric_set()`](https://www.spsanderson.com/healthyR.ai/reference/hai_default_classification_metric_set.md).

- .model_type:

  Default is `classification`, can also be `regression`.

## Value

A list

## Details

This uses the
[`parsnip::svm_rbf()`](https://parsnip.tidymodels.org/reference/svm_rbf.html)
with the `engine` set to `kernlab`

## See also

<https://parsnip.tidymodels.org/reference/svm_rbf.html>

Other Boiler_Plate:
[`hai_auto_c50()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_c50.md),
[`hai_auto_cubist()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_cubist.md),
[`hai_auto_earth()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_earth.md),
[`hai_auto_glmnet()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_glmnet.md),
[`hai_auto_knn()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_knn.md),
[`hai_auto_ranger()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_ranger.md),
[`hai_auto_svm_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_svm_poly.md),
[`hai_auto_wflw_metrics()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_wflw_metrics.md),
[`hai_auto_xgboost()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_xgboost.md)

Other SVM_RBF:
[`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
if (FALSE) { # \dontrun{
data <- iris

rec_obj <- hai_svm_rbf_data_prepper(data, Species ~ .)

auto_rbf <- hai_auto_svm_rbf(
  .data = data,
  .rec_obj = rec_obj,
  .best_metric = "f_meas"
)

auto_rbf$recipe_info
} # }
```
