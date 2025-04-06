-- CASE 식 사용

SELECT last_name, job_id, NVL(salary,0) salary,
CASE job_id WHEN 'IT_PROG' THEN 1.10*salary
WHEN 'ST_CLERK' THEN 1.15*salary
WHEN 'SA_REP' THEN 1.20*salary
ELSE salary END "REVISED_SALARY"
FROM employees;

-- 검색된 CASE 표현식

SELECT last_name,salary,
(CASE
    WHEN COMMISSION_PCT IS Null THEN 'No Commission'
    WHEN salary<5000 THEN 'Low'
    WHEN salary<10000 THEN 'Medium'
    WHEN salary<20000 THEN 'Good'
    ELSE 'Excellent'
END) qualified_salary
FROM employees
ORDER BY COMMISSION_PCT DESC;

SELECT last_name, job_id, salary,
DECODE(job_id,  'IT_PROG',  1.10 * salary,
                'ST_CLERK', 1.15 * salary,
                'SA_REP',   1.20 * salary, salary)
            REVISED_SALARY
FROM employees;

select AVG(salary) "평균"
from EMPLOYEES
order by salary desc;

select count(job_id)
from employees
order by job_id desc;

/*GROUP BY는 같은 값을 가진 행을 그룹화하여 집계하는 SQL 명령어입니다.
즉, 특정 컬럼을 기준으로 그룹을 만든 후, COUNT(), SUM(), AVG() 등의 집계 함수를 적용할 때 사용됩니다.*/

SELECT JOB_ID, COUNT(*) AS count_per_job
FROM employees
GROUP BY JOB_ID;

SELECT  AVG(salary), MAX(salary),
        MIN(salary), SUM(salary)
FROM employees
WHERE job_id LIKE '%REP%';

SELECT DEPARTMENT_ID, JOB_ID, AVG(salary) "평균 급여"
FROM employees
    where department_id is not null
    GROUP BY JOB_ID, DEPARTMENT_ID
    ORDER BY DEPARTMENT_ID DESC;

SELECT NVL(department_id,0) DEPARTMENT_ID, job_id, COUNT(last_name)
FROM employees
group by department_id, job_id
ORDER BY department_id DESC;

SELECT COUNT(*) 
FROM EMPLOYEES
UNION ALL
SELECT COUNT(COMMISSION_PCT) 
FROM EMPLOYEES;

select count(distinct COMMISSION_PCT)
from employees;

-- GROUP BY 절 사용

SELECT AVG(salary)
FROM employees
GROUP BY department_id;

select department_id, TO_CHAR(AVG(salary), '$999,999,999.000')
from employees
group by department_id
order by department_id;

select max(avg(SALARY)) max_avg_sal
from EMPLOYEES
group by DEPARTMENT_ID

union ALL

select max(avg(salary)) max_avg_sal
from EMPLOYEES
group by DEPARTMENT_ID;

    -- 연습문제 5

/*1. 각 사원에 대해 다음과 같이 출력하는 보고서를 작성합니다.
<employee last name> earns <salary> monthly but wants <3 times salary.>
열 레이블을 Dream Salaries로 지정합니다.*/

select  last_name || ' earns' || TO_CHAR(salary, '$999,999.00') || ' monthly but wants' 
        ||TO_CHAR(salary * 3, '$999,999.00') || '.' AS "Dreams Salaries"
from employees
Order by salary desc; 

/*2. 각 사원의 성, 채용 날짜 및 근무 6개월 후 첫번째 월요일에 해당하는 급여 심의 날짜를
표시합니다. 열 레이블을 REVIEW로 지정합니다. 날짜 형식을 "Monday, the Thirty-First of
July, 2000"과 유사한 형식으로 지정합니다.*/

ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';

select  last_name, hire_date,
        TO_CHAR(NEXT_DAY(ADD_MONTHS(hire_date, 6),'MONDAY'),
                'fmDAY," the" fmddspth "of" fmMONTH "," fmYYYY')
                REVIEW
from    employees;

/*3. 사원의 성 및 커미션 금액을 표시하는 query를 작성합니다. 사원이 커미션을 받지 않으면
"No Commission"을 표시합니다. 열 레이블을 COMM으로 지정합니다.*/

select last_name, nvl(TO_CHAR(commission_pct), 'No Commission') COMM
from employees;

