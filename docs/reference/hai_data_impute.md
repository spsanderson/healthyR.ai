# Data Preprocessor - Imputation

Takes in a recipe and will impute missing values using a selected
recipe. To call the recipe use a quoted argument like "median" or
"bagged".

## Usage

``` r
hai_data_impute(
  .recipe_object = NULL,
  ...,
  .seed_value = 123,
  .type_of_imputation = "mean",
  .number_of_trees = 25,
  .neighbors = 5,
  .mean_trim = 0,
  .roll_statistic,
  .roll_window = 5
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

- .seed_value:

  To make results reproducible, set the seed.

- .type_of_imputation:

  This is a quoted argument and can be one of the following:

  - "bagged"

  - "knn"

  - "linear"

  - "lower"

  - "mean"

  - "median"

  - "mode"

  - "roll"

- .number_of_trees:

  This is used for the
  [`recipes::step_impute_bag()`](https://recipes.tidymodels.org/reference/step_impute_bag.html)
  trees parameter. This should be an integer.

- .neighbors:

  This should be filled in with an integer value if
  `.type_of_imputation` selected is "knn".

- .mean_trim:

  This should be filled in with a fraction if `.type_of_imputation`
  selected is "mean".

- .roll_statistic:

  This should be filled in with a single unquoted function that takes
  with it a single argument such as mean. This should be filled in if
  `.type_of_imputation` selected is "roll".

- .roll_window:

  This should be filled in with an integer value if
  `.type_of_imputation` selected is "roll".

## Value

A list object

## Details

This function will get your data ready for processing with many types of
ml/ai models.

This is intended to be used inside of the data processor and therefore
is an internal function. This documentation exists to explain the
process and help the user understand the parameters that can be set in
the pre-processor function.

## See also

<https://recipes.tidymodels.org/reference/index.html#section-step-functions-imputation/>

step_impute_bag

[`recipes::step_impute_bag()`](https://recipes.tidymodels.org/reference/step_impute_bag.html)

<https://recipes.tidymodels.org/reference/step_impute_bag.html>

step_impute_knn

[`recipes::step_impute_knn()`](https://recipes.tidymodels.org/reference/step_impute_knn.html)

<https://recipes.tidymodels.org/reference/step_impute_knn.html>

step_impute_linear

[`recipes::step_impute_linear()`](https://recipes.tidymodels.org/reference/step_impute_linear.html)

<https://recipes.tidymodels.org/reference/step_impute_linear.html>

step_impute_lower

[`recipes::step_impute_lower()`](https://recipes.tidymodels.org/reference/step_impute_lower.html)

<https://recipes.tidymodels.org/reference/step_impute_lower.html>

step_impute_mean

[`recipes::step_impute_mean()`](https://recipes.tidymodels.org/reference/step_impute_mean.html)

<https://recipes.tidymodels.org/reference/step_impute_mean.html>

step_impute_median

[`recipes::step_impute_median()`](https://recipes.tidymodels.org/reference/step_impute_median.html)

<https://recipes.tidymodels.org/reference/step_impute_median.html>

step_impute_mode

[`recipes::step_impute_mode()`](https://recipes.tidymodels.org/reference/step_impute_mode.html)

<https://recipes.tidymodels.org/reference/step_impute_mode.html>

step_impute_roll

[`recipes::step_impute_roll()`](https://recipes.tidymodels.org/reference/step_impute_roll.html)

<https://recipes.tidymodels.org/reference/step_impute_roll.html>

Other Data Recipes:
[`hai_data_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_poly.md),
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
val_seq <- rep(c(rnorm(9), NA), times = 10)
df_tbl <- tibble(
  date_col = date_seq,
  value    = val_seq
)

rec_obj <- recipe(value ~ ., df_tbl)

hai_data_impute(
  .recipe_object = rec_obj,
  value,
  .type_of_imputation = "roll",
  .roll_statistic = median
)$new_rec_obj %>%
  get_juiced_data()
#> # A tibble: 100 × 2
#>    date_col    value
#>    <date>      <dbl>
#>  1 2013-01-01  0.408
#>  2 2013-02-01  1.39 
#>  3 2013-03-01  0.360
#>  4 2013-04-01  0.655
#>  5 2013-05-01  1.05 
#>  6 2013-06-01 -1.98 
#>  7 2013-07-01  1.21 
#>  8 2013-08-01 -0.169
#>  9 2013-09-01  0.295
#> 10 2013-10-01  0.351
#> # ℹ 90 more rows
```
