SELECT empno, ename, sal, deptno   
FROM emp  
WHERE REGEXP_LIKE(ename, '^(S|A)') ;  

select job, count(*) ,count(comm)
from emp
group by job;

select deptno, job, sum(sal), count(*)
from emp
group by deptno, job;

SELECT department_id, job_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY ROLLUP(department_id, job_id);

SELECT department_id, job_id, AVG(salary) AS avg_salary
FROM employees
GROUP BY CUBE(department_id, job_id);

SELECT DEPTNO, JOB, SUM(SAL), COUNT(*) 
  FROM EMP 
 GROUP BY DEPTNO, JOB 

UNION ALL -- 컬럼 개수가 같아야 함!

SELECT DEPTNO, NULL, SUM(SAL), COUNT(*)
  FROM EMP 
 GROUP BY DEPTNO;
 
 insert into dept(deptno, dname)
 values (50, 'HR');

  select *
 from dept;

  insert into emp
 values (8000,'kim', 'salesman', 7788, '25/02/18', 8000, NULL, 30);

 select *
 from emp;

 select current_date
 from dual

ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY-MM-DD HH24:MI:SS';

SELECT SYSDATE FROM DUAL

-- 날짜 비교에는 between and 및 TO_DATE 함수를 추천
-- 날짜 데이터 관련 쿼리 생성 시 TO_DATE를 통해 형 변환을 미리 하는 걸 추천!

-- TRUNC 함수 날짜에 사용 시 DD로 기본 값

INSERT INTO sales_reps(id, name, salary, commission_pct) 
SELECT employee_id, last_name, salary, commission_pct 
FROM   employees 
WHERE  job_id LIKE '%REP%';

SELECT *
  FROM EMP 
 WHERE DEPTNO IN (10, 30) 
UNION
SELECT *
  FROM EMP 
 WHERE DEPTNO IN (20, 30) ; 


-- 연습문제 9

/*1. HR 부서에서 직무 ID ST_CLERK를 포함하지 않는 부서에 대한 부서 ID 리스트를
요구합니다. 집합 연산자를 사용하여 이 보고서를 작성합니다.*/

select DEPARTMENT_ID
from employees
MINUS
select DEPARTMENT_ID
from employees
where job_id LIKE 'ST_CLERK'

/*2. HR 부서에서 부서가 소재하지 않는 국가의 리스트를 요구합니다. 해당 국가의 국가
ID 및 이름을 표시합니다. 집합 연산자를 사용하여 이 보고서를 작성합니다.*/

select COUNTRY_ID, COUNTRY_NAME
from COUNTRIES
where COUNTRY_ID NOT IN (select COUNTRY_ID 
                          from locations);

/*3. 부서 50 및 80에 근무하는 모든 사원의 리스트를 생성합니다. 집합 연산자를 사용하여 사원
ID, 직무 ID 및 부서 ID를 표시합니다.*/

select employee_id, job_id, DEPARTMENT_ID
from employees
where department_id = 50
UNION all
select employee_id, job_id, DEPARTMENT_ID
from employees
where department_id = 80;

/*4. 영업 담당자이며 현재 영업 부서에서 근무 중인 모든 사원의 세부 정보를 나열하는 보고서를
생성합니다.*/

select employee_id
from employees
where 

/*5. HR 부서에서 다음과 같은 사양의 보고서를 요구합니다.
 해당 사원이 부서에 소속되었는지 여부에 관계없이 EMPLOYEES 테이블에 있는 모든
사원의 성 및 부서 ID
 해당 부서에 근무 중인 사원이 있는지 여부에 관계없이 DEPARTMENTS 테이블에 있는
모든 부서의 부서 ID 및 부서 이름
이 보고서를 생성하는 복합 query를 작성합니다.*/

select last_name, department_id, TO_CHAR(NULL) AS DEPT_NAME
from employees
UNIon all
select TO_CHAR(null), department_id, DEPARTMENT_NAME
from departments

--연습문제 10

CREATE TABLE my_employee(
id NUMBER(4) NOT NULL,
last_name VARCHAR2(25),
first_name VARCHAR2(25),
userid VARCHAR2(8),
salary number(9,2)
) ;