# Augment Function Fourier

Takes a numeric vector(s) or date and will return a tibble of one of the
following:

- "sin"

- "cos"

- "sincos"

- c("sin","cos","sincos")

## Usage

``` r
hai_fourier_augment(
  .data,
  .value,
  .period,
  .order,
  .names = "auto",
  .scale_type = c("sin", "cos", "sincos")
)
```

## Arguments

- .data:

  The data being passed that will be augmented by the function.

- .value:

  This is passed
  [`rlang::enquo()`](https://rlang.r-lib.org/reference/enquo.html) to
  capture the vectors you want to augment.

- .period:

  The number of observations that complete a cycle

- .order:

  The fourier term order

- .names:

  The default is "auto"

- .scale_type:

  A character of one of the following: "sin","cos", or sincos" All can
  be passed by setting the param equal to c("sin","cos","sincos")

## Value

A augmented tibble

## Details

Takes a numeric vector or date and will return a vector of one of the
following:

- "sin"

- "cos"

- "sincos"

- c("sin","cos","sincos")

This function is intended to be used on its own in order to add columns
to a tibble.

## See also

Other Augment Function:
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
[`hai_hyperbolic_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_augment.md),
[`hai_polynomial_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_polynomial_augment.md),
[`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md),
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md),
[`hai_winsorized_move_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_augment.md),
[`hai_winsorized_truncate_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_augment.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
suppressPackageStartupMessages(library(dplyr))

len_out <- 10
by_unit <- "month"
start_date <- as.Date("2021-01-01")

data_tbl <- tibble(
  date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
  a = rnorm(len_out),
  b = runif(len_out)
)

hai_fourier_augment(data_tbl, b, .period = 12, .order = 1, .scale_type = "sin")
#> # A tibble: 10 × 4
#>    date_col         a      b fourier_b_sin
#>    <date>       <dbl>  <dbl>         <dbl>
#>  1 2021-01-01 -0.638  0.986         0.494 
#>  2 2021-02-01 -0.985  0.0855        0.0448
#>  3 2021-03-01 -2.11   0.624         0.321 
#>  4 2021-04-01 -0.0435 0.173         0.0905
#>  5 2021-05-01  0.905  0.513         0.265 
#>  6 2021-06-01 -2.17   0.770         0.392 
#>  7 2021-07-01 -0.918  0.562         0.290 
#>  8 2021-08-01  0.103  0.509         0.263 
#>  9 2021-09-01  0.0778 0.0516        0.0270
#> 10 2021-10-01 -0.548  0.708         0.362 
hai_fourier_augment(data_tbl, b, .period = 12, .order = 1, .scale_type = "cos")
#> # A tibble: 10 × 4
#>    date_col         a      b fourier_b_cos
#>    <date>       <dbl>  <dbl>         <dbl>
#>  1 2021-01-01 -0.638  0.986          0.870
#>  2 2021-02-01 -0.985  0.0855         0.999
#>  3 2021-03-01 -2.11   0.624          0.947
#>  4 2021-04-01 -0.0435 0.173          0.996
#>  5 2021-05-01  0.905  0.513          0.964
#>  6 2021-06-01 -2.17   0.770          0.920
#>  7 2021-07-01 -0.918  0.562          0.957
#>  8 2021-08-01  0.103  0.509          0.965
#>  9 2021-09-01  0.0778 0.0516         1.000
#> 10 2021-10-01 -0.548  0.708          0.932
```
