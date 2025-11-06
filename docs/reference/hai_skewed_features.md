# Get Skewed Feature Columns

Takes in a data.frame/tibble and returns a vector of names of the
columns that are skewed.

## Usage

``` r
hai_skewed_features(.data, .threshold = 0.6, .drop_keys = NULL)
```

## Arguments

- .data:

  The data.frame/tibble you are passing in.

- .threshold:

  A level of skewness that indicates where you feel a column should be
  considered skewed.

- .drop_keys:

  A c() character vector of columns you do not want passed to the
  function.

## Value

A character vector of column names that are skewed.

## Details

Takes in a data.frame/tibble and returns a vector of names of the skewed
columns. There are two other parameters. The first is the `.threshold`
parameter that is set to the level of skewness you want in order to
consider the column too skewed. The second is `.drop_keys`, these are
columns you don't want to be considered for whatever reason in the
skewness calculation.

## Author

Steven P. Sandeson II, MPH

## Examples

``` r
hai_skewed_features(mtcars)
#> [1] "mpg"  "hp"   "carb"
hai_skewed_features(mtcars, .drop_keys = c("mpg", "hp"))
#> [1] "carb"
hai_skewed_features(mtcars, .drop_keys = "hp")
#> [1] "mpg"  "carb"
```
