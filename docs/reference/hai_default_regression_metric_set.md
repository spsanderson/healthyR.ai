# Metric Set

Default regression metric sets from `yardstick`

## Usage

``` r
hai_default_regression_metric_set()
```

## Value

A yardstick metric set tibble

## Details

Default regression metric sets from `yardstick`

## See also

Other Default Metric Sets:
[`hai_default_classification_metric_set()`](https://www.spsanderson.com/healthyR.ai/reference/hai_default_classification_metric_set.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
hai_default_regression_metric_set()
#> A metric set, consisting of:
#> - `mae()`, a numeric metric   | direction: minimize
#> - `mape()`, a numeric metric  | direction: minimize
#> - `mase()`, a numeric metric  | direction: minimize
#> - `smape()`, a numeric metric | direction: minimize
#> - `rmse()`, a numeric metric  | direction: minimize
#> - `rsq()`, a numeric metric   | direction: maximize
```
