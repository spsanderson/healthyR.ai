# Compute Kurtosis of a Vector

This function takes in a vector as it's input and will return the
kurtosis of that vector. The length of this vector must be at least four
numbers. The kurtosis explains the sharpness of the peak of a
distribution of data.

`((1/n) * sum(x - mu})^4) / ((()1/n) * sum(x - mu)^2)^2`

## Usage

``` r
hai_kurtosis_vec(.x)
```

## Arguments

- .x:

  A numeric vector of length four or more.

## Value

The kurtosis of a vector

## Details

A function to return the kurtosis of a vector.

## See also

<https://en.wikipedia.org/wiki/Kurtosis>

Other Vector Function:
[`hai_fourier_discrete_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_vec.md),
[`hai_fourier_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_vec.md),
[`hai_hyperbolic_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_vec.md),
[`hai_scale_zero_one_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_vec.md),
[`hai_scale_zscore_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_vec.md),
[`hai_skewness_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_skewness_vec.md),
[`hai_winsorized_move_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_vec.md),
[`hai_winsorized_truncate_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_vec.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
hai_kurtosis_vec(rnorm(100, 3, 2))
#> [1] 2.720724
```
