# UMAP Projection

Create a umap object from the
[`uwot::umap()`](https://jlmelville.github.io/uwot/reference/umap.html)
function.

## Usage

``` r
hai_umap_list(.data, .kmeans_map_tbl, .k_cluster = 5)

umap_list(.data, .kmeans_map_tbl, .k_cluster = 5)
```

## Arguments

- .data:

  The data from the
  [`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)
  function.

- .kmeans_map_tbl:

  The data from the
  [`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md).

- .k_cluster:

  Pick the desired amount of clusters from your analysis of the scree
  plot.

## Value

A list of tibbles and the umap object

## Details

This takes in the user item table/matix that is produced by
[`hai_kmeans_user_item_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_user_item_tbl.md)
function. This function uses the defaults of
[`uwot::umap()`](https://jlmelville.github.io/uwot/reference/umap.html).

## See also

- <https://cran.r-project.org/package=uwot> (CRAN)

- <https://github.com/jlmelville/uwot> (GitHub)

- <https://github.com/jlmelville/uwot> (arXiv paper)

Other UMAP:
[`hai_umap_plot()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_plot.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(healthyR.data)
library(dplyr)
library(broom)

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

kmm_tbl <- hai_kmeans_mapped_tbl(uit_tbl)

umap_list(.data = uit_tbl, kmm_tbl, 3)
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`
#> Joining with `by = join_by(service_line)`
#> $umap_obj
#>              [,1]       [,2]
#>  [1,]  0.28528859  2.2491667
#>  [2,] -0.13117764  2.1084384
#>  [3,] -0.24542640 -2.2402340
#>  [4,]  0.80739882 -0.5729858
#>  [5,]  0.44699981 -1.3484811
#>  [6,] -0.61160252 -2.1092884
#>  [7,] -0.80734990  1.2504653
#>  [8,] -0.50440572  0.8303128
#>  [9,]  0.24279811 -1.9372908
#> [10,] -0.17718671 -0.5774085
#> [11,] -0.23473046  1.4898180
#> [12,] -0.24119590 -1.2576221
#> [13,]  0.12464406  1.7042488
#> [14,] -0.20695231  0.9352088
#> [15,]  0.38569762 -0.2300152
#> [16,] -0.31607697  0.3515507
#> [17,]  0.03603007 -1.5945875
#> [18,]  0.69957330  2.1887216
#> [19,]  0.13563564  0.6237887
#> [20,]  0.50685622 -0.9394032
#> [21,]  0.05819347 -0.9300539
#> [22,]  0.47927787  1.7866853
#> [23,] -0.73228906 -1.7810346
#> attr(,"scaled:center")
#> [1] -4.707077 -2.644019
#> 
#> $umap_results_tbl
#> # A tibble: 23 × 3
#>         x      y service_line                 
#>     <dbl>  <dbl> <chr>                        
#>  1  0.285  2.25  Alcohol Abuse                
#>  2 -0.131  2.11  Bariatric Surgery For Obesity
#>  3 -0.245 -2.24  CHF                          
#>  4  0.807 -0.573 COPD                         
#>  5  0.447 -1.35  CVA                          
#>  6 -0.612 -2.11  Carotid Endarterectomy       
#>  7 -0.807  1.25  Cellulitis                   
#>  8 -0.504  0.830 Chest Pain                   
#>  9  0.243 -1.94  GI Hemorrhage                
#> 10 -0.177 -0.577 Joint Replacement            
#> # ℹ 13 more rows
#> 
#> $kmeans_obj
#> K-means clustering with 3 clusters of sizes 5, 6, 12
#> 
#> Cluster means:
#>   Blue Cross Commercial Compensation Exchange Plans        HMO   Medicaid
#> 1  0.1495475 0.03679700 0.0003066332    0.020729565 0.16252855 0.13072521
#> 2  0.1170278 0.03141187 0.0101665392    0.013865190 0.09822472 0.08557952
#> 3  0.0783745 0.02182129 0.0043244347    0.006202137 0.04493860 0.03684344
#>   Medicaid HMO Medicare A Medicare HMO    No Fault    Self Pay
#> 1   0.31446157  0.1318675   0.03192357 0.001364577 0.019748398
#> 2   0.14652195  0.3535395   0.10524131 0.007067791 0.031353724
#> 3   0.08001653  0.5625037   0.15152338 0.003475542 0.009976485
#> 
#> Clustering vector:
#>  [1] 1 1 3 3 3 3 2 2 3 3 1 3 1 2 3 2 3 2 2 3 3 1 3
#> 
#> Within cluster sum of squares by cluster:
#> [1] 0.19152559 0.08456928 0.09625399
#>  (between_SS / total_SS =  73.6 %)
#> 
#> Available components:
#> 
#> [1] "cluster"      "centers"      "totss"        "withinss"     "tot.withinss"
#> [6] "betweenss"    "size"         "iter"         "ifault"      
#> 
#> $kmeans_cluster_tbl
#> # A tibble: 23 × 2
#>    service_line                  .cluster
#>    <chr>                         <fct>   
#>  1 Alcohol Abuse                 1       
#>  2 Bariatric Surgery For Obesity 1       
#>  3 CHF                           3       
#>  4 COPD                          3       
#>  5 CVA                           3       
#>  6 Carotid Endarterectomy        3       
#>  7 Cellulitis                    2       
#>  8 Chest Pain                    2       
#>  9 GI Hemorrhage                 3       
#> 10 Joint Replacement             3       
#> # ℹ 13 more rows
#> 
#> $umap_kmeans_cluster_results_tbl
#> # A tibble: 23 × 4
#>         x      y service_line                  .cluster
#>     <dbl>  <dbl> <chr>                         <fct>   
#>  1  0.285  2.25  Alcohol Abuse                 1       
#>  2 -0.131  2.11  Bariatric Surgery For Obesity 1       
#>  3 -0.245 -2.24  CHF                           3       
#>  4  0.807 -0.573 COPD                          3       
#>  5  0.447 -1.35  CVA                           3       
#>  6 -0.612 -2.11  Carotid Endarterectomy        3       
#>  7 -0.807  1.25  Cellulitis                    2       
#>  8 -0.504  0.830 Chest Pain                    2       
#>  9  0.243 -1.94  GI Hemorrhage                 3       
#> 10 -0.177 -0.577 Joint Replacement             3       
#> # ℹ 13 more rows
#> 
```
