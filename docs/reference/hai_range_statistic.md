# Get the range statistic

Takes in a numeric vector and returns back the range of that vector

## Usage

``` r
hai_range_statistic(.x)
```

## Arguments

- .x:

  A numeric vector

## Value

A single number, the range statistic

## Details

Takes in a numeric vector and returns the range of that vector using the
`diff` and `range` functions.

## Author

Steven P. Sandeson II, MPH

## Examples

``` r
hai_range_statistic(seq(1:10))
#> [1] 9
```
