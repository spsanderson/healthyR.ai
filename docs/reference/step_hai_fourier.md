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
rec_obj <- recipe(a ~ ., data = data_tbl) %>%
  step_hai_fourier(b, scale_type = "sin") %>%
  step_hai_fourier(b, scale_type = "cos") %>%
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
#>    date_col       b       a fourier_b_sin fourier_b_cos fourier_b_sincos
#>    <date>     <dbl>   <dbl>         <dbl>         <dbl>            <dbl>
#>  1 2021-01-01 0.184 -0.320          0.916         0.402            0.368
#>  2 2021-02-01 0.687 -0.109         -0.922        -0.388            0.357
#>  3 2021-03-01 0.476  0.626          0.150        -0.989           -0.149
#>  4 2021-04-01 0.865 -0.175         -0.751         0.660           -0.496
#>  5 2021-05-01 0.630 -1.12          -0.730        -0.684            0.499
#>  6 2021-06-01 0.321  0.725          0.902        -0.431           -0.389
#>  7 2021-07-01 0.280 -0.0191         0.983        -0.185           -0.182
#>  8 2021-08-01 0.362 -0.974          0.764        -0.646           -0.493
#>  9 2021-09-01 0.665 -0.296         -0.862        -0.507            0.437
#> 10 2021-10-01 0.373  0.353          0.715        -0.699           -0.500

rec_obj %>% get_juiced_data()
#> # A tibble: 10 × 6
#>    date_col       b       a fourier_b_sin fourier_b_cos fourier_b_sincos
#>    <date>     <dbl>   <dbl>         <dbl>         <dbl>            <dbl>
#>  1 2021-01-01 0.184 -0.320          0.916         0.402            0.368
#>  2 2021-02-01 0.687 -0.109         -0.922        -0.388            0.357
#>  3 2021-03-01 0.476  0.626          0.150        -0.989           -0.149
#>  4 2021-04-01 0.865 -0.175         -0.751         0.660           -0.496
#>  5 2021-05-01 0.630 -1.12          -0.730        -0.684            0.499
#>  6 2021-06-01 0.321  0.725          0.902        -0.431           -0.389
#>  7 2021-07-01 0.280 -0.0191         0.983        -0.185           -0.182
#>  8 2021-08-01 0.362 -0.974          0.764        -0.646           -0.493
#>  9 2021-09-01 0.665 -0.296         -0.862        -0.507            0.437
#> 10 2021-10-01 0.373  0.353          0.715        -0.699           -0.500
```
