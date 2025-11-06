# Prep Data for k-NN - Recipe

Automatically prep a data.frame/tibble for use in the k-NN algorithm.

## Usage

``` r
hai_knn_data_prepper(.data, .recipe_formula)
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
the k-NN algorithm. The k-NN algorithm is a lazy learning classification
algorithm. It expects data to be presented in a certain fashion.

This function will output a recipe specification.

## See also

Other Preprocessor:
[`hai_c50_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_c50_data_prepper.md),
[`hai_cubist_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_cubist_data_prepper.md),
[`hai_earth_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_earth_data_prepper.md),
[`hai_glmnet_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_glmnet_data_prepper.md),
[`hai_ranger_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_ranger_data_prepper.md),
[`hai_svm_poly_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_poly_data_prepper.md),
[`hai_svm_rbf_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_svm_rbf_data_prepper.md),
[`hai_xgboost_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_xgboost_data_prepper.md)

Other knn:
[`hai_glmnet_data_prepper()`](https://www.spsanderson.com/healthyR.ai/reference/hai_glmnet_data_prepper.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(ggplot2)
library(tibble)

Titanic <- as_tibble(Titanic)

hai_knn_data_prepper(.data = Titanic, .recipe_formula = Survived ~ .)
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 4
#> 
#> ── Operations 
#> • Novel factor level assignment for: recipes::all_nominal_predictors()
#> • Dummy variables from: recipes::all_nominal_predictors()
#> • Zero variance filter on: recipes::all_predictors()
#> • Centering and scaling for: recipes::all_numeric()
rec_obj <- hai_knn_data_prepper(iris, Species ~ .)
get_juiced_data(rec_obj)
#> # A tibble: 150 × 5
#>    Sepal.Length Sepal.Width Petal.Length Petal.Width Species
#>           <dbl>       <dbl>        <dbl>       <dbl> <fct>  
#>  1       -0.898      1.02          -1.34       -1.31 setosa 
#>  2       -1.14      -0.132         -1.34       -1.31 setosa 
#>  3       -1.38       0.327         -1.39       -1.31 setosa 
#>  4       -1.50       0.0979        -1.28       -1.31 setosa 
#>  5       -1.02       1.25          -1.34       -1.31 setosa 
#>  6       -0.535      1.93          -1.17       -1.05 setosa 
#>  7       -1.50       0.786         -1.34       -1.18 setosa 
#>  8       -1.02       0.786         -1.28       -1.31 setosa 
#>  9       -1.74      -0.361         -1.34       -1.31 setosa 
#> 10       -1.14       0.0979        -1.28       -1.44 setosa 
#> # ℹ 140 more rows
```
