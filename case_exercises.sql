-- Case Statements
-- Exercises

USE employees;

-- 1. Write a query that returns all employees (emp_no), their department number, their start date, their end date, and a new column 'is_current_employee' that is a 1 if the employee is still with the company and 0 if not.

SELECT dept_emp.emp_no, dept_no, from_date, a.max_date,
	a.max_date > curdate() AS is_current_employee	
FROM dept_emp
JOIN (
	SELECT emp_no, max(to_date) AS max_date
	FROM dept_emp
	GROUP BY emp_no) AS a ON a.emp_no = dept_emp.emp_no
	AND a.max_date = dept_emp.to_date;

-- 2. Write a query that returns all employee names (previous and current), and a new column 'alpha_group' that returns 'A-H', 'I-Q', or 'R-Z' depending on the first letter of their last name.

SELECT concat(first_name, ' ', last_name) AS 'Full Name',
	CASE
	WHEN last_name <= 'H%' THEN 'A-H'
	WHEN last_name <= 'Q%' THEN 'I-Q'
	WHEN last_name >= 'R%' THEN 'R-Z'
	END AS 'alpha_group'
FROM employees;

-- 3. How many employees (current or previous) were born in each decade?

SELECT count(*),
	CASE
	WHEN birth_date LIKE '195%' THEN '1950''s'
	WHEN birth_date LIKE '196%' THEN '1960''s'
	END AS decade
FROM employees
GROUP BY decade;

-- BONUS. What is the current average salary for each of the following department groups: R&D, Sales & Marketing, Prod & QM, Finance & HR, Customer Service?

SELECT AVG(salary),
	CASE dept_name
		WHEN dept_name IN ('research', 'development') THEN 'R&D'
        WHEN dept_name IN ('sales', 'marketing') THEN 'Sales & Marketing' 
        WHEN dept_name in ('Production', 'Quality Management') THEN 'Prod & QM'
        ELSE dept_name
        END AS dept_group
FROM salaries
JOIN dept_emp ON dept_emp.emp_no = salaries.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
WHERE salaries.to_date > curdate()
GROUP BY dept_group;
