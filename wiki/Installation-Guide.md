# Installation Guide

Complete guide to installing `healthyR.ai` and its dependencies.

---

## 📋 Prerequisites

### System Requirements

- **R Version**: R >= 3.3 (R >= 4.1.0 recommended for native pipe operator `|>`)
- **Operating System**: 
  - Windows 10 or later
  - macOS 10.13 or later
  - Linux (any recent distribution)

### Required Knowledge
- Basic familiarity with R
- Understanding of data frames and basic data manipulation
- (Optional) Familiarity with the tidyverse ecosystem

---

## 🚀 Installation Methods

### Method 1: Install from CRAN (Recommended for Most Users)

The stable version is available on CRAN:

```r
install.packages("healthyR.ai")
```

This is the recommended method for most users as it installs the latest stable release that has been thoroughly tested.

### Method 2: Install from GitHub (Development Version)

For the latest features and bug fixes:

```r
# Install devtools if you haven't already
if (!requireNamespace("devtools", quietly = TRUE)) {
  install.packages("devtools")
}

# Install the development version
devtools::install_github("spsanderson/healthyR.ai")
```

**Note**: The development version may contain new features but could be less stable than the CRAN release.

### Method 3: Install from Source

If you want to install from a local source:

```r
# Download the source package first, then:
install.packages("path/to/healthyR.ai_x.x.x.tar.gz", repos = NULL, type = "source")
```

---

## 📦 Dependencies

`healthyR.ai` has several dependencies that will be automatically installed. Understanding these can help with troubleshooting.

### Core Dependencies (Automatically Installed)

#### Tidyverse & Data Manipulation
- `magrittr` - Pipe operators
- `dplyr` - Data manipulation
- `tidyr` - Data tidying
- `tibble` - Modern data frames
- `purrr` - Functional programming
- `forcats` - Factor handling

#### Tidymodels Ecosystem
- `recipes` (>= 1.0.0) - Data preprocessing
- `parsnip` - Unified modeling interface
- `workflows` - Modeling workflows
- `tune` - Hyperparameter tuning
- `dials` - Parameter tuning grids
- `yardstick` (>= 0.0.8) - Model evaluation

#### Visualization
- `ggplot2` - Graphics
- `ggrepel` - Label placement

#### Modeling
- `h2o` - AutoML and machine learning
- `modeltime` - Time series modeling

#### Other
- `broom` - Tidy model outputs
- `rlang` (>= 0.1.2) - R language features
- `stats` - Statistical functions
- `utils` - Utility functions

### Suggested Dependencies (Install as Needed)

These packages are not required but enhance functionality:

```r
# Suggested packages for full functionality
install.packages(c(
  "rmarkdown",      # For vignettes
  "knitr",          # For vignettes
  "healthyR.data",  # Sample healthcare datasets
  "scales",         # Axis scaling
  "tidyselect",     # Column selection helpers
  "janitor",        # Data cleaning
  "timetk",         # Time series tools
  "plotly",         # Interactive plots
  "rsample",        # Data splitting
  "kknn",           # K-nearest neighbors
  "hardhat",        # Model preprocessing
  "uwot",           # UMAP dimensionality reduction
  "stringr"         # String manipulation
))
```

---

## 🔧 Special Installation Cases

### Installing H2O

The `h2o` package is a critical dependency for AutoML functions. It usually installs automatically, but if you encounter issues:

```r
# Remove existing H2O installation
if ("package:h2o" %in% search()) { detach("package:h2o", unload = TRUE) }
if ("h2o" %in% rownames(installed.packages())) { remove.packages("h2o") }

# Install latest H2O
install.packages("h2o", type = "source", 
                 repos = "http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")

# Verify installation
library(h2o)
h2o.init()
h2o.shutdown(prompt = FALSE)
```

### Behind a Corporate Proxy

If you're behind a corporate proxy:

```r
# Set proxy
Sys.setenv(http_proxy = "http://proxy.company.com:8080")
Sys.setenv(https_proxy = "https://proxy.company.com:8080")

# Then install
install.packages("healthyR.ai")
```

### Using a Custom Library Path

To install in a specific directory:

```r
# Create custom library path
.libPaths(c("/path/to/your/R/library", .libPaths()))

# Install to custom location
install.packages("healthyR.ai", lib = "/path/to/your/R/library")

# Load from custom location
library(healthyR.ai, lib.loc = "/path/to/your/R/library")
```

---

## ✅ Verifying Installation

