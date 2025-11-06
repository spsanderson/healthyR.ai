# Augment Function Scale Zero One

Takes a numeric vector and will return a vector that has been scaled by
mean and standard deviation

## Usage

``` r
hai_scale_zscore_augment(.data, .value, .names = "auto")
```

## Arguments

- .data:

  The data being passed that will be augmented by the function.

- .value:

  This is passed
  [`rlang::enquo()`](https://rlang.r-lib.org/reference/enquo.html) to
  capture the vectors you want to augment.

- .names:

  This is set to 'auto' by default but can be a user supplied character
  string.

## Value

An augmented tibble

## Details

Takes a numeric vector and will return a vector that has been scaled by
mean and standard deviation.

The input vector must be numeric. The computation is fairly
straightforward. This may be helpful when trying to compare the
distributions of data where a distribution like beta from the
`fitdistrplus` package which requires data to be between 0 and 1

\$\$y\[h\] = (x - mean(x) / sd(x))\$\$

This function is intended to be used on its own in order to add columns
to a tibble.

## See also

Other Augment Function:
[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
[`hai_hyperbolic_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_augment.md),
[`hai_polynomial_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_polynomial_augment.md),
[`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md),
[`hai_winsorized_move_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_augment.md),
[`hai_winsorized_truncate_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_augment.md)

Other Scale:
[`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md),
[`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md),
[`hai_scale_zscore_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_vec.md),
[`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
df <- data.frame(x = mtcars$mpg)
hai_scale_zscore_augment(df, x)
#> # A tibble: 32 × 2
#>        x hai_scale_zscore_x
#>    <dbl>              <dbl>
#>  1  21                0.151
#>  2  21                0.151
#>  3  22.8              0.450
#>  4  21.4              0.217
#>  5  18.7             -0.231
#>  6  18.1             -0.330
#>  7  14.3             -0.961
#>  8  24.4              0.715
#>  9  22.8              0.450
#> 10  19.2             -0.148
#> # ℹ 22 more rows
```
