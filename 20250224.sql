select *
from emp 
where comm = 0 OR comm is NULL
and sal <= 2000;

SELECT empno, ename, sal, deptno   
FROM emp  
WHERE REGEXP_LIKE(ename, '^(S|A)') ;  

SELECT empno, ename, sal, deptno   
FROM emp  
WHERE REGEXP_LIKE(ename, '[SA]') ; 


 SELECT empno, ename, hiredate    
 FROM empdt   
 WHERE VALIDATE_CONVERSION(hiredate AS DATE, 'YYYYMMDD') = 0 ; 

 SELECT empno, ename, sal, comm    
 FROM emp;

WITH AVG_EMP AS (SELECT DEPTNO, AVG(SAL) AS AVG_SAL
                FROM EMP
                GROUP BY DEPTNO) 
SELECT A.EMPNO, A.ENAME, A.JOB, A.SAL, A.DEPTNO, B.AVG_SAL
FROM EMP A, AVG_EMP B where a.deptno = b.deptno
and a.sal > b.AVG_SAL;


select cust_id
from sh.sales
where extract(YEAR from time_ID) = 2000;

select cust_id, cust_first_name, cust_last_name, cust_gender, country_id
from sh.CUSTOMERS
where CUST_YEAR_OF_BIRTH = 1980;

select B.*
from (select distinct cust_id
        from sh.sales
        where extract(YEAR from time_ID) = 2000) A
        join
    (select cust_id, cust_first_name, cust_last_name, cust_gender, country_id
        from sh.CUSTOMERS
        where CUST_YEAR_OF_BIRTH = 1980) B
    ON A.cust_id = B.cust_id
where 1=1
order by B.cust_id;

select product_id 상품번호, producT_name 상품이름, LIST_PRICE 판매정가, MIN_PRICE 상품원가
from productS;

select PRODUCT_ID 상품번호, unit_price 판매금액, ORDER_ID 주문번호
from order_items
group by order_id, product_id,UNIT_PRICE
order by product_id;

select PRODUCT_ID 상품번호, sum(UNIT_PRICE * QUANTITY) / SUM(QUANTITY) AS 평균판매금액
from order_items
group by  product_id
order by product_id;

with A AS (select /*+ materialize */ product_id 상품번호, producT_name 상품이름, LIST_PRICE 판매정가, MIN_PRICE 상품원가
            from productS), 
             B AS (select PRODUCT_ID 상품번호, unit_price 판매금액, ORDER_ID 주문번호
                    from order_items
                    group by order_id, product_id,UNIT_PRICE
                    order by product_id),
            C AS (select PRODUCT_ID 상품번호, round(sum(UNIT_PRICE * QUANTITY) / SUM(QUANTITY),1) AS 평균판매금액
                from order_items
                group by  product_id
                order by product_id)
select A.상품번호, A.상품이름, A.판매정가, A.상품원가, C.평균판매금액, B.판매금액, B.주문번호
from A join B on a.상품번호 = B.상품번호 join C on B.상품번호 = C.상품번호
where C.평균판매금액 > B.판매금액
order by C.평균판매금액 - B.판매금액;

select *
from dept;

select *
from emp;

select D.deptno DPET_DEPTNO, D.dname, E.EMPNO EMP_DEPTno, E.ENAME, E.SAL
from dept D  left outer join emp E on D.deptno = E.DEPTNO
where E.sal >= 2000 OR E.empno IS NULL;

select *
FROM DEPT
WHERE DEPTNO NOT IN (SELECT DEPTNO
                        FROM EMP
                       );

select CUST_ID, SUM(unit_price * quantity) AS WISH_TOTAL
from WISHLIST
where deleted = 'N'
group by CUST_ID;

select cust_id, SUM(order_total) AS order_total
from orders
group by CUST_ID;

describe orders;

/*8. CUSTOMERS, ORDERS, WISHLIST 테이블을 이용하여, 
WISHLIST(관심상품)에 저장된 상품이 있는 고객의 
주문 합계(SUM(orders.order_total))를 다음과 같이 검색하세요. 
참고. WISHLIST.DELETED 컬럼이 'N'인 행이 현재 관심상품을 의미한다. */

select C.cust_id, C.CUST_FNAME, C.CUST_LNAME, O.order_total
from CUSTOMERS C join (select cust_id, SUM(order_total) AS order_total
                        from orders
                        group by CUST_ID) O on C.cust_id = O.cust_id
where C.cust_id in (select cust_id
                    from WISHLIST
                    where deleted = 'N')
order by cust_id;

/*9. CUSTOMERS, ORDERS, WISHLIST 테이블을 이용하여 
고객별 주문 금액의 합계(SUM(order_total))와 
관심상품 목록의 합계(SUM(unit_price*quantity))를 검색하세요.  
참고. WISHLIST.DELETED 컬럼이 'N'인 행이 현재 관심상품을 의미한다. */

select C.cust_id, C.CUST_FNAME, C.CUST_LNAME, O.order_total, W.WISH_TOTAL
from CUSTOMERS C join (select cust_id, SUM(order_total) AS order_total
                        from orders
                        group by CUST_ID) O on C.cust_id = O.cust_id
                JOIN (select CUST_ID, SUM(unit_price * quantity) AS WISH_TOTAL
                        from WISHLIST
                        where deleted = 'N'
                        group by CUST_ID) W ON C.CUST_ID = W.CUST_ID
