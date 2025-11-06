# Automatic K-Means H2O

This is a wrapper around the
[`h2o::h2o.predict()`](https://rdrr.io/pkg/h2o/man/h2o.predict.html)
function that will return a list object with a lot of useful and easy to
use tidy style information.

## Usage

``` r
hai_kmeans_automl_predict(.input)
```

## Arguments

- .input:

  This is the output of the
  [`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md)
  function.

## Value

A list object

## Details

This function will internally take in the output assigned from the
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md)
function only and return a list of useful information. The items that
are returned are as follows:

1.  prediction - The h2o dataframe of predictions

2.  prediction_tbl - The h2o predictions in tibble format

3.  valid_tbl - The validation data in tibble format

4.  pred_full_tbl - The entire validation set with the predictions
    attached using [`base::cbind()`](https://rdrr.io/r/base/cbind.html).
    The predictions are in a column called `predicted_cluster` and are
    in the formate of a factor using
    [`forcats::as_factor()`](https://forcats.tidyverse.org/reference/as_factor.html)

## See also

Other Kmeans:
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md),
[`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md),
[`hai_kmeans_obj()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_obj.md),
[`hai_kmeans_scree_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_data_tbl.md),
[`hai_kmeans_scree_plt()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_plt.md),
[`hai_kmeans_tidy_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_tidy_tbl.md),
[`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
if (FALSE) { # \dontrun{
h2o.init()

output <- hai_kmeans_automl(
  .data = iris,
  .predictors = c("Sepal.Width", "Sepal.Length", "Petal.Width", "Petal.Length"),
  .standardize = FALSE
)

pred <- hai_kmeans_automl_predict(output)

h2o.shutdown()
} # }
```
