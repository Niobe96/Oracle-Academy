select sysdate from dual;
ALTER SESSION SET NLS_DATE_FORMAT = 'YYYY/MM/DD';

select sysdate from dual;

-- SQL_복습문제.sql

-- EMP 테이블에서 이름(ENAME)에 ‘A’과 ‘M’이 모두 포함된 사원 정보를 검색하시오.

select ename from emp where ename like '%A%' and ename like '%M%';

--EMP 테이블에서 이름(ENAME)이 ‘S’ 또는 ‘A’로 시작하는 사원 정보를 검색하시오.

select ename from emp where ename like 'S%' or ename like 'A%';

--EMP 테이블에서, 1981년에 입사한 사원 정보를 검색하시오. (HIREDATE : 입사일자)

select empno, ename, hiredate, deptno
from EMP
where extract(year from hiredate) = '1981';

--EMP 테이블에서, 4월에 입사한 사원을 검색하시오. (HIREDATE : 입사일자)

select empno, ename, hiredate, deptno
from EMP
where extract(month from hiredate) = '04';

--연도에 상관없이 각월 16일전에 입사한 사원을 검색하시요.

select empno, ename, hiredate, deptno
from EMP
where extract(day from hiredate) <= '15';

/*사원의 이름 및 커미션 금액을 표시하는 query를 작성합니다. 
사원이 커미션을 받지 않으면 "No Commission"을 표시합니다. 
열 레이블을 COMM으로 지정합니다.*/

select ename, NVL(TO_CHAR(COMM), 'No commission') COMM
from emp;

--EMP 테이블에서 연봉(SAL*12) 이 35000 이상인 사원 정보를 검색하시오.

select empno, ename, sal * 12 AS ANN_SAL, DEPTNO
from emp
where sal * 12 >= 35000;

--EMPLOYEES 테이블에서 CASE와 DECODE 함수를 이용해 JOB_ID 열의 값을 기준으로 
--모든 사원의 등급을 표시하는 query를 작성합니다.

select JOB_ID, decode(JOB_ID, 'AD_PRES', 'A',
                              'ST_MAN', 'B',
                              'IT_PROG', 'C',
                              'SA_REP', 'D',
                              'ST_CLERK', 'E',
                                '0') AS GRADE
from employees;

/*EMPLOYEES 테이블에서 사원의 총 수와 그 총 수 중 2005년, 2006년, 2007년, 2008년에 채용된(HIRE_DATE) 사원의 수를 검색하시오.*/

SELECT count(*) TOTAL,
        SUM(DECODE(extract(year from hire_DATE), 2005,1,0)) AS "2005",
        SUM(DECODE(extract(year from hire_DATE), 2006,1,0)) AS "2006",
        SUM(DECODE(extract(year from hire_DATE), 2007,1,0)) AS "2007",
        SUM(DECODE(extract(year from hire_DATE), 2008,1,0)) AS "2008"
from EMPLOYEES;

/*EMPLOYEES, DEPARTMENTS 를 조인하여 각 사원정보의 소속 부서의 LOCATION_ID를 다음과 같이 표시하시요.*/

select e.employee_id, e.last_name, e.department_id AS "DEPARTMENT_ID", d.department_id AS "DEPARTMENT_ID", d.location_id
from employees e join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--부서 번호 20, 50 번 부서의 부서번호, 부서이름과 부서가 위치한 도시명을 다음과 같이 표시하시요.

select d.department_id, d.department_name, l.city
from DEPARTMENTS D join LOCATIONS L on D.LOCATION_ID = L.LOCATION_ID
where d.department_id in (20, 50);

SELECT count(*) TOTAL,
        count(DECODE(extract(year from hire_DATE), 2005,1)) AS "2005",
        count(DECODE(extract(year from hire_DATE), 2006,1)) AS "2006",
        count(DECODE(extract(year from hire_DATE), 2007,1)) AS "2007",
        count(DECODE(extract(year from hire_DATE), 2008,1)) AS "2008"
