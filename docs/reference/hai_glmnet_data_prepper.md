# Prep Data for glmnet - Recipe

Automatically prep a data.frame/tibble for use in the glmnet algorithm.

## Usage

``` r
hai_glmnet_data_prepper(.data, .recipe_formula)
```

## Arguments

- .data:

  The data that you are passing to the function. Can be any type of data
  that is accepted by the `data` parameter of the `recipes::reciep()`
  function.

- .recipe_formula:

  The formula that is going to be passed. For example if you are using
  the `iris` data then the formula would most likely be something like
  `Species ~ .`

## Value

A recipe object

## Details

This function will automatically prep your data.frame/tibble for use in
the glmnet algorithm. It expects data to be presented in a certain
fashion.

This function will output a recipe specification.

## See also

Other Preprocessor:
[`hai_c50_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_c50_data_prepper.md),
[`hai_cubist_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_cubist_data_prepper.md),
[`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md),
[`hai_knn_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_knn_data_prepper.md),
[`hai_ranger_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_ranger_data_prepper.md),
[`hai_svm_poly_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_poly_data_prepper.md),
[`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md),
[`hai_xgboost_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_xgboost_data_prepper.md)

Other knn:
[`hai_knn_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_knn_data_prepper.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(ggplot2)
library(tibble)

Titanic <- as_tibble(Titanic)

hai_glmnet_data_prepper(.data = Titanic, .recipe_formula = Survived ~ .)
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 4
#> 
#> ── Operations 
#> • Factor variables from: tidyselect::vars_select_helpers$where(is.character)
#> • Novel factor level assignment for: recipes::all_nominal_predictors()
#> • Dummy variables from: recipes::all_nominal_predictors()
#> • Zero variance filter on: recipes::all_predictors()
#> • Centering and scaling for: recipes::all_numeric_predictors()
rec_obj <- hai_glmnet_data_prepper(Titanic, Survived ~ .)
get_juiced_data(rec_obj)
#> # A tibble: 32 × 7
#>         n Survived Class_X2nd Class_X3rd Class_Crew Sex_Male Age_Child
#>     <dbl> <fct>         <dbl>      <dbl>      <dbl>    <dbl>     <dbl>
#>  1 -0.506 No           -0.568     -0.568     -0.568    0.984     0.984
#>  2 -0.506 No            1.70      -0.568     -0.568    0.984     0.984
#>  3 -0.248 No           -0.568      1.70      -0.568    0.984     0.984
#>  4 -0.506 No           -0.568     -0.568      1.70     0.984     0.984
#>  5 -0.506 No           -0.568     -0.568     -0.568   -0.984     0.984
#>  6 -0.506 No            1.70      -0.568     -0.568   -0.984     0.984
#>  7 -0.381 No           -0.568      1.70      -0.568   -0.984     0.984
#>  8 -0.506 No           -0.568     -0.568      1.70    -0.984     0.984
#>  9  0.362 No           -0.568     -0.568     -0.568    0.984    -0.984
#> 10  0.627 No            1.70      -0.568     -0.568    0.984    -0.984
#> # ℹ 22 more rows
```
