# Health Insurance and Self-Employment Analysis

This project investigates **health insurance coverage in the United States** and how **self-employment status** may affect access to insurance. Using a publicly available dataset from the **Medical Expenditure Panel Survey (MEPS)**, we perform statistical analyses to **estimate proportions**, **construct confidence intervals**, and **test hypotheses** regarding insurance coverage.

## About the Project

The dataset `health-insurance.csv` contains **8,802 observations** and several variables related to individuals’ demographics, employment, and insurance coverage.  https://rdrr.io/cran/AER/man/HealthInsurance.html

**Key variables analyzed in this project include:**

| Variable        | Description                                          | Values       |
| --------------- | ---------------------------------------------------- | ------------ |
| `insurance`     | Indicates whether an individual has health insurance | "yes" / "no" |
| `selfemp`       | Indicates whether an individual is self-employed     | "yes" / "no" |
| Other variables | Age, gender, income, employment type, etc.           | Various      |

## Questions Answered Using Statistical Analysis

This project uses standard **statistical methods** to answer the research questions:

- **Proportion Estimation:** Calculated sample proportions of insured individuals overall and by employment status.  
- **Confidence Intervals:** Constructed 95% Wald confidence intervals to estimate population proportions.  
- **Hypothesis Testing:**  
  - One-sample z-test for comparing overall coverage with 1995 benchmark.  
  - Two-proportion z-test for comparing coverage between self-employed and non-self-employed individuals.  

## Results and Interpretations

### A. Overall Health Insurance Coverage

| Analysis | Value / Result | Interpretation |
|---------|----------------|----------------|
| Sample proportion insured | 0.8012 (~80.12%) | 80% of individuals in the survey have health insurance. |
| 95% Confidence Interval | [0.7928, 0.8095] | We are 95% confident the true proportion of insured individuals in the population is between 79.3% and 80.9%. |
| Comparison with 1995 Census Benchmark | 1995: 84.6% insured | Sample shows lower coverage (~4.5% difference). The difference may reflect sampling bias, as the survey may not perfectly represent the U.S. population. |
| Hypothesis Test (1995 vs 1996) | z = -11.65, p-value ≈ 0 | Statistically significant difference; sample suggests a change, but actual census data shows coverage was essentially unchanged (~84.4%). This demonstrates how sample estimates can differ from population parameters. |

**Takeaway:** The sample provides an estimate of coverage, but the discrepancy with national statistics highlights the importance of considering sampling methods, representativeness, and potential bias.

### B. Self-Employment and Health Insurance

| Employment Status | Sample Proportion Insured | 95% CI | Interpretation |
|-----------------|-------------------------|--------|----------------|
| Self-employed | 0.65 | 0.63 – 0.67 | Self-employed individuals are less likely to have health insurance. |
| Non-self-employed | 0.82 | 0.81 – 0.83 | Non-self-employed individuals are more likely to have coverage. |

**Two-proportion z-test:** p-value ≈ 0 → Statistically significant difference.

**Overall:** The project demonstrates how survey data can estimate health insurance coverage, how to construct confidence intervals, and how to test for differences between groups. It also highlights potential limitations of survey-based estimates when compared with population-level data.
