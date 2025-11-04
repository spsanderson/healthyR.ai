# Contributing Guide

Thank you for your interest in contributing to `healthyR.ai`! This guide will help you get started.

---

## 📚 Table of Contents

1. [Ways to Contribute](#ways-to-contribute)
2. [Getting Started](#getting-started)
3. [Development Workflow](#development-workflow)
4. [Code Standards](#code-standards)
5. [Testing](#testing)
6. [Documentation](#documentation)
7. [Pull Request Process](#pull-request-process)

---

## 🤝 Ways to Contribute

### Report Bugs 🐛
Found a bug? Please report it!
- Check [existing issues](https://github.com/spsanderson/healthyR.ai/issues) first
- Create a [new issue](https://github.com/spsanderson/healthyR.ai/issues/new) with:
  - Clear title and description
  - Steps to reproduce
  - Expected vs actual behavior
  - R version and package version
  - Minimal reproducible example

### Suggest Features 💡
Have an idea for improvement?
- Open an issue with `[Feature Request]` in the title
- Describe the feature and its use case
- Explain why it would be valuable
- Consider implementation approaches

### Improve Documentation 📝
Documentation is crucial!
- Fix typos or unclear explanations
- Add examples to function documentation
- Create or improve vignettes
- Update wiki pages
- Improve code comments

### Submit Code 👨‍💻
Contribute code improvements:
- Fix bugs
- Implement new features
- Improve performance
- Add tests
- Refactor code

---

## 🚀 Getting Started

### Fork and Clone

1. **Fork the repository** on GitHub
2. **Clone your fork**:
```bash
git clone https://github.com/YOUR_USERNAME/healthyR.ai.git
cd healthyR.ai
```

3. **Add upstream remote**:
```bash
git remote add upstream https://github.com/spsanderson/healthyR.ai.git
```

### Setup Development Environment

```r
# Install development dependencies
install.packages(c(
  "devtools",
  "roxygen2",
  "testthat",
  "knitr",
  "rmarkdown"
))

# Install package dependencies
devtools::install_dev_deps()

# Load package
devtools::load_all()
```

### Create a Branch

```bash
git checkout -b feature/my-new-feature
# or
git checkout -b fix/bug-description
```

---

## 🔄 Development Workflow

### 1. Make Changes

Edit files in the appropriate directory:
- **R code**: `R/`
- **Tests**: `tests/testthat/`
- **Documentation**: `man/` (generated from roxygen2 comments)
- **Vignettes**: `vignettes/`

### 2. Document Your Code

Use roxygen2 comments for all exported functions:

```r
#' Function Title
#'
#' @family Function Category
#'
#' @author Your Name
#'
#' @description
#' Brief description of what the function does.
#'
#' @details
#' Detailed explanation, formulas, background information.
#'
#' @param .data Description of parameter (required)
#' @param .param Optional parameter description (optional, default: value)
#'
#' @examples
#' # Simple example
#' result <- my_function(mtcars)
#'
#' # More complex example
#' result <- my_function(
#'   .data = mtcars,
#'   .param = "value"
#' )
#'
#' @return Description of what the function returns
#'
#' @export
#'
my_function <- function(.data, .param = "default") {
  # Function code
}
```

### 3. Generate Documentation

```r
# Generate .Rd files from roxygen comments
devtools::document()
```

### 4. Run Tests

```r
# Run all tests
devtools::test()

# Run specific test file
testthat::test_file("tests/testthat/test-my-function.R")
```

### 5. Check Package

```r
# Full package check (like CRAN)
devtools::check()

# Should pass with 0 errors, 0 warnings, 0 notes
```

---

## 📏 Code Standards

### Style Guidelines

Follow the [tidyverse style guide](https://style.tidyverse.org/):

```r
# ✅ Good
calculate_mean <- function(.data, .column) {
  result <- mean(.data[[.column]], na.rm = TRUE)
  return(result)
}

# ❌ Bad
CalculateMean<-function(d,c){
result=mean(d[[c]],na.rm=T)
return(result)}
```

### Function Naming

- All main functions: `hai_*`
- Vector functions: `hai_*_vec()`
- Augment functions: `hai_*_augment()`
- Recipe steps: `step_hai_*`
- Use snake_case for all names

### Parameter Naming

- Data parameters: `.data`
- Column selections: `.value`, `.value_col`, etc.
- Options: descriptive names with `.` prefix

### Code Organization

```r
function_name <- function(.param1, .param2) {
  
  # Tidyeval ----
  param1_expr <- rlang::enquo(.param1)
  
  # * Checks ----
  if (!is.data.frame(.data)) {
    stop(call. = FALSE, "(.data) must be a data.frame")
  }
  
  # * Manipulation ----
  result <- .data %>%
    dplyr::mutate(new_col = !!param1_expr)
  
  # * Return ----
  return(result)
}
```

---

## 🧪 Testing

### Writing Tests

Create test files in `tests/testthat/`:

```r
# tests/testthat/test-my-function.R
test_that("my_function works with valid input", {
  # Setup
  data <- mtcars
  
  # Execute
  result <- my_function(data)
  
  # Verify
  expect_s3_class(result, "data.frame")
  expect_true(nrow(result) > 0)
})

test_that("my_function handles errors correctly", {
  expect_error(
    my_function("not a data frame"),
    "must be a data.frame"
  )
})

test_that("my_function handles edge cases", {
  # Empty data
  empty_data <- mtcars[0, ]
  result <- my_function(empty_data)
  expect_equal(nrow(result), 0)
  
  # Single row
  single_row <- mtcars[1, ]
  result <- my_function(single_row)
  expect_equal(nrow(result), 1)
})
```

### Test Coverage

Aim for high test coverage:
```r
# Check coverage
library(covr)
package_coverage()
```

---

## 📝 Documentation

### Function Documentation

- Use roxygen2 comments (`#'`)
- Include `@family` tag for grouping
- Provide clear `@examples`
- Document all parameters
- Explain return values

### Vignettes

For major features, create vignettes:

```r
# Create new vignette
usethis::use_vignette("my-feature")
```

Structure:
```rmarkdown
---
title: "Feature Name"
author: "Your Name"
date: "`r Sys.Date()`"
output: rmarkdown::html_vignette
vignette: >
  %\VignetteIndexEntry{Feature Name}
  %\VignetteEngine{knitr::rmarkdown}
  %\VignetteEncoding{UTF-8}
---

## Introduction

## Installation

## Basic Usage

## Advanced Examples

## Conclusion
```

---

## 🔀 Pull Request Process

### Before Submitting

1. **Update your branch**:
```bash
git fetch upstream
git rebase upstream/master
```

2. **Run checks**:
```r
devtools::check()  # Must pass!
devtools::test()   # All tests pass
```

3. **Update NEWS.md**:
```markdown
# healthyR.ai (development version)

## New Features
- Added `hai_new_function()` for [purpose] (#123)

## Bug Fixes  
- Fixed issue in `hai_existing_function()` (#124)
```

4. **Commit changes**:
```bash
git add .
git commit -m "Add feature: descriptive message"
```

### Submit Pull Request

1. **Push to your fork**:
```bash
git push origin feature/my-new-feature
```

2. **Create Pull Request** on GitHub:
   - Clear title describing the change
   - Reference related issues (#123)
   - Describe what changed and why
   - Mention any breaking changes
   - Add examples if relevant

3. **PR Template**:
```markdown
## Description
Brief description of changes

## Related Issue
Fixes #123

## Type of Change
- [ ] Bug fix
- [ ] New feature
- [ ] Documentation update
- [ ] Code refactoring

## Testing
- [ ] Tests added/updated
- [ ] All tests pass
- [ ] `devtools::check()` passes

## Checklist
- [ ] Code follows style guidelines
- [ ] Documentation updated
- [ ] NEWS.md updated
- [ ] Examples provided
```

### Review Process

- Maintainer will review your PR
- Address any feedback
- Make requested changes
- Once approved, maintainer will merge

---

## 🎨 Code Review Checklist

When reviewing or preparing code:

- [ ] Code is clear and well-commented
- [ ] Follows naming conventions
- [ ] All functions have documentation
- [ ] Examples are provided and work
- [ ] Tests cover new functionality
- [ ] Tests cover edge cases
- [ ] No unnecessary dependencies added
- [ ] Performance considered
- [ ] Backwards compatible (or breaking changes noted)
- [ ] NEWS.md updated

---

## 🏷️ Issue Labels

Understanding issue labels:

- **bug**: Something isn't working
- **enhancement**: New feature or request
- **documentation**: Documentation improvements
- **good first issue**: Good for newcomers
- **help wanted**: Extra attention needed
- **question**: Further information requested
- **wontfix**: Not planned to be addressed

---

## 📞 Getting Help

Need help contributing?

- **Questions**: Open a GitHub Discussion
- **Issues**: File a GitHub Issue  
- **Contact**: Reach out to the maintainer

---

## 🙏 Recognition

All contributors are recognized in:
- GitHub contributors list
- Package AUTHORS file
- Release notes

Thank you for contributing to `healthyR.ai`! 🎉

---

## 📚 Additional Resources

- [R Packages Book](https://r-pkgs.org/)
- [Tidyverse Style Guide](https://style.tidyverse.org/)
- [R Package Primer](https://kbroman.org/pkg_primer/)
- [Writing R Extensions](https://cran.r-project.org/doc/manuals/R-exts.html)

---

*Last Updated: 2024-11-04*
