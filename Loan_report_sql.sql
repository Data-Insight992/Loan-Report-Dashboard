
-- What is the overall performance of the loan portfolio?
SELECT
    COUNT(DISTINCT id) AS total_loans,
    SUM(loan_amount) AS total_funded_amount,
    ROUND(AVG(loan_amount), 2) AS average_loan_amount,
    SUM(total_payment) AS total_payments_received
FROM financial_loan;

-- How many loans have been repaid, remain current, or been charged off?
SELECT
    loan_status,
    COUNT(DISTINCT id) AS loan_count,
    ROUND(
        100.0 * COUNT(DISTINCT id) /
        (SELECT COUNT(DISTINCT id)
         FROM financial_loan),
        2
    ) AS percentage_of_loans
FROM financial_loan
GROUP BY loan_status
ORDER BY loan_count DESC;

-- Which credit grades have the highest charge-off rates?
SELECT
    grade,
    COUNT(*) AS resolved_loans,
    SUM(
        CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END
    ) AS charged_off_loans,
    ROUND(
        100.0 * SUM(
            CASE WHEN loan_status = 'Charged Off'
                 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS charged_off_rate_pct
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Charged Off')
GROUP BY grade
ORDER BY grade;


-- Which loan purposes contribute the most to lending and charge-offs?
SELECT
    purpose,
    COUNT(*) AS resolved_loans,
    SUM(loan_amount) AS funded_amount,
    SUM(
        CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END
    ) AS charged_off_loans,
    ROUND(
        100.0 * SUM(
            CASE WHEN loan_status = 'Charged Off'
                 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS charged_off_rate_pct
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Charged Off')
GROUP BY purpose
ORDER BY funded_amount DESC;


-- Is lending increasing or decreasing over time?
SELECT
    DATE_FORMAT(
        STR_TO_DATE(issue_date, '%d-%m-%Y'),
        '%Y-%m'
    ) AS issue_month,
    COUNT(DISTINCT id) AS loan_count,
    SUM(loan_amount) AS funded_amount
FROM financial_loan
GROUP BY
    DATE_FORMAT(
        STR_TO_DATE(issue_date, '%d-%m-%Y'),
        '%Y-%m'
    )
ORDER BY issue_month;

-- Do longer-term loans have a higher charge-off rate?
SELECT
    term,
    COUNT(*) AS resolved_loans,
    SUM(
        CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END
    ) AS charged_off_loans,
    ROUND(
        100.0 * SUM(
            CASE WHEN loan_status = 'Charged Off'
                 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS charged_off_rate_pct,
    SUM(loan_amount) AS funded_amount
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Charged Off')
GROUP BY term
ORDER BY term;


-- Which states contribute the most to the loan portfolio?
SELECT
    address_state,
    COUNT(*) AS resolved_loans,
    SUM(loan_amount) AS funded_amount,
    SUM(
        CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END
    ) AS charged_off_loans,
    ROUND(
        100.0 * SUM(
            CASE WHEN loan_status = 'Charged Off'
                 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS charged_off_rate_pct
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Charged Off')
GROUP BY address_state
ORDER BY funded_amount DESC
LIMIT 10;


-- How do home ownership and borrower financial profiles relate to charge-offs?
SELECT
    home_ownership,
    COUNT(*) AS resolved_loans,
    SUM(
        CASE WHEN loan_status = 'Charged Off'
             THEN 1 ELSE 0 END
    ) AS charged_off_loans,
    ROUND(
        100.0 * SUM(
            CASE WHEN loan_status = 'Charged Off'
                 THEN 1 ELSE 0 END
        ) / COUNT(*),
        2
    ) AS charged_off_rate_pct,
    ROUND(AVG(annual_income), 2)
        AS average_annual_income,
    ROUND(AVG(dti) * 100, 2)
        AS average_dti_pct
FROM financial_loan
WHERE loan_status IN ('Fully Paid', 'Charged Off')
GROUP BY home_ownership
ORDER BY resolved_loans DESC;

-- Are there missing or duplicate records that could affect reporting?
use project_loan;
SHOW TABLES;


-- Check for duplicate loan IDs
SELECT
    id,
    COUNT(*) AS occurrences
FROM financial_loan
GROUP BY id
HAVING COUNT(*) > 1;


SELECT
    COUNT(*) AS total_rows,
    SUM(CASE WHEN emp_title IS NULL
             THEN 1 ELSE 0 END) AS missing_emp_title,
    SUM(CASE WHEN loan_amount IS NULL
             THEN 1 ELSE 0 END) AS missing_loan_amount,
    SUM(CASE WHEN loan_status IS NULL
             THEN 1 ELSE 0 END) AS missing_loan_status,
    SUM(CASE WHEN issue_date IS NULL
                  OR issue_date = ''
             THEN 1 ELSE 0 END) AS missing_issue_date
FROM financial_loan;


-- Which loan grades contribute the most to charge-offs?
SELECT
    grade,
    COUNT(*) AS charged_off_loans,
    SUM(loan_amount) AS charged_off_funded_amount,
    ROUND(AVG(int_rate) * 100, 2)
        AS average_interest_rate_pct
FROM financial_loan
WHERE loan_status = 'Charged Off'
GROUP BY grade
ORDER BY charged_off_loans DESC;