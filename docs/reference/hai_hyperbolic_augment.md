# Augment Function Hyperbolic

Takes a numeric vector(s) or date and will return a tibble of one of the
following:

- "sin"

- "cos"

- "tan"

- "sincos"

- c("sin","cos","tan", "sincos")

## Usage

``` r
hai_hyperbolic_augment(
  .data,
  .value,
  .names = "auto",
  .scale_type = c("sin", "cos", "tan", "sincos")
)
```

## Arguments

- .data:

  The data being passed that will be augmented by the function.

- .value:

  This is passed
  [`rlang::enquo()`](https://rlang.r-lib.org/reference/enquo.html) to
  capture the vectors you want to augment.

- .names:

  The default is "auto"

- .scale_type:

  A character of one of the following: "sin","cos","tan", "sincos" All
  can be passed by setting the param equal to
  c("sin","cos","tan","sincos")

## Value

A augmented tibble

## Details

Takes a numeric vector or date and will return a vector of one of the
following:

- "sin"

- "cos"

- "tan"

- "sincos"

- c("sin","cos","tan", "sincos")

This function is intended to be used on its own in order to add columns
to a tibble.

## See also

Other Augment Function:
[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
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

hai_hyperbolic_augment(data_tbl, b, .scale_type = "sin")
#> # A tibble: 10 × 4
#>    date_col        a      b hyperbolic_b_sin
#>    <date>      <dbl>  <dbl>            <dbl>
#>  1 2021-01-01 -0.156 0.660            0.613 
#>  2 2021-02-01 -1.27  0.0942           0.0941
#>  3 2021-03-01 -0.270 0.0682           0.0681
#>  4 2021-04-01 -0.389 0.134            0.133 
#>  5 2021-05-01 -1.11  0.378            0.369 
#>  6 2021-06-01 -0.658 0.522            0.499 
#>  7 2021-07-01  3.24  0.0510           0.0510
#>  8 2021-08-01 -0.180 0.194            0.193 
#>  9 2021-09-01 -0.176 0.396            0.385 
#> 10 2021-10-01  0.378 0.824            0.734 
hai_hyperbolic_augment(data_tbl, b, .scale_type = "tan")
#> # A tibble: 10 × 4
#>    date_col        a      b hyperbolic_b_tan
#>    <date>      <dbl>  <dbl>            <dbl>
#>  1 2021-01-01 -0.156 0.660            0.776 
#>  2 2021-02-01 -1.27  0.0942           0.0945
#>  3 2021-03-01 -0.270 0.0682           0.0683
#>  4 2021-04-01 -0.389 0.134            0.134 
#>  5 2021-05-01 -1.11  0.378            0.397 
#>  6 2021-06-01 -0.658 0.522            0.575 
#>  7 2021-07-01  3.24  0.0510           0.0511
#>  8 2021-08-01 -0.180 0.194            0.197 
#>  9 2021-09-01 -0.176 0.396            0.418 
#> 10 2021-10-01  0.378 0.824            1.08  
```
