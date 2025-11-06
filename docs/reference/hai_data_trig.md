# Data Preprocessor - Trigonometric Functions

Takes in a recipe and will scale values using a selected recipe. To call
the recipe use a quoted argument like "sinh", "cosh" or "tanh".

## Usage

``` r
hai_data_trig(
  .recipe_object = NULL,
  ...,
  .type_of_scale = "sinh",
  .inverse = FALSE
)
```

## Arguments

- .recipe_object:

  The data that you want to process

- ...:

  One or more selector functions to choose variables to be imputed. When
  used with imp_vars, these dots indicate which variables are used to
  predict the missing data in each variable. See selections() for more
  details

- .type_of_scale:

  This is a quoted argument and can be one of the following:

  - "sinh"

  - "cosh"

  - "tanh"

- .inverse:

  A logical: should the inverse function be used? Default is FALSE

## Value

A list object

## Details

This function will get your data ready for processing with many types of
ml/ai models.

This is intended to be used inside of the data processor and therefore
is an internal function. This documentation exists to explain the
process and help the user understand the parameters that can be set in
the pre-processor function.

[`recipes::step_hyperbolic()`](https://recipes.tidymodels.org/reference/step_hyperbolic.html)

## See also

<https://recipes.tidymodels.org/reference/step_hyperbolic.html>

Other Data Recipes:
[`hai_data_impute()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_impute.md),
[`hai_data_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_poly.md),
[`hai_data_scale()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_scale.md),
[`hai_data_transform()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_transform.md),
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

hai_data_trig(
  .recipe_object = rec_obj,
  value,
  .type_of_scale = "sinh"
)$new_rec_obj %>%
  get_juiced_data()
#> # A tibble: 100 × 2
#>    date_col    value
#>    <date>      <dbl>
#>  1 2013-01-01 2345. 
#>  2 2013-02-01  393. 
#>  3 2013-03-01  101. 
#>  4 2013-04-01  166. 
#>  5 2013-05-01  216. 
#>  6 2013-06-01  437. 
#>  7 2013-07-01  210. 
#>  8 2013-08-01  205. 
#>  9 2013-09-01 1298. 
#> 10 2013-10-01   51.3
#> # ℹ 90 more rows
```
