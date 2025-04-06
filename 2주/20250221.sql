/*서브쿼리 : SQL 명령문에 포함된 SELECT 명령문
- Main Query보다 먼저 실행될 수 있고, 
  실행결과는 서브쿼리 위치로 리턴 후 Main Query에서 사용 됨


1. 조건절의 Subquery (WHERE, HAVING) 
 - 리턴되는 행, 컬럼 개수에 따라 비교 연산자 주의 
 - Correlated Subquery 사용 가능 
 - ORDER BY 절 사용 불가능 */

-- 단일 행 서브쿼리: 단일 행 비교 연산자 사용  

SELECT *
  FROM employees
 WHERE department_id = (SELECT department_id
                          FROM departments
                         WHERE location_id = 1800) ; 

SELECT department_id
      ,ROUND(AVG(salary)) 
  FROM employees 
 GROUP BY department_id
HAVING ROUND(AVG(salary)) > (SELECT AVG(salary) 
                               FROM employees 
                              WHERE department_id = 60) ; 

--다중 행 서브쿼리: IN, ANY, ALL 사용

SELECT *                         -- ERROR 
  FROM employees
 WHERE department_id = (SELECT department_id
                          FROM departments
                         WHERE location_id = 1700) ; 

SELECT *                       
  FROM employees
 WHERE department_id IN (SELECT department_id
                           FROM departments
                          WHERE location_id = 1700) ; 

SELECT * 
  FROM EMP 
 WHERE DEPTNO =ANY (10,20) ; 

SELECT * 
  FROM EMP 
 WHERE DEPTNO IN (10,20) ; 


SELECT *                         -- ERROR 
  FROM employees 
 WHERE salary > (SELECT AVG(salary) 
                   FROM employees 
                  GROUP BY department_id) ; 

SELECT *                         
  FROM employees 
 WHERE salary >ANY (SELECT AVG(salary) 
                      FROM employees 
                     GROUP BY department_id) ; 

SELECT *                         
  FROM employees 
 WHERE salary >ANY (3500, 10154, 19333,4400,7000) ; 

SELECT *                         
  FROM employees 
 WHERE salary > 3500 
    OR salary > 10154
    OR salary > 19333
    OR salary > 4400
    OR salary > 7000 ; 

SELECT *                         
  FROM employees 
 WHERE salary > 3500 ; 

--다중 컬럼 서브쿼리: IN 사용  

SELECT *
  FROM employees 
 WHERE (department_id, salary) IN (SELECT department_id, MIN(salary)
                                     FROM employees 
                                    GROUP BY department_id) ; 

SELECT *
  FROM employees 
 WHERE salary IN (SELECT MIN(salary)
                    FROM employees 
                   GROUP BY department_id) ; 


--Correlated Subquery (Scalar Subqery) 

SELECT * 
  FROM employees e 
 WHERE salary = (SELECT MIN(salary) 
                   FROM employees 
                  WHERE department_id = e.department_id) ; 

SELECT * 
  FROM employees e 
 WHERE salary > (SELECT AVG(salary) 
                   FROM employees 
                  WHERE department_id = e.department_id) ; 

SELECT E.*
  FROM EMPLOYEES E 
  JOIN (SELECT DEPARTMENT_ID, AVG(SALARY) AS AVG_SAL 
          FROM EMPLOYEES 
         GROUP BY DEPARTMENT_ID) A 
    ON E.DEPARTMENT_ID = A.DEPARTMENT_ID 
   AND E.SALARY        > A.AVG_SAL ; 


--EXISTS 

SELECT * 
  FROM departments d 
 WHERE EXISTS (SELECT * 
                 FROM employees 
                WHERE department_id = d.department_id) ; 


SELECT * 
  FROM departments d 
 WHERE NOT EXISTS (SELECT * 
                     FROM employees 
                    WHERE department_id = d.department_id) ; 

/*2. FROM 절의 서브쿼리 (Inline View) 
 - 실행 결과를 하나의 집합으로 사용 가능 (임시 테이블 효과) 
 - 반드시 Main Query와 상관없이 실행 가능해야 함 
 - ORDER BY 절 사용 가능 (TOP-n 질의) 
 - Correlated Subquery 사용 불가능 
 - WITH 절로 대체 가능 */

SELECT * 
  FROM emp e 
  JOIN (SELECT deptno, SUM(sal) AS SUM_SAL 
          FROM emp 
         GROUP BY deptno) s 
    ON e.deptno = s.deptno ;   

WITH sum_emp AS (SELECT deptno, SUM(sal) AS SUM_SAL 
                   FROM emp 
                  GROUP BY deptno)
