--JOIN 심화학습

SELECT *
FROM DEPT A JOIN EMP B
ON A.DEPTNO = B.DEPTNO;

SELECT *
FROM SALGRADE;


SELECT *
FROM EMP E JOIN SALGRADE S  ON  E.SAL >= S.LOSAL
                            AND E.SAL <= S.HISAL;

SELECT E.*, J.ENAME, J.SAL 
  FROM EMP E 
  JOIN EMP J 
    ON J.EMPNO = 7566 
   AND E.SAL   > J.SAL ;

SELECT EMPNO, ENAME, JOB, MGR
FROM EMP;

SELECT *
  FROM EMP W 
  JOIN EMP M 
    ON W.MGR = M.EMPNO ;

SELECT *
FROM EMP;

SELECT *
FROM DEPARTMENTS;

SELECT *
FROM EMPLOYEES;

SELECT *
FROM DEPARTMENTS JOIN EMPLOYEES USING(MANAGER_ID);

DESCRIBE EMP;

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
   and E.SALARY        > A.AVG_SAL ; 


-- 코드를 작성해주세요
SELECT ID, EMAIL, FIRST_NAME, LAST_NAME
FROM DEVELOPERS
WHERE LPAD('CAST(BIN(SKILL_CODE) AS CHAR',15,'0') LIKE '__1________' OR
      CAST(BIN(SKILL_CODE) AS CHAR) LIKE '1__________';

--QUIZ

--EMP, DEPT 테이블을 조인하여 다음 조건에 만족하는 결과를 검색하세요.

SELECT EMPNO, ENAME, JOB, SAL, DEPTNO, DNAME
FROM EMP JOIN DEPT USING(DEPTNO)
WHERE EXTRACT(YEAR FROM HIREDATE) = '1981'
ORDER BY EMPNO;

--TID, TACCT 테이블을 조인하여 다음 조건에 만족하는 결과를 검색하세요.

SELECT LNID, ID_TYP, GENDER, LNACT, LNACT_SEQ, BRANCH, LN_DT, LMT, BB_AMT
FROM TID JOIN TACCT USING(LNID)
WHERE LMT_TYP = 1 
AND ID_TYP = 1
AND TO_CHAR(LN_DT, 'YYYY-MM') = '2022-12';

--TID, TCREDIT 테이블을 조인하여 다음 조건에 만족하는 결과를 검색하세요.

SELECT LNID, BTHDAY, GRADE, ACODE, START_DT, END_DT, CODE
FROM TID JOIN TCREDIT USING(LNID)
WHERE ID_TYP = 2
AND TO_CHAR(BTHDAY,'YYYY-MM') BETWEEN '2018-01' AND '2018-06'
ORDER BY LNID, CODE;

--TID, TCREDIT, TAGENCY 테이블을 조인하여 다음 조건에 만족하는 결과를 검색하세요.

SELECT A.LNID, A.BTHDAY, A.GRADE, C.ANAME, B.START_DT, B.END_DT, B.CODE
FROM TID A JOIN TCREDIT B ON A.LNID = B.LNID JOIN TAGENCY C ON B.ACODE = C.ACODE
WHERE ID_TYP = 2
AND TO_CHAR(BTHDAY,'YYYY-MM') BETWEEN '2018-01' AND '2018-06'
ORDER BY LNID, CODE;

DESCRIBE TCODE

SELECT LNID, BTHDAY, TID.GRADE, ANAME, START_DT, END_DT, CODE, TCODE.GRADE
FROM TID JOIN TCREDIT USING(LNID)
JOIN TAGENCY USING(ACODE)
JOIN TCODE USING(CODE)
WHERE ID_TYP = 2
AND TO_CHAR(BTHDAY,'YYYY-MM') BETWEEN '2018-01' AND '2018-06'
ORDER BY LNID, CODE;

--다음 조건에 만족하는 데이터를 검색하세요. 
SELECT BRANCH, COUNT(*), SUM(LN_AMT), COUNT(DLQ_DT)
FROM TACCT
WHERE LMT_TYP IS NULL
GROUP BY BRANCH
ORDER BY COUNT(*) DESC
FETCH FIRST 1 ROW ONLY;


SELECT * 
  FROM EMP E 
  JOIN (SELECT DEPTNO, AVG(SAL) AS AVG_SAL 
          FROM EMP 
         GROUP BY DEPTNO) A 
    ON E.DEPTNO = A.DEPTNO 
   AND E.SAL    > A.AVG_SAL ; 

--https://school.programmers.co.kr/learn/courses/30/lessons/131116
--프로그래머스 문제 join 내 서브쿼리 생성 확인 필요!

SELECT f.category, f.price AS MAX_PRICE, f.product_name
FROM food_product f
JOIN (
    SELECT category, MAX(price) AS max_price
    FROM food_product
    GROUP BY category
) max_prices 
ON f.category = max_prices.category AND f.price = max_prices.max_price
WHERE f.category IN ('과자', '국', '김치', '식용유')
ORDER BY MAX_PRICE DESC;

-- 원래 내가 쓴 거!

SELECT category, MAX(price) AS MAX_PRICE, PRODUCT_NAME
from food_product
group by category
HAVING CATEGORY IN ('과자', '국', '김치', '식용유')
order by MAX_PRICE DESC;

--프로그래머스 문제!

SELECT 
    U.USER_ID, 
    U.NICKNAME, 
    CONCAT(U.STREET_ADDRESS1, ' ', U.STREET_ADDRESS2) AS 전체주소,  
    CONCAT(SUBSTR(U.TLNO, 1, 3), '-', SUBSTR(U.TLNO, 4, 4), '-', SUBSTR(U.TLNO, 8, 4)) AS 전화번호
FROM USED_GOODS_BOARD B 
JOIN USED_GOODS_USER U ON B.WRITER_ID = U.USER_ID
GROUP BY U.USER_ID, U.NICKNAME, 전체주소, 전화번호
HAVING count(*) >= 3
ORDER BY USER_ID DESC;

select writer_id
from USED_GOODS_BOARD
group by writer_id
having count(*) >= 3;

SELECT INSERT(INSERT(phone_number, 4, 0, '-'), 9, 0, '-') AS formatted_phone
FROM customers;

SELECT U.USER_ID, U.NICKNAME, CITY || ' ' || STREET_ADDRESS1 || STREET_ADDRESS2 AS "전체주소",
SUBSTR(TLNO, 1, 3) || '-' || SUBSTR(TLNO, 4, 4) || '-' || SUBSTR(TLNO, 8) AS "전화번호"
FROM USED_GOODS_USER U
WHERE U.USER_ID IN
            (SELECT WRITER_ID
            FROM USED_GOODS_BOARD
            GROUP BY WRITER_ID
            HAVING COUNT(WRITER_ID) >= 3)
ORDER BY 1 DESC

SELECT 
    U.USER_ID, 
    U.NICKNAME, 
    CONCAT(U.CITY, ' ', U.STREET_ADDRESS1, ' ', U.STREET_ADDRESS2) AS "전체 주소",  
CONCAT(SUBSTR(U.TLNO, 1, 3), '-', SUBSTR(U.TLNO, 4, 4), '-', SUBSTR(U.TLNO, 8, 4)) AS 전화번호
    
FROM    USED_GOODS_USER U join 
        (select writer_id
        from USED_GOODS_BOARD
        group by writer_id
        having count(writer_id) >= 3) B
        on B.writer_id = U.user_id

ORDER BY USER_ID DESC;

-- 코드를 입력하세요
SELECT *
from FOOD_PRODUCT p join food_order O on p.PRODUCT_ID = o.product_id
order by p.product_id