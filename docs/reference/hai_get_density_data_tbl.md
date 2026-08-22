# Get Density Data Helper

This function will return a tibble that can either be nested/unnested,
and grouped or un-grouped. The `.data` argument must be the output of
the
[`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md)
function.

## Usage

``` r
hai_get_density_data_tbl(.data, .unnest = TRUE, .group_data = TRUE)
```

## Arguments

- .data:

  The data from the
  [`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md)
  function as this function looks for an attribute of
  `hai_dist_compare_tbl`

- .unnest:

  Should the resulting tibble be un-nested, a Boolean value TRUE/FALSE.
  The default is TRUE

- .group_data:

  Should the resulting tibble be grouped, a Boolean value TRUE/FALSE.
  The default is FALSE

## Value

A tibble.

## Details

This function expects to take the output of the
[`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md)
function. It returns a tibble of the `tidy` density data.

## See also

Other Distribution Functions:
[`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md),
[`hai_get_dist_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_get_dist_data_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)

df <- hai_scale_zero_one_vec(.x = mtcars$mpg) |>
  hai_distribution_comparison_tbl()
hai_get_density_data_tbl(df)
#> # A tibble: 1,536 × 3
#> # Groups:   distribution [3]
#>    distribution      x       y
#>    <chr>         <dbl>   <dbl>
#>  1 gamma        -0.268 0.00903
#>  2 gamma        -0.262 0.0112 
#>  3 gamma        -0.256 0.0138 
#>  4 gamma        -0.249 0.0169 
#>  5 gamma        -0.243 0.0208 
#>  6 gamma        -0.237 0.0254 
#>  7 gamma        -0.231 0.0308 
#>  8 gamma        -0.225 0.0371 
#>  9 gamma        -0.219 0.0445 
#> 10 gamma        -0.213 0.0534 
#> # ℹ 1,526 more rows
```
