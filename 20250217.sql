select TO_NUMBER(decode(job,'PRESIDENT', NULL, sal)) AS SALARY
from emp
order by SALARY DESC

SELECT DEPTNO
FROM EMP
group by DEPTNO

SELECT distinct DEPTNO
from emp

SELECT DEPTNO, SUM(SAL)
    FROM Emp   
    group by DEPTNO
having SUM(SAL) > 9000

SELECT DEPTNO, SUM(SAL)
from emp
group by DEPTNO
having deptno in (10,20)

SELECT DEPTNO, SUM(SAL)
  FROM EMP 
  where TO_CHAR(HIREDATE,'YYYY') = '1981' 
 GROUP BY DEPTNO 

SELECT EMPNO, ENAME, SAL * 12 AS ANN_SAL
from emp
ORDER BY ANN_SAL DESC

SELECT DEPTNO, SUM(SAL)
  FROM EMP 
 GROUP BY DEPTNO 
HAVING SUM(SAL) > 9000 
   AND DEPTNO IN (10,20);

SELECT DEPTNO, SUM(SAL)
  FROM EMP 
 WHERE DEPTNO IN (10,20) 
 GROUP BY DEPTNO 
HAVING SUM(SAL) > 9000;


--QUIZ

--1

select lnid, id_typ, bthday, gender, score
from tid

--2
select lnid  AS 차주번호, id_typ AS 차주구분, bthday AS 생일, gender AS 성별, score AS 신용점수
from tid

--3
select '차주번호 ' || lnid || '의 계좌번호는 ' || lnact || '이며 대출 금액은 ' || ln_amt || '입니다' AS 대출정보
from tacct

--4
select distinct branch, prod_cd
from tacct

--5
select lnid, id_typ, bthday, gender, score
from tid
where id_typ >= 1

--6
select lnid, id_typ, bthday, gender, score
from tid
where id_typ >= 1 AND TO_CHAR(bthday, 'YYYY-MM-DD')  >= '1990-01-01'

--7
select lnid, id_typ, bthday, gender, score
from tid
where id_typ >= 1 AND score between 800 AND 899

--8
select lnid, id_typ, bthday, grade
from tid
where id_typ >= 2 AND grade IN ('AA+', 'AA', 'AA-')

--9
select lnid, id_typ, bthday, grade
from tid
where id_typ >= 2 AND grade LIKE 'B%'

--10
select lnid, id_typ, bthday, grade
from tid
where id_typ >= 2 AND grade IN ('AA+', 'AA', 'AA-')
order by grade, bthday DESC;

--11
select lnact, lnact_seq, lnid, ln_dt, ln_amt/10000 AS "대출금(만원)", rate, 
        TRUNC((ln_amt * rate)/12) AS 월이자
from tacct
where lmt_typ IS NULL
order by "대출금(만원)", 월이자

--12
select SUM(ln_amt) SUM_ANT, AVG(ln_amt) AVG_ANT, MAX(ln_amt) MAX_ANT, MIN(ln_amt) MIN_ANT, COUNT(ln_amt) CNT_ANT
from tacct
where lmt_typ IS NULL

--13
select branch, COUNT(ln_amt) CMT_AMT, SUM(ln_amt)SUM_AMT, AVG(ln_amt) AVG_AMT
from tacct
where lmt_typ IS NULL
group by branch
order by branch

--14
select prod_cd, MAX(ln_amt) MAX_AMT, MIN(ln_amt) MIN_AMT
from tacct
where lmt_typ IS NULL
group by prod_cd
order by prod_cd

--15
select branch, prod_cd, COUNT(ln_amt) CNT_AMT, SUM(ln_amt) SUM_ANT, AVG(ln_amt) ABG_AMT
from tacct
where lmt_typ IS NULL
group by branch, prod_cd
order by branch, prod_cd

--16
select prod_cd, MAX(ln_amt) MAX_AMT, MIN(ln_amt) MIN_AMT, MAX(ln_amt) - min(ln_amt) DIFFERENCE
from tacct
group by prod_cd
order by prod_cd

--17
select MAX(COUNT(*)) CNT
from tacct
where lmt_typ IS NULL
group by branch;

--18
select branch, COUNT(*), SUM(LN_AMT), count(DLQ_DT)
from tacct
where lmt_typ IS NULL
group by branch
HAVING COUNT(*) = 81;