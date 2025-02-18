-- GROU BY 절 학습

-- 1. 부서별 평균 급여 조회
SELECT distinct department_id, AVG(salary) AS avg_salary
FROM  employees
GROUP BY department_id;

-- 2. 부서별 직원 수 조회
SELECT department_id, COUNT(distinct EMPLOYEE_ID) AS employee_count
FROM employees
GROUP BY department_id;

-- 3. 직무별(job_id) 급여 합계 조회
SELECT job_id, SUM(salary) AS total_salary
FROM employees
GROUP BY job_id;

-- 4. 부서별 최고 급여 조회
SELECT department_id, MAX(salary) AS max_salary
FROM employees
GROUP BY department_id;

-- 5. 부서별 최소 급여 조회 (부서가 없는 경우 제외)
SELECT department_id, MIN(salary) AS min_salary
FROM employees
WHERE department_id IS NOT NULL
GROUP BY department_id;

-- 6. 부서별 평균 급여가 5000 이상인 부서 조회
SELECT department_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY department_id
HAVING AVG(salary) >= 5000;

-- 7. 직무별(job_id) 직원 수가 5명 이상인 경우만 조회
SELECT job_id, COUNT(*) AS employee_count
FROM employees
GROUP BY job_id
HAVING COUNT(EMPLOYEE_ID) >= 2;

-- 8. 매니저별(manager_id) 관리하는 직원 수 조회
SELECT manager_id, COUNT(*) AS employee_count
FROM employees
WHERE manager_id IS NOT NULL
GROUP BY manager_id;

-- 9. 부서별 급여 총합이 20000 이상인 부서 조회
SELECT department_id, SUM(salary) AS total_salary
FROM employees
GROUP BY department_id
HAVING SUM(salary) >= 20000;

-- 10. 부서별(employee_id) 각 직무(job_id)별 직원 수 조회
SELECT department_id, job_id, COUNT(*) AS employee_count
FROM employees
GROUP BY department_id, job_id;

-- NATURAL JOIN 을 활용한 구문
-- NATURAL JOIN은 두 테이블 사이에 동일한 이름을 가진 열이 있을 때 사용할 수 있는 조인 방법입니다.

SELECT EMPLOYEE_ID, LAST_NAME, JOB_ID, JOB_TITLE
FROM EMPLOYEES NATURAL JOIN JOBS;

select e.EMPLOYEE_ID, e.LAST_NAME, e.DEPARTMENT_ID, d.DEPARTMENT_ID, d.LOCATION_ID
from employees e join departments d
on (e.department_id = d.department_id);

select employee_id, last_name, department_id, department_id, location_id
from employees e natural join departments d;

-- ON 절을 활용한 구문
-- ON 절은 두 테이블 사이에 동일한 이름을 가진 열이 없을 때 사용할 수 있는 조인 방법입니다.

SELECT A.EMPLOYEE_ID, A.FIRST_NAME, A.JOB_ID, B.JOB_ID, B.JOB_TITLE
FROM EMPLOYEES A JOIN JOBS B
ON A.JOB_ID = B.JOB_id;

--USING 절을 활용한 구문
--USING 절은 두 테이블 사이에 동일한 이름을 가진 열이 있을 때 사용할 수 있는 조인 방법입니다.

SELECT EMPLOYEE_ID, LAST_NAME, LOCATION_ID, DEPARTMENT_ID
FROM EMPLOYEES JOIN DEPARTMENTS
USING (DEPARTMENT_ID);

-- 3WAY JOIN
-- 3WAY JOIN은 3개의 테이블을 조인하는 방법입니다.

SELECT  employee_id, city, department_name
FROM    employees e JOIN departments d
ON      d.department_id = e.department_id
JOIN    locations l
ON      d.location_id = l.location_id;

/*ON 절을 활용한 self join
ON 절은 동일한 테이블이나 다른 테이블에서 서로 다른 이름을 가진 열을 조인하는 데도
사용할 수 있습니다.*/

SELECT  worker.last_name emp, manager.last_name mgr
FROM    employees worker JOIN employees manager
ON      (worker.manager_id = manager.employee_id)
MINUS
SELECT worker.last_name emp, manager.last_name mgr
FROM   employees worker JOIN employees manager
ON    (manager.manager_id = worker.employee_id);

SELECT e.last_name, d.department_id, d.department_name
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id) ;

SELECT NVL(e.last_name,0) AS "e.last_name", NVL(d.department_id,0), NVL(d.department_name,0)
FROM employees e FULL OUTER JOIN departments d
ON (e.department_id = d.department_id);

-- Right Outer Join의 다른 표현!

