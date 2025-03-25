SELECT t1.deptno, t1.job, t2.avg_sal
FROM (SELECT t11.deptno, t12.job
FROM (SELECT DISTINCT deptno FROM dept) t11
, (SELECT DISTINCT job FROM emp) t12
) t1
, (SELECT deptno, job, avg(sal) avg_sal
FROM emp
GROUP BY deptno, job) t2
WHERE t1.deptno=t2.deptno(+)
AND t1.job =t2.job(+)
ORDER BY 1,2;

--Toronto(LOCATIONS.CITY)에서 근무하는 모든 사원의 이름, 직무, 부서 번호 및 부서 이름을 표시하세요.

select e.last_name, e.job_id, e.department_id, d.DEPARTMENT_NAME
from employees e join DEPARTMENTS d on e.department_id = d.department_id
where e.department_id = 20; 

--모든 사원의 이름과 사번, 관리자 이름과 관리자 사번을 표시하시요.

select a.last_name as Employee, a.employee_id as EMP#, b.last_name as Manager, b.employee_id
 from employees a left outer join employees b on a.MANAGER_ID = b.EMPLOYEE_ID;

 --모든 사원의 이름, 직무, 부서 이름, 급여 및 급여 등급을 표시하시요.
--(급여 등급 정보는JOB_GRADES 테이블에 있습니다.)

select e.last_name, e.job_id, d. department_name, e.salary, g.grade_level AS grade
from EMPLOYEES e left outer join DEPARTMENTS d on e.DEPARTMENT_ID = d.DEPARTMENT_ID 
                join JOB_GRADES g on e.SALARY BETWEEN g.LOWEST_SAL and g.highest_sal;

select * from emp_kind
 order by emp_kind;
select * from emp;
SELECT * from DEPARTMENTS;

/*다음의 테이블을 이용하여 각 사원들의 급여정보를 검색하시요.
정규직 사원일 경우에는 EMP_KIND1 테이블의 OFFICE_SAL, 비정규직일 경우는 EMP_KIND2 테이블의 SAL 컬럼 검색*/

select empno, ename, sal as OFFICE_SAL, NULL AS sal
from EMP_KIND
where emp_kind = 1
UNION ALL
select empno, ename, NULL as OFFICE_SAL, sal 
from EMP_KIND
where emp_kind = 2;

-- 부서별 AVG 와 모든 부서의 AVG를 한 테이블에 표시하는 방법!

SELECT 
    d.department_name,
    ROUND(AVG(e.salary), 2) AS dept_avg_salary,
    (SELECT ROUND(AVG(salary), 2) FROM employees) AS total_avg_salary
FROM 
    employees e
LEFT JOIN 
    departments d ON e.department_id = d.department_id
GROUP BY 
    d.department_name;

/*EMPLOYEES 테이블에서 사번(EMPLOYEE_ID)이 141 인 사원과 같은 직무(JOB_ID)이며 급여(SALARY)는 적게 받는 사원을 검색하시오.*/

select last_name, job_id, SALARY
from EMPLOYEES
where JOB_id = (select JOB_ID from EMPLOYEES where employee_id = 141) 
    AND SALARY < (select SALARY from employees  where employee_id = 141)
order by SALARY DESC;

--EMPLOYEES 테이블에서 최소급여를 받는 사원의 이름과 급여를 검색하시오.

select last_name, salary 
from employees
where salary = (select MIN(salary)
                    from employees);

--EMPLOYEES 테이블에서 평균 급여가 가장 낮은 직무(JOB_ID)를 찾아 검색하시오.

select job_id, avg(salary)
from EMPLOYEES
group by job_id
order by 2 
fetch first 1 row only;

select * from employees;

/*EMPLOYEES 테이블에서 관리자인 사원들의 이름을 검색하시오.*/

select LAST_NAME
from EMPLOYEES
where employee_id in (select manager_id from employees);

--EMPLOYEES 테이블에서 관리자가 아닌 사원들의 이름을 검색하시오.

select LAST_NAME
from EMPLOYEES
where employee_id not in (select NVL(manager_id,0) from employees);

/*EMPL_DEMO 테이블에서 FIRST_NAME이 ‘John’인 사원과 매니저, 부서 둘 다 일치하는 사원을
검색하시오.*/

create table EMPL_DEMO AS select * from employees;

select * from DEPARTMENTS;

/*[문제 9]
EMPL_DEMO 테이블에서 이름(FIRST_NAME)이 ‘John’인 사원의 매니저 사번(MANAGER_ID),
부서 번호(DEPARTMENT_ID) 둘 다 일치하는 사원을 검색하시오.*/