where C.cust_id in (select cust_id
                    from WISHLIST
                    where deleted = 'N')
order by cust_id;

--05. 집계 함수를 활용한 리포팅

/*1. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
- 부서별 급여 합계와 전체 급여 합계 검색*/

SELECT DEPTNO, SUM(SAL) AS SUM_SAL
FROM EMP
GROUP BY DEPTNO
UNION
SELECT NULL, SUM(SAL) AS SUM_SAL
FROM EMP;

/*2. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
    - DEPTNO, JOB 컬럼으로 그룹화된 급여의 합계 
    - DEPTNO 컬럼으로 그룹화된 급여 합계 
    - 전체 급여 합계는 검색 안함  */

SELECT DEPTNO, JOB, SUM(SAL) AS SUM_SAL
FROM EMP
GROUP BY DEPTNO, JOB
UNION
SELECT DEPTNO, NULL, SUM(SAL) AS SUM_SAL
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO;

/*3. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
    - 사원 정보를 검색하면서 소속 부서의 급여 합계를 함께 검색 
    - DEPTNO, EMPNO 기준으로 정렬  */

SELECT DEPTNO, EMPNO, ENAME, SUM(SAL) SAL
FROM EMP 
GROUP BY DEPTNO, EMPNO, ENAME
UNION
SELECT DEPTNO, NULL, NULL, SUM(SAL) SAL
FROM EMP
GROUP BY DEPTNO
ORDER BY DEPTNO, EMPNO;

/*4. 사원(EMP) 테이블에서 다음 조건에 만족하는 행을 검색하세요. 
    - 사원 정보를 검색하면서 소속 부서의 급여 합계와 평균 급여 검색 
    - 전체 사원의 급여 합계와 평균 급여 검색 
    - DEPTNO, EMPNO 기준으로 정렬  */

    SELECT DEPTNO, EMPNO, ENAME, SUM(SAL) SAL
    FROM EMP 
    GROUP BY DEPTNO, EMPNO, ENAME
UNION ALL
    SELECT DEPTNO, NULL, 'DEPT_SUM', SUM(SAL) SAL
    FROM EMP
    GROUP BY DEPTNO
UNION ALL
    SELECT DEPTNO, NULL, 'DEPT_AVG', ROUND(AVG(SAL),2) SAL
    FROM EMP
    GROUP BY DEPTNO
UNION ALL
    SELECT null, null, 'TOTAL_SUM', SUM(sal)
    FROM emp  
UNION ALL
    SELECT null, null, 'TOTAL_AVG', ROUND(AVG(sal),1)
    FROM emp  
ORDER BY 1,2,3;

SELECT deptno, mgr, SUM(sal), GROUPING(deptno), GROUPING(mgr), GROUPING_ID(deptno,mgr)  
FROM emp  
GROUP BY CUBE(deptno, mgr)  
ORDER BY 6, 1, 2 ; 

SELECT deptno, mgr, SUM(sal)   
FROM emp  
GROUP BY ROLLUP(deptno, mgr) ;

SELECT deptno, mgr, SUM(sal)   
FROM emp  
GROUP BY deptno, ROLLUP(mgr) ;

select decode(grouping('A'),0,round(avg(sal),2), sum(sal)) AS SUM
from EMP
group by rollup('A');

SELECT DEPTNO, EMPNO,              
    DECODE(GROUPING_ID(1,DEPTNO,3,EMPNO),   1,'DEPT_SUM',   3,'DEPT_AVG',
                                            7,'TOTAL_SUM', 15,'TOTAL_AVG',
                                            ENAME) AS ENAME,
    DECODE(GROUPING_ID(1,DEPTNO,3,EMPNO),   1,SUM(SAL),  3,ROUND(AVG(SAL),1),
                                            7,SUM(SAL), 15,ROUND(AVG(SAL),1),
                                            SUM(SAL)) AS SAL,
    GROUPING(DEPTNO), GROUPING(EMPNO), GROUPING(ENAME)
    FROM EMP  
    GROUP BY ROLLUP(1,DEPTNO,3,(EMPNO,ENAME)) 
    ORDER BY DEPTNO, EMPNO ; 

SELECT DEPTNO, EMPNO,              
    DECODE(GROUPING_ID(DEPTNO,EMPNO),   1,'DEPT_SUM',   3,'DEPT_AVG',
                                            7,'TOTAL_SUM', 15,'TOTAL_AVG',
                                            ENAME) AS ENAME,
    DECODE(GROUPING_ID(DEPTNO,EMPNO),   1,SUM(SAL),  3,ROUND(AVG(SAL),1),
                                            7,SUM(SAL), 15,ROUND(AVG(SAL),1),
                                            SUM(SAL)) AS SAL,
    GROUPING(DEPTNO), GROUPING(EMPNO), GROUPING(ENAME)
    FROM EMP  
    GROUP BY ROLLUP(DEPTNO,(EMPNO,ENAME)) 
    ORDER BY DEPTNO, EMPNO ; 


select deptno, job
from emp
group by deptno, job;





    