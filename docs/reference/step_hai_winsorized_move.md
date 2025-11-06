# Recipes Step Winsorized Move Generator

`step_hai_winsorized_move` creates a a *specification* of a recipe step
that will winsorize numeric data.

## Usage

``` r
step_hai_winsorized_move(
  recipe,
  ...,
  role = "predictor",
  trained = FALSE,
  columns = NULL,
  multiple = 3,
  skip = FALSE,
  id = rand_id("hai_winsorized_move")
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

- multiple:

  A positive number indicating how many times the the zero center mean
  absolute deviation should be multiplied by for the scaling parameter.

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

For `step_hai_winsorize_move`, an updated version of recipe with the new
step added to the sequence of existing steps (if any).

Main Recipe Functions:

- [`recipes::recipe()`](https://recipes.tidymodels.org/reference/recipe.html)

- [`recipes::prep()`](https://recipes.tidymodels.org/reference/prep.html)

- [`recipes::bake()`](https://recipes.tidymodels.org/reference/bake.html)

## Details

**Numeric Variables** Unlike other steps, `step_hai_winsorize_move` does
*not* remove the original numeric variables.
[`recipes::step_rm()`](https://recipes.tidymodels.org/reference/step_rm.html)
can be used for this purpose.

## See also

Other Recipes:
[`step_hai_fourier()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier.md),
[`step_hai_fourier_discrete()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_fourier_discrete.md),
[`step_hai_hyperbolic()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_hyperbolic.md),
[`step_hai_scale_zero_one()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zero_one.md),
[`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md),
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
rec_obj <- recipe(b ~ ., data = data_tbl) %>%
  step_hai_winsorized_move(a, multiple = 3)

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
#> • Winsorized Scaling/Move Transformation on: a

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
#> • Winsorized Scaling/Move Transformation on: a | Trained

# Bake the recipe object - Adds the Time Series Signature
bake(prep(rec_obj), data_tbl)
#> # A tibble: 10 × 4
#>    date_col         a      b winsorized_move_a
#>    <date>       <dbl>  <dbl>             <dbl>
#>  1 2021-01-01 -0.0353 0.738            -0.0353
#>  2 2021-02-01 -1.39   0.749            -1.39  
#>  3 2021-03-01  0.129  0.520             0.129 
#>  4 2021-04-01  1.06   0.153             1.06  
#>  5 2021-05-01  0.986  0.646             0.986 
#>  6 2021-06-01 -0.0644 0.697            -0.0644
#>  7 2021-07-01  1.87   0.947             1.87  
#>  8 2021-08-01  0.422  0.0143            0.422 
#>  9 2021-09-01  0.668  0.997             0.668 
#> 10 2021-10-01 -0.226  0.0106           -0.226 

rec_obj %>% get_juiced_data()
#> # A tibble: 10 × 4
#>    date_col         a      b winsorized_move_a
#>    <date>       <dbl>  <dbl>             <dbl>
#>  1 2021-01-01 -0.0353 0.738            -0.0353
#>  2 2021-02-01 -1.39   0.749            -1.39  
#>  3 2021-03-01  0.129  0.520             0.129 
#>  4 2021-04-01  1.06   0.153             1.06  
#>  5 2021-05-01  0.986  0.646             0.986 
#>  6 2021-06-01 -0.0644 0.697            -0.0644
#>  7 2021-07-01  1.87   0.947             1.87  
#>  8 2021-08-01  0.422  0.0143            0.422 
#>  9 2021-09-01  0.668  0.997             0.668 
#> 10 2021-10-01 -0.226  0.0106           -0.226 
```