After installation, verify everything works:

```r
# Load the package
library(healthyR.ai)

# Check version
packageVersion("healthyR.ai")

# View available functions
ls("package:healthyR.ai")

# Run a simple example
data_tbl <- tibble::tibble(
  x = rnorm(100),
  y = rnorm(100)
)

# Test a basic function
result <- hai_scale_zero_one_vec(data_tbl$x)
print(summary(result))
```

Expected output should show:
- Package loads without errors
- Version number displays (e.g., "0.1.1")
- Function list appears
- Example runs successfully

---

## 🐛 Troubleshooting Installation Issues

### Issue: Package Dependencies Fail to Install

**Solution 1**: Update your R version
```r
# Check your R version
R.version.string

# If < 3.3, update R from https://www.r-project.org/
```

**Solution 2**: Install dependencies manually
```r
# Install core tidyverse
install.packages("tidyverse")

# Install tidymodels
install.packages("tidymodels")

# Then try healthyR.ai again
install.packages("healthyR.ai")
```

### Issue: H2O Installation Fails

**Solution**: Use Java 8 or later
```r
# Check Java version
system("java -version")

# Install H2O from source
install.packages("h2o", type = "source",
                 repos = "http://h2o-release.s3.amazonaws.com/h2o/latest_stable_R")
```

### Issue: Compilation Errors on Linux

**Solution**: Install system dependencies
```bash
# Ubuntu/Debian
sudo apt-get install r-base-dev libcurl4-openssl-dev libssl-dev libxml2-dev

# Fedora/RedHat/CentOS
sudo yum install R-devel libcurl-devel openssl-devel libxml2-devel

# Then retry in R
install.packages("healthyR.ai")
```

### Issue: "Package not found" Error

**Solution**: Check CRAN mirror
```r
# Set CRAN mirror explicitly
options(repos = c(CRAN = "https://cloud.r-project.org/"))

# Try installation again
install.packages("healthyR.ai")
```

### Issue: Permission Denied

**Solution**: Use personal library
```r
# Create personal library
dir.create(Sys.getenv("R_LIBS_USER"), recursive = TRUE)

# Install there
install.packages("healthyR.ai", lib = Sys.getenv("R_LIBS_USER"))
```

---

## 🔄 Updating healthyR.ai

### Update from CRAN

```r
# Update all packages including healthyR.ai
update.packages(ask = FALSE)

# Or update only healthyR.ai
install.packages("healthyR.ai")
```

### Update from GitHub

```r
# Remove old version
remove.packages("healthyR.ai")

# Install latest development version
devtools::install_github("spsanderson/healthyR.ai")
```

### Check for Updates

```r
# Check installed version
packageVersion("healthyR.ai")

# Check CRAN version
available.packages()["healthyR.ai", "Version"]

# Check GitHub version
devtools::package_info("spsanderson/healthyR.ai")
```

---

## 🎓 Next Steps

After successful installation:

1. **[Quick Start Guide](Quick-Start-Guide.md)** - Learn basic usage
2. **[Use Cases and Examples](Use-Cases-and-Examples.md)** - See real-world applications
3. **[AutoML Functions](AutoML-Functions.md)** - Explore automated machine learning
4. **Package Vignettes** - Read detailed tutorials:
   ```r
   browseVignettes("healthyR.ai")
   ```

---

## 📞 Getting Help

If you encounter installation issues not covered here:

1. **Check GitHub Issues**: [healthyR.ai/issues](https://github.com/spsanderson/healthyR.ai/issues)
2. **File a New Issue**: Include your R version, OS, and error message
3. **Check Package Website**: [www.spsanderson.com/healthyR.ai](https://www.spsanderson.com/healthyR.ai/)

---

## 💻 Development Environment Setup

For contributors or advanced users wanting a complete development environment:

```r
# Install development dependencies
install.packages(c(
  "devtools",       # Development tools
  "roxygen2",       # Documentation
  "testthat",       # Testing
  "covr",           # Code coverage
  "pkgdown",        # Website generation
  "usethis"         # Package development helpers
))

# Clone the repository
# git clone https://github.com/spsanderson/healthyR.ai.git

# In R, set working directory to cloned repo
# setwd("path/to/healthyR.ai")

# Install package with all dependencies
devtools::install_dev_deps()

# Build and load
devtools::load_all()

# Run tests
devtools::test()

# Build documentation
devtools::document()
```

---

*Last Updated: 2024-11-04*
