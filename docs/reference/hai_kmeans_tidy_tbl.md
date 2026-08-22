# K-Means Object Tidy Functions

K-Means tidy functions

## Usage

``` r
hai_kmeans_tidy_tbl(.kmeans_obj, .data, .tidy_type = "tidy")

kmeans_tidy_tbl(.kmeans_obj, .data, .tidy_type = "tidy")
```

## Arguments

- .kmeans_obj:

  A [`stats::kmeans()`](https://rdrr.io/r/stats/kmeans.html) object

- .data:

  The user item tibble created from
  [`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)

- .tidy_type:

  "tidy","glance", or "augment"

## Value

A tibble

## Details

Takes in a k-means object and its associated user item tibble and then
returns one of the items asked for. Either:
[`broom::tidy()`](https://broom.tidymodels.org/reference/reexports.html),
[`broom::glance()`](https://broom.tidymodels.org/reference/reexports.html)
or
[`broom::augment()`](https://broom.tidymodels.org/reference/reexports.html).
The function defaults to
[`broom::tidy()`](https://broom.tidymodels.org/reference/reexports.html).

## See also

Other Kmeans:
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md),
[`hai_kmeans_automl_predict()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl_predict.md),
[`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md),
[`hai_kmeans_obj()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_obj.md),
[`hai_kmeans_scree_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_data_tbl.md),
[`hai_kmeans_scree_plt()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_plt.md),
[`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(healthyR.data)
library(dplyr)
library(broom)
#> Warning: package 'broom' was built under R version 4.5.3

data_tbl <- healthyR_data |>
  filter(ip_op_flag == "I") |>
  filter(payer_grouping != "Medicare B") |>
  filter(payer_grouping != "?") |>
  select(service_line, payer_grouping) |>
  mutate(record = 1) |>
  as_tibble()

uit_tbl <- hai_kmeans_user_item_tbl(
  .data = data_tbl,
  .row_input = service_line,
  .col_input = payer_grouping,
  .record_input = record
)

km_obj <- hai_kmeans_obj(uit_tbl)

hai_kmeans_tidy_tbl(
  .kmeans_obj = km_obj,
  .data = uit_tbl,
  .tidy_type = "augment"
)
#> # A tibble: 23 × 2
#>    service_line                  cluster
#>    <chr>                         <fct>  
#>  1 Alcohol Abuse                 4      
#>  2 Bariatric Surgery For Obesity 3      
#>  3 CHF                           1      
#>  4 COPD                          1      
#>  5 CVA                           1      
#>  6 Carotid Endarterectomy        1      
#>  7 Cellulitis                    2      
#>  8 Chest Pain                    2      
#>  9 GI Hemorrhage                 1      
#> 10 Joint Replacement             1      
#> # ℹ 13 more rows

hai_kmeans_tidy_tbl(
  .kmeans_obj = km_obj,
  .data = uit_tbl,
  .tidy_type = "glance"
)
#> # A tibble: 1 × 4
#>   totss tot.withinss betweenss  iter
#>   <dbl>        <dbl>     <dbl> <int>
#> 1  1.41        0.202      1.21     2

hai_kmeans_tidy_tbl(
  .kmeans_obj = km_obj,
  .data = uit_tbl,
  .tidy_type = "tidy"
) |>
  glimpse()
#> Rows: 5
#> Columns: 14
#> $ `Blue Cross`     <dbl> 0.07837450, 0.13375082, 0.27188303, 0.07912806, 0.000…
#> $ Commercial       <dbl> 0.02182129, 0.03542694, 0.05712358, 0.02702478, 0.000…
#> $ Compensation     <dbl> 0.0043244347, 0.0121998471, 0.0003293808, 0.000291468…
#> $ `Exchange Plans` <dbl> 0.006202137, 0.016160901, 0.039065198, 0.009301354, 0…
#> $ HMO              <dbl> 0.04493860, 0.10724914, 0.18065096, 0.07723873, 0.272…
#> $ Medicaid         <dbl> 0.03684344, 0.05150211, 0.04246134, 0.21428392, 0.181…
#> $ `Medicaid HMO`   <dbl> 0.08001653, 0.13107693, 0.24760799, 0.28209782, 0.454…
#> $ `Medicare A`     <dbl> 0.56250366, 0.35217108, 0.10958146, 0.23654904, 0.090…
#> $ `Medicare HMO`   <dbl> 0.15152338, 0.11769769, 0.03584494, 0.04362913, 0.000…
#> $ `No Fault`       <dbl> 0.003475542, 0.008242686, 0.000000000, 0.002672067, 0…
#> $ `Self Pay`       <dbl> 0.009976485, 0.034521844, 0.015452115, 0.027783628, 0…
#> $ size             <int> 12, 5, 2, 3, 1
#> $ withinss         <dbl> 0.09625399, 0.02592247, 0.03549821, 0.04450884, 0.000…
#> $ cluster          <fct> 1, 2, 3, 4, 5
```
