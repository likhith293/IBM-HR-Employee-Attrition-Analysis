CREATE DATABASE ibm_hr_analytics;

USE ibm_hr_analytics;
SELECT *
FROM employee_attrition
LIMIT 10;

SELECT COUNT(*) AS total_employees
FROM employee_attrition;

DESCRIBE employee_attrition;

-- Business Question 1: What is the overall employee attrition rate?

SELECT
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition;

-- Business Question 2: Which department has the highest attrition rate?
SELECT
    Department,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY Department
ORDER BY attrition_rate DESC;

-- Business Question 3: Which job roles have the highest attrition rate?

SELECT
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY JobRole
ORDER BY attrition_rate DESC;

-- Business Question 4: Does working overtime increase employee attrition?

SELECT
    OverTime,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY OverTime
ORDER BY attrition_rate DESC;

-- Business Question 5: Do employees who leave have a lower average monthly income?

SELECT 
    Attrition,
    ROUND(AVG(MonthlyIncome), 2) AS average_monthly_income
FROM
    employee_attrition
GROUP BY Attrition;

-- Business Question 6: Do employees who leave have lower average tenure in the company?

SELECT
    Attrition,
    ROUND(AVG(YearsAtCompany), 2) AS average_years_at_company
FROM employee_attrition
GROUP BY Attrition;

-- Business Question 7: Does business travel affect employee attrition?

SELECT
    BusinessTravel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY BusinessTravel
ORDER BY attrition_rate DESC;


-- Business Question 8: Which job roles account for the highest number of employees who left?

SELECT
    JobRole,
    COUNT(*) AS employees_left
FROM employee_attrition
WHERE Attrition = 'Yes'
GROUP BY JobRole
ORDER BY employees_left DESC;

-- Business Question 9: Which job roles have an attrition rate above 20%?

SELECT 
    JobRole,
    COUNT(*) AS total_employees,
    SUM(CASE
        WHEN Attrition = 'Yes' THEN 1
        ELSE 0
    END) AS employees_left,
    ROUND(SUM(CASE
                WHEN Attrition = 'Yes' THEN 1
                ELSE 0
            END) * 100.0 / COUNT(*),
            2) AS attrition_rate
FROM
    employee_attrition
GROUP BY JobRole
HAVING attrition_rate > 20
ORDER BY attrition_rate DESC;

-- Business Question 10: Does stock option level affect employee attrition?

SELECT
    StockOptionLevel,
    COUNT(*) AS total_employees,
    SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END) AS employees_left,
    ROUND(
        SUM(CASE WHEN Attrition = 'Yes' THEN 1 ELSE 0 END)
        * 100.0 / COUNT(*),
        2
    ) AS attrition_rate
FROM employee_attrition
GROUP BY StockOptionLevel
ORDER BY attrition_rate DESC;

