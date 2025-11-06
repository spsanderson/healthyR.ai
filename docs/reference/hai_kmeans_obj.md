# K-Means Object

Takes the output of the
[`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)
function and applies the k-means algorithm to it using
[`stats::kmeans()`](https://rdrr.io/r/stats/kmeans.html)

## Usage

``` r
hai_kmeans_obj(.data, .centers = 5)

kmeans_obj(.data, .centers = 5)
```

## Arguments

- .data:

  The data that gets passed from
  [`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)

- .centers:

  How many initial centers to start with

## Value

A stats k-means object

## Details

Uses the [`stats::kmeans()`](https://rdrr.io/r/stats/kmeans.html)
function and creates a wrapper around it.

## See also

Other Kmeans:
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md),
[`hai_kmeans_automl_predict()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl_predict.md),
[`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md),
[`hai_kmeans_scree_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_data_tbl.md),
[`hai_kmeans_scree_plt()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_plt.md),
[`hai_kmeans_tidy_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_tidy_tbl.md),
[`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)

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
) %>%
  hai_kmeans_obj()
#> K-means clustering with 5 clusters of sizes 2, 1, 12, 5, 3
#> 
#> Cluster means:
#>   Blue Cross Commercial Compensation Exchange Plans        HMO   Medicaid
#> 1 0.27188303 0.05712358 0.0003293808    0.039065198 0.18065096 0.04246134
#> 2 0.00000000 0.00000000 0.0000000000    0.000000000 0.27272727 0.18181818
#> 3 0.07837450 0.02182129 0.0043244347    0.006202137 0.04493860 0.03684344
#> 4 0.13375082 0.03542694 0.0121998471    0.016160901 0.10724914 0.05150211
#> 5 0.07912806 0.02702478 0.0002914681    0.009301354 0.07723873 0.21428392
#>   Medicaid HMO Medicare A Medicare HMO    No Fault    Self Pay
#> 1   0.24760799 0.10958146   0.03584494 0.000000000 0.015452115
#> 2   0.45454545 0.09090909   0.00000000 0.000000000 0.000000000
#> 3   0.08001653 0.56250366   0.15152338 0.003475542 0.009976485
#> 4   0.13107693 0.35217108   0.11769769 0.008242686 0.034521844
#> 5   0.28209782 0.23654904   0.04362913 0.002672067 0.027783628
#> 
#> Clustering vector:
#>  [1] 5 1 3 3 3 3 4 4 3 3 1 3 5 4 3 4 3 5 4 3 3 2 3
#> 
#> Within cluster sum of squares by cluster:
#> [1] 0.03549821 0.00000000 0.09625399 0.02592247 0.04450884
#>  (between_SS / total_SS =  85.6 %)
#> 
#> Available components:
#> 
#> [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
#> [6] "betweenss"    "size"         "iter"         "ifault"      
```
