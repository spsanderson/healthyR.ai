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
#>    date_col        a     b winsor_scale_a
#>    <date>      <dbl> <dbl>          <dbl>
#>  1 2021-01-01  0.715 0.534          0.715
#>  2 2021-02-01  0.360 0.163          0.360
#>  3 2021-03-01  0.785 0.399          0.785
#>  4 2021-04-01 -1.36  0.257         -1.36 
#>  5 2021-05-01 -1.62  0.672         -1.62 
#>  6 2021-06-01  0.781 0.162          0.781
#>  7 2021-07-01 -0.324 0.584         -0.324
#>  8 2021-08-01 -0.256 0.957         -0.256
#>  9 2021-09-01 -0.772 0.983         -0.772
#> 10 2021-10-01  1.000 0.705          1.000
#> # ℹ 14 more rows
```
