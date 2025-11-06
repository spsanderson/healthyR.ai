# Automatic K-Means H2O

This is a wrapper around the
[`h2o::h2o.kmeans()`](https://rdrr.io/pkg/h2o/man/h2o.kmeans.html)
function that will return a list object with a lot of useful and easy to
use tidy style information.

## Usage

``` r
hai_kmeans_automl(
  .data,
  .split_ratio = 0.8,
  .seed = 1234,
  .centers = 10,
  .standardize = TRUE,
  .print_model_summary = TRUE,
  .predictors,
  .categorical_encoding = "auto",
  .initialization_mode = "Furthest",
  .max_iterations = 100
)
```

## Arguments

- .data:

  The data that is to be passed for clustering.

- .split_ratio:

  The ratio for training and testing splits.

- .seed:

  The default is 1234, but can be set to any integer.

- .centers:

  The default is 1. Specify the number of clusters (groups of data) in a
  data set.

- .standardize:

  The default is set to TRUE. When TRUE all numeric columns will be set
  to zero mean and unit variance.

- .print_model_summary:

  This is a boolean and controls if the model summary is printed to the
  console. The default is TRUE.

- .predictors:

  This must be in the form of c("column_1", "column_2", ... "column_n")

- .categorical_encoding:

  Can be one of the following:

  - "auto"

  - "enum"

  - "one_hot_explicit"

  - "binary"

  - "eigen"

  - "label_encoder"

  - "sort_by_response"

  - "enum_limited"

- .initialization_mode:

  This can be one of the following:

  - "Random"

  - "Furthest (default)

  - "PlusPlus"

- .max_iterations:

  The default is 100. This specifies the number of training iterations

## Value

A list object

## See also

Other Kmeans:
[`hai_kmeans_automl_predict()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl_predict.md),
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
h2o.shutdown()
} # }
```
