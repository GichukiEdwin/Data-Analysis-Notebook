-- Finding the maximum salary using window/analytic fns

SELECT MAX(salary) AS maximum_salary
FROM employee;

SELECT department, MAX(salary) AS maximum_salary
FROM employee
GROUP BY department
ORDER BY maximum_salary DESC;

--Finding the maximum salary and return all other details of the table with the help of OVER clause (aggregate fns)
SELECT employee.*,
MAX(salary) OVER() AS maximum_salary
FROM employee;

SELECT employee.*,
ROW_NUMBER() OVER() AS row_numbe_r
FROM employee;

--partion by

SELECT employee.*,
MAX(salary) OVER(PARTITION BY department) AS maximum_salary
FROM employee;

SELECT employee.*,
ROW_NUMBER() OVER(PARTITION BY department) AS row_numbe_r
FROM employee;

-- Subqueries
-- Fetch the first 2 employees from each department to join the company

SELECT employee.*,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY employee_id) AS row_numbe_r
FROM employee;

SELECT * FROM (
	SELECT employee.*, ROW_NUMBER() OVER(PARTITION BY department ORDER BY employee_id) AS row_numbe_r
	FROM employee) AS table_1
WHERE table_1.row_numbe_r < 3;

-- RANK()
-- Requirement; Fetch the top 3 employees in each department earning the maximum salary using RANK() or DENSE()

SELECT employee.*,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_column
FROM employee;

SELECT *
FROM (
SELECT employee.*,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_column
FROM employee) AS new_emp
WHERE new_emp.rank_column < 4;

--alternative solution using ROW_NUMBER()

with ranked_employees as (
select employee.*,
row_number() over(partition by department order by salary desc) as row_column
from employee)
select *
from ranked_employees
where row_column < 4;

-- DENSE_RANK
SELECT employee.*,
DENSE_RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS dense_rank_column,
RANK() OVER(PARTITION BY department ORDER BY salary DESC) AS rank_column,
ROW_NUMBER() OVER(PARTITION BY department ORDER BY salary DESC) AS row_colomn
FROM employee;

--which employees share the same salary rank in each department


-- LEAD() LAG()

SELECT employee.*,
LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) AS lag_salary,
LEAD(salary) OVER(PARTITION BY department ORDER BY employee_id) AS lead_salary
FROM employee;

-- fetch a query to check if the salary of an employee is higher lower or equal to that of the previous employee
SELECT employee.*,
LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) AS lag_salary,
CASE
WHEN LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) > salary THEN 'previous salary is higher than current salary'
WHEN LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) < salary THEN 'previous salary is lower than current salary'
WHEN LAG(salary) OVER(PARTITION BY department ORDER BY employee_id) = salary THEN 'previous salary is equal to current salary'
END AS comparison
FROM employee;


