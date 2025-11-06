# K-Means User Item Tibble

Takes in a data.frame/tibble and transforms it into an
aggregated/normalized user-item tibble of proportions. The user will
need to input the parameters for the rows/user and the columns/items.

## Usage

``` r
hai_kmeans_user_item_tbl(.data, .row_input, .col_input, .record_input)

kmeans_user_item_tbl(.data, .row_input, .col_input, .record_input)
```

## Arguments

- .data:

  The data that you want to transform

- .row_input:

  The column that is going to be the row (user)

- .col_input:

  The column that is going to be the column (item)

- .record_input:

  The column that is going to be summed up for the aggregation and
  normalization process.

## Value

A aggregated/normalized user item tibble

## Details

This function should be used before using a k-mean model. This is
commonly referred to as a user-item matrix because "users" tend to be on
the rows and "items" (e.g. orders) on the columns. You must supply a
column that can be summed for the aggregation and normalization process
to occur.

## See also

Other Kmeans:
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md),
[`hai_kmeans_automl_predict()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl_predict.md),
[`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md),
[`hai_kmeans_obj()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_obj.md),
[`hai_kmeans_scree_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_data_tbl.md),
[`hai_kmeans_scree_plt()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_plt.md),
[`hai_kmeans_tidy_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_tidy_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(healthyR.data)
library(dplyr)

data_tbl <- healthyR_data %>%
  filter(ip_op_flag == "I") %>%
  filter(payer_grouping != "Medicare B") %>%
  filter(payer_grouping != "?") %>%
  select(service_line, payer_grouping) %>%
  mutate(record = 1) %>%
  as_tibble()

hai_kmeans_user_item_tbl(
  .data = data_tbl,
  .row_input = service_line,
  .col_input = payer_grouping,
  .record_input = record
)
#> # A tibble: 23 × 12
#>    service_line     `Blue Cross` Commercial Compensation `Exchange Plans`    HMO
#>    <chr>                   <dbl>      <dbl>        <dbl>            <dbl>  <dbl>
#>  1 Alcohol Abuse          0.0941    0.0321      0.000525          0.0116  0.0788
#>  2 Bariatric Surge…       0.317     0.0583      0                 0.0518  0.168 
#>  3 CHF                    0.0295    0.00958     0.000518          0.00414 0.0205
#>  4 COPD                   0.0493    0.0228      0.000228          0.00548 0.0342
#>  5 CVA                    0.0647    0.0246      0.00107           0.0107  0.0524
#>  6 Carotid Endarte…       0.0845    0.0282      0                 0       0.0141
#>  7 Cellulitis             0.110     0.0339      0.0118            0.00847 0.0805
#>  8 Chest Pain             0.144     0.0391      0.00290           0.00543 0.112 
#>  9 GI Hemorrhage          0.0542    0.0175      0.00125           0.00834 0.0480
#> 10 Joint Replaceme…       0.139     0.0179      0.0336            0.00673 0.0516
#> # ℹ 13 more rows
#> # ℹ 6 more variables: Medicaid <dbl>, `Medicaid HMO` <dbl>, `Medicare A` <dbl>,
#> #   `Medicare HMO` <dbl>, `No Fault` <dbl>, `Self Pay` <dbl>
```
