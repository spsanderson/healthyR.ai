# Vector Function Winsorize Move

Takes a numeric vector and will return a vector of winsorized values.

## Usage

``` r
hai_winsorized_move_vec(.x, .multiple = 3)
```

## Arguments

- .x:

  A numeric vector

- .multiple:

  A positive number indicating how many times the the zero center mean
  absolute deviation should be multiplied by for the scaling parameter.

## Value

A numeric vector

## Details

Takes a numeric vector and will return a winsorized vector of values
that have been moved some multiple from the mean absolute deviation zero
center of some vector. The intent of winsorization is to limit the
effect of extreme values.

## See also

<https://en.wikipedia.org/wiki/Winsorizing>

This function can be used on it's own. It is also the basis for the
function
[`hai_winsorized_move_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_augment.md).

Other Vector Function:
[`hai_fourier_discrete_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_vec.md),
[`hai_fourier_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_vec.md),
[`hai_hyperbolic_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_vec.md),
[`hai_kurtosis_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kurtosis_vec.md),
[`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md),
[`hai_scale_zscore_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_vec.md),
[`hai_skewness_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_skewness_vec.md),
[`hai_winsorized_truncate_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
suppressPackageStartupMessages(library(dplyr))

len_out <- 25
by_unit <- "month"
start_date <- as.Date("2021-01-01")

data_tbl <- tibble(
  date_col = seq.Date(from = start_date, length.out = len_out, by = by_unit),
  a = rnorm(len_out),
  b = runif(len_out)
)

vec_1 <- hai_winsorized_move_vec(data_tbl$a, .multiple = 1)

plot(data_tbl$a)
lines(data_tbl$a)
lines(vec_1, col = "blue")

```