/*4. 다음 데이터를 사용하여 CASE 함수를 통해 JOB_ID 열의 값을 기준으로 모든 사원의
등급을 표시하는 query를 작성합니다.*/

select job_id, 
    case job_id when 'AD_PRES' then 'A'
                when 'ST_MAN' then 'B'
                when 'IT_PROG' then 'C'
                when 'SA_PEP' then 'D'
                when 'ST_CLERK' then 'E'
                else 'O'
                end GRADE
from employees;

--5. 검색된 CASE 구문을 사용하여 앞의 연습에 나오는 명령문을 재작성합니다.

select job_id, 
    (case       when job_id LIKE 'AD_PRES' then 'A'
                when job_id LIKE 'ST_MAN' then 'B'
                when job_id LIKE 'IT_PROG' then 'C'
                when job_id LIKE 'SA_PEP' then 'D'
                when job_id LIKE 'ST_CLERK' then 'E'
                else 'O'
    end) GRADE
from employees;

--6. 검색된 DECODE 구문을 사용하여 앞의 연습에 나오는 명령문을 재작성합니다.

SELECT JOB_ID, 
    DECODE(     JOB_ID, 'AD_PRES', 'A',
                        'ST_MAN', 'B',
                        'IT_PROG', 'C',
                        'SA_PEP', 'D',
                        'ST_CLERK', 'E',
                    'O')
    GRADE
FROM EMPLOYEES;

--연습문제 6

/*5. 각 직무 유형에 대해 최소, 최대, 합계 및 평균 급여를 표시하도록 lab_06_04.sql의
query를 수정합니다. lab_06_04.sql을 lab_06_05.sql로 다시 저장합니다.
lab_06_05.sql의 명령문을 실행합니다.*/

select job_id, max(salary) Maximum, min(salary) Minimum, avg(salary) Average
from EMPLOYEES
group by job_id;

/*6. 동일한 직무를 수행하는 사람 수를 표시하기 위한 query를 작성합니다.*/

SELECT JOB_ID, COUNT(*)
FROM EMPLOYEES
WHERE JOB_ID = '&JOB'
GROUP BY JOB_ID;

/*7. 관리자를 나열하지 않는 채로 관리자 수를 확인합니다. 열 레이블을 Number of
Managers로 지정합니다.
힌트: MANAGER_ID 열을 사용하여 관리자 수를 확인합니다.*/

SELECT COUNT(DISTINCT MANAGER_ID) AS "NUMBER OF MANAGERS"
FROM EMPLOYEES;

--8. 최고 급여와 최저 급여의 차이를 알아냅니다. 열 레이블을 DIFFERENCE로 지정합니다.

SELECT MAX(SALARY) - MIN(SALARY) DIFFERENCE
FROM EMPLOYEES;

/*9. 관리자 번호 및 해당 관리자의 부하 사원 중 최저 급여를 받는 사원의 급여를 표시하는
보고서를 작성합니다. 관리자를 알 수 없는 모든 사원을 제외합니다. 최소 급여가
$6,000 이하인 그룹을 제외합니다. 급여의 내림차순으로 출력을 정렬합니다.*/

SELECT MANAGER_ID, MIN(salary)
from employees
WHERE MANAGER_ID IS NOT NULL
group by MANAGER_ID
HAVING MIN(salary) > 6000
ORDER BY MIN(salary) DESC;

SELECT count(EMPLOYEE_ID)
from employees;


    SELECT COUNT(EMPLOYEE_ID) TOTAL,
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2005',0)) "2005",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2006',0)) "2006",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2007',0)) "2007",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'YYYY'), '2008',0)) "2008"
    from employees;
    
   SELECT COUNT(EMPLOYEE_ID) TOTAL,
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '01',0)) "1월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '02',0)) "2월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '03',0)) "3월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '04',0)) "4월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '05',0)) "5월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '06',0)) "6월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '07',0)) "7월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '08',0)) "8월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '09',0)) "9월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '10',0)) "10월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '11',0)) "11월",
    COUNT(DECODE(TO_CHAR(HIRE_DATE, 'mm'), '12',0)) "12월"
    from employees;

    select TO_CHAR(HIRE_DATE, 'mm')
    from EMPLOYEES;

