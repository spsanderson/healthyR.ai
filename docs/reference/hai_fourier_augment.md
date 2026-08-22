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
#>    date_col        a      b fourier_b_sin
#>    <date>      <dbl>  <dbl>         <dbl>
#>  1 2021-01-01  1.93  0.226         0.118 
#>  2 2021-02-01  0.378 0.340         0.177 
#>  3 2021-03-01  0.458 0.926         0.466 
#>  4 2021-04-01 -0.314 0.424         0.220 
#>  5 2021-05-01 -0.196 0.769         0.392 
#>  6 2021-06-01  0.532 0.355         0.185 
#>  7 2021-07-01 -1.30  0.146         0.0763
#>  8 2021-08-01 -0.116 0.0725        0.0380
#>  9 2021-09-01 -1.79  0.512         0.265 
#> 10 2021-10-01  1.04  0.551         0.285 
hai_fourier_augment(data_tbl, b, .period = 12, .order = 1, .scale_type = "cos")
#> # A tibble: 10 × 4
#>    date_col        a      b fourier_b_cos
#>    <date>      <dbl>  <dbl>         <dbl>
#>  1 2021-01-01  1.93  0.226          0.993
#>  2 2021-02-01  0.378 0.340          0.984
#>  3 2021-03-01  0.458 0.926          0.885
#>  4 2021-04-01 -0.314 0.424          0.975
#>  5 2021-05-01 -0.196 0.769          0.920
#>  6 2021-06-01  0.532 0.355          0.983
#>  7 2021-07-01 -1.30  0.146          0.997
#>  8 2021-08-01 -0.116 0.0725         0.999
#>  9 2021-09-01 -1.79  0.512          0.964
#> 10 2021-10-01  1.04  0.551          0.959
```
