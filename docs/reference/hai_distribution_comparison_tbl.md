# Compare Data Against Distributions

This function will attempt to get some key information on the data you
pass to it. It will also automatically normalize the data from 0 to 1.
This will not change the distribution just it's scale in order to make
sure that many different types of distributions can be fit to the data,
which should help identify what the distribution of the passed data
could be.

The resulting output has attributes added to it that get used in other
functions that are meant to compliment each other.

This function will automatically pass the `.x` parameter to
[`hai_skewness_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_skewness_vec.md)
and
[`hai_kurtosis_vec()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kurtosis_vec.md)
in order to help create the random data from the distributions.

The distributions that can be chosen from are:

|                |               |
|----------------|---------------|
| Distribution   | R stats::dist |
| normal         | rnorm         |
| uniform        | runif         |
| exponential    | rexp          |
| logistic       | rlogis        |
| beta           | rbeta         |
| lognormal      | rlnorm        |
| gamma          | rgamma        |
| weibull        | weibull       |
| chisquare      | rchisq        |
| cauchy         | rcauchy       |
| hypergeometric | rhyper        |
| f              | rf            |
| poisson        | rpois         |

## Usage

``` r
hai_distribution_comparison_tbl(
  .x,
  .distributions = c("gamma", "beta"),
  .normalize = TRUE
)
```

## Arguments

- .x:

  The numeric vector to analyze.

- .distributions:

  A character vector of distributions to check. For example,
  c("gamma","beta")

- .normalize:

  A boolean value of TRUE/FALSE, the default is TRUE. This will
  normalize the data using the `hai_scale_zero_one_vec` function.

## Value

A tibble.

## Details

Get information on the empirical distribution of your data along with
generated densities of other distributions. This information is in the
resulting tibble that is generated. Three columns will generate,
Distribution, from the `param .distributions`, `dist_data` which is a
list vector of density values passed to the underlying stats r
distribution function, and `density_data`, which is the `dist_data`
column passed to `list(stats::density(unlist(dist_data)))`

This has the effect of giving you the desired vector that can be used in
resultant plots (`dist_data`) or you can interact with the `density`
object itself.

If the skewness of the distribution is negative, then for the gamma and
beta distributions the skew is set equal to the kurtosis and the
kurtosis is set equal to `sqrt((skew)^2)`

## See also

Other Distribution Functions:
[`hai_get_density_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_get_density_data_tbl.md),
[`hai_get_dist_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_get_dist_data_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
x_vec <- hai_scale_zero_one_vec(mtcars$mpg)
df <- hai_distribution_comparison_tbl(
  .x = x_vec,
  .distributions = c("beta", "gamma")
)
df
#> # A tibble: 3 × 3
#>   distribution dist_data  density_data
#>   <chr>        <list>     <list>      
#> 1 beta         <dbl [32]> <density>   
#> 2 gamma        <dbl [32]> <density>   
#> 3 empirical    <dbl [32]> <density>   
```
