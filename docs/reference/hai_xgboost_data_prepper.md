# Prep Data for XGBoost - Recipe

Automatically prep a data.frame/tibble for use in the xgboost algorithm.

## Usage

``` r
hai_xgboost_data_prepper(.data, .recipe_formula)
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
the XGBoost algorithm.

This function will output a recipe specification.

## See also

<https://parsnip.tidymodels.org/reference/details_boost_tree_xgboost.html>

Other Preprocessor:
[`hai_c50_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_c50_data_prepper.md),
[`hai_cubist_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_cubist_data_prepper.md),
[`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md),
[`hai_glmnet_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_glmnet_data_prepper.md),
[`hai_knn_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_knn_data_prepper.md),
[`hai_ranger_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_ranger_data_prepper.md),
[`hai_svm_poly_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_poly_data_prepper.md),
[`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(ggplot2)
library(tibble)

# Regression
hai_xgboost_data_prepper(.data = diamonds, .recipe_formula = price ~ .)
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
#> • Novel factor level assignment for: recipes::all_nominal_predictors()
#> • Dummy variables from: recipes::all_nominal_predictors()
#> • Zero variance filter on: recipes::all_predictors()
reg_obj <- hai_xgboost_data_prepper(diamonds, price ~ .)
get_juiced_data(reg_obj)
#> # A tibble: 53,940 × 27
#>    carat depth table     x     y     z price  cut_1  cut_2  cut_3  cut_4   cut_5
#>    <dbl> <dbl> <dbl> <dbl> <dbl> <dbl> <int>  <dbl>  <dbl>  <dbl>  <dbl>   <dbl>
#>  1  0.23  61.5    55  3.95  3.98  2.43   326  0.359 -0.109 -0.522 -0.567 -0.315 
#>  2  0.21  59.8    61  3.89  3.84  2.31   326  0.120 -0.436 -0.298  0.378  0.630 
#>  3  0.23  56.9    65  4.05  4.07  2.31   327 -0.359 -0.109  0.522 -0.567  0.315 
#>  4  0.29  62.4    58  4.2   4.23  2.63   334  0.120 -0.436 -0.298  0.378  0.630 
#>  5  0.31  63.3    58  4.34  4.35  2.75   335 -0.359 -0.109  0.522 -0.567  0.315 
#>  6  0.24  62.8    57  3.94  3.96  2.48   336 -0.120 -0.436  0.298  0.378 -0.630 
#>  7  0.24  62.3    57  3.95  3.98  2.47   336 -0.120 -0.436  0.298  0.378 -0.630 
#>  8  0.26  61.9    55  4.07  4.11  2.53   337 -0.120 -0.436  0.298  0.378 -0.630 
#>  9  0.22  65.1    61  3.87  3.78  2.49   337 -0.598  0.546 -0.373  0.189 -0.0630
#> 10  0.23  59.4    61  4     4.05  2.39   338 -0.120 -0.436  0.298  0.378 -0.630 
#> # ℹ 53,930 more rows
#> # ℹ 15 more variables: color_1 <dbl>, color_2 <dbl>, color_3 <dbl>,
#> #   color_4 <dbl>, color_5 <dbl>, color_6 <dbl>, color_7 <dbl>,
#> #   clarity_1 <dbl>, clarity_2 <dbl>, clarity_3 <dbl>, clarity_4 <dbl>,
#> #   clarity_5 <dbl>, clarity_6 <dbl>, clarity_7 <dbl>, clarity_8 <dbl>

# Classification
Titanic <- as_tibble(Titanic)

hai_xgboost_data_prepper(Titanic, Survived ~ .)
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
cla_obj <- hai_xgboost_data_prepper(Titanic, Survived ~ .)
get_juiced_data(cla_obj)
#> # A tibble: 32 × 7
#>        n Survived Class_X2nd Class_X3rd Class_Crew Sex_Male Age_Child
#>    <dbl> <fct>         <dbl>      <dbl>      <dbl>    <dbl>     <dbl>
#>  1     0 No                0          0          0        1         1
#>  2     0 No                1          0          0        1         1
#>  3    35 No                0          1          0        1         1
#>  4     0 No                0          0          1        1         1
#>  5     0 No                0          0          0        0         1
#>  6     0 No                1          0          0        0         1
#>  7    17 No                0          1          0        0         1
#>  8     0 No                0          0          1        0         1
#>  9   118 No                0          0          0        1         0
#> 10   154 No                1          0          0        1         0
#> # ℹ 22 more rows
```
