-- Temporary Tables
-- Exercises

USE florence05;

-- 1.Using the example from the lesson, re-create the employees_with_departments table.
 
CREATE TEMPORARY TABLE employees_with_departments AS
	SELECT emp_no, first_name, last_name, dept_no, dept_name
	FROM employees.employees
	JOIN employees.dept_emp USING (emp_no)
	JOIN employees.departments USING (dept_no)
	LIMIT 100;
	
-- 1a. Add a column named full_name to this table. It should be a VARCHAR whose length is the sum of the lengths of the first name and last name columns

DESCRIBE employees_with_departments;

ALTER TABLE employees_with_departments ADD full_name VARCHAR(30);

-- 1b. Update the table so that full name column contains the correct data

UPDATE employees_with_departments
SET full_name = concat(first_name, ' ', last_name);

-- 1c. Remove the first_name and last_name columns from the table.

ALTER TABLE employees_with_departments DROP COLUMN first_name;
ALTER TABLE employees_with_departments DROP COLUMN last_name;

-- 1d. What is another way you could have ended up with this same table?

-- When creating the temporary table, could have used CONCAT to combine first_name and last_name into full_name.
/* 
CREATE TEMPORARY TABLE employees_with_departments AS
	SELECT emp_no, concat(first_name, ' ', last_name) as full_name, dept_no, dept_name
	FROM employees.employees
	JOIN employees.dept_emp USING (emp_no)
	JOIN employees.departments USING (dept_no)
	LIMIT 100;
*/

-- 2. Create a temporary table based on the payment table from the sakila database.

CREATE TEMPORARY TABLE temp_payment AS 
	SELECT *
	FROM sakila.payment;
	
-- Write the SQL necessary to transform the amount column such that it is stored as an integer representing the number of cents of the payment. For example, 1.99 should become 199.
	
-- amount data type is dec(5,2), will need to be dec(7,2) before converting	
ALTER TABLE temp_payment MODIFY COLUMN amount DECIMAL(7,2);

-- convert dollars.cents into only cents
UPDATE temp_payment SET amount = amount * 100;

-- change data type from dec(7,2) to INT
ALTER TABLE temp_payment MODIFY COLUMN amount INT;

-- 3. Find out how the current average pay in each department compares to the overall, historical average pay. In order to make the comparison easier, you should use the Z-score for salaries. In terms of salary, what is the best department right now to work for? The worst?

