# Get the Juiced Data

This is a simple function that will get the juiced data from a recipe.

## Usage

``` r
get_juiced_data(.recipe_object)
```

## Arguments

- .recipe_object:

  The recipe object you want to pass.

## Value

A tibble of the prepped and juiced data from the given recipe

## Details

Instead of typing out something like:
`recipe_object %>% prep() %>% juice() %>% glimpse()`

## See also

Other Data Generation:
[`generate_mesh_data()`](https://www.spsanderson.com/healthyR.ai/reference/generate_mesh_data.md)

## Author

Steven P. Sanderson II, MPH

## Examples

``` r
suppressPackageStartupMessages(library(timetk))
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(purrr))
suppressPackageStartupMessages(library(healthyR.data))
suppressPackageStartupMessages(library(rsample))
suppressPackageStartupMessages(library(recipes))

data_tbl <- healthyR_data %>%
  select(visit_end_date_time) %>%
  summarise_by_time(
    .date_var = visit_end_date_time,
    .by       = "month",
    value     = n()
  ) %>%
  set_names("date_col", "value") %>%
  filter_by_time(
    .date_var = date_col,
    .start_date = "2013",
    .end_date = "2020"
  )

splits <- initial_split(data = data_tbl, prop = 0.8)

rec_obj <- recipe(value ~ ., training(splits))

get_juiced_data(rec_obj)
#> # A tibble: 76 × 2
#>    date_col            value
#>    <dttm>              <int>
#>  1 2016-11-01 00:00:00  1513
#>  2 2015-07-01 00:00:00  1751
#>  3 2018-08-01 00:00:00  1609
#>  4 2019-01-01 00:00:00  1631
#>  5 2018-09-01 00:00:00  1343
#>  6 2013-05-01 00:00:00  2028
#>  7 2014-12-01 00:00:00  1757
#>  8 2019-07-01 00:00:00  1474
#>  9 2019-05-01 00:00:00  1486
#> 10 2013-02-01 00:00:00  1719
#> # ℹ 66 more rows
```