SELECT e.last_name, e.department_id, d.DEPARTMENT_ID,  d.department_name
from employees e, departments d
where e.DEPARTMENT_ID(+) = d.DEPARTMENT_ID;

SELECT e.last_name, e.department_id, d.DEPARTMENT_ID,  d.department_name
from employees e Right outer join departments d
ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID);

select DEPARTMENT_ID, count(*)
from EMPLOYEES
group by DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;

select DEPARTMENT_ID, count(*)
from RETIRED_EMPLOYEES
group by DEPARTMENT_ID
ORDER BY DEPARTMENT_ID;


--1. 부서별 현직 직원과 은퇴 직원 수 비교

select e.DEPARTMENT_ID, r.DEPARTMENT_ID, e.last_name, r.last_name
from employees e LEFT outer join RETIRED_EMPLOYEES r
ON (e.department_id = r.department_id);

SELECT Count(a.employee_id) as Active_Employee, Count(b.employee_id) as Retired_employee
from employees a FULL outer join retired_employees b
ON (a.employee_id = b.employee_id);

--2. 현직 직원과 은퇴 직원 수 및 평균급여 비교

SELECT 'Active Employees' AS category, COUNT(*) AS employee_count, ROUND(AVG(salary), 2) AS avg_salary
FROM employees
UNION ALL
SELECT 'Retired Employees' AS category, COUNT(*) AS employee_count, ROUND(AVG(salary), 2) AS avg_salary
FROM retired_employees;

    --8. subquery 활용

SELECT  last_name, hire_date
FROM    employees
WHERE   hire_date > (   SELECT hire_date
                        FROM employees
                        WHERE last_name = 'Davies')
ORDER BY hire_date;

    -- 연습문제 7

/*1. HR 부서를 위해 모든 부서의 주소를 생성하는 query를 작성합니다. LOCATIONS 및
COUNTRIES 테이블을 사용합니다. 출력에 위치 ID, 동/리, 구/군, 시/도 및 국가를
표시합니다. NATURAL JOIN을 사용하여 결과를 생성합니다.*/

SELECT LOCATION_ID, STREET_ADDRESS, CITY, STATE_PROVINCE, COUNTRY_NAME
FROM LOCATIONS NATURAL JOIN COUNTRIES;

/*2. HR 부서에서 해당 부서가 있는 모든 사원에 대해 보고서를 요구합니다. 이러한 사원의 성,
부서 번호 및 부서 이름을 표시하는 query를 작성합니다.*/

SELECT LAST_NAME, DEPARTMENT_ID, DEPARTMENT_NAME
FROM EMPLOYEES NATURAL JOIN DEPARTMENTS;

/*3. HR 부서에서 Toronto에 근무하는 사원에 대한 보고서를 요구합니다. Toronto에서 근무하는
모든 사원의 성, 직무, 부서 번호 및 부서 이름을 표시합니다.*/

SELECT e.LAST_NAME, e.JOB_ID, e.DEPARTMENT_ID, d.DEPARTMENT_NAME
FROM EMPLOYEES e 
JOIN departments d
ON (e.DEPARTMENT_ID = d.DEPARTMENT_ID)
JOIN locations l
USING (location_id)
WHERE l.city = 'Toronto';


SELECT table_name, column_name 
FROM all_tab_columns 
WHERE column_name = 'DEPARTMENT_ID';

/*4. 사원의 성 및 사원 번호를 해당 관리자의 성 및 관리자 번호와 함께 표시하는 보고서를
작성합니다. 열 레이블을 각각 Employee, Emp#, Manager 및 Mgr#으로 지정합니다. SQL
문을 lab_07_04.sql로 저장합니다. query를 실행합니다.*/

select  a.last_name AS "Employee", a.employee_id AS "EMP#",
        b.last_name AS "Manager", b.employee_id as "MGR#"
FROM    employees a JOIN employees b
ON      (a.manager_id = b.employee_id);

/*5. King을 비롯하여 해당 관리자가 지정되지 않은 모든 사원을 표시하도록 lab_07_04.sql을
수정합니다. 사원 번호순으로 결과를 정렬합니다. SQL 문을 lab_07_05.sql로 저장합니다.
lab_07_05.sql의 query를 실행합니다.*/

select  a.last_name AS "Employee", a.employee_id AS "EMP#",
        b.last_name AS "Manager", b.employee_id as "MGR#"
FROM    employees a LEFT OUTER JOIN employees b
ON      (a.manager_id = b.employee_id);

/*6. HR 부서용으로 사원의 성, 부서 번호 및 지정된 사원과 동일한 부서에서 근무하는 모든
사원을 표시하는 보고서를 작성합니다. 각 열에 적절한 레이블을 지정합니다. 이 스크립트를
lab_07_06.sql이라는 파일에 저장합니다.*/

