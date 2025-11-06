# Prep Data for Ranger - Recipe

Automatically prep a data.frame/tibble for use in the Ranger algorithm.

## Usage

``` r
hai_ranger_data_prepper(.data, .recipe_formula)
```

## Arguments

- .data:

  The data that you are passing to the function. Can be any type of data
  that is accepted by the `data` parameter of the `recipes::reciep()`
  function.

- .recipe_formula:

  The formula that is going to be passed. For example if you are using
  the `diamonds` data then the formula would most likely be something
  like `price ~ .`

## Value

A recipe object

## Details

This function will automatically prep your data.frame/tibble for use in
the Ranger algorithm.

This function will output a recipe specification.

## See also

<https://parsnip.tidymodels.org/reference/rand_forest.html>

Other Preprocessor:
[`hai_c50_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_c50_data_prepper.md),
[`hai_cubist_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_cubist_data_prepper.md),
[`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md),
[`hai_glmnet_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_glmnet_data_prepper.md),
[`hai_knn_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_knn_data_prepper.md),
[`hai_svm_poly_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_poly_data_prepper.md),
[`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md),
[`hai_xgboost_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_xgboost_data_prepper.md)

Other Ranger:
[`hai_auto_ranger()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_ranger.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(ggplot2)
library(tibble)

# Regression
hai_ranger_data_prepper(.data = diamonds, .recipe_formula = price ~ .)
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 9
#> 
#> ── Operations 
#> • Factor variables from: tidyselect::vars_select_helpers$where(is.character)
reg_obj <- hai_ranger_data_prepper(diamonds, price ~ .)
get_juiced_data(reg_obj)
#> # A tibble: 53,940 × 10
#>    carat cut       color clarity depth table     x     y     z price
#>    <dbl> <ord>     <ord> <ord>   <dbl> <dbl> <dbl> <dbl> <dbl> <int>
#>  1  0.23 Ideal     E     SI2      61.5    55  3.95  3.98  2.43   326
#>  2  0.21 Premium   E     SI1      59.8    61  3.89  3.84  2.31   326
#>  3  0.23 Good      E     VS1      56.9    65  4.05  4.07  2.31   327
#>  4  0.29 Premium   I     VS2      62.4    58  4.2   4.23  2.63   334
#>  5  0.31 Good      J     SI2      63.3    58  4.34  4.35  2.75   335
#>  6  0.24 Very Good J     VVS2     62.8    57  3.94  3.96  2.48   336
#>  7  0.24 Very Good I     VVS1     62.3    57  3.95  3.98  2.47   336
#>  8  0.26 Very Good H     SI1      61.9    55  4.07  4.11  2.53   337
#>  9  0.22 Fair      E     VS2      65.1    61  3.87  3.78  2.49   337
#> 10  0.23 Very Good H     VS1      59.4    61  4     4.05  2.39   338
#> # ℹ 53,930 more rows

# Classification
Titanic <- as_tibble(Titanic)

hai_ranger_data_prepper(Titanic, Survived ~ .)
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
cla_obj <- hai_ranger_data_prepper(Titanic, Survived ~ .)
get_juiced_data(cla_obj)
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
