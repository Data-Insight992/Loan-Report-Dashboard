# Loan-Report-Dashboard

This project presents an interactive Bank Loan Report Dashboard
built in Microsoft Power BI. It helps explore loan applications, funded
amounts, amounts received, loan quality, interest rates, and borrower
debt-to-income (DTI) information.

The report is organized into three pages --- Summary, Overview, and
Details --- so users can move from high-level performance indicators
to trends, segment comparisons, and individual loan records.


Dashboard Pages
1. Summary
Provides a high-level view of loan portfolio performance, including: -
Total loan applications - Total funded amount - Total amount received -
Average interest rate - Average DTI - Good-loan and bad-loan application
and amount measures - Loan-status comparison table - Good vs. bad loan
distribution
Available filters: loan purpose, loan grade, and state.

3. Overview
Explores how loan applications and selected measures vary across
borrower and loan segments. Visuals include: - Monthly trend of loan
applications - Loan-term distribution - Applications by employment
length - Applications by loan purpose - Applications by home-ownership
category - State-level application distribution using a map - Summary
KPI cards for applications, funded amount, amount received, average
interest rate, and average DTI
The page includes a measure selector to switch the measure displayed in
supported visuals, as well as filters for loan quality/status, state,
and grade.

4. Details
Provides a loan-level table for closer inspection. The displayed fields
include: - Loan ID - Purpose - Home ownership - Grade and sub-grade -
Issue date - Funded amount - Interest rate

KPI cards and slicers provide additional context while exploring the
records.


Key Metrics

Total Loan Applications             Overall application volume

  Total Funded Amount                 Amount disbursed through loans

  Total Amount Received               Amount received against loans

  Average Interest Rate               Average interest rate across the
                                      selected records

  Average DTI                         Average debt-to-income ratio across
                                      the selected records

  Good Loan / Bad Loan Applications   Application volume by the report's
                                      loan-quality classification

  Good Loan / Bad Loan Funded Amount  Funded amount by loan-quality
                                      classification



SQL Query
What is the overall performance of the loan portfolio?
How many loans have been repaid, remain current, or been charged off?
Which credit grades have the highest charge-off rates?
Which loan purposes contribute the most to lending and charge-offs?
Is lending increasing or decreasing over time?
Do longer-term loans have a higher charge-off rate?
Which states contribute the most to the loan portfolio?
How do home ownership and borrower financial profiles relate to charge-offs?
Are there missing or duplicate records that could affect reporting?
Check for duplicate loan IDs
Which loan grades contribute the most to charge-offs?