SELECT  a.DEPARTMENT_ID AS Department, a.last_name AS EMPLOYEE, b.last_name as colleague
 FROM EMPLOYEES a Join employees b
 on (a.DEPARTMENT_ID = b.DEPARTMENT_ID)
 where a.last_name != b.last_name;

SELECT GRADE_LEVEL,
    LOWEST_SAL,
    HIGHEST_SAL FROM JOB_GRADES;

-- 연습문제 8

/*1. HR 부서에서 유저에게 사원의 성을 입력하라는 프롬프트를 표시하는 query를 요구합니다.
그런 다음 이 query는 유저가 제공한 이름을 가진 사원과 동일한 부서에서 근무하는 사원의
성과 채용 날짜를 표시합니다(해당 사원은 제외). 예를 들어, 유저가 Zlotkey를 입력하면
Zlotkey와 함께 근무하는 모든 사원을 찾습니다(Zlotkey는 제외).*/

SELECT department_id, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME = '&LAST_NAME')
AND DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME <> '&LAST_NAME');
-- 문제점 : 어차피 &NAME와 중복되는 ID 값을 출력하기 때문에 WHERE 절에서 이를 제외해야 한다.
-- 수정

SELECT department_id, LAST_NAME, HIRE_DATE
FROM EMPLOYEES
WHERE DEPARTMENT_ID IN (SELECT DEPARTMENT_ID
                        FROM EMPLOYEES
                        WHERE LAST_NAME = '&LAST_NAME')
AND LAST_NAME <> '&LAST_NAME';

/*2. 평균 급여 이상을 받는 모든 사원의 사원 번호, 성 및 급여를 표시하는 보고서를 작성합니다.
급여의 오름차순으로 결과를 정렬합니다.*/

SELECT EMPLOYEE_ID, LAST_NAME, SALARY
FROM EMPLOYEES
WHERE SALARY >= (SELECT AVG(SALARY)
                FROM EMPLOYEES)
ORDER BY SALARY DESC;


/*3. 성에 문자 "u"가 포함된 사원과 같은 부서에 근무하는 모든 사원의 사원 번호와 성을
표시하는 query를 작성합니다. 작성한 SQL 문을 lab_08_03.sql로 저장합니다. query를
실행합니다.*/

SELECT employee_id, last_name, department_id
FROM employees
where department_id IN (select DEPARTMENT_ID
                    from employees
                    where last_name LIKE '%u%')

SELECT *
from departments;

SELECT *
from employees;

/*4. HR 부서에서 부서 위치 ID가 1700인 모든 사원의 성, 부서 ID 및 작업 ID를 표시하는
보고서를 요구합니다.*/

select last_name, department_id, job_id
from employees
where department_id in (select DEPARTMENT_ID
                        from departments
                        where location_id = '&ID');
                        
/*5. HR을 위해 King에게 보고하는 모든 사원의 성과 급여를 표시하는 보고서를 작성합니다.*/

SELECT last_name, salary
from Employees
where job_id LIKE '___MAN' 
OR department_id in (select DEPARTMENT_ID
                        from employees
                        where last_name Like 'King')
AND last_name <> 'King';


SELECT  employee_id, last_name
FROM    employees
WHERE   salary IN
                (   SELECT MIN(salary)
                    FROM employees
                    GROUP BY department_id);

/*6. HR을 위해 Executive 부서의 모든 사원에 대해 부서 ID, 성 및 직무 ID를 표시하는 보고서를
작성합니다.*/

select DEPARTMENT_ID, last_name, JOB_ID
from employees
where department_id = (select DEPARTMENT_ID 
        from departments 
        where department_name like 'Executive') 

/*7. 부서 60의 사원보다 급여가 많은 모든 사원 리스트를 표시하는 보고서를 작성합니다*/

select last_name
from employees
where salary > (select MIN(salary)
                from employees
                where department_id = 60)

/*8. 평균보다 많은 급여를 받고 성에 문자 "u"가 포함된 사원이 속한 부서에서 근무하는 모든
사원의 사원 번호, 성 및 급여를 표시하도록 lab_08_03.sql의 query를 수정합니다.
lab_08_03.sql을 lab_08_08.sql로 다시 저장합니다. lab_08_08.sql의 명령문을
실행합니다.*/

select employee_id, last_name, SALARY
from employees
where salary > (select AVG(SALARY)
                from employees)
and department_id in (select DEPARTMENT_ID
                        from employees
                        where last_name like '%u%')

select employee_id, last_name, SALARY
from employees
where department_id in (select DEPARTMENT_ID
                        from employees
                        where last_name like '%u%')

select *
from employees
where last_name like '%u%'