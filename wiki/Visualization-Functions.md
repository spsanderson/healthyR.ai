# Visualization Functions

Comprehensive guide to visualization functions in `healthyR.ai` for data exploration, quality monitoring, and distribution analysis.

---

## 📚 Table of Contents

1. [Control Charts](#control-charts)
2. [Distribution Plots](#distribution-plots)
3. [Faceted Visualizations](#faceted-visualizations)
4. [Color-Blind Friendly Palettes](#color-blind-friendly-palettes)

---

## 📊 Control Charts

### Overview

Control charts (Shewhart charts) are statistical process control tools used to determine if a process is in a state of control. Essential for healthcare quality monitoring.

### `hai_control_chart()`

Monitor metrics over time to identify when processes are out of statistical control.

```r
library(healthyR.ai)
library(ggplot2)

# Create sample data
data_tbl <- tibble::tibble(
  day = sample(c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday"), 100, TRUE),
  person = sample(c("Tom", "Jane", "Alex"), 100, TRUE),
  count = rbinom(100, 20, ifelse(day == "Friday", .5, .2)),
  date = Sys.Date() - sample.int(100)
)

# Generate control chart
my_chart <- hai_control_chart(
  .data = data_tbl,
  .value_col = count,
  .x_col = date,
  .center_line = mean,    # Function for central tendency
  .std_dev = 3,           # Number of standard deviations
  .plt_title = "Adverse Events Control Chart",
  .plt_caption = "Healthcare Quality Monitoring",
  .plt_font_size = 11,
  .print_plot = TRUE
)

# Customize further
my_chart +
  ylab("Number of Adverse Events") +
  scale_x_date(name = "Week of...", date_breaks = "week") +
  theme(axis.text.x = element_text(angle = -90, vjust = 0.5, hjust = 1))
```

**Parameters**:
- `.data`: Data frame or path to CSV file
- `.value_col`: Variable to monitor (y-axis)
- `.x_col`: Time/sequence variable (x-axis)
- `.center_line`: Function for central tendency (default: `mean`, could use `median`)
- `.std_dev`: Number of standard deviations for control limits (default: 3)
- `.plt_title`: Plot title
- `.plt_caption`: Plot caption
- `.plt_font_size`: Base font size (default: 11)
- `.print_plot`: Whether to print plot (default: TRUE)

**Returns**: ggplot2 object that can be further customized

**Interpretation**:
- **Points within control limits**: Process is stable
- **Points outside control limits**: "Special cause variation" - investigate!
- **Trends or patterns**: May indicate systemic changes

**Use Cases**:
- Monitoring adverse events
- Tracking readmission rates
- Quality metric surveillance
- Patient safety indicators
- Infection rates
- Wait times
- Medication errors

---

## 📈 Distribution Plots

### Overview

Visualize and understand data distributions to identify skewness, outliers, and patterns.

### `hai_density_plot()`

Create density plots to visualize distribution shape.

```r
library(healthyR.ai)

# Get density data
density_data <- hai_scale_zero_one_vec(mtcars$mpg) %>%
  hai_distribution_comparison_tbl() %>%
  hai_get_density_data_tbl()

# Create density plot
hai_density_plot(
  .data = density_data,
  .dist_name_col = distribution,
  .x_col = x,
  .y_col = y,
  .size = 1,
  .alpha = 0.5,
  .interactive = FALSE  # Set TRUE for plotly
)
```

**Parameters**:
- `.data`: Data from `hai_get_density_data_tbl()`
- `.dist_name_col`: Column with distribution names
- `.x_col`: X values from density
- `.y_col`: Y values (density)
- `.size`: Line size (default: 1)
- `.alpha`: Transparency (default: 0.382)
- `.interactive`: Boolean, TRUE for plotly plot

---

### `hai_density_hist_plot()`

Combined density and histogram plot.

```r
# Create combined plot
hai_density_hist_plot(
  .data = mtcars,
  .value_col = mpg,
  .bins = 30,
  .fill = "lightblue",
  .alpha = 0.5,
  .interactive = FALSE
)
```

**Parameters**:
- `.data`: Your data frame
- `.value_col`: Column to plot
- `.bins`: Number of histogram bins (default: 30)
- `.fill`: Fill color (default: "lightblue")
- `.alpha`: Transparency
- `.interactive`: Boolean for plotly

**Use When**: You want to see both the smooth density and binned histogram together

---

### `hai_density_qq_plot()`

Q-Q plot for assessing normality.

```r
# Check if data is normally distributed
hai_density_qq_plot(
  .data = mtcars,
  .value_col = mpg,
  .alpha = 0.5,
  .interactive = FALSE
)
```

**Parameters**:
- `.data`: Data frame
- `.value_col`: Column to assess
- `.alpha`: Point transparency
- `.interactive`: Boolean for plotly

**Interpretation**:
- **Points on diagonal line**: Data is approximately normal
- **Deviations at ends**: Heavy or light tails
- **S-shaped curve**: Skewed distribution
- **Systematic deviations**: Non-normal distribution

---

## 📊 Faceted Visualizations

### `hai_histogram_facet_plot()`

Create small multiple histograms across categories.

```r
library(healthyR.ai)

# Faceted histogram by species
hai_histogram_facet_plot(
  .data = iris,
  .value_col = Sepal.Length,
  .facet_col = Species,
  .bins = 10,
  .fill = "steelblue",
  .scale_data = FALSE,  # Set TRUE to scale data
  .ncol = 3,
  .interactive = FALSE
)
```

**Parameters**:
- `.data`: Data frame
- `.value_col`: Numeric column to plot
- `.facet_col`: Column to facet by
- `.bins`: Number of bins per histogram
- `.fill`: Bar fill color
- `.scale_data`: Boolean, scale data with `hai_scale_zero_one_vec()`?
- `.ncol`: Number of columns in facet layout
- `.interactive`: Boolean for plotly

**Returns**: List containing:
- `plot`: The ggplot/plotly object
- `data`: Original data
- `factored_data`: Data with factors
- `scaled_data`: Scaled data (if `.scale_data = TRUE`)

**Use Cases**:
- Compare distributions across groups
- Visualize patient cohorts
- Compare departments or facilities
- Analyze time periods

---

## 🎨 Color-Blind Friendly Palettes

### Overview

`healthyR.ai` provides color-blind friendly color palettes for accessible visualizations.

### `color_blind()`

Get color-blind friendly color vectors.

```r
# Get all color-blind friendly colors
colors <- color_blind()
print(colors)

# Use in plots
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +
  scale_color_manual(values = color_blind())
```

### `hai_scale_color_colorblind()`

Apply color-blind friendly colors to ggplot2 color scale.

```r
library(ggplot2)

# Create plot with color-blind friendly colors
ggplot(iris, aes(x = Sepal.Length, y = Sepal.Width, color = Species)) +
  geom_point(size = 3) +
  hai_scale_color_colorblind() +
  theme_minimal()
```

### `hai_scale_fill_colorblind()`

Apply color-blind friendly colors to ggplot2 fill scale.

```r
# Bar plot with color-blind friendly fills
iris %>%
  count(Species) %>%
  ggplot(aes(x = Species, y = n, fill = Species)) +
  geom_col() +
  hai_scale_fill_colorblind() +
  theme_minimal()
```

**Why This Matters**: 
- ~8% of males have some form of color blindness
- Ensures your visualizations are accessible to all
- Professional and inclusive data visualization

---

## 🎯 Common Visualization Patterns

### Pattern 1: Quality Monitoring Dashboard

```r
library(healthyR.ai)
library(patchwork)  # For combining plots

# Monthly metrics
monthly_adverse <- adverse_events_data %>%
  group_by(month) %>%
  summarise(count = n())

# Control chart
p1 <- hai_control_chart(
  monthly_adverse, 
  count, 
  month,
  .plt_title = "Adverse Events"
) + theme_minimal()

# Distribution
p2 <- hai_density_hist_plot(
  adverse_events_data,
  severity_score,
  .plt_title = "Severity Distribution"
) + theme_minimal()

# Combine
dashboard <- p1 / p2
print(dashboard)
```

### Pattern 2: Distribution Comparison

```r
# Compare multiple distributions
df_scaled <- hai_scale_zero_one_vec(patient_data$length_of_stay)
comparison_tbl <- hai_distribution_comparison_tbl(df_scaled)
density_data <- hai_get_density_data_tbl(comparison_tbl)

# Plot
hai_density_plot(
  density_data,
  distribution,
  x,
  y,
  .alpha = 0.5
) +
  labs(title = "Length of Stay: Distribution Comparison",
       subtitle = "Testing multiple distribution fits") +
  theme_minimal()
```

### Pattern 3: Multi-Group Analysis

```r
# Faceted histograms by department
hai_histogram_facet_plot(
  .data = patient_data,
  .value_col = length_of_stay,
  .facet_col = department,
  .bins = 15,
  .fill = color_blind()[1],
  .ncol = 3
) +
  labs(title = "Length of Stay by Department")
```

### Pattern 4: Normality Assessment

```r
# Check multiple variables for normality
vars_to_check <- c("age", "bmi", "blood_pressure", "cholesterol")

qq_plots <- map(vars_to_check, ~{
  hai_density_qq_plot(
    patient_data,
    !!sym(.x)
  ) +
    labs(title = .x)
})

# Combine with patchwork
library(patchwork)
wrap_plots(qq_plots, ncol = 2)
```

---

## 💡 Best Practices

### 1. Choose the Right Visualization

- **Time-based monitoring**: Control charts
- **Distribution shape**: Density plots
- **Normality**: Q-Q plots
- **Group comparisons**: Faceted histograms
- **Combined view**: Density + histogram

### 2. Use Appropriate Colors

```r
# ✅ Color-blind friendly
ggplot(data, aes(..., color = group)) +
  geom_point() +
  hai_scale_color_colorblind()

# ❌ Default colors may not be accessible
ggplot(data, aes(..., color = group)) +
  geom_point()  # Uses default colors
```

### 3. Add Context with Labels

```r
hai_control_chart(data, metric, date) +
  labs(
    title = "Hospital Acquired Infections",
    subtitle = "Monthly tracking with 3-sigma control limits",
    caption = "Data source: Quality Department",
    y = "Number of Infections",
    x = "Month"
  )
```

### 4. Make Interactive for Exploration

```r
# Static for reports
plot_static <- hai_density_hist_plot(
  data, value,
  .interactive = FALSE
)

# Interactive for exploration
plot_interactive <- hai_density_hist_plot(
  data, value,
  .interactive = TRUE
)

# View in browser
plot_interactive
```

### 5. Save High-Quality Outputs

```r
# Create plot
my_plot <- hai_control_chart(data, metric, date)

# Save
ggsave(
  "control_chart.png",
  plot = my_plot,
  width = 10,
  height = 6,
  dpi = 300,
  bg = "white"
)

# Or PDF for presentations
ggsave(
  "control_chart.pdf",
  plot = my_plot,
  width = 10,
  height = 6
)
```

---

## 📊 Combining with Other Tools

### With plotly for Interactivity

```r
library(plotly)

# Create base ggplot
p <- hai_control_chart(data, metric, date, .print_plot = FALSE)

# Convert to plotly
ggplotly(p) %>%
  layout(
    hovermode = "x unified",
    title = list(text = "Interactive Control Chart")
  )
```

### With gganimate for Animation

```r
library(gganimate)

# Create base plot
p <- ggplot(time_series_data, aes(x = date, y = value)) +
  geom_line(color = color_blind()[1]) +
  geom_hline(yintercept = mean(time_series_data$value), 
             linetype = "dashed") +
  theme_minimal()

# Animate over time
p + transition_reveal(date)
```

---

## 🎓 Use Cases

### Healthcare Quality Monitoring

```r
# Track hospital-acquired infections
infection_data %>%
  group_by(week) %>%
  summarise(infections = n()) %>%
  hai_control_chart(
    .value_col = infections,
    .x_col = week,
    .plt_title = "Hospital-Acquired Infections",
    .std_dev = 3
  )
```

### Readmission Rate Analysis

```r
# Monthly readmission rates
readmission_rates %>%
  hai_control_chart(
    rate,
    month,
    .plt_title = "30-Day Readmission Rate",
    .plt_caption = "Target: <15%"
  ) +
  geom_hline(yintercept = 0.15, color = "red", linetype = "dashed")
```

### Patient Length of Stay Distribution

```r
# Compare LOS across departments
hai_histogram_facet_plot(
  .data = patient_data,
  .value_col = length_of_stay,
  .facet_col = department,
  .bins = 20
) +
  labs(title = "Length of Stay Distribution by Department")
```

---

## 📚 Additional Resources

- **[Statistical Functions](Statistical-Functions.md)** - Calculate distribution statistics
- **[Quick Start Guide](Quick-Start-Guide.md)** - Basic visualization examples
- **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world applications
- **ggplot2 Documentation**: https://ggplot2.tidyverse.org/
- **plotly for R**: https://plotly.com/r/

---

*Last Updated: 2024-11-04*
