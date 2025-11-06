# Data Preprocessor - Transformation Functions

Takes in a recipe and will perform the desired transformation on the
selected varialbe(s) using a selected recipe. To call the desired
transformation recipe use a quoted argument like "boxcos", "bs" etc.

## Usage

``` r
hai_data_transform(
  .recipe_object = NULL,
  ...,
  .type_of_scale = "log",
  .bc_limits = c(-5, 5),
  .bc_num_unique = 5,
  .bs_deg_free = NULL,
  .bs_degree = 3,
  .log_base = exp(1),
  .log_offset = 0,
  .logit_offset = 0,
  .ns_deg_free = 2,
  .rel_shift = 0,
  .rel_reverse = FALSE,
  .rel_smooth = FALSE,
  .yj_limits = c(-5, 5),
  .yj_num_unique = 5
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

  - "boxcox"

  - "bs"

  - "log"

  - "logit"

  - "ns"

  - "relu"

  - "sqrt"

  - "yeojohnson

- .bc_limits:

  A length 2 numeric vector defining the range to compute the
  transformation parameter lambda.

- .bc_num_unique:

  An integer to specify minimum required unique values to evaluate for a
  transformation

- .bs_deg_free:

  The degrees of freedom for the spline. As the degrees of freedom for a
  spline increase, more flexible and complex curves can be generated.
  When a single degree of freedom is used, the result is a rescaled
  version of the original data.

- .bs_degree:

  Degree of polynomial spline (integer).

- .log_base:

  A numberic value for the base.

- .log_offset:

  An optional value to add to the data prior to logging (to avoid
  log(0))

- .logit_offset:

  A numberic value to modify values ofthe columns that are either one or
  zero. They are modifed to be `x - offset` or `offset` respectively.

- .ns_deg_free:

  The degrees of freedom for the natural spline. As the degrees of
  freedom for a natural spline increase, more flexible and complex
  curves can be generated. When a single degree of freedom is used, the
  result is a rescaled version of the original data.

- .rel_shift:

  A numeric value dictating a translation to apply to the data.

- .rel_reverse:

  A logical to indicate if theleft hinge should be used as opposed to
  the right hinge.

- .rel_smooth:

  A logical indicating if hte softplus function, a smooth approximation
  to the rectified linear transformation, should be used.

- .yj_limits:

  A length 2 numeric vector defining the range to compute the
  transformation parameter lambda.

- .yj_num_unique:

  An integer where data that have less possible values will not be
  evaluated for a transformation.

## Value

A list object

## Details

This function will get your data ready for processing with many types of
ml/ai models.

This is intended to be used inside of the data processor and therefore
is an internal function. This documentation exists to explain the
process and help the user understand the parameters that can be set in
the pre-processor function.

[`recipes::step_BoxCox()`](https://recipes.tidymodels.org/reference/step_BoxCox.html)

## See also

<https://recipes.tidymodels.org/reference/step_BoxCox.html>

[`recipes::step_bs()`](https://recipes.tidymodels.org/reference/step_bs.html)

<https://recipes.tidymodels.org/reference/step_bs.html>

[`recipes::step_log()`](https://recipes.tidymodels.org/reference/step_log.html)

<https://recipes.tidymodels.org/reference/step_log.html>

[`recipes::step_logit()`](https://recipes.tidymodels.org/reference/step_logit.html)

<https://recipes.tidymodels.org/reference/step_logit.html>

[`recipes::step_ns()`](https://recipes.tidymodels.org/reference/step_ns.html)

<https://recipes.tidymodels.org/reference/step_ns.html>

[`recipes::step_relu()`](https://recipes.tidymodels.org/reference/step_relu.html)

<https://recipes.tidymodels.org/reference/step_relu.html>

[`recipes::step_sqrt()`](https://recipes.tidymodels.org/reference/step_sqrt.html)

<https://recipes.tidymodels.org/reference/step_sqrt.html>

[`recipes::step_YeoJohnson()`](https://recipes.tidymodels.org/reference/step_YeoJohnson.html)

<https://recipes.tidymodels.org/reference/step_YeoJohnson.html>

Other Data Recipes:
[`hai_data_impute()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_impute.md),
[`hai_data_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_poly.md),
[`hai_data_scale()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_scale.md),
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

hai_data_transform(
  .recipe_object = rec_obj,
  value,
  .type_of_scale = "log"
)$new_rec_obj %>%
  get_juiced_data()
#> # A tibble: 100 × 2
#>    date_col   value
#>    <date>     <dbl>
#>  1 2013-01-01 0.849
#>  2 2013-02-01 2.03 
#>  3 2013-03-01 1.11 
#>  4 2013-04-01 1.15 
#>  5 2013-05-01 2.29 
#>  6 2013-06-01 2.00 
#>  7 2013-07-01 1.89 
#>  8 2013-08-01 1.74 
#>  9 2013-09-01 1.29 
#> 10 2013-10-01 2.22 
#> # ℹ 90 more rows
```
