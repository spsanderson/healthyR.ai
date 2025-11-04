# healthyR.ai Wiki

Welcome to the comprehensive documentation wiki for `healthyR.ai` - The Machine Learning and AI Modeling Companion to healthyR.

This wiki contains detailed guides, examples, and references for all aspects of the `healthyR.ai` package.

---

## 📚 Wiki Structure

### Getting Started (New Users Start Here!)

1. **[Home](Home.md)** - Wiki overview and package introduction
2. **[Installation Guide](Installation-Guide.md)** - Step-by-step installation instructions
3. **[Quick Start Guide](Quick-Start-Guide.md)** - Your first steps with healthyR.ai

### Core Features (Main Documentation)

#### Machine Learning
4. **[AutoML Functions](AutoML-Functions.md)** - Automated machine learning with 9 algorithms
   - C5.0, Cubist, Earth (MARS), GLMnet, KNN
   - Ranger (Random Forest), SVM (Poly & RBF), XGBoost
   - Complete guide with examples and best practices

#### Unsupervised Learning
5. **[Clustering and Dimensionality Reduction](Clustering-and-Dimensionality-Reduction.md)**
   - K-Means AutoML with automatic cluster detection
   - UMAP for visualization
   - PCA for dimensionality reduction

#### Data Processing
6. **[Data Preprocessing](Data-Preprocessing.md)** - Transform and prepare your data
   - Scaling: Z-score, Min-Max normalization
   - Transformations: Fourier, Hyperbolic, Polynomial
   - Winsorization for outlier handling

7. **[Recipe Steps](Recipe-Steps.md)** - Tidymodels integration
   - Custom recipe steps for seamless preprocessing
   - Integration with tidymodels workflows
   - Complete pipeline examples

#### Analysis & Visualization
8. **[Visualization Functions](Visualization-Functions.md)** - Create insightful plots
   - Control charts for quality monitoring
   - Distribution plots (density, histogram, Q-Q)
   - Faceted visualizations
   - Color-blind friendly palettes

9. **[Statistical Functions](Statistical-Functions.md)** - Understand your data
   - Skewness and kurtosis
   - Distribution comparison
   - Feature analysis

### Practical Application
10. **[Use Cases and Examples](Use-Cases-and-Examples.md)** - Real-world scenarios
    - Predicting length of stay
    - Readmission risk assessment
    - Patient segmentation
    - Quality metrics monitoring
    - Cost prediction
    - Resource utilization analysis

### Reference & Support
11. **[API Reference](API-Reference.md)** - Complete function reference
    - All 70+ functions categorized
    - Function naming conventions
    - Parameter patterns
    - Quick lookup guide

12. **[Troubleshooting and FAQ](Troubleshooting-and-FAQ.md)** - Common issues and solutions
    - Installation problems
    - H2O issues
    - AutoML troubleshooting
    - Performance optimization
    - Frequently asked questions

### Contributing
13. **[Contributing Guide](Contributing-Guide.md)** - Help improve healthyR.ai
    - How to contribute
    - Development workflow
    - Code standards
    - Testing and documentation
    - Pull request process

14. **[Changelog and Versioning](Changelog-and-Versioning.md)** - Version history
    - Detailed changelog
    - Breaking changes
    - New features by version
    - Upgrade guides

---

## 🎯 Quick Navigation by Task

### I want to...

**Learn the Basics**
→ Start with [Installation Guide](Installation-Guide.md) → [Quick Start Guide](Quick-Start-Guide.md)

**Build a Predictive Model**
→ Go to [AutoML Functions](AutoML-Functions.md) → [Use Cases and Examples](Use-Cases-and-Examples.md)

**Preprocess My Data**
→ Read [Data Preprocessing](Data-Preprocessing.md) → [Recipe Steps](Recipe-Steps.md)

**Segment Patients/Customers**
→ Check [Clustering and Dimensionality Reduction](Clustering-and-Dimensionality-Reduction.md)

**Monitor Quality Metrics**
→ See [Visualization Functions](Visualization-Functions.md) (Control Charts section)

**Analyze Distributions**
→ Review [Statistical Functions](Statistical-Functions.md) → [Visualization Functions](Visualization-Functions.md)

**Find a Specific Function**
→ Use [API Reference](API-Reference.md)

**Solve a Problem**
→ Visit [Troubleshooting and FAQ](Troubleshooting-and-FAQ.md)

**Contribute Code**
→ Read [Contributing Guide](Contributing-Guide.md)

**See What's New**
→ Check [Changelog and Versioning](Changelog-and-Versioning.md)