SELECT * 
  FROM emp e 
  JOIN sum_emp s 
    ON e.deptno = s.deptno ;    


SELECT * 
  FROM (SELECT * 
          FROM emp 
         ORDER BY sal DESC) 
 WHERE rownum <= 3 ; 


/*3. SELECT 절의 서브쿼리 
 - 반드시 하나의 컬럼, 하나의 행 리턴 (Scalar Subquery) 
 - 보통 Correlated Subquery 사용됨 
 - 동일 테이블을 반복적으로 사용하는 서브쿼리를 여러 개 사용 시 성능 저하 
 - ORDER BY 절 사용 불가능 */

SELECT empno, ename, sal, deptno
      ,(SELECT SUM(sal) 
          FROM emp) AS total 
  FROM emp ; 

SELECT empno, ename, sal, deptno
      ,(SELECT SUM(sal) 
          FROM emp
         WHERE deptno = e.deptno) AS dept_sum
  FROM emp e; 

SELECT empno, ename, sal, deptno            -- ERROR 
      ,(SELECT SUM(sal), AVG(sal)  
          FROM emp
         WHERE deptno = e.deptno) AS dept_sum
  FROM emp e; 

SELECT empno, ename, sal, deptno
      ,(SELECT SUM(sal) 
          FROM emp
         WHERE deptno = e.deptno) AS dept_sum
      ,(SELECT ROUND(AVG(sal)) 
          FROM emp
         WHERE deptno = e.deptno) AS dept_avg
  FROM emp e; 

/*4. ORDER BY절의 서브쿼리 
 - 반드시 하나의 컬럼, 하나의 행 리턴 (Scalar Subquery) 
 - 정렬에 사용된 값이 화면에 검색이 안됨 */

SELECT e.empno, e.ename, e.sal, e.deptno, d.dname, d.loc  
  FROM emp  e
  JOIN dept d 
    ON e.deptno = d.deptno 
ORDER BY d.loc ; 

SELECT * 
  FROM emp e 
ORDER BY (SELECT loc
            FROM dept 
           WHERE deptno = e.deptno) ; 

select *
from sh.sales;

SELECT count(*)
FROM employees e
WHERE EXISTS (
    SELECT 1 FROM departments
    WHERE e.department_id = 60
);

select *
from departments d
where exists (select NULL
                from employees
                where department_id = d.department_id
                AND rownum = 1);

select DEPARTMENT_ID * MANAGER_ID
from departments;



select rownum, empno, ename
from emp
where rownum = 2 OR rownum = 1;

WITH sum_emp AS (SELECT deptno, SUM(sal) AS SUM_SAL 
                   FROM emp 
                  GROUP BY deptno)
    ,TEMP_EMP AS (SELECT MAX(SUM_SAL) AS MAX_SAL 
                    FROM SUM_EMP)
SELECT * 
  FROM emp e 
  JOIN sum_emp s 
    ON e.deptno = s.deptno
  JOIN TEMP_EMP T 
    ON S.SUM_SAL = MAX_SAL ;    


SELECT empno, ename, sal, deptno, SUM_SAL, AVG_SAL 
   FROM emp
   CROSS JOIN (SELECT SUM(sal) AS SUM_SAL, AVG(SAL) AS AVG_SAL 
                 FROM emp) ;


SELECT empno, ename, sal, sum(SAL) over (order by empno) AS TOTAL
 from emp;

 SELECT e.empno, e.ename, e.sal, 
       (SELECT SUM(f.sal) 
        FROM emp f 
        WHERE f.ROWNUM <= e.ROWNUM) AS TOTAL
FROM emp e;

SELECT e.empno, e.ename, e.sal, 
       (SELECT SUM(sal) 
        FROM (SELECT emp.*, ROWNUM AS rnum FROM emp) e2 
        WHERE e2.rnum <= e.rnum) AS TOTAL
FROM (SELECT emp.*, ROWNUM AS rnum FROM emp) e;


select a.empno, a.ename, a.sal, (select sum(SAL)
                                    from emp
                                    where empno <= a.empno) AS TOTAL
from emp a
order by a.empno;

select deptno, listagg(ename, ', ') AS employees
from emp
group by deptno;


select *
from sales_plan;

select *
from SALES_RESULT;

select distinct a.item, b.sale_date
from sales_plan a  join sales_result b on a.plan_date = b.SALE_DATE AND a.item = b.item;

select *
from sales_plan join sales_result using(item);

select empno, sum(SAL)
from emp e
group by empno;

SELECT * 
FROM (SELECT * 
       FROM emp 
      ORDER BY sal DESC)
WHERE rownum = 1;