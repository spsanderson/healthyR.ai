# Recipes Step Winsorized Truncate Generator

`step_hai_winsorized_truncate` creates a a *specification* of a recipe
step that will winsorize numeric data.

## Usage

``` r
step_hai_winsorized_truncate(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  columns = NULL,
  fraction = 0.05,
  skip = FALSE,
  id = rand_id("hai_winsorized_truncate")
)
```

## Arguments

- recipe:

  A recipe object. The step will be added to the sequence of operations
  for this recipe.

- ...:

  One or more selector functions to choose which variables that will be
  used to create the new variables. The selected variables should have
  class `numeric`

- role:

  For model terms created by this step, what analysis role should they
  be assigned?. By default, the function assumes that the new variable
  columns created by the original variables will be used as predictors
  in a model.

- trained:

  A logical to indicate if the quantities for preprocessing have been
  estimated.

- columns:

  A character string of variables that will be used as inputs. This
  field is a placeholder and will be populated once
  [`recipes::prep()`](https://recipes.tidymodels.org/reference/prep.html)
  is used.

- fraction:

  A positive fractional between 0 and 0.5 that is passed to the
  [`stats::quantile`](https://rdrr.io/r/stats/quantile.html) paramater
  of `probs`.

- skip:

  A logical. Should the step be skipped when the recipe is baked by
  bake.recipe()? While all operations are baked when prep.recipe() is
  run, some operations may not be able to be conducted on new data (e.g.
  processing the outcome variable(s)). Care should be taken when using
  skip = TRUE as it may affect the computations for subsequent
  operations.

- id:

  A character string that is unique to this step to identify it.

## Value

For `step_hai_winsorize_truncate`, an updated version of recipe with the
new step added to the sequence of existing steps (if any).

Main Recipe Functions:

- [`recipes::recipe()`](https://recipes.tidymodels.org/reference/recipe.html)

- [`recipes::prep()`](https://recipes.tidymodels.org/reference/prep.html)

- [`recipes::bake()`](https://recipes.tidymodels.org/reference/bake.html)

## Details

**Numeric Variables** Unlike other steps, `step_hai_winsorize_truncate`
does *not* remove the original numeric variables.
[`recipes::step_rm()`](https://recipes.tidymodels.org/reference/step_rm.html)
can be used for this purpose.

## See also

Other Recipes:
[`step_hai_fourier()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier.md),
[`step_hai_fourier_discrete()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier_discrete.md),
[`step_hai_hyperbolic()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_hyperbolic.md),
[`step_hai_scale_zero_one()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zero_one.md),
[`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md),
[`step_hai_winsorized_move()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_winsorized_move.md)

## Examples

``` r
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(recipes))

len_out <- 10
by_unit <- "month"
start_date <- as.Date("2021-01-01")

data_tbl <- tibble(
  date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
  a = rnorm(len_out),
  b = runif(len_out)
)

# Create a recipe object
rec_obj <- recipe(b ~ ., data = data_tbl) %>%
  step_hai_winsorized_truncate(a, fraction = 0.05)

# View the recipe object
rec_obj
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 2
#> 
#> ── Operations 
#> • Winsorized Truncation Transformation on: a

# Prepare the recipe object
prep(rec_obj)
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 2
#> 
#> ── Training information 
#> Training data contained 10 data points and no incomplete rows.
#> 
#> ── Operations 
#> • Winsorized Truncation Transformation on: a | Trained

# Bake the recipe object - Adds the Time Series Signature
bake(prep(rec_obj), data_tbl)
#> # A tibble: 10 × 4
#>    date_col        a     b winsorized_truncate_a
#>    <date>      <dbl> <dbl>                 <dbl>
#>  1 2021-01-01 -0.261 0.453                -0.261
#>  2 2021-02-01  0.993 0.229                 0.993
#>  3 2021-03-01 -1.00  0.535                -1.00 
#>  4 2021-04-01  1.98  0.868                 1.90 
#>  5 2021-05-01  0.350 0.854                 0.350
#>  6 2021-06-01  1.02  0.112                 1.02 
#>  7 2021-07-01  1.81  0.234                 1.81 
#>  8 2021-08-01 -1.65  0.508                -1.36 
#>  9 2021-09-01  0.305 0.771                 0.305
#> 10 2021-10-01 -0.202 0.660                -0.202

rec_obj %>% get_juiced_data()
#> # A tibble: 10 × 4
#>    date_col        a     b winsorized_truncate_a
#>    <date>      <dbl> <dbl>                 <dbl>
#>  1 2021-01-01 -0.261 0.453                -0.261
#>  2 2021-02-01  0.993 0.229                 0.993
#>  3 2021-03-01 -1.00  0.535                -1.00 
#>  4 2021-04-01  1.98  0.868                 1.90 
#>  5 2021-05-01  0.350 0.854                 0.350
#>  6 2021-06-01  1.02  0.112                 1.02 
#>  7 2021-07-01  1.81  0.234                 1.81 
#>  8 2021-08-01 -1.65  0.508                -1.36 
#>  9 2021-09-01  0.305 0.771                 0.305
#> 10 2021-10-01 -0.202 0.660                -0.202
```