---

## 📊 Wiki Statistics

- **Total Pages**: 14 comprehensive guides
- **Total Content**: ~160,000 words
- **Code Examples**: 200+ working examples
- **Functions Documented**: 70+ functions
- **Use Cases**: 6 complete real-world scenarios

---

## 🔍 Search Tips

### Finding Information

1. **Use Browser Search (Ctrl+F / Cmd+F)**: Each page is searchable
2. **Check the Table of Contents**: Every page has a detailed TOC
3. **Follow Cross-References**: Pages link to related content
4. **Start Broad, Go Specific**: Home → Category → Specific Topic

### Recommended Reading Paths

**For Beginners**:
1. Home
2. Installation Guide
3. Quick Start Guide
4. One of: AutoML Functions OR Visualization Functions
5. Use Cases and Examples

**For Experienced R Users**:
1. Home (skim)
2. Quick Start Guide (focus on examples)
3. AutoML Functions
4. Recipe Steps
5. API Reference (bookmark for later)

**For Contributors**:
1. All user-facing documentation
2. Contributing Guide
3. Troubleshooting and FAQ
4. Changelog and Versioning

---

## 📖 Documentation Conventions

### Code Blocks

````r
# R code examples are formatted like this
library(healthyR.ai)

result <- hai_auto_knn(
  .data = train_data,
  .rec_obj = recipe_obj,
  .best_metric = "rmse"
)
````

### Callouts

**When to use**: Important information highlighted

**Use Cases**: Real-world application examples

**Parameters**: Function parameter explanations

### Navigation

- **Bold**: Key concepts and emphasis
- `code font`: Functions, parameters, code elements
- [Links](Home.md): Internal wiki links
- → : Workflow or process steps

---

## 🔗 External Resources

### Package Resources
- **CRAN**: https://CRAN.R-project.org/package=healthyR.ai
- **Website**: https://www.spsanderson.com/healthyR.ai/
- **GitHub**: https://github.com/spsanderson/healthyR.ai
- **Issues**: https://github.com/spsanderson/healthyR.ai/issues

### Related Documentation
- **tidymodels**: https://www.tidymodels.org/
- **recipes**: https://recipes.tidymodels.org/
- **H2O**: https://docs.h2o.ai/

---

## 💡 Tips for Using This Wiki

1. **Bookmark This Page**: Come back here for navigation
2. **Start with Quick Start**: Don't skip the basics
3. **Follow Examples**: Copy and modify code examples
4. **Cross-Reference**: Use links between pages
5. **Search Within Pages**: Use browser search on long pages
6. **Check API Reference**: Quick function lookup
7. **Read Use Cases**: See complete workflows
8. **Ask Questions**: Use GitHub Issues for help

---

## 🔄 Wiki Maintenance

### Last Updated
- **Date**: 2024-11-04
- **Package Version**: 0.1.1.9000 (development)
- **Status**: Complete and current

### Update Frequency
- Updated with each major release
- Bug fixes and improvements as needed
- Community contributions welcome

### How to Contribute
See the [Contributing Guide](Contributing-Guide.md) for details on:
- Reporting documentation issues
- Suggesting improvements
- Submitting documentation updates
- Adding examples

---

## 📞 Getting Help

### Quick Answers
1. Check [Troubleshooting and FAQ](Troubleshooting-and-FAQ.md)
2. Search this wiki
3. Review examples in [Use Cases](Use-Cases-and-Examples.md)

### Still Need Help?
- **GitHub Issues**: https://github.com/spsanderson/healthyR.ai/issues
- **Function Help**: `?function_name` in R
- **Vignettes**: `browseVignettes("healthyR.ai")`
- **Package Website**: https://www.spsanderson.com/healthyR.ai/

---

## 🙏 Acknowledgments

This comprehensive wiki was created to make `healthyR.ai` accessible to users of all skill levels. Special thanks to:

- **Steven P. Sanderson II, MPH** - Package author and maintainer
- **tidymodels team** - For the excellent modeling infrastructure
- **H2O.ai** - For the powerful H2O machine learning platform
- **R Community** - For feedback and contributions

---

## 📄 License

This documentation is provided under the same MIT license as the `healthyR.ai` package.

**Copyright** © Steven P. Sanderson II, MPH

---

**Happy Modeling! 🎉**

*For questions, issues, or suggestions about this wiki, please visit our [GitHub Issues](https://github.com/spsanderson/healthyR.ai/issues) page.*

---

*Last Updated: 2024-11-04*
