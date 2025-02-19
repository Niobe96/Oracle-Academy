CREATE TABLE T1
(C1 NUMBER,
C2  NUMBER(4,2),
C3  NUMBER(4),
C4 NUMBER(2,4),
C5 NUMBER(4,-1)
);

INSERT INTO T1 VALUES (10, 99.99,9999,0.0099,12394);

SELECT *
FROM T1;

DROP TABLE T1;

CREATE TABLE T2
(C1 CHAR(5),
C2  VARCHAR(2),
C3  LONG
);

INSERT INTO T2 VALUES (C1,C2) ;

-- LONG 타입 칼럼은 테이블 당 1개만 생성 가능함!

CREATE TABLE EMP30(EMPNO, ENAME, ANNSAL)
AS
SELECT EMPNO, ENAME, SAL * 12
FROM EMP
WHERE DEPTNO = 30;

DESCRIBE EMP30;

DROP TABLE EMP30;

-- UNIQUE 에서 NULL 값의 중복은 가능함!

SELECT DUMP(EMPNO)
FROM EMP;

-- 코드를 입력하세요
SELECT BOARD_ID, writer_id, title, price, CASE
    when status = 'SALE' THEN '판매중'
    when status = 'RESERVED' THEN '예약중'
    when status = 'DONE' then '거래완료'
    END as STATUS
from USED_GOODS_BOARD
where TO_char(CREATED_DATE,'YYYY-MM-DD') = '2022-10-05'
order by BOARD_ID DESC

-- 코드를 작성해주세요
select G.SCORE, G.EMP_NO, E.EMP_NAME, E.POSITION, E.EMAIL
from HR_GRADE G 
    join HR_employees E on G.EMP_NO = E.EMP_NO
    join HR_DEPARTMENT D ON E.DEPT_ID = D.DEPT_ID
where year = 2022
group by G.EMPNO
order by score DESC
limit 1