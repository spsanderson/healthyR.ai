# Data Preprocessor - Scale/Normalize

Takes in a recipe and will scale values using a selected recipe. To call
the recipe use a quoted argument like "scale" or "normalize".

## Usage

``` r
hai_data_scale(
  .recipe_object = NULL,
  ...,
  .type_of_scale = "center",
  .range_min = 0,
  .range_max = 1,
  .scale_factor = 1
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

  - "center"

  - "normalize"

  - "range"

  - "scale"

- .range_min:

  A single numeric value for the smallest value in the range. This
  defaults to 0.

- .range_max:

  A single numeric value for the largeest value in the range. This
  defaults to 1.

- .scale_factor:

  A numeric value of either 1 or 2 that scales the numeric inputs by one
  or two standard deviations. By dividing by two standard deviations,
  the coefficients attached to continuous predictors can be interpreted
  the same way as with binary inputs. Defaults to 1. More in reference
  below.

## Value

A list object

## Details

This function will get your data ready for processing with many types of
ml/ai models.

This is intended to be used inside of the data processor and therefore
is an internal function. This documentation exists to explain the
process and help the user understand the parameters that can be set in
the pre-processor function.

## References

Gelman, A. (2007) "Scaling regression inputs by dividing by two standard
deviations." Unpublished. Source:
<https://sites.stat.columbia.edu/gelman/research/unpublished/standardizing.pdf>.

## See also

<https://recipes.tidymodels.org/reference/index.html#section-step-functions-normalization>

step_center

[`recipes::step_center()`](https://recipes.tidymodels.org/reference/step_center.html)

<https://recipes.tidymodels.org/reference/step_center.html>

step_normalize

[`recipes::step_normalize()`](https://recipes.tidymodels.org/reference/step_normalize.html)

<https://recipes.tidymodels.org/reference/step_normalize.html>

step_range

[`recipes::step_range()`](https://recipes.tidymodels.org/reference/step_range.html)

<https://recipes.tidymodels.org/reference/step_range.html>

step_scale

[`recipes::step_scale()`](https://recipes.tidymodels.org/reference/step_scale.html)

<https://recipes.tidymodels.org/reference/step_scale.html>

Other Data Recipes:
[`hai_data_impute()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_impute.md),
[`hai_data_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_poly.md),
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

hai_data_scale(
  .recipe_object = rec_obj,
  value,
  .type_of_scale = "center"
)$new_rec_obj %>%
  get_juiced_data()
#> # A tibble: 100 × 2
#>    date_col    value
#>    <date>      <dbl>
#>  1 2013-01-01 -0.141
#>  2 2013-02-01  2.27 
#>  3 2013-03-01  1.70 
#>  4 2013-04-01  1.84 
#>  5 2013-05-01 -1.96 
#>  6 2013-06-01  2.46 
#>  7 2013-07-01 -2.30 
#>  8 2013-08-01 -2.93 
#>  9 2013-09-01 -1.88 
#> 10 2013-10-01  0.931
#> # ℹ 90 more rows
```
