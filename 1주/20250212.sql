-- 4. 단일 행 함수를 사용하여 출력 커스터마이즈

SELECT SYSDATE
FROM DUAL;

SELECT      EMPLOYEE_ID, LAST_NAME, SALARY, ROUND(SALARY*115.5/100) NEW_SALARY
FROM        EMPLOYEES
ORDER BY    EMPLOYEE_ID;

SELECT  EMPLOYEE_ID, LAST_NAME, DEPARTMENT_ID
FROM    EMPLOYEES
WHERE   LOWER(LAST_NAME) = 'higgins';

SELECT  LENGTH(DEPARTMENT_ID), LENGTH(MANAGER_ID)
FROM    EMPLOYEES;

--테이블 생성 및 삭제 함수(CREATE, DROP)

CREATE TABLE COUNTRIES_COPY AS SELECT * FROM COUNTRIES; 

ALTER TABLE COUNTRIES_COPY MODIFY COUNTRY_ID  CHAR(3);
DESC COUNTRIES_COPY;

UPDATE COUNTRIES_COPY
SET COUNTRY_ID = COUNTRY_ID||' ';

SELECT LENGTH(COUNTRY_ID) FROM COUNTRIES_COPY;

UPDATE countries_copy
SET country_id = TRIM(country_id)||' ';

SELECT A.COUNTRY_ID, B.COUNTRY_ID,LENGTH(A.country_id),LENGTH(B.country_id)
FROM countries A,countries_copy B
WHERE A.COUNTRY_ID = B.COUNTRY_ID;

SELECT A.COUNTRY_ID, B.COUNTRY_ID
FROM COUNTRIES A,COUNTRIES_COPY B
WHERE A.COUNTRY_ID = B.COUNTRY_ID;

DROP TABLE COUNTRIES_COPY;

-- 날짜 함수

SELECT NEXT_day('01-jan-05', 2)
From DUAL;

SELECT  NEXT_DAY(SYSDATE, 'FRIDAY') 
FROM    dual;
ALTER SESSION SET NLS_DATE_LANGUAGE = 'ENGLISH';

SELECT * 
FROM NLS_SESSION_PARAMETERS 
WHERE PARAMETER = 'NLS_DATE_LANGUAGE';

SELECT TRUNC(TRUNC('01-JAN-05', 'YEAR'),'MONTH')
FROM DUAL;

SELECT 
    TO_DATE('2005-09-12','YYYY-MM-DD') - TO_DATE('2004-01-04', 'YYYY-MM-DD') "BETWEEN DAYS"
FROM 
    DUAL;

 -- 5. 변환 함수 및 조건부 표현식 사용

SELECT  LAST_NAME,
        TO_CHAR(HIRE_DATE, 'fmDD MONTH YYYY') AS "HIRE DATE"
FROM    EMPLOYEES;

SELECT last_name,
    TO_CHAR(hire_date, 
            'fmDdspth "of" Month YYYY fmHH:MI:SS AM') HIREDATE
FROM employees;

SELECT last_name,
 TO_CHAR(hire_date, 'fmDD Month YYYY')
 AS HIREDATE
 FROM   employees;

/*TO_CHAR(date, 'DD MONTH YYYY')는 불필요한 공백을 포함할 수 있음.
FM을 사용하면 공백이 제거되고, 한 자리 숫자의 0도 자동으로 사라짐.
FM을 붙이면 가독성이 좋아지고, UI나 레포트에서 불필요한 공백을 방지할 수 있음.
👉 날짜 포맷을 좀 더 깔끔하게 출력하고 싶다면 FM을 붙이는 것이 좋음! 🚀*/

SELECT last_name, salary, commission_pct,
    (salary*12) + (salary*12*commission_pct) AN_SAL
FROM   employees
ORDER BY AN_SAL DESC;

SELECT last_name, salary, NVL(commission_pct, 0),
(salary*12) + (salary*12*NVL(commission_pct, 0)) AN_SAL
FROM employees
ORDER BY AN_SAL DESC, LAST_NAME DESC;

SELECT last_name, salary, commission_pct,
NVL2(commission_pct,
'SAL+COMM', 'SAL') income
FROM employees WHERE department_id IN (50, 80);

-- NULL IF 함수 활용

select FIRST_NAME, Length(FIRST_NAME) "expr1",
       LAST_NAME, LENgth(LAST_NAME) "expr2",
       NULLIF(length(FIRST_NAME), length(last_name)) result
from EMPLOYEES; 

-- COALESCE 함수 활용용

SELECT last_name, salary, commission_pct,
COALESCE((salary+(commission_pct*salary)), salary+2000)"New Salary"
FROM employees;

    -- 연습문제 4 

/*2. HR 부서에서 각 사원에 대해 사원 번호, 성, 급여 및 15.5% 인상된 급여(정수로 표현)를
표시하는 보고서가 필요합니다. 열 레이블을 New Salary로 지정합니다. 작성한 SQL 문을
lab_04_02.sql이라는 파일에 저장합니다.*/

select EMPLOYEE_ID, last_name, salary, RPAD(TO_CHAR(salary * 1.155, '99999.00'), 9, '0') "New Salary"
from EMPLOYEES
order by "New Salary" DESC;

