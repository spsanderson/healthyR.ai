# Vector Function Discrete Fourier

Takes a numeric vector or date and will return a vector of one of the
following:

- "sin"

- "cos"

- "sincos" This will do value = sin(x) \* cos(x) When either of these
  values falls below zero, then zero else one

## Usage

``` r
hai_fourier_discrete_vec(
  .x,
  .period,
  .order,
  .scale_type = c("sin", "cos", "sincos")
)
```

## Arguments

- .x:

  A numeric vector

- .period:

  The number of observations that complete a cycle

- .order:

  The fourier term order

- .scale_type:

  A character of one of the following: "sin","cos","sincos"

## Value

A numeric vector of 1's and 0's

## Details

Takes a numeric vector or date and will return a vector of one of the
following:

- "sin"

- "cos"

- "sincos"

The internal caluclation is straightforward:

- `sin = sin(2 * pi * h * x)`, where `h = .order/.period`

- `cos = cos(2 * pi * h * x)`, where `h = .order/.period`

- `sincos = sin(2 * pi * h * x) * cos(2 * pi * h * x)` where
  `h = .order/.period`

This function can be used on its own. It is also the basis for the
function
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md).

## See also

Other Vector Function:
[`hai_fourier_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_vec.md),
[`hai_hyperbolic_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_vec.md),
[`hai_kurtosis_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kurtosis_vec.md),
[`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md),
[`hai_scale_zscore_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_vec.md),
[`hai_skewness_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_skewness_vec.md),
[`hai_winsorized_move_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_vec.md),
[`hai_winsorized_truncate_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_vec.md)

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

vec_1 <- hai_fourier_discrete_vec(data_tbl$a, .period = 12, .order = 1, .scale_type = "sin")
vec_2 <- hai_fourier_discrete_vec(data_tbl$a, .period = 12, .order = 1, .scale_type = "cos")
vec_3 <- hai_fourier_discrete_vec(data_tbl$a, .period = 12, .order = 1, .scale_type = "sincos")

plot(data_tbl$b)
lines(vec_1, col = "blue")
lines(vec_2, col = "red")
lines(vec_3, col = "green")

```
