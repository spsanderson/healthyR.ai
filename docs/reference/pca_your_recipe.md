# Perform PCA

This is a simple function that will perform PCA analysis on a passed
recipe.

## Usage

``` r
pca_your_recipe(.recipe_object, .data, .threshold = 0.75, .top_n = 5)
```

## Arguments

- .recipe_object:

  The recipe object you want to pass.

- .data:

  The full data set that is used in the original recipe object passed
  into `.recipe_object` in order to obtain the baked data of the
  transform.

- .threshold:

  A number between 0 and 1. A fraction of the total variance that should
  be covered by the components.

- .top_n:

  How many variables loadings should be returned per PC

## Value

A list object with several components.

## Details

This is a simple wrapper around some recipes functions to perform a PCA
on a given recipe. This function will output a list and return it
invisible. All of the components of the analysis will be returned in a
list as their own object that can be selected individually. A scree plot
is also included. The items that get returned are:

1.  pca_transform - This is the pca recipe.

2.  variable_loadings

3.  variable_variance

4.  pca_estimates

5.  pca_juiced_estimates

6.  pca_baked_data

7.  pca_variance_df

8.  pca_rotattion_df

9.  pca_variance_scree_plt

10. pca_loadings_plt

11. pca_loadings_plotly

12. pca_top_n_loadings_plt

13. pca_top_n_plotly

## See also

<https://recipes.tidymodels.org/reference/step_pca.html>

Other Data Recipes:
[`hai_data_impute()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_impute.md),
[`hai_data_poly()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_poly.md),
[`hai_data_scale()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_scale.md),
[`hai_data_transform()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_transform.md),
[`hai_data_trig()`](https://www.spsanderson.com/healthyR.ai/reference/hai_data_trig.md)

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
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(plotly))

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
  ) %>%
  mutate(date_col = as.Date(date_col))

splits <- initial_split(data = data_tbl, prop = 0.8)

rec_obj <- recipe(value ~ ., training(splits)) %>%
  step_timeseries_signature(date_col) %>%
  step_rm(matches("(iso$)|(xts$)|(hour)|(min)|(sec)|(am.pm)"))

output_list <- pca_your_recipe(rec_obj, .data = data_tbl)
#> Warning: !  The following columns have zero variance so scaling cannot be used:
#>   date_col_day, date_col_mday, and date_col_mday7.
#> ℹ Consider using ?step_zv (`?recipes::step_zv()`) to remove those columns
#>   before normalizing.
output_list$pca_variance_scree_plt

output_list$pca_loadings_plt

output_list$pca_top_n_loadings_plt

```
