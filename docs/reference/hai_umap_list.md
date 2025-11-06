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

data_tbl <- healthyR_data %>%
  filter(ip_op_flag == "I") %>%
  filter(payer_grouping != "Medicare B") %>%
  filter(payer_grouping != "?") %>%
  select(service_line, payer_grouping) %>%
  mutate(record = 1) %>%
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
#>             [,1]       [,2]
#>  [1,] -1.1981357  2.0046529
#>  [2,] -1.1084554  1.4954147
#>  [3,]  1.1993915 -2.0136724
#>  [4,]  0.6678632 -0.2270990
#>  [5,]  1.1996123 -0.8039470
#>  [6,]  0.7658432 -1.9398838
#>  [7,] -0.1887519  1.0237469
#>  [8,] -0.5976817  0.9337668
#>  [9,]  0.4483375 -1.8110748
#> [10,] -0.1902566 -0.8540483
#> [11,] -0.8490075  1.2578320
#> [12,]  1.2085169 -1.3726707
#> [13,] -0.9003626  1.7225141
#> [14,] -0.9173445  0.6489176
#> [15,]  0.1387130 -0.2898183
#> [16,] -0.1390712  0.5165686
#> [17,]  0.8088696 -1.0972915
#> [18,] -0.3292845  1.6555008
#> [19,] -0.4978821  0.4275813
#> [20,]  0.2071733 -1.1744819
#> [21,]  0.3182040 -0.6837402
#> [22,] -0.7576456  2.1124949
#> [23,]  0.7113548 -1.5312629
#> attr(,"scaled:center")
#> [1]  0.1631531 -9.4144959
#> 
#> $umap_results_tbl
#> # A tibble: 23 × 3
#>         x      y service_line                 
#>     <dbl>  <dbl> <chr>                        
#>  1 -1.20   2.00  Alcohol Abuse                
#>  2 -1.11   1.50  Bariatric Surgery For Obesity
#>  3  1.20  -2.01  CHF                          
#>  4  0.668 -0.227 COPD                         
#>  5  1.20  -0.804 CVA                          
#>  6  0.766 -1.94  Carotid Endarterectomy       
#>  7 -0.189  1.02  Cellulitis                   
#>  8 -0.598  0.934 Chest Pain                   
#>  9  0.448 -1.81  GI Hemorrhage                
#> 10 -0.190 -0.854 Joint Replacement            
#> # ℹ 13 more rows
#> 
#> $kmeans_obj
#> K-means clustering with 3 clusters of sizes 6, 5, 12
#> 
#> Cluster means:
#>   Blue Cross Commercial Compensation Exchange Plans        HMO   Medicaid
#> 1  0.1170278 0.03141187 0.0101665392    0.013865190 0.09822472 0.08557952
#> 2  0.1495475 0.03679700 0.0003066332    0.020729565 0.16252855 0.13072521
#> 3  0.0783745 0.02182129 0.0043244347    0.006202137 0.04493860 0.03684344
#>   Medicaid HMO Medicare A Medicare HMO    No Fault    Self Pay
#> 1   0.14652195  0.3535395   0.10524131 0.007067791 0.031353724
#> 2   0.31446157  0.1318675   0.03192357 0.001364577 0.019748398
#> 3   0.08001653  0.5625037   0.15152338 0.003475542 0.009976485
#> 
#> Clustering vector:
#>  [1] 2 2 3 3 3 3 1 1 3 3 2 3 2 1 3 1 3 1 1 3 3 2 3
#> 
#> Within cluster sum of squares by cluster:
#> [1] 0.08456928 0.19152559 0.09625399
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
#>  1 Alcohol Abuse                 2       
#>  2 Bariatric Surgery For Obesity 2       
#>  3 CHF                           3       
#>  4 COPD                          3       
#>  5 CVA                           3       
#>  6 Carotid Endarterectomy        3       
#>  7 Cellulitis                    1       
#>  8 Chest Pain                    1       
#>  9 GI Hemorrhage                 3       
#> 10 Joint Replacement             3       
#> # ℹ 13 more rows
#> 
#> $umap_kmeans_cluster_results_tbl
#> # A tibble: 23 × 4
#>         x      y service_line                  .cluster
#>     <dbl>  <dbl> <chr>                         <fct>   
#>  1 -1.20   2.00  Alcohol Abuse                 2       
#>  2 -1.11   1.50  Bariatric Surgery For Obesity 2       
#>  3  1.20  -2.01  CHF                           3       
#>  4  0.668 -0.227 COPD                          3       
#>  5  1.20  -0.804 CVA                           3       
#>  6  0.766 -1.94  Carotid Endarterectomy        3       
#>  7 -0.189  1.02  Cellulitis                    1       
#>  8 -0.598  0.934 Chest Pain                    1       
#>  9  0.448 -1.81  GI Hemorrhage                 3       
#> 10 -0.190 -0.854 Joint Replacement             3       
#> # ℹ 13 more rows
#> 
```
