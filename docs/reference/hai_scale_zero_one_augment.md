# Augment Function Scale Zero One

Takes a numeric vector and will return a vector that has been scaled
from `[0,1]`

## Usage

``` r
hai_scale_zero_one_augment(.data, .value, .names = "auto")
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

Takes a numeric vector and will return a vector that has been scaled
from `[0,1]` The input vector must be numeric. The computation is fairly
straightforward. This may be helpful when trying to compare the
distributions of data where a distribution like beta from the
`fitdistrplus` package which requires data to be between 0 and 1

\$\$y\[h\] = (x - min(x))/(max(x) - min(x))\$\$

This function is intended to be used on its own in order to add columns
to a tibble.

## See also

Other Augment Function:
[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
[`hai_hyperbolic_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_augment.md),
[`hai_polynomial_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_polynomial_augment.md),
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md),
[`hai_winsorized_move_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_augment.md),
[`hai_winsorized_truncate_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_augment.md)

Other Scale:
[`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md),
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md),
[`hai_scale_zscore_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_vec.md),
[`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
df <- data.frame(x = rnorm(100, 2, 1))
hai_scale_zero_one_augment(df, x)
#> # A tibble: 100 × 2
#>        x hai_scale_zero_one_x
#>    <dbl>                <dbl>
#>  1 2.25                 0.537
#>  2 3.93                 0.850
#>  3 2.61                 0.603
#>  4 2.26                 0.539
#>  5 2.94                 0.665
#>  6 3.78                 0.822
#>  7 2.76                 0.632
#>  8 0.603                0.231
#>  9 2.04                 0.498
#> 10 2.37                 0.559
#> # ℹ 90 more rows
```
