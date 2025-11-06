# K-Means Scree Plot

Create a scree-plot from the
[`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md)
function.

## Usage

``` r
hai_kmeans_scree_plt(.data)

kmeans_scree_plt(.data)

hai_kmeans_scree_plot(.data)
```

## Arguments

- .data:

  The data from the
  [`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md)
  function

## Value

A ggplot2 plot

## Details

Outputs a scree-plot

## See also

<https://en.wikipedia.org/wiki/Scree_plot>

Other Kmeans:
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md),
[`hai_kmeans_automl_predict()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl_predict.md),
[`hai_kmeans_mapped_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_mapped_tbl.md),
[`hai_kmeans_obj()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_obj.md),
[`hai_kmeans_scree_data_tbl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_scree_data_tbl.md),
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

ui_tbl <- hai_kmeans_user_item_tbl(
  .data = data_tbl,
  .row_input = service_line,
  .col_input = payer_grouping,
  .record_input = record
)

kmm_tbl <- hai_kmeans_mapped_tbl(ui_tbl)

hai_kmeans_scree_plt(.data = kmm_tbl)

```
