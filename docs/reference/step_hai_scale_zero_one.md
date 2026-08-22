# Recipes Data Scale to Zero and One

`step_hai_scale_zero_one` creates a a *specification* of a recipe step
that will convert numeric data into from a time series into its
velocity.

## Usage

``` r
step_hai_scale_zero_one(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  columns = NULL,
  skip = FALSE,
  id = rand_id("hai_scale_zero_one")
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

For `step_hai_scale_zero_one`, an updated version of recipe with the new
step added to the sequence of existing steps (if any).

Main Recipe Functions:

- [`recipes::recipe()`](https://recipes.tidymodels.org/reference/recipe.html)

- [`recipes::prep()`](https://recipes.tidymodels.org/reference/prep.html)

- [`recipes::bake()`](https://recipes.tidymodels.org/reference/bake.html)

## Details

**Numeric Variables** Unlike other steps, `step_hai_scale_zero_one` does
*not* remove the original numeric variables.
[`recipes::step_rm()`](https://recipes.tidymodels.org/reference/step_rm.html)
can be used for this purpose.

## See also

Other Recipes:
[`step_hai_fourier()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier.md),
[`step_hai_fourier_discrete()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier_discrete.md),
[`step_hai_hyperbolic()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_hyperbolic.md),
[`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md),
[`step_hai_winsorized_move()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_winsorized_move.md),
[`step_hai_winsorized_truncate()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_winsorized_truncate.md)

## Examples

``` r
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(recipes))

data_tbl <- data.frame(a = rnorm(200, 3, 1), b = rnorm(200, 2, 2))

# Create a recipe object
rec_obj <- recipe(a ~ ., data = data_tbl) |>
  step_hai_scale_zero_one(b)

# View the recipe object
rec_obj
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 1
#> 
#> ── Operations 
#> • Zero-One Scale Transformation on: b

# Prepare the recipe object
prep(rec_obj)
#> 
#> ── Recipe ──────────────────────────────────────────────────────────────────────
#> 
#> ── Inputs 
#> Number of variables by role
#> outcome:   1
#> predictor: 1
#> 
#> ── Training information 
#> Training data contained 200 data points and no incomplete rows.
#> 
#> ── Operations 
#> • Zero-One Scale Transformation on: b | Trained

# Bake the recipe object - Adds the Time Series Signature
bake(prep(rec_obj), data_tbl)
#> # A tibble: 200 × 3
#>          b     a hai_scale_zero_one_b
#>      <dbl> <dbl>                <dbl>
#>  1 -0.0392  3.82                0.267
#>  2  3.36    4.65                0.606
#>  3  0.437   4.26                0.314
#>  4 -0.398   4.61                0.231
#>  5  6.57    2.16                0.929
#>  6  1.84    3.62                0.455
#>  7  1.17    1.41                0.387
#>  8 -0.900   3.35                0.181
#>  9  2.34    4.06                0.505
#> 10  2.89    3.95                0.560
#> # ℹ 190 more rows

rec_obj |>
  prep() |>
  juice()
#> # A tibble: 200 × 3
#>          b     a hai_scale_zero_one_b
#>      <dbl> <dbl>                <dbl>
#>  1 -0.0392  3.82                0.267
#>  2  3.36    4.65                0.606
#>  3  0.437   4.26                0.314
#>  4 -0.398   4.61                0.231
#>  5  6.57    2.16                0.929
#>  6  1.84    3.62                0.455
#>  7  1.17    1.41                0.387
#>  8 -0.900   3.35                0.181
#>  9  2.34    4.06                0.505
#> 10  2.89    3.95                0.560
#> # ℹ 190 more rows
```
