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

select trunc(trunc(sysdate, 'year'),'month')
from dual;

    -- 연습문제

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

SELECT  LAST_NAME "NAME", LENGTH(LAST_NAME) "LENGTH"
FROM    EMPLOYEES
WHERE   LAST_NAME LIKE 'J%' OR 
        LAST_NAME LIKE 'A%' OR 
        LAST_NAME LIKE 'M%';

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

SELECT LAST_NAME, ROUND(MONTHS_BETWEEN(SYSDATE, HIRE_DATE)) MONTHS_WORKED
FROM EMPLOYEES
ORDER BY MONTHS_WORKED;

/*7. 모든 사원의 성과 급여를 표시하기 위한 QUERY를 작성합니다. 급여가 15자 길이로
표시되고 왼쪽에 $ 기호가 채워지도록 형식을 지정합니다. 열 레이블을 SALARY로
지정합니다.*/

SELECT LAST_NAME, LPAD(SALARY,15,'$') SALARY
FROM EMPLOYEES;

/*8. 사원의 성을 표시하고 급여 액수를 별표로 나타내는 QUERY를 작성합니다. 각 별표는
$1,000을 나타냅니다. 급여의 내림차순으로 데이터를 정렬합니다. 열 레이블을
EMPLOYEES_AND_THEIR_SALARIES로 지정합니다.*/

SELECT LAST_NAME, RPAD('*', TRUNC(SALARY,-3)/1000, '*') EMPLOYEES_AND_THEIR_SALARIES
FROM EMPLOYEES
ORDER BY EMPLOYEES_AND_THEIR_SALARIES DESC;

/*9. 부서 90의 모든 사원에 대해 성 및 재직 기간(주 단위)을 표시하도록 QUERY를 작성합니다.
주를 나타내는 숫자 열의 레이블을 TENURE로 지정합니다. 주를 나타내는 숫자 값을
소수점 왼쪽에서 TRUNCATE합니다. 직원 재직 기간의 내림차순으로 레코드를 표시합니다.*/

SELECT LAST_NAME, TRUNC(MONTHS_BETWEEN(SYSDATE, HIRE_DATE) * 7 ,0) TENURE
FROM EMPLOYEES
ORDER BY TENURE DESC;

