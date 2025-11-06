# Augment Function Fourier Discrete

Takes a numeric vector(s) or date and will return a tibble of one of the
following:

- "sin"

- "cos"

- "sincos"

- c("sin","cos","sincos") When either of these values falls below zero,
  then zero else one

## Usage

``` r
hai_fourier_discrete_augment(
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

Takes a numeric vector or a date and will return a vector of one of the
following:

- "sin"

- "cos"

- "sincos"

- c("sin","cos","sincos")

This function is intended to be used on its own in order to add columns
to a tibble.

## See also

Other Augment Function:
[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),
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

len_out <- 24
by_unit <- "month"
start_date <- as.Date("2021-01-01")

data_tbl <- tibble(
  date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
  a = rnorm(len_out),
  b = runif(len_out)
)

hai_fourier_discrete_augment(data_tbl, b, .period = 2 * 12, .order = 1, .scale_type = "sin")
#> # A tibble: 24 × 4
#>    date_col        a     b fourier_discrete_b_sin
#>    <date>      <dbl> <dbl>                  <dbl>
#>  1 2021-01-01 -2.27  0.450                      1
#>  2 2021-02-01 -1.27  0.837                      1
#>  3 2021-03-01  0.635 0.501                      1
#>  4 2021-04-01  0.280 0.535                      1
#>  5 2021-05-01  1.10  0.187                      1
#>  6 2021-06-01  0.636 0.681                      1
#>  7 2021-07-01  0.839 0.952                      1
#>  8 2021-08-01 -0.350 0.186                      1
#>  9 2021-09-01  1.10  0.281                      1
#> 10 2021-10-01 -0.276 0.501                      1
#> # ℹ 14 more rows
hai_fourier_discrete_augment(data_tbl, b, .period = 2 * 12, .order = 1, .scale_type = "cos")
#> # A tibble: 24 × 4
#>    date_col        a     b fourier_discrete_b_cos
#>    <date>      <dbl> <dbl>                  <dbl>
#>  1 2021-01-01 -2.27  0.450                      1
#>  2 2021-02-01 -1.27  0.837                      1
#>  3 2021-03-01  0.635 0.501                      1
#>  4 2021-04-01  0.280 0.535                      1
#>  5 2021-05-01  1.10  0.187                      1
#>  6 2021-06-01  0.636 0.681                      1
#>  7 2021-07-01  0.839 0.952                      1
#>  8 2021-08-01 -0.350 0.186                      1
#>  9 2021-09-01  1.10  0.281                      1
#> 10 2021-10-01 -0.276 0.501                      1
#> # ℹ 14 more rows
```
