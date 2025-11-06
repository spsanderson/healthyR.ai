# Augment Function Winsorize Move

Takes a numeric vector and will return a tibble with the winsorized
values.

## Usage

``` r
hai_winsorized_move_augment(.data, .value, .multiple, .names = "auto")
```

## Arguments

- .data:

  The data being passed that will be augmented by the function.

- .value:

  This is passed
  [`rlang::enquo()`](https://rlang.r-lib.org/reference/enquo.html) to
  capture the vectors you want to augment.

- .multiple:

  A positive number indicating how many times the the zero center mean
  absolute deviation should be multiplied by for the scaling parameter.

- .names:

  The default is "auto"

## Value

An augmented tibble

## Details

Takes a numeric vector and will return a winsorized vector of values
that have been moved some multiple from the mean absolute deviation zero
center of some vector. The intent of winsorization is to limit the
effect of extreme values.

## See also

<https://en.wikipedia.org/wiki/Winsorizing>

Other Augment Function:
[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
[`hai_hyperbolic_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_augment.md),
[`hai_polynomial_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_polynomial_augment.md),
[`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md),
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md),
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

hai_winsorized_move_augment(data_tbl, a, .multiple = 3)
#> # A tibble: 24 × 4
#>    date_col        a       b winsor_scale_a
#>    <date>      <dbl>   <dbl>          <dbl>
#>  1 2021-01-01  0.115 0.231            0.115
#>  2 2021-02-01  1.33  0.861            1.33 
#>  3 2021-03-01  1.13  0.447            1.13 
#>  4 2021-04-01 -1.38  0.00849         -1.38 
#>  5 2021-05-01 -0.843 0.879           -0.843
#>  6 2021-06-01  1.26  0.809            1.26 
#>  7 2021-07-01 -1.25  0.371           -1.25 
#>  8 2021-08-01  0.390 0.0133           0.390
#>  9 2021-09-01 -0.234 0.814           -0.234
#> 10 2021-10-01  0.185 0.644            0.185
#> # ℹ 14 more rows
```
