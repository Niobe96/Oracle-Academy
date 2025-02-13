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

SELECT JOB_ID, 
    DECODE(     JOB_ID, 'AD_PRES', 'A',
                        'ST_MAN', 'B',
                        'IT_PROG', 'C',
                        'SA_PEP', 'D',
                        'ST_CLERK', 'E',
                    'O')
    GRADE
FROM EMPLOYEES;