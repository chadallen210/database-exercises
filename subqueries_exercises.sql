
-- Subqueries Exercises

USE employees;

-- 1. Find all the current employees with the same hire date as employee 101010 using a sub-query.

SELECT concat(first_name, ' ', last_name) AS 'Full Name', hire_date
FROM employees
WHERE hire_date = (
	SELECT hire_date
	FROM employees
	WHERE emp_no = 101010
)
AND emp_no IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate()
	);
-- returns 55 records

-- 2. Find all the titles ever held by all current employees with the first name Aamod.
	
SELECT DISTINCT title
FROM titles
WHERE to_date > curdate()
AND emp_no IN (
	SELECT emp_no
	FROM employees
	WHERE first_name = 'Aamod'
);
-- returns 6 records, returns 168 records without the DISTINCT filter

-- 3. How many people in the employees table are no longer working for the company? Give the answer in a comment in your code.
	
SELECT *
FROM employees
WHERE emp_no NOT IN (
	SELECT emp_no
	FROM dept_emp
	WHERE to_date > curdate()
);
-- returns 59900 records

-- 4. Find all the current department managers that are female. List their names in a comment in your code.
	
SELECT concat(first_name, ' ', last_name) AS Fullname, gender
FROM employees
WHERE gender = 'F'
AND emp_no IN (
	SELECT emp_no
	FROM dept_manager
	WHERE to_date > curdate()
);
-- returns 4 records - Isamu Legleitner, Karsten Sigstam, Leon DasSarma, Hilary Kambil

-- 5. Find all the employees who currently have a higher salary than the companies overall, historical average salary.
	
SELECT *
FROM employees
WHERE emp_no IN (
	SELECT emp_no
	FROM salaries
	WHERE to_date > curdate()
	AND salary > (
		SELECT AVG(salary)
		FROM salaries)
);
-- returns 154543 records

-- 6. How many current salaries are within 1 standard deviation of the current highest salary? (Hint: you can use a built in function to calculate the standard deviation.) What percentage of all salaries is this?
		
SELECT count(salary)
FROM salaries
WHERE to_date > curdate()
AND salary > (
	SELECT (max(salary) - std(salary))
	FROM salaries
	WHERE to_date > curdate()
);
-- returns 83 records

SELECT (
	SELECT count(salary)
	FROM salaries
	WHERE to_date > curdate()
	AND salary > (
		SELECT (max(salary) - std(salary))
		FROM salaries
		WHERE to_date > curdate())
)
/
(SELECT count(salary)
FROM salaries
WHERE to_date > curdate()) * 100 AS '%';
-- returns 0.0346%

-- BONUS
-- 1. Find all the department names that currently have female managers.

SELECT dept_name AS 'Department Name'
FROM departments
JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN (
	SELECT emp_no
	FROM employees
	WHERE gender = 'F'
	AND emp_no IN (
		SELECT emp_no
		FROM dept_manager
		WHERE to_date > curdate())) AS a ON a.emp_no = employees.emp_no
;

		
-- 2. Find the first and last name of the employee with the highest salary.

SELECT concat(first_name, ' ', last_name) AS 'Full Name'
FROM employees
WHERE emp_no = (
	SELECT emp_no
	FROM salaries
	WHERE to_date > curdate()
	ORDER BY salary DESC
	LIMIT 1
);
-- returns Tokuyasu Pesch

-- 3. Find the department name that the employee with the highest salary works in.

SELECT dept_name AS 'Department'
FROM departments
WHERE dept_no = (
	SELECT dept_no
	FROM dept_emp
	WHERE emp_no = (
		SELECT emp_no
		FROM salaries
		WHERE to_date > curdate()
		ORDER BY salary DESC
		LIMIT 1)
);
-- returns Sales