select *
from comdata.summary;

SELECT BRANCH
      ,SUM(M1), SUM(M2), SUM(M3), SUM(M4), SUM(M5), SUM(M6)
      ,SUM(M7), SUM(M8), SUM(M9), SUM(M10), SUM(M11), SUM(M12) 
      ,ROUND(AVG(M1),2), ROUND(AVG(M2),2), ROUND(AVG(M3),2), ROUND(AVG(M4),2), ROUND(AVG(M5),2), ROUND(AVG(M6),2)
      ,ROUND(AVG(M7),2), ROUND(AVG(M8),2), ROUND(AVG(M9),2), ROUND(AVG(M10),2), ROUND(AVG(M11),2), ROUND(AVG(M12),2) 
      ,MAX(M1), MAX(M2), MAX(M3), MAX(M4), MAX(M5), MAX(M6)
      ,MAX(M7), MAX(M8), MAX(M9), MAX(M10), MAX(M11), MAX(M12) 
      ,MIN(M1), MIN(M2), MIN(M3), MIN(M4), MIN(M5), MIN(M6)
      ,MIN(M7), MIN(M8), MIN(M9), MIN(M10), MIN(M11), MIN(M12) 
  FROM COMDATA.SUMMARY 
 GROUP BY BRANCH 
 ORDER BY BRANCH;

SELECT deptno,      SUM(CASE job WHEN 'ANALYST' THEN sal END) AS analyst, 
                    SUM(CASE job WHEN 'CLERK' THEN sal END)  AS clerk,  
                    SUM(CASE job WHEN 'MANAGER' THEN sal END)  AS manager, 
                    SUM(CASE job WHEN 'PRESIDENT' THEN sal END)  AS president,     
                    SUM(CASE job WHEN 'SALESMAN'  THEN sal END)  AS salesman   
             FROM emp   
             GROUP BY deptno   
ORDER BY deptno ; 

select *
from DUAL
connect by level <= 10;

select level as no
from DUAL
connect by level <= 10;

 (SELECT '1981/'||LPAD(LEVEL,2,0) hire  
 FROM dual         
 CONNECT BY LEVEL <= 12);

 SELECT TO_CHAR(hiredate,'YYYY/MM') hire, count(*) cnt  
 FROM emp 
 WHERE hiredate 
 BETWEEN TO_DATE('1981/01/01','YYYY/MM/DD') AND TO_DATE('1981/12/31','YYYY/MM/DD')  
 GROUP BY TO_CHAR(hiredate,'YYYY/MM');

 SELECT TO_CHAR(ADD_MONTHS(TO_DATE('1981/01/01','YYYY/MM/DD') ,LEVEL-1)  ,'YYYY/MM') AS MONTH
 FROM dual 
 CONNECT BY LEVEL <= 12;

-- order by 분석함수 rows - 물리적인 행 기반으로 정의
-- order by 분석함수 range - 명시된 값 기준으로 정의(날짜면 날짜 기준)

-- 연습문제

/*1. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
    - 사원정보와 소속부서의 평균 급여검색 
    - 검색 결과는 EMPNO 컬럼을 기준으로 오름차순 정렬 */

select empno, ename, sal, deptno, ROUND(AVG(SAL) OVER(partition by deptno),2) AS AVG_SAL
from emp
order by empno;

--2. EMPLOYEES 테이블을 이용하여 부서별 최대 급여를 받는 사원 정보를 검색하세요.  

select last_name, salary, job_id, department_id
from (select last_name, salary, MAX(salary) over (partition by department_id) AS MAX, job_id, department_id
        from employees E
        where department_id is not null)
where salary = max;

/*3. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
    - EMPNO 컬럼으로 오름차순 정렬하고, 행별로 누적 급여를 검색*/

select empno, ename, sal, 
        sum(sal) over(order by empno rows BETWEEN unbounded preceding and current row) AS TOTAL
from emp;

/*4. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
    - HIREDATE, EMPNO 컬럼으로 정렬 
    - 현재 사원보다 먼저 입사한 사원 이름과 나중에 입사한 사원 이름을 검색 */

select empno, ename, TO_CHAR(hiredate,'YYYY/MM/DD') AS hiredate
    , LAG(ename, 1, null) over (order by hiredate) as preV_ename,
      LEAD(ename, 1, null) over (order by hiredate) as next_ename
from emp
order by hiredate;

select *
from emp;

/*5. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
    - 부서별 사원이름을 하나의 컬럼으로 검색 */

SELECT deptno,        
LISTAGG(ename,',') WITHIN GROUP (ORDER BY ename) AS employee   
FROM emp  
GROUP BY deptno ; 

SELECT d.dname, LISTAGG(e.ename||'('||e.sal||')',',') WITHIN GROUP (ORDER BY ename) AS employee   
FROM emp e, dept d   
WHERE e.deptno = d.deptno  
GROUP BY d.dname ;


select (LEAD(order_date,1) over(partition by order_id order by order_date) - order_date) / COUNT(order_id) OVER () AS order_AVG
from comdata.orders
where 1=1
and order_date between to_date('2024/05/01','yyyy/mm/dd') and 
                        to_date('2024/06/01','yyyy/mm/dd') - 1/86400

order by order_date;

select *
from comdata.orders;

select LEAD(order_date,1) over(order by order_date), order_date
from comdata.orders
order by ORDER_DATE;

select order_date
from comdata.orders
order by order_date;

select order_date
from comdata.ORDERS
where cust_id = 107 AND order_date between to_DATE('2024/05/01','YYYY/MM/DD') 
                    AND TO_DATE('2024/06/01','YYYY/MM/DD') - 1/86400
order by order_date;

SELECT cust_id, ROUND((MAX(ORDER_DATE) - MIN(ORDER_DATE))/(COUNT(DISTINCT ORDER_DATE)-1),2) AS 평균주기
  FROM COMDATA.ORDERS 
 WHERE 1=1
   AND ORDER_DATE BETWEEN TO_DATE('20240501','YYYYMMDD') 
                      AND TO_DATE('20240601','YYYYMMDD') - INTERVAL '1' SECOND 
group by cust_id;

SELECT *
 FROM emp
 start with ename = 'king'
 connect by prior empno = MGR;

 SELECT LPAD(' ',LEVEL*2-2)||ename AS NAME, LEVEL, empno, mgr   
 FROM emp  
 START WITH empno = 7839   
 CONNECT BY prior empno = mgr;

 
select *
from tacct
where extract(year from EXP_DT) = 2024;

