# UMAP and K-Means Cluster Visualization

Create a UMAP Projection plot.

## Usage

``` r
hai_umap_plot(.data, .point_size = 2, .label = TRUE)

umap_plt(.data, .point_size = 2, .label = TRUE)
```

## Arguments

- .data:

  The data from the
  [`umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)
  function.

- .point_size:

  The desired size for the points of the plot.

- .label:

  Should
  [`ggrepel::geom_label_repel()`](https://ggrepel.slowkow.com/reference/geom_text_repel.html)
  be used to display cluster user labels.

## Value

A ggplot2 UMAP Projection with clusters represented by colors.

## Details

This takes in `umap_kmeans_cluster_results_tbl` from the
[`umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)
function output.

## See also

- <https://cran.r-project.org/package=uwot> (CRAN)

- <https://github.com/jlmelville/uwot> (GitHub)

- <https://github.com/jlmelville/uwot> (arXiv paper)

Other UMAP:
[`hai_umap_list()`](https://www.spsanderson.com/healthyR.ai/reference/hai_umap_list.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
library(healthyR.data)
library(dplyr)
library(broom)
library(ggplot2)

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

ump_lst <- hai_umap_list(.data = uit_tbl, kmm_tbl, 3)
#> New names:
#> • `` -> `...1`
#> • `` -> `...2`
#> Joining with `by = join_by(service_line)`

hai_umap_plot(.data = ump_lst, .point_size = 3)

```
