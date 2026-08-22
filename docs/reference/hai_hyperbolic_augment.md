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
#>    date_col         a     b hyperbolic_b_sin
#>    <date>       <dbl> <dbl>            <dbl>
#>  1 2021-01-01  1.14   0.695            0.641
#>  2 2021-02-01 -0.222  0.120            0.120
#>  3 2021-03-01 -0.208  0.885            0.774
#>  4 2021-04-01  0.750  0.742            0.676
#>  5 2021-05-01  0.118  0.852            0.753
#>  6 2021-06-01  0.0990 0.572            0.541
#>  7 2021-07-01  1.36   0.764            0.692
#>  8 2021-08-01 -0.839  0.716            0.656
#>  9 2021-09-01 -1.06   0.693            0.638
#> 10 2021-10-01  2.11   0.667            0.618
hai_hyperbolic_augment(data_tbl, b, .scale_type = "tan")
#> # A tibble: 10 × 4
#>    date_col         a     b hyperbolic_b_tan
#>    <date>       <dbl> <dbl>            <dbl>
#>  1 2021-01-01  1.14   0.695            0.834
#>  2 2021-02-01 -0.222  0.120            0.120
#>  3 2021-03-01 -0.208  0.885            1.22 
#>  4 2021-04-01  0.750  0.742            0.917
#>  5 2021-05-01  0.118  0.852            1.14 
#>  6 2021-06-01  0.0990 0.572            0.644
#>  7 2021-07-01  1.36   0.764            0.959
#>  8 2021-08-01 -0.839  0.716            0.870
#>  9 2021-09-01 -1.06   0.693            0.830
#> 10 2021-10-01  2.11   0.667            0.787
```