/*11. 부서 20, 50, 80 및 90에 대해 직무, 부서 번호별 해당 직무에 대한 급여 및 해당 직무에
대한 총 급여를 표시하고 각 열에 적절한 머리글을 지정하기 위한 Matrix query를
작성합니다.*/


    SELECT JOB_ID "JOB",
    SUM(DECODE(DEPARTMENT_ID, 20, SALARY)) "DEPT 20",
    SUM(DECODE(DEPARTMENT_ID, 50, SALARY)) "DEPT 50",
    SUM(DECODE(DEPARTMENT_ID, 80, SALARY)) "DEPT 80",
    SUM(DECODE(DEPARTMENT_ID, 90, SALARY)) "DEPT 90",
    SUM(SALARY) "TOTAL"
    FROM EMPLOYEES
    GROUP BY JOB_ID;
    
    SELECT JOB_ID "JOB",
    SUM(CASE WHEN DEPARTMENT_ID = 20 THEN SALARY END) "DEPT 20",
    SUM(CASE WHEN DEPARTMENT_ID = 50 THEN SALARY END) "DEPT 50",
    SUM(CASE WHEN DEPARTMENT_ID = 80 THEN SALARY END) "DEPT 80",
    SUM(CASE WHEN DEPARTMENT_ID = 90 THEN SALARY END) "DEPT 90",
    SUM(SALARY) "TOTAL"
    FROM EMPLOYEES
    GROUP BY JOB_ID;

-- job_id가 두 개 이상인 부서를 찾으시오

 SELECT DEPARTMENT_ID, COUNT(job_id) "직무별 사원 수"
 from employees
 GROUP BY DEPARTMENT_ID
 HAVING COUNT(job_id) >= 2
 ORDER BY COUNT(job_id) DESC;


 SELECT SUBSTR(job_id, 4, 9), count(distinct DEPARTMENT_ID)
 from employees
 where DEPARTMENT_ID in (20, 50,60, 80, 90)
 GROUP BY SUBSTR(job_id, 4, 9) --DEPARTMENT_ID
 HAVING COUNT(distinct DEPARTMENT_ID) >= 2
 ORDER BY SUBSTR(job_id, 4, 9);

 SELECT 
    SUBSTR(JOB_ID,4),
    DEPARTMENT_ID
    FROM EMPLOYEES
    where DEPARTMENT_ID in (20, 50,60, 80, 90)
    ORDER BY SUBSTR(JOB_ID,4) DESC;

    SELECT SUM(SALARY) "총 급여"
    from employees
    where DEPARTMENT_ID in (20, 50,60, 80, 90);

SELECT   Substr(job_id, 4, 9) "Job", 
         NVL(SUM(DECODE(department_id , 20, salary)),0) "Dept 20", 
         NVL(SUM(DECODE(department_id , 50, salary)),0) "Dept 50", 
         NVL(SUM(DECODE(department_id , 60, salary)),0) "Dept 60", 
         NVL(SUM(DECODE(department_id , 80, salary)),0) "Dept 80", 
         NVL(SUM(DECODE(department_id , 90, salary)),0) "Dept 90",
         sum(salary)
  FROM     employees 
  WHERE  department_id IN ( 20, 50, 60, 80, 90 )
GROUP BY Substr(job_id, 4, 9) 
order by Substr(job_id, 4, 9);

/*7 조인을 사용하여 다중 테이블의 데이터 표시*/

SELECT employee_id, job_id, job_title
from employees Natural join jobs;

SELECT department_id, department_name,
location_id, city
FROM departments
NATURAL JOIN locations
WHERE department_id IN (20, 50);

SELECT employee_id, last_name,
location_id, department_id
FROM employees JOIN departments
USING (department_id);

SELECT e.employee_id, l.city, d.department_name
FROM employees e
JOIN departments d
USING (department_id)
JOIN locations l
USING (location_id);


    SELECT worker.last_name emp, manager.last_name mgr
FROM employees worker JOIN employees manager
ON (worker.manager_id = manager.employee_id);

select shit.last_name emp, fuck.last_name mgr
from EMPLOYEES shit join EMPLOYEES fuck
on shit.MANAGER_ID = fuck.EMPLOYEE_ID;

SELECT ho.employee_id, ho.last_name, ho.department_id,
d.department_id, d.location_id
FROM employees ho JOIN departments d
ON (ho.department_id = d.department_id) ;

SELECT  d.DEPARTMENT_ID, e.last_name, e.salary, d.department_name
FROM    employees e JOIN departments d 
ON      e.department_id = d.department_id;
