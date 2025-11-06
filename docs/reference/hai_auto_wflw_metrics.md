# Collect Metrics from Boilerplat Workflows

This function will extract the metrics from the `hai_auto_` boilerplate
functions.

## Usage

``` r
hai_auto_wflw_metrics(.data)
```

## Arguments

- .data:

  The output of the `hai_auto_` boilerplate function in it's entirety.

## Value

A tibble

## Details

This function will extract the metrics from the `hai_auto_` boilerplate
functions. This function looks for a specific attribute from the
`hai_auto_` functions so that it will extract the `tuned_results` from
the tuning process if it has indeed been tuned.

## See also

Other Boiler_Plate:
[`hai_auto_c50()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_c50.md),
[`hai_auto_cubist()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_cubist.md),
[`hai_auto_earth()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_earth.md),
[`hai_auto_glmnet()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_glmnet.md),
[`hai_auto_knn()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_knn.md),
[`hai_auto_ranger()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_ranger.md),
[`hai_auto_svm_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_svm_poly.md),
[`hai_auto_svm_rbf()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_svm_rbf.md),
[`hai_auto_xgboost()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_xgboost.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
if (FALSE) { # \dontrun{
data <- iris

rec_obj <- hai_knn_data_prepper(data, Species ~ .)

auto_knn <- hai_auto_knn(
  .data = data,
  .rec_obj = rec_obj,
  .best_metric = "f_meas",
  .model_type = "classification",
  .grid_size = 2,
  .num_cores = 4
)

hai_auto_wflw_metrics(auto_knn)
} # }
```
