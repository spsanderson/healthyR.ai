# Prep Data for SVM_Poly - Recipe

Automatically prep a data.frame/tibble for use in the SVM_Poly
algorithm.

## Usage

``` r
hai_svm_poly_data_prepper(.data, .recipe_formula)
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
the SVM_Poly algorithm. The SVM_Poly algorithm is for regression only.

This function will output a recipe specification.

## See also

<https://parsnip.tidymodels.org/reference/svm_poly.html>

Other Preprocessor:
[`hai_c50_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_c50_data_prepper.md),
[`hai_cubist_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_cubist_data_prepper.md),
[`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md),
[`hai_glmnet_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_glmnet_data_prepper.md),
[`hai_knn_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_knn_data_prepper.md),
[`hai_ranger_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_ranger_data_prepper.md),
[`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md),
[`hai_xgboost_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_xgboost_data_prepper.md)

Other SVM_Poly:
[`hai_auto_svm_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_auto_svm_poly.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(ggplot2)
library(tibble)

# Regression
hai_svm_poly_data_prepper(.data = diamonds, .recipe_formula = price ~ .)
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 9
#> 
#> ── Operations 
#> • Zero variance filter on: recipes::all_predictors()
#> • Centering and scaling for: recipes::all_numeric_predictors()
reg_obj <- hai_svm_poly_data_prepper(diamonds, price ~ .)
get_juiced_data(reg_obj)
#> # A tibble: 53,940 × 10
#>    carat cut       color clarity  depth  table     x     y     z price
#>    <dbl> <ord>     <ord> <ord>    <dbl>  <dbl> <dbl> <dbl> <dbl> <int>
#>  1 -1.20 Ideal     E     SI2     -0.174 -1.10  -1.59 -1.54 -1.57   326
#>  2 -1.24 Premium   E     SI1     -1.36   1.59  -1.64 -1.66 -1.74   326
#>  3 -1.20 Good      E     VS1     -3.38   3.38  -1.50 -1.46 -1.74   327
#>  4 -1.07 Premium   I     VS2      0.454  0.243 -1.36 -1.32 -1.29   334
#>  5 -1.03 Good      J     SI2      1.08   0.243 -1.24 -1.21 -1.12   335
#>  6 -1.18 Very Good J     VVS2     0.733 -0.205 -1.60 -1.55 -1.50   336
#>  7 -1.18 Very Good I     VVS1     0.384 -0.205 -1.59 -1.54 -1.51   336
#>  8 -1.13 Very Good H     SI1      0.105 -1.10  -1.48 -1.42 -1.43   337
#>  9 -1.22 Fair      E     VS2      2.34   1.59  -1.66 -1.71 -1.49   337
#> 10 -1.20 Very Good H     VS1     -1.64   1.59  -1.54 -1.47 -1.63   338
#> # ℹ 53,930 more rows

# Classification
Titanic <- as_tibble(Titanic)

hai_svm_poly_data_prepper(Titanic, Survived ~ .)
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 4
#> 
#> ── Operations 
#> • Zero variance filter on: recipes::all_predictors()
#> • Centering and scaling for: recipes::all_numeric_predictors()
cla_obj <- hai_svm_poly_data_prepper(Titanic, Survived ~ .)
get_juiced_data(cla_obj)
#> # A tibble: 32 × 5
#>    Class Sex    Age        n Survived
#>    <fct> <fct>  <fct>  <dbl> <fct>   
#>  1 1st   Male   Child -0.506 No      
#>  2 2nd   Male   Child -0.506 No      
#>  3 3rd   Male   Child -0.248 No      
#>  4 Crew  Male   Child -0.506 No      
#>  5 1st   Female Child -0.506 No      
#>  6 2nd   Female Child -0.506 No      
#>  7 3rd   Female Child -0.381 No      
#>  8 Crew  Female Child -0.506 No      
#>  9 1st   Male   Adult  0.362 No      
#> 10 2nd   Male   Adult  0.627 No      
#> # ℹ 22 more rows
```