from EMPLOYEES;

select * from employees;

SELECT empno, ename, job, NVL(TO_CHAR(mgr), 'NO Manager') manager
FROM emp;

select ename, job, sal, 
        case job when 'CLERK' then sal * 1.1
                    when 'MANAGER' then sal * 1.15
                    when 'ANALYST' then sal*1.20 
                    ELSE sal END revised_SALARY
from emp;

select  
    case 
    when sal >= '3000' then 'Excellent'
     when sal >= '2000' then 'Good' 
     when sal >= '1000' then 'Medium'
     ELSE 'LOW' END  GRADE,
     count(*) grade_cnt
from emp
group by 
    case 
    when sal >= '3000' then 'Excellent'
     when sal >= '2000' then 'Good' 
     when sal >= '1000' then 'Medium'
     ELSE 'LOW'
    end;

select ename, job, sal, decode(job, 'CLERK', 1.10*sal,
                                    'MANAGER',1.15*sal,
                                    'ANALYST',1.20*sal,
                                            sal) revised_SALARY
from emp;

SELECT
    employee_id,
    last_name,
    NULL AS temp_column
FROM employees;

SELECT sales_date, product_id, USER_ID, SALES_AMOUNT
FROM ONLINE_SALE
WHERE sales_date BETWEEN TO_DATE('2022-03-01', 'YYYY-MM-DD')
                     AND TO_DATE('2022-03-31', 'YYYY-MM-DD')
UNION ALL

SELECT sales_date, product_id, CAST(NULL AS NUMBER) AS USER_ID, SALES_AMOUNT
FROM OFFLINE_SALE
WHERE sales_date BETWEEN TO_DATE('2022-03-01', 'YYYY-MM-DD')
                     AND TO_DATE('2022-03-31', 'YYYY-MM-DD')
order by sales_date, product_id, user_id;

--EMPLOYEES 테이블에서 각 사원의 이름(LAST_NAME)과 매니저의 이름(LAST_NAME)을 검색하시오

select a.last_name as WORKER, b.last_name
from employees a join employees b on a.manager_id = b.employee_id;

--PERSON 테이블에서 부모 정보가 있는 사람들의 이름(FIRST_NAME) 및 부모의 이름(FIRST_NAME)을 검색하시오.

select C.first_name AS child_name, M.first_name AS mother_name, F.first_name as father_name
from person C join person M on c.mother_id = M.id join person F on C.father_id = f.id;

--EMPLOYEES, JOB_GRADES 테이블을 참조하여 각 사원의 급여 등급을 검색하시오.

select e.last_name, e.salary, j.grade_level
from employees e, job_grades J
where e.SALARY BETWEEN J.LOWEST_SAL AND J.HIGHEST_SAL;

--COLOR 테이블에서 NAME 값이 중복되는 것을 찾아 다음과 같이 검색하시오.

select a.ID, a.NAME, b.ID, b.NAME
from COLOR A join color b on a.name = b.name
where a.name = b.name
and a.id < b.id;

/*EMPLOYEES, DEPARTMENTS 테이블에서 전 부서의 이름과 해당부서에 소속된 사원의 정보를
검색하시오.*/

select e.last_name, e.department_id, d.department_id, d.department_name
from employees e right outer join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

--EMPLOYEES, DEPARTMENTS 테이블에서 전 사원의 정보에 소속 부서 이름을 검색하시오.

select e.last_name, e.department_id, d.department_id, d.department_name
from employees e left outer join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID;

/*EMPLOYEES, DEPARTMENTS 테이블을 이용하여 전 부서의 이름과 해당부서에 소속된 사원의
정보를 검색하시오. 단, 급여를 10000 이상 받는 사원의 정보만 검색합니다.*/

select d.department_id, d.department_name, e.last_name, e.salary
from DEPARTMENTS d left outer join (select * from employees where salary >= 10000) e on d.DEPARTMENT_ID = e.DEPARTMENT_ID;

