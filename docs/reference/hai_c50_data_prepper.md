# Prep Data for C5.0 - Recipe

Automatically prep a data.frame/tibble for use in the C5.0 algorithm.

## Usage

``` r
hai_c50_data_prepper(.data, .recipe_formula)
```

## Arguments

- .data:

  The data that you are passing to the function. Can be any type of data
  that is accepted by the `data` parameter of the
  [`recipes::recipe()`](https://recipes.tidymodels.org/reference/recipe.html)
  function.

- .recipe_formula:

  The formula that is going to be passed. For example if you are using
  the `iris` data then the formula would most likely be something like
  `Species ~ .`

## Value

A recipe object

## Details

This function will automatically prep your data.frame/tibble for use in
the C5.0 algorithm. The C5.0 algorithm is a lazy learning classification
algorithm. It expects data to be presented in a certain fashion.

This function will output a recipe specification.

## See also

<https://www.rulequest.com/see5-unix.html>

Other Preprocessor:
[`hai_cubist_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_cubist_data_prepper.md),
[`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md),
[`hai_glmnet_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_glmnet_data_prepper.md),
[`hai_knn_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_knn_data_prepper.md),
[`hai_ranger_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_ranger_data_prepper.md),
[`hai_svm_poly_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_poly_data_prepper.md),
[`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md),
[`hai_xgboost_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_xgboost_data_prepper.md)

Other C5.0:
[`hai_auto_c50()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_c50.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(ggplot2)
library(tibble)

Titanic <- as_tibble(Titanic)

hai_c50_data_prepper(.data = Titanic, .recipe_formula = Survived ~ .)
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
rec_obj <- hai_c50_data_prepper(Titanic, Survived ~ .)
get_juiced_data(rec_obj)
#> # A tibble: 32 × 5
#>    Class Sex    Age       n Survived
#>    <fct> <fct>  <fct> <dbl> <fct>   
#>  1 1st   Male   Child     0 No      
#>  2 2nd   Male   Child     0 No      
#>  3 3rd   Male   Child    35 No      
#>  4 Crew  Male   Child     0 No      
#>  5 1st   Female Child     0 No      
#>  6 2nd   Female Child     0 No      
#>  7 3rd   Female Child    17 No      
#>  8 Crew  Female Child     0 No      
#>  9 1st   Male   Adult   118 No      
#> 10 2nd   Male   Adult   154 No      
#> # ℹ 22 more rows
```
