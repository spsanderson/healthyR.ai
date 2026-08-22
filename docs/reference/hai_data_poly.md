# Data Preprocessor - Polynomial Function

Takes in a recipe and will scale values using a selected recipe.

## Usage

``` r
hai_data_poly(.recipe_object = NULL, ..., .p_degree = 2)
```

## Arguments

- .recipe_object:

  The data that you want to process

- ...:

  One or more selector functions to choose variables to be imputed. When
  used with imp_vars, these dots indicate which variables are used to
  predict the missing data in each variable. See selections() for more
  details

- .p_degree:

  The polynomial degree, an integer.

## Value

A list object

## Details

This function will get your data ready for processing with many types of
ml/ai models.

This is intended to be used inside of the data processor and therefore
is an internal function. This documentation exists to explain the
process and help the user understand the parameters that can be set in
the pre-processor function.

[`recipes::step_poly()`](https://recipes.tidymodels.org/reference/step_poly.html)

## See also

<https://recipes.tidymodels.org/reference/step_poly.html>

Other Data Recipes:
[`hai_data_impute()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_impute.md),
[`hai_data_scale()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_scale.md),
[`hai_data_transform()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_transform.md),
[`hai_data_trig()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_trig.md),
[`pca_your_recipe()`](https://www.spsanderson.com/healthyR.ai/reference/pca_your_recipe.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(recipes))

date_seq <- seq.Date(from = as.Date("2013-01-01"), length.out = 100, by = "month")
val_seq <- rep(rnorm(10, mean = 6, sd = 2), times = 10)
df_tbl <- tibble(
  date_col = date_seq,
  value    = val_seq
)

rec_obj <- recipe(value ~ ., df_tbl)

hai_data_poly(
  .recipe_object = rec_obj,
  value
)$new_rec_obj |>
  get_juiced_data()
#> # A tibble: 100 × 3
#>    date_col   value_poly_1 value_poly_2
#>    <date>            <dbl>        <dbl>
#>  1 2013-01-01      0.0634       -0.0575
#>  2 2013-02-01     -0.109        -0.0175
#>  3 2013-03-01     -0.157         0.140 
#>  4 2013-04-01     -0.132         0.0505
#>  5 2013-05-01      0.0954        0.0244
#>  6 2013-06-01      0.0743       -0.0326
#>  7 2013-07-01      0.0708       -0.0409
#>  8 2013-08-01      0.00111      -0.137 
#>  9 2013-09-01      0.142         0.193 
#> 10 2013-10-01     -0.0495       -0.123 
#> # ℹ 90 more rows
```
