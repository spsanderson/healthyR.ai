# Get Distribution Data Helper

This function will return a tibble that can either be nested/unnested,
and grouped or ungrouped. The `.data` argument must be the output of the
[`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md)
function.

## Usage

``` r
hai_get_dist_data_tbl(.data, .unnest = TRUE, .group_data = FALSE)
```

## Arguments

- .data:

  The data from the
  [`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md)
  function as this function looks for a class of 'hai_dist_data'

- .unnest:

  Should the resulting tibble be unnested, a boolean value TRUE/FALSE.
  The default is TRUE

- .group_data:

  Shold the resulting tibble be grouped, a boolean value TRUE/FALSE. The
  default is FALSE

## Value

A tibble.

## Details

This function expects to take the output of the
[`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md)
function. It returns a tibble of the distribution and the randomly
generated data produced from the associated stats r function like
`rnorm`

## See also

Other Distribution Functions:
[`hai_distribution_comparison_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_distribution_comparison_tbl.md),
[`hai_get_density_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_get_density_data_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(dplyr)

df <- hai_scale_zero_one_vec(.x = mtcars$mpg) %>%
  hai_distribution_comparison_tbl()
hai_get_dist_data_tbl(df)
#> # A tibble: 96 × 2
#>    distribution dist_data
#>    <chr>            <dbl>
#>  1 gamma         0.211   
#>  2 gamma         0.0252  
#>  3 gamma         0.554   
#>  4 gamma         0.0646  
#>  5 gamma         0.0890  
#>  6 gamma         0.260   
#>  7 gamma         0.425   
#>  8 gamma         0.000101
#>  9 gamma         0.0466  
#> 10 gamma         0.269   
#> # ℹ 86 more rows
```
