library(tidyverse)
HealthInsurance <- read_csv("/Users/Aishwarya/Documents/GitHub/health-insurance-self-employment/data/health_insurance.csv")

summary(HealthInsurance)

#ceck rows and cols
dim(HealthInsurance)

#column header
colnames(HealthInsurance)

HealthInsurance %>% glimpse()

#check missing values
colSums(is.na(HealthInsurance))

#The dataset contains 8,802 observations and X variables, including indicators for health insurance coverage and self-employment status.

#Let's analyze if having employement is related to having health insurance

#PART A
#1.proportion of individuals having insurance
p_hat <- mean(HealthInsurance$insurance == "yes")
p_hat
#2. Lets construct a 95% confidence interval for the true population proportion of individuals who have health insurance.
#we will use Wald method for constructing CI - p_hat ± z∗⋅SE_p
#Calculate SE of sample proportion
#check conditions for binomial to normal approximation
n <- nrow(HealthInsurance)

n*p_hat
n*(1-p_hat)
print("Both np and nq >=5")

SE_p <- sqrt(p_hat * (1 - p_hat) / n)
SE_p
#Given alpha=0.05, calculate z score
alpha <- 0.05
z_star <- qnorm(1 - alpha/2)
z_star

lower <- p_hat - 1.96 * SE_p
upper <- p_hat + 1.96 * SE_p
p <- c(lower, upper)
p
cat("We are 95% confident that the true population proportion of individuals with health insurance lies between",
    round(lower, 4), "and", round(upper, 4), "\n")

"'PART B:According to census.gov (https://www.census.gov/library/publications/1996/demo/p60-195.html), an
estimated 15.4% of individuals were without health insurance in 1995. Taking this 15.4% as the truth
and using the data collected from this survey, is there evidence that the proportion of individuals with
health insurance changed from 1995 to 1996?
'"

#let q0=.154
p0 <- 1-.154
print(p0)
# standard error under H0
SE0 <- sqrt(p0 * (1 - p0) / n)

# z-statistic
z <- (p_hat - p0) / SE0
z

p_value <- 2 * (1 - pnorm(abs(z)))
p_value

if (p_value < 0.05) {
  cat("Reject H0: there is evidence that the proportion changed.\n")
} else {
  cat("Fail to reject H0: no evidence of change.\n")
}

#Part C
#Proportion of individuals who are self-employed
p_selfemp <- mean(HealthInsurance$selfemp == "yes")

cat("Proportion of self-employed individuals:", round(p_selfemp, 4), "\n\n")

#Point estimates and confidence intervals for insured by employment status
insurance_by_emp <- HealthInsurance %>%
  group_by(selfemp) %>%
  summarize(
    n = n(),
    prop_insured = mean(insurance == "yes"),
    SE = sqrt(prop_insured * (1 - prop_insured) / n),
    CI_lower = prop_insured - 1.96 * SE,
    CI_upper = prop_insured + 1.96 * SE
  )

print(insurance_by_emp)

cat("\n")

# Two-proportion z-test to see if proportions differ
# Create table of counts
table_insurance <- table(HealthInsurance$selfemp, HealthInsurance$insurance)
table_insurance
# Perform z-test for difference in proportions
test_result <- prop.test(
  x = c(table_insurance["yes","yes"], table_insurance["no","yes"]),
  n = c(sum(table_insurance["yes",]), sum(table_insurance["no",])),
  correct = FALSE
)

print(test_result)

if (test_result$p.value < 0.05) {
  cat("\nThe difference in health insurance coverage between self-employed and non-self-employed individuals is statistically significant (p-value =", round(test_result$p.value, 4), ").\n")
} else {
  cat("\nThere is no significant difference in health insurance coverage between self-employed and non-self-employed individuals (p-value =", round(test_result$p.value, 4), ").\n")
}
