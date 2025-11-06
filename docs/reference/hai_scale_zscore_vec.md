# Vector Function Scale to Zero and One

Takes a numeric vector and will return a vector that has been scaled
from by mean and standard deviation

## Usage

``` r
hai_scale_zscore_vec(.x)
```

## Arguments

- .x:

  A numeric vector to be scaled by mean and standard deviation
  inclusive.

## Value

A numeric vector

## Details

Takes a numeric vector and will return a vector that has been scaled
from mean and standard deviation.

The input vector must be numeric. The computation is fairly
straightforward. This may be helpful when trying to compare the
distributions of data where a distribution like beta from the
`fitdistrplus` package which requires data to be between 0 and 1

\$\$y\[h\] = (x - mean(x) / sd(x))\$\$

This function can be used on it's own. It is also the basis for the
function
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md).

## See also

Other Vector Function:
[`hai_fourier_discrete_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_vec.md),
[`hai_fourier_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_vec.md),
[`hai_hyperbolic_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_vec.md),
[`hai_kurtosis_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kurtosis_vec.md),
[`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md),
[`hai_skewness_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_skewness_vec.md),
[`hai_winsorized_move_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_vec.md),
[`hai_winsorized_truncate_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_vec.md)

Other Scale:
[`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md),
[`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md),
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md),
[`step_hai_scale_zscore()`](https://www.spsanderson.com/healthyR.ai/reference/step_hai_scale_zscore.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
vec_1 <- mtcars$mpg
vec_2 <- hai_scale_zscore_vec(vec_1)

ax <- pretty(min(vec_1, vec_2):max(vec_1, vec_2), n = 12)

hist(vec_1, breaks = ax, col = "blue")
hist(vec_2, breaks = ax, col = "red", add = TRUE)

```
