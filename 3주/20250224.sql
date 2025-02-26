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

/*2. 상품별 평균 판매 금액보다 낮은 가격에 판매된 상품 정보를 다음과 같이 검색하세요.
 - PRODUCTS(상품), ORDER_ITEMS(주문 상세) 테이블 이용 
 - 평균 금액과 판매 금액의 차액이 적은 상품부터 검색  */

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
from rental;

/*3. DEPT, EMP 테이블에서, 2000 이상의 급여(SAL)를 받는 사원 정보와 
    소속 부서의 이름(DNAME)을 함께 검색하세요.  
    - 근무하는 사원이 없는 부서 정보도 함께 검색 */

select D.deptno DPET_DEPTNO, D.dname, E.EMPNO EMP_DEPTno, E.ENAME, E.SAL
from dept D  left outer join emp E on D.deptno = E.DEPTNO
where E.sal >= 2000 OR E.empno IS NULL;

/*5. SH.PRODUCTS, SH.SALES 테이블을 이용하여 상품별 판매 수량(QUANTITY_SOLD)의 합계를 검색하세요. 
단, 판매되지 않은 상품이 있다면 함께 검색합니다.  
    - PROD_ID 컬럼을 기준으로 오름차순 정렬*/

with B AS (select prod_id, sum(quantity_sold) AS prodsum
                            from sh.SALES
                            group by prod_id)
select A.prod_id, A.prod_name, B.prodsum
from sh.PRODUCTS A join B
                    on A.prod_id = B.prod_id
order by prod_id;


select sh.PRODUCTS.prod_id, sh.PRODUCTS.prod_name, B.prodsum
from sh.PRODUCTS  join (select prod_id, sum(quantity_sold) AS prodsum
                            from sh.SALES
                            group by prod_id) B
                    on sh.PRODUCTS.prod_id = B.prod_id
order by prod_id;


select count(*)
from sh.SALES
group by prod_id
order by prod_id;

/*6. 부서(DEPT), 사원(EMP) 테이블을 이용하여 근무하는 사원이 없는 부서 정보를 검색하세요. 
- NOT IN을 사용한 문장과 NOT EXISTS를 사용한 문장 2개를 만드세요. */

select *
FROM DEPT
WHERE DEPTNO NOT IN (SELECT DEPTNO
                        FROM EMP
                       );

/*7. DEPT, EMP 테이블을 사용하여 각 부서의 사원 존재 여부를 다음과 같이 검색합니다.*/

with A as (select distinct deptno
            from emp)
select dept.deptno, dept.dname, dept.loc, case 
                            when dept.deptno in A.deptno then 'yes'
                            ELSE 'NO' END AS "emp"
from dept left outer join A on dept.deptno = A.deptno;


select deptno, dname, loc, case 
                            when deptno in (select deptno
                                            from emp) then 'yes'
                            ELSE 'NO' END AS "emp"
from dept;

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

/*10. SALES_PLAN, SALES_RESULT 테이블은 판매 계획 및 실제 판매 정보를 저장하는 테이블입니다. 
두 테이블을 이용하여 제품별 판매 계획 및 실제 판매 정보를 다음과 같이 검색하세요. */

WITH A AS(SELECT ITEM, PLAN_DATE, SUM(QTY) AS PLAN_SUM
FROM SALES_PLAN
GROUP BY ITEM, PLAN_DATE);

WITH B AS(SELECT ITEM, SALE_DATE, SUM(QTY) AS RESULT_SUM
FROM SALES_RESULT
GROUP BY ITEM, SALE_DATE);


select NVL(a.item,b.item) as item,
       NVL(a.plan_date,b.sale_date) as sale_date,
       NVL(a.plan_SUM, 0) as plan_qty,
       NVL(b.result_sum, 0) as result_qty

from (SELECT ITEM, PLAN_DATE, SUM(QTY) AS PLAN_SUM
        FROM SALES_PLAN
        GROUP BY ITEM, PLAN_DATE) a
    full outer join
    (SELECT ITEM, SALE_DATE, SUM(QTY) AS RESULT_SUM
        FROM SALES_RESULT
        GROUP BY ITEM, SALE_DATE) b
    on a.item = b.item AND a.plan_date = b.sale_date;



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


select * from tpid;
select * from tcid;

SELECT *
  FROM TACCOUNT TA 
  JOIN TCID     TC 
    ON TA.LNID = TC.LNID 
   AND TA.ID_TYP = '1' 
 WHERE TA.LNACT = '200266';

SELECT *
  FROM TACCOUNT TA 
  LEFT JOIN TCID     TC 
    ON TA.LNID = TC.LNID 
   AND TA.ID_TYP = '2' 
  LEFT JOIN TPID TP 
    ON TA.LNID = TP.LNID 
   AND TA.ID_TYP = '1'     
 WHERE TA.LNACT = '200266' ; 
