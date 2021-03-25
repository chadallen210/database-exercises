use employees;

-- 2.
select distinct last_name
from employees
order by last_name desc
limit 10;
-- Zykh, Zyda, Zwicker, Zweizig, Zumaque, Zultner, Zucker, Zuberek, Zschoche, Zongker

-- 3. 
select *
from employees
where hire_date like '199%'
and birth_date like '%-12-25'
order by hire_date
limit 5;
-- Alselm Cappello, Utz Mandell, Bouchung Schreiter, Baocai Kushner, Petter Stroustrup

-- 4.
select *
from employees
where hire_date like '199%'
and birth_date like '%-12-25'
order by hire_date
limit 5 offset 45;
/*
OFFSET will determine where the returns displayed will begin (i.e. OFFSET = 1 would start the display at the beginning of the results, whereas OFFSET = 50 would begin displaying results at the 51st result). LIMIT will determine the numbers of results returned (i.e. LIMIT = 5 would only display 5 results, whereas LIMIT = 50 would display 50 results). In the example provided, the page number seems to be determined by the limit of 5 results per pages.
*/