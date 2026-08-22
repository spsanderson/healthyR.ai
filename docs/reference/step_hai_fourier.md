# Recipes Step Fourier Generator

`step_hai_fourier` creates a a *specification* of a recipe step that
will convert numeric data into either a 'sin', 'cos', or 'sincos'
feature that can aid in machine learning.

## Usage

``` r
step_hai_fourier(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  columns = NULL,
  scale_type = c("sin", "cos", "sincos"),
  period = 1,
  order = 1,
  skip = FALSE,
  id = rand_id("hai_fourier")
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

- scale_type:

  A character string of a scaling type, one of "sin","cos", or "sincos"

- period:

  The number of observations that complete a cycle

- order:

  The fourier term order

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

For `step_hai_fourier`, an updated version of recipe with the new step
added to the sequence of existing steps (if any).

Main Recipe Functions:

- [`recipes::recipe()`](https://recipes.tidymodels.org/reference/recipe.html)

- [`recipes::prep()`](https://recipes.tidymodels.org/reference/prep.html)

- [`recipes::bake()`](https://recipes.tidymodels.org/reference/bake.html)

## Details

**Numeric Variables** Unlike other steps, `step_hai_fourier` does *not*
remove the original numeric variables.
[`recipes::step_rm()`](https://recipes.tidymodels.org/reference/step_rm.html)
can be used for this purpose.

## See also

Other Recipes:
[`step_hai_fourier_discrete()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier_discrete.md),
[`step_hai_hyperbolic()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_hyperbolic.md),
[`step_hai_scale_zero_one()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zero_one.md),
[`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md),
[`step_hai_winsorized_move()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_winsorized_move.md),
[`step_hai_winsorized_truncate()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_winsorized_truncate.md)

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
rec_obj <- recipe(a ~ ., data = data_tbl) |>
  step_hai_fourier(b, scale_type = "sin") |>
  step_hai_fourier(b, scale_type = "cos") |>
  step_hai_fourier(b, scale_type = "sincos")

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
#> • Fourier Transformation on: b
#> • Fourier Transformation on: b
#> • Fourier Transformation on: b

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
#> • Fourier Transformation on: b | Trained
#> • Fourier Transformation on: b | Trained
#> • Fourier Transformation on: b | Trained

# Bake the recipe object - Adds the Time Series Signature
bake(prep(rec_obj), data_tbl)
#> # A tibble: 10 × 6
#>    date_col        b       a fourier_b_sin fourier_b_cos fourier_b_sincos
#>    <date>      <dbl>   <dbl>         <dbl>         <dbl>            <dbl>
#>  1 2021-01-01 0.0623 -0.674          0.381        0.924            0.352 
#>  2 2021-02-01 0.807   0.663         -0.936        0.353           -0.331 
#>  3 2021-03-01 0.810   0.890         -0.931        0.366           -0.340 
#>  4 2021-04-01 0.812   1.17          -0.925        0.379           -0.351 
#>  5 2021-05-01 0.202   1.32           0.956        0.295            0.282 
#>  6 2021-06-01 0.627   0.0470        -0.716       -0.699            0.500 
#>  7 2021-07-01 0.717  -0.677         -0.979       -0.206            0.202 
#>  8 2021-08-01 0.839   0.395         -0.849        0.529           -0.449 
#>  9 2021-09-01 0.468   1.99           0.201       -0.980           -0.197 
#> 10 2021-10-01 0.764   3.05          -0.996        0.0886          -0.0883

rec_obj |> get_juiced_data()
#> # A tibble: 10 × 6
#>    date_col        b       a fourier_b_sin fourier_b_cos fourier_b_sincos
#>    <date>      <dbl>   <dbl>         <dbl>         <dbl>            <dbl>
#>  1 2021-01-01 0.0623 -0.674          0.381        0.924            0.352 
#>  2 2021-02-01 0.807   0.663         -0.936        0.353           -0.331 
#>  3 2021-03-01 0.810   0.890         -0.931        0.366           -0.340 
#>  4 2021-04-01 0.812   1.17          -0.925        0.379           -0.351 
#>  5 2021-05-01 0.202   1.32           0.956        0.295            0.282 
#>  6 2021-06-01 0.627   0.0470        -0.716       -0.699            0.500 
#>  7 2021-07-01 0.717  -0.677         -0.979       -0.206            0.202 
#>  8 2021-08-01 0.839   0.395         -0.849        0.529           -0.449 
#>  9 2021-09-01 0.468   1.99           0.201       -0.980           -0.197 
#> 10 2021-10-01 0.764   3.05          -0.996        0.0886          -0.0883
```
