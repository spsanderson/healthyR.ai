# Augment Function Winsorize Truncate

Takes a numeric vector and will return a tibble with the winsorized
values.

## Usage

``` r
hai_winsorized_truncate_augment(.data, .value, .fraction, .names = "auto")
```

## Arguments

- .data:

  The data being passed that will be augmented by the function.

- .value:

  This is passed
  [`rlang::enquo()`](https://rlang.r-lib.org/reference/enquo.html) to
  capture the vectors you want to augment.

- .fraction:

  A positive fractional between 0 and 0.5 that is passed to the
  [`stats::quantile`](https://rdrr.io/r/stats/quantile.html) paramater
  of `probs`.

- .names:

  The default is "auto"

## Value

An augmented tibble

## Details

Takes a numeric vector and will return a winsorized vector of values
that have been truncated if they are less than or greater than some
defined fraction of a quantile. The intent of winsorization is to limit
the effect of extreme values.

## See also

<https://en.wikipedia.org/wiki/Winsorizing>

Other Augment Function:
[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
[`hai_hyperbolic_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_augment.md),
[`hai_polynomial_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_polynomial_augment.md),
[`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md),
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md),
[`hai_winsorized_move_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_augment.md)

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

hai_winsorized_truncate_augment(data_tbl, a, .fraction = 0.05)
#> # A tibble: 24 × 4
#>    date_col         a     b winsor_trunc_a
#>    <date>       <dbl> <dbl>          <dbl>
#>  1 2021-01-01 -0.127  0.364        -0.127 
#>  2 2021-02-01  0.0346 0.897         0.0346
#>  3 2021-03-01  0.363  0.612         0.363 
#>  4 2021-04-01  0.0358 0.801         0.0358
#>  5 2021-05-01  0.681  0.771         0.681 
#>  6 2021-06-01  1.14   0.709         1.14  
#>  7 2021-07-01  1.24   0.903         1.24  
#>  8 2021-08-01 -0.234  0.325        -0.234 
#>  9 2021-09-01 -0.358  0.830        -0.358 
#> 10 2021-10-01  0.173  0.907         0.173 
#> # ℹ 14 more rows
```
