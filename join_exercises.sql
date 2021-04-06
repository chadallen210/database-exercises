-- Joins Exercises

-- Join Example Database
-- 1. Use the join_example_db. Select all the records from both the users and roles tables.

USE join_example_db;

SELECT *
FROM users
JOIN roles;

-- 2. Use join, left join, and right join to combine results from the users and roles tables as we did in the lesson. Before you run each query, guess the expected number of results.

SELECT *
FROM users
JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
LEFT JOIN roles ON users.role_id = roles.id;

SELECT *
FROM users
RIGHT JOIN roles ON users.role_id = roles.id;

-- 3. Although not explicitly covered in the lesson, aggregate functions like count can be used with join queries. Use count and the appropriate join type to get a list of roles along with the number of users that has the role. Hint: You will also need to use group by in the query.

SELECT roles.name, count(users.role_id) AS role_count
FROM roles
LEFT JOIN users ON users.role_id = roles.id
GROUP BY roles.name;


-- Employees Database
-- 1. Use the employees database.

USE employees;

-- 2. Using the example in the Associative Table Joins section as a guide, write a query that shows each department along with the name of the current manager for that department.

SELECT dept_name AS 'Department Name', concat(first_name, ' ', last_name) AS 'Department Manager'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date > curdate()
ORDER BY dept_name ASC;

-- 3. Find the name of all departments currently managed by women.

SELECT dept_name AS 'Department Name', concat(first_name, ' ', last_name) AS 'Department Manager'
FROM departments
JOIN dept_manager ON departments.dept_no = dept_manager.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date > curdate() 
AND employees.gender = 'F'
ORDER BY dept_name ASC;

-- 4. Find the current titles of employees currently working in the Customer Service department.

SELECT title AS 'Title', count(title) AS 'Count'
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN titles ON titles.emp_no = dept_emp.emp_no
WHERE departments.dept_name = 'Customer Service' 
AND dept_emp.to_date > curdate() 
AND titles.to_date > curdate()
GROUP BY title;

-- 5. Find the current salary of all current managers.

SELECT dept_name AS 'Department Name', concat(first_name, ' ', last_name) AS 'Name', salary AS 'Salary'
FROM departments
JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON salaries.emp_no = dept_manager.emp_no
WHERE dept_manager.to_date > curdate()
AND salaries.to_date > curdate()
ORDER BY dept_name ASC;

-- 6. Find the number of current employees in each department.

SELECT departments.dept_no, dept_name, count(*) AS num_employees
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
WHERE dept_emp.to_date > curdate()
GROUP BY dept_no
ORDER BY departments.dept_no;

-- 7. Which department has the highest average salary? Hint: Use current not historic information.

SELECT dept_name, AVG(salary) AS 'average_salary'
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN salaries ON salaries.emp_no = dept_emp.emp_no
WHERE dept_emp.to_date > curdate()
AND salaries.to_date > curdate()
GROUP BY dept_name
ORDER BY average_salary DESC
LIMIT 1;

-- 8. Who is the highest paid employee in the Marketing department?

SELECT first_name, last_name
FROM departments
JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = dept_emp.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE departments.dept_no IN ('d001')
ORDER BY salary DESC
LIMIT 1;

-- 9. Which current department manager has the highest salary?

SELECT first_name, last_name, salary, dept_name
FROM departments
JOIN dept_manager ON dept_manager.dept_no = departments.dept_no
JOIN employees ON employees.emp_no = dept_manager.emp_no
JOIN salaries ON salaries.emp_no = employees.emp_no
WHERE dept_manager.to_date > curdate()
AND salaries.to_date > curdate()
ORDER BY salary DESC
LIMIT 1;

-- 10. Bonus Find the names of all current employees, their department name, and their current manager's name.

SELECT concat(e1.first_name, ' ', e1.last_name) AS 'Employee Name', dept_name AS 'Department Name', concat(e2.first_name, ' ', e2.last_name) AS 'Manager Name'
FROM dept_emp

JOIN employees  AS e1 ON e1.emp_no = dept_emp.emp_no

JOIN departments ON departments.dept_no = dept_emp.dept_no

JOIN dept_manager ON dept_manager.dept_no = dept_emp.dept_no

JOIN employees  AS e2 ON e2.emp_no = dept_manager.emp_no

WHERE dept_emp.to_date > curdate()
AND dept_manager.to_date > curdate();

-- 11. Who is the highest paid employee within each department.

SELECT concat(employees.first_name, ' ', employees.last_name) AS 'Employee Name', 'Salary', 'Department Name'
FROM salaries
JOIN employees ON employees.emp_no = salaries.emp_no
JOIN dept_emp ON dept_emp.emp_no = employees.emp_no
JOIN departments ON departments.dept_no = dept_emp.dept_no
JOIN (
	SELECT max(salary) AS 'Salary', departments.dept_name AS 'Department Name'
	FROM departments
	JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
	JOIN salaries ON salaries.emp_no = dept_emp.emp_no
	WHERE salaries.to_date > curdate()
	AND dept_emp.to_date > curdate()
	GROUP BY dept_emp.dept_no) AS a ON a.dept_no = departments.dept_no
	AND a.salary = salaries.salary
WHERE dept_emp.to_date > curdate()
AND salaries.to_date > curdate();

SELECT max(salary) AS 'Salary', departments.dept_name AS 'Department Name'
	FROM departments
	JOIN dept_emp ON dept_emp.dept_no = departments.dept_no
	JOIN salaries ON salaries.emp_no = dept_emp.emp_no
	WHERE salaries.to_date > curdate()
	AND dept_emp.to_date > curdate()
	GROUP BY dept_emp.dept_no;