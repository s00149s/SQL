--------------------
-- JOIN
--------------------

-- employees와 departments 테이블 확인
DESC employees;
DESC departments;

SELECT * FROM employees; -- 107
SELECT * FROM departments; -- 27

SELECT first_name, department_name
FROM employees, departments;    
-- 단순히 출력만 해주면 두 테이블의 조합 가능한 모든 쌍이 출력(107 * 27)
-- 카티전 프로덕트, Cross Join
-- 일반적으로 잘 쓰지 않음

-- 두 테이블의 연결 조건을 WHERE에 부여 -> Simple join
SELECT *
FROM employees, departments
WHERE employees.department_id = departments.department_id;   -- 106명
--  두 개의 컬럼의 모호성 발생, 테이블명 명시해줌으로서 모호성의 해소

-- 필드의 모호성을 해소하기 위해 테이블명 혹은 alias를 부여
SELECT emp.first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id;

-- INNER JOIN
SELECT emp.first_name,
    dept.department_name
FROM employees emp JOIN departments dept
                    USING (department_id);
SELECT first_name,
    department_name
FROM employees emp JOIN departments dept
                    ON emp.department_id = dept.department_id;
                    --  ON은 JOIN의 조건을 명시할 때 사용

SELECT first_name, department_name
FROM employees NATURAL JOIN departments;    --  Natural JOIN
-- 같은 이름을 가진 컬럼을 기준으로 JOIN

-- Theta JOIN
-- 특정 조건을 기준으로 JOIN을 하되
-- 조건이 =이 아닌 경우
-- NON EQUI JOIN이라고 한다
SELECT * FROM jobs WHERE job_id = 'FI_MGR';


SELECT first_name, salary FROM employees emp, jobs j
WHERE j.job_id='FI_MGR' AND salary BETWEEN j.min_salary AND j.max_salary;

----------------------
-- OUTER JOIN
----------------------
-- 조건이 만족하는 짝이 없는 레코드도 null을 포함하여 결과를 출력
-- 모든 레코드를 출력할 테이블이 어느 쪽에 있는가에 따라서 LEFT, RIGHT, FULL로 나눔
-- 전체 사원 수
SELECT COUNT(*) FROM employees; -- 107명의 사원

-- 부서 id가 null인 직원
SELECT first_name, department_id
FROM employees
WHERE department_id IS NULL; --106

-- LEFT OUTER JOIN: 짝이 없어도 왼쪽의 테이블 전체를 출력에 참여
-- ORACLE SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id = dept.department_id (+);

-- ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp LEFT OUTER JOIN departments dept
                        ON emp.department_id = dept.department_id;

-- RIGHT OUTER JOIN
-- 오른쪽 테이블의 모든 레코드를 출력에 참여시킴 -> 왼쪽 테이블에 매칭되는 짝이 없는 경우
-- 왼쪽 테이블 컬럼이 NULL로 표기된다
-- ORACLE SQL
SELECT
    first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp, departments dept
WHERE emp.department_id (+) = dept.department_id;

--ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp RIGHT OUTER JOIN departments dept
                    ON emp.department_id = dept.department_id;

-- FULL OUTER JOIN
-- 양쪽 테이블 모두 짝이 없어도 출력에 참여
-- ERROR
--SELECT first_name,
--    emp.department_id,
--    dept.department_id,
--    department_name
--FROM employees emp, departments dept
--WHERE emp.department_id (+) = dept.department_id (+);

-- ANSI SQL
SELECT first_name,
    emp.department_id,
    dept.department_id,
    department_name
FROM employees emp FULL OUTER JOIN departments dept
                        ON emp.department_id = dept.department_id;
                        
-- 3중 JOIN 연습
-- 부서 ID, 부서명, 속한 도시명, 속한 국가명을 출력
SELECT department_id,
    department_name,
    city,
    country_name
FROM departments dept, locations loc JOIN countries co
                                ON loc.country_id = co.country_id
WHERE dept.location_id = loc.location_id
ORDER BY dept.department_id asc;

-- OR
SELECT department_id,
    department_name,
    city,
    country_name
FROM departments dept,
    locations loc,
    countries co
WHERE dept.location_id = loc.location_id AND
    loc.country_id = co.country_id
ORDER BY department_id ASC;

--------------
-- SELF JOIN
--------------
-- 자기 자신과 JOIN
-- 한 개 테이블을 두 번 이상 사용해야 하므로 반드시 alias 사용
SELECT * FROM employees;    -- 107명

-- 사원의 아이디, 사원 이름, 매니저 아이디, 매니저 이름
SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
FROM employees emp JOIN employees man
                    ON emp.manager_id = man.employee_id; -- 106
                    
-- OR
SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id;

-- manager가 없는 사람?
SELECT * FROM employees
WHERE manager_id IS NULL;

-- manager가 없는 사람도 출력(outer join)
SELECT emp.employee_id,
    emp.first_name,
    emp.manager_id,
    man.first_name
FROM employees emp, employees man
WHERE emp.manager_id = man.employee_id (+);