select EMPLOYEE_ID, last_name, salary, TO_CHAR(salary * 1.155, '99999.00') "New Salary"
from EMPLOYEES
order by "New Salary" DESC;

/*4. 새 급여에서 이전 급여를 빼는 열을 추가하도록 LAB_04_02.SQL의 QUERY를 수정합니다.
열 레이블을 INCREASE로 지정합니다. 파일 내용을 LAB_04_04.SQL로 저장합니다. 수정한
QUERY를 실행합니다.*/

SELECT      EMPLOYEE_ID, LAST_NAME, ROUND(SALARY*115.5/100) NEW_SALARY, 
            ROUND(SALARY*115.5/100) - SALARY INCREASE
FROM        EMPLOYEES
ORDER BY    INCREASE DESC;

/*5. 다음 작업을 수행합니다.
A. "J", "A" 또는 "M"으로 시작하는 이름을 가진 모든 사원의 성(첫번째 문자는 대문자,
나머지는 모두 소문자)과 성의 길이를 표시하는 QUERY를 작성합니다. 각 열에 적절한
레이블을 지정합니다. 사원의 성을 기준으로 결과를 정렬합니다.*/

SELECT  INITCAP(LAST_NAME) "NAME", LENGTH(LAST_NAME) "LENGTH"
FROM    EMPLOYEES
WHERE   LAST_NAME LIKE 'J%' OR 
        LAST_NAME LIKE 'A%' OR 
        LAST_NAME LIKE 'M%'
ORDER BY last_name;

SELECT
    initcap(last_name) AS name,
    length(last_name)  AS length
FROM
    employees
WHERE
    substr(upper(last_name),1,1) IN ( 'J', 'A', 'M' )
ORDER BY
    last_name;

/*B. 유저에게 성의 첫 문자를 입력하는 프롬프트를 표시하도록 QUERY를 재작성합니다.
예를 들어, 문자 입력 프롬프트가 표시되었을 때 유저가 "H"(대문자)를 입력하면 성이
"H"로 시작하는 모든 사원이 출력에 표시되어야 합니다.*/

SELECT LAST_NAME "NAME", LENGTH(LAST_NAME) "LENGTH"
FROM EMPLOYEES
WHERE LAST_NAME LIKE '&LAST_NAME%';

/*C. 입력된 문자의 대소문자 여부에 따라 출력이 달라지지 않도록 QUERY를 수정합니다.
입력된 문자는 SELECT QUERY에서 처리되기 전에 대문자로 변경해야 합니다.*/

SELECT LAST_NAME "NAME", LENGTH(LAST_NAME) "LENGTH"
FROM EMPLOYEES
WHERE LOWER(LAST_NAME) LIKE '&LAST_NAME%';

/*6. HR 부서에서 각 사원의 근속 기간을 파악하려고 합니다. 각 사원에 대해 성을 표시하고
채용일부터 오늘까지 경과한 개월 수를 계산합니다. 열 레이블을 MONTHS_WORKED로
지정합니다. 재직 개월 수에 따라 결과를 정렬합니다. 개월 수는 가장 가까운 정수로
반올림해야 합니다.*/

SELECT      LAST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) MONTHS_WORKED
FROM        EMPLOYEES
ORDER BY    MONTHS_WORKED;

SELECT      LAST_NAME, TO_NUMBER(TO_CHAR(SYSDATE, 'MM')) - TO_NUMBER(TO_CHAR(HIRE_DATE, 'MM')) MONTHS_WORKED
FROM        EMPLOYEES
ORDER BY    MONTHS_WORKED;
--문제점 1: 연도를 고려하지 않음

/*7. 모든 사원의 성과 급여를 표시하기 위한 QUERY를 작성합니다. 급여가 15자 길이로
표시되고 왼쪽에 $ 기호가 채워지도록 형식을 지정합니다. 열 레이블을 SALARY로
지정합니다.*/

SELECT  LAST_NAME, LPAD(SALARY,15,'$') SALARY
FROM    EMPLOYEES;

/*8. 사원의 성을 표시하고 급여 액수를 별표로 나타내는 QUERY를 작성합니다. 각 별표는
$1,000을 나타냅니다. 급여의 내림차순으로 데이터를 정렬합니다. 열 레이블을
EMPLOYEES_AND_THEIR_SALARIES로 지정합니다.*/

SELECT      LAST_NAME, RPAD('*', TRUNC(SALARY,-3)/1000, '*') EMPLOYEES_AND_THEIR_SALARIES
FROM        EMPLOYEES
ORDER BY    EMPLOYEES_AND_THEIR_SALARIES DESC;

/*9. 부서 90의 모든 사원에 대해 성 및 재직 기간(주 단위)을 표시하도록 QUERY를 작성합니다.
주를 나타내는 숫자 열의 레이블을 TENURE로 지정합니다. 주를 나타내는 숫자 값을
소수점 왼쪽에서 TRUNCATE합니다. 직원 재직 기간의 내림차순으로 레코드를 표시합니다.*/

SELECT      LAST_NAME, TRUNC((SYSDATE - HIRE_DATE) / 7) TENURE
FROM        EMPLOYEES
WHERE       DEPARTMENT_ID = 90
ORDER BY    TENURE DESC;

select salary
from employees;

