--------------------
-- 오라클 시험
--------------------

-- A06
SELECT last_name, 
        salary, 
        department_name,
        commission_pct
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+)
AND commission_pct IS NOT NULL;

-- A07
SELECT emp.last_name,
    emp.salary,
    emp.job_id
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id
AND man.last_name = 'King';

-- A08
SELECT emp.last_name, 
    emp.salary
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id
AND emp.salary > man.salary;

-- A09
SELECT MIN(salary) min,
    MAX(salary) max,
    SUM(salary) sum,
    ROUND(AVG(salary)) avg
FROM employees;