select employee_id, manager_id, department_id
from EMPL_DEMO
where (manager_id, department_id) in (select manager_id, DEPARTMENT_ID
                                        from EMPL_DEMO
                                        where first_name = 'John');


/*[문제 10]
EMPLOYEES 테이블에서 부서별로 최소 급여 받는 사원들의 정보를 검색하시오.*/

SELECT MIN(LAST_NAME), MIN(SALARY), MIN(DEPARTMENT_ID)
FROM EMPLOYEES
WHERE DEPARTMENT_ID IS NOT NULL
GROUP BY DEPARTMENT_ID;

select last_name
from EMPLOYEES o
where exists (select 1 from EMPLOYEES 
                where manager_id=o.employee_id);

select employee_id, last_name, (select department_name
                                    from DEPARTMENTS 
                                    where department_id = o.department_id) AS DEPARTMENT_NAME,
                                    (select round(avg(salary),2) from EMPLOYEES
                                    where department_id = o.department_id) a_sal
from employees o;

--DEPARTMENTS, EMPLOYEES 테이블에서, 근무하는 사원이 없는 부서 정보를 검색하시오.

select * from DEPARTMENTS;

select e.department_id, d.department_name, e.manager_id, d.LOCATION_id
from employees e join DEPARTMENTS d on d.DEPARTMENT_ID = e.department_id
where d.DEPARTMENT_ID not in NVL(e.DEPARTMENT_ID,0);

select d.* 
from departments d
where not exists(select 1 from employees e where e.department_id = d.department_id);

/*DEPT, EMP 테이블을 사용하여, 
소속 부서의 평균 급여보다 많은 급여를 받는 'MANAGER' 들의 
부서 번호, 부서이름, 사원 번호, 사원 이름, 급여를 검색하시오.*/

desc dept;

select * from emp;

select d.deptno, d.dname, e.empno, e.ename, e.sal
from dept d join emp e on d.deptno = e.deptno
where e.job = 'MANAGER' and e.sal > (select AVG(SAL) from emp where deptno = d.deptno);


/*COUNTRIES, EMPLOYEES 테이블을 이용하여, 'Canada'에서 근무 중인 사원 정보를 다음과 같이 검색하시오. 
만약 추가적으로 필요한 테이블이 더 있다면 함께 사용합니다.*/

select e.first_name, e.last_name, e.salary, e.job_id, c.country_name
from employees e join DEPARTMENTS d on e.department_id = d.department_id 
    join locations l on d.LOCATION_ID = l.LOCATION_ID 
    join COUNTRIES c on l.COUNTRY_ID = c.COUNTRY_ID
where c.country_name = 'Canada';

desc customers;
desc orders;
select * from WISHLIST;

/*CUSTOMERS, ORDERS, WISHLIST 테이블을 이용하여, 
WISHLIST(관심상품)에 저장된 상품이있는 고객의 주문 합계(SUM(orders.order_total))를 다음과 같이 검색하시오.
참고. WISHLIST.DELETED 컬럼이 'N'인 행이 현재 관심상품을 의미한다.*/

select c.cust_id, c.cust_fname, c.cust_lname, sum(distinct(o.ORDER_TOTAL))
from CUSTOMERS c join orders o on c.cust_id = o.cust_id join WISHLIST w on o.cust_id = w.CUST_ID
where w.DELETED = 'N'
group by c.cust_id, c.cust_fname, c.cust_lname
order by 1;

create view emp10
AS
select * from emp where deptno = 10;

SELECT d.dname, avg_sal_dept
FROM dept d
, (SELECT deptno, avg(sal) avg_sal_dept
FROM emp
GROUP BY deptno) e
WHERE d.deptno=e.deptno;

select d.deptno, d.dname, round(avg(e.sal),2) AS AVG_SAL
from dept d, emp e
where d.deptno = e.deptno
group by d.deptno, d.dname;

--EMPLOYEES 테이블을 사용하여 부서별로 최소 급여 받는 사원들의 이름과 급여를 검색하시오.

SELECT e.last_name, e.salary, e.department_id
FROM employees e
JOIN (
    SELECT department_id, MIN(salary) AS min_salary
    FROM employees
    WHERE department_id IS NOT NULL
    GROUP BY department_id
) m
ON e.department_id = m.department_id AND e.salary = m.min_salary
ORDER BY e.department_id;

select * from employees
where DEPARTMENT_ID = 60;

