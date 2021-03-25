use employees;

-- 2. first row = Irena Reutenauer, last row = Vidya Simmen
select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name;

-- 3. first row = Irena Acton, last row = Vidya Zweizig
select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by first_name, last_name;

-- 4. first row = Irena Acton, last row = Maya Zyda
select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya')
order by last_name, first_name;

-- 5. returns 899 records
select *
from employees
where last_name like 'E%e'
order by emp_no;
-- first row = 10021 Ramzi Erde

select *
from employees
where last_name like 'E%e'
order by emp_no desc;
-- last row = 499648 Tadahiro Erde

-- 6. returns 899 records
select *
from employees
where last_name like 'E%e'
order by hire_date desc;
-- newest tenured employee = Teiji Eldridge

select *
from employees
where last_name like 'E%e'
order by hire_date;
-- oldest tenured employee = Sergi Erde

-- 7. returns 362 records 
select *
from employees
where hire_date like '199%'
and birth_date like '%-12-25'
order by birth_date, hire_date desc;
-- oldest employee hired last = Khun Bernini

select *
from employees
where hire_date like '199%'
and birth_date like '%-12-25'
order by birth_date desc, hire_date;
-- youngest employee hired first = Douadi Pettis