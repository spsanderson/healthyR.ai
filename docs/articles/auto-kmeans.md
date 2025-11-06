# Auto K-Means with healthyR.ai

``` r
library(healthyR.ai)
suppressPackageStartupMessages(library(dplyr))
suppressPackageStartupMessages(library(ggplot2))
suppressPackageStartupMessages(library(h2o))
```

## Data

Many times in a project we want to perform some sort of clustering on a
given set of data. This can be accomplished many different ways. This
`vignette` will showcase how you can take a data set that is prepared,
say like the internal `iris` file and process it with the `healthyR.ai`
function
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md).

First lets take a look at the data itself.

``` r
df_tbl <- iris

glimpse(df_tbl)
#> Rows: 150
#> Columns: 5
#> $ Sepal.Length <dbl> 5.1, 4.9, 4.7, 4.6, 5.0, 5.4, 4.6, 5.0, 4.4, 4.9, 5.4, 4.…
#> $ Sepal.Width  <dbl> 3.5, 3.0, 3.2, 3.1, 3.6, 3.9, 3.4, 3.4, 2.9, 3.1, 3.7, 3.…
#> $ Petal.Length <dbl> 1.4, 1.4, 1.3, 1.5, 1.4, 1.7, 1.4, 1.5, 1.4, 1.5, 1.5, 1.…
#> $ Petal.Width  <dbl> 0.2, 0.2, 0.2, 0.2, 0.2, 0.4, 0.3, 0.2, 0.2, 0.1, 0.2, 0.…
#> $ Species      <fct> setosa, setosa, setosa, setosa, setosa, setosa, setosa, s…
```

From here we can see that the data is already prepared and ready to go.
There is a factor column that denotes the species or the `row` data and
the columns are already numeric. Now the rest is fairly simple and
straight forward. Let’s use the
[`hai_kmeans_automl()`](https://www.spsanderson.com/healthyR.ai/reference/hai_kmeans_automl.md)
function to create the list output that comes from it where we will want
to use the `Species` column as the predictor based upon the features
presented.

## Use the function

``` r
column_names <- names(iris)
target_col <- "Species"
predictor_cols <- setdiff(column_names, target_col)
```

Now we have our column inputs for the function, so we can go ahead and
run it.

``` r
h2o.init()

output <- hai_kmeans_automl(
  .data = df_tbl,
  .predictors = predictor_cols,
  .standardize = FALSE
)

h2o.shutdown(prompt = FALSE)
```

This function gives a lot of output inside of it. From here we will
discuss what comes out of the function.

## Function Output

Lets take a look at the structure of the output object. It is a list of
lists with four main components. They are the following:

- data
- auto_kmeans_obj
- model_id (h2o model id)
- scree_plt (a `ggplot2` object)

Lets explor each of these items.

### Data

Inside of the data list there are several sections. We can view and
access these very simply. You will find that all of the outputs have
been labeled in a very simple to understand manner.

``` r
output$data
```

### Auto-ML Object

Now for the auto-ml object itself.

``` r
output$auto_kmeans_obj
```

### The Best Model

We also have in the output the best model that is saved off.

``` r
output$model_id
```

### Scree Plot

There is also a `ggplot2` scree plot that is generated, this helps us to
understand how many clusters are in the data resulting from minimizing
the within sum of squares errors.

``` r
print(output$scree_plt)
```
