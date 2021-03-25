-- 1.
use employees;

-- 2. returns 709 records
select *
from employees
where first_name in ('Irena', 'Vidya', 'Maya');

-- 3. returns 709 records - matches Q2
select *
from employees
where first_name = 'Irena'
	or first_name = 'Vidya'
	or first_name = 'Maya';
	
-- 4. returns 441 records
select *
from employees
where gender = 'M'
and (first_name = 'Irena'
	or first_name = 'Vidya'
	or first_name = 'Maya');
	
-- 5. returns 7330 records
select *
from employees
where last_name like 'E%';

-- 6. returns 30723 records, returns 23393 records
select *
from employees
where last_name like 'E%'
or last_name like '%e';

select *
from employees
where last_name like '%e'
and last_name not like 'E%';

-- 7. returns 899 records, returns 24292 records
select *
from employees
where last_name like 'E%'
and last_name like '%e';

select *
from employees
where last_name like '%e';

-- 8. returns 135214 records
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31';

-- 9. returns 842 records
select *
from employees
where birth_date like '%-12-25';

-- 10. returns 362 records
select *
from employees
where hire_date between '1990-01-01' and '1999-12-31'
and birth_date like '%-12-25';

-- 11. returns 1873 records
select *
from employees
where last_name like '%q%';

-- 12. returns 547 records
select *
from employees
where last_name like '%q%'
and last_name not like '%qu%';