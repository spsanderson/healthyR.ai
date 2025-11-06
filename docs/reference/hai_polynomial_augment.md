# Augment Polynomial Features

This function takes in a data table and a predictor column. A user can
either create their own formula using the `.formula` parameter or, if
they leave the default of `NULL` then the user must enter a `.degree`
**AND** `.pred_col` column.

## Usage

``` r
hai_polynomial_augment(
  .data,
  .formula = NULL,
  .pred_col = NULL,
  .degree = 1,
  .new_col_prefix = "nt_"
)
```

## Arguments

- .data:

  The data being passed that will be augmented by the function.

- .formula:

  This should be a valid formula like 'y ~ .^2' or NULL.

- .pred_col:

  This is passed
  [`rlang::enquo()`](https://rlang.r-lib.org/reference/enquo.html) to
  capture the vector that you designate as the 'y' column.

- .degree:

  This should be an integer and is used to set the degree in the poly
  function. The degree must be less than the unique data points or it
  will error out.

- .new_col_prefix:

  The default is "nt\_" which stands for "new_term". You can set this to
  whatever you like, as long as it is a quoted string.

## Value

An augmented tibble

## Details

A valid data.frame/tibble must be passed to this function. It is
required that a user either enter a `.formula` or a `.degree` **AND**
`.pred_col` otherwise this function will stop and error out.

Under the hood this function will create a
[`stats::poly()`](https://rdrr.io/r/stats/poly.html) function if the
`.formula` is left as `NULL`. For example:

- .formula = A ~ .^2

- OR .degree = 2, .pred_col = A

There is also a parameter `.new_col_prefix` which will add a character
string to the column names so that they are easily identified further
down the line. The default is 'nt\_'

## See also

Other Augment Function:
[`hai_fourier_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_augment.md),
[`hai_fourier_discrete_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_fourier_discrete_augment.md),
[`hai_hyperbolic_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_hyperbolic_augment.md),
[`hai_scale_zero_one_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zero_one_augment.md),
[`hai_scale_zscore_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_scale_zscore_augment.md),
[`hai_winsorized_move_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_move_augment.md),
[`hai_winsorized_truncate_augment()`](https://www.spsanderson.com/healthyR.ai/reference/hai_winsorized_truncate_augment.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
suppressPackageStartupMessages(library(dplyr))
data_tbl <- data.frame(
  A = c(0, 2, 4),
  B = c(1, 3, 5),
  C = c(2, 4, 6)
)

hai_polynomial_augment(.data = data_tbl, .pred_col = A, .degree = 2, .new_col_prefix = "n")
#> The formula used is: A ~ poly(B, 2) + poly(C, 2)
#> # A tibble: 3 × 8
#>       A     B     C nintercept npoly_b_2_1 npoly_b_2_2 npoly_c_2_1 npoly_c_2_2
#>   <dbl> <dbl> <dbl>      <dbl>       <dbl>       <dbl>       <dbl>       <dbl>
#> 1     0     1     2          1   -7.07e- 1       0.408   -7.07e- 1       0.408
#> 2     2     3     4          1   -7.85e-17      -0.816   -7.85e-17      -0.816
#> 3     4     5     6          1    7.07e- 1       0.408    7.07e- 1       0.408
hai_polynomial_augment(.data = data_tbl, .formula = A ~ .^2, .degree = 1)
#> The formula used is: A ~ .^2
#> # A tibble: 3 × 7
#>       A     B     C nt_intercept  nt_b  nt_c nt_b_c
#>   <dbl> <dbl> <dbl>        <dbl> <dbl> <dbl>  <dbl>
#> 1     0     1     2            1     1     2      2
#> 2     2     3     4            1     3     4     12
#> 3     4     5     6            1     5     6     30
```
