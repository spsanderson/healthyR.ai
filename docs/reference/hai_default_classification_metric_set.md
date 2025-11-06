# Metric Set

Default classification metric sets from `yardstick`

## Usage

``` r
hai_default_classification_metric_set()
```

## Value

A yardstick metric set tibble

## Details

Default classification metric sets from `yardstick`

## See also

Other Default Metric Sets:
[`hai_default_regression_metric_set()`](https://www.spsanderson.com/healthyR.ai/reference/hai_default_regression_metric_set.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
hai_default_classification_metric_set()
#> A metric set, consisting of:
#> - `sensitivity()`, a class metric  | direction: maximize
#> - `specificity()`, a class metric  | direction: maximize
#> - `recall()`, a class metric       | direction: maximize
#> - `precision()`, a class metric    | direction: maximize
#> - `mcc()`, a class metric          | direction: maximize
#> - `accuracy()`, a class metric     | direction: maximize
#> - `f_meas()`, a class metric       | direction: maximize
#> - `kap()`, a class metric          | direction: maximize
#> - `ppv()`, a class metric          | direction: maximize
#> - `npv()`, a class metric          | direction: maximize
#> - `bal_accuracy()`, a class metric | direction: maximize
```
