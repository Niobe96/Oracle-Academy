-- 4. 단일 행 함수를 사용하여 출력 커스터마이즈

SELECT SYSDATE
FROM DUAL;

SELECT employee_id, last_name, salary, ROUND(salary*115.5/100) NEW_SALARY
FROM employees
ORDER BY employee_id;

/*4. 새 급여에서 이전 급여를 빼는 열을 추가하도록 lab_04_02.sql의 query를 수정합니다.
열 레이블을 Increase로 지정합니다. 파일 내용을 lab_04_04.sql로 저장합니다. 수정한
query를 실행합니다.*/

SELECT  employee_id, last_name, ROUND(salary*115.5/100) NEW_SALARY, 
        ROUND(salary*115.5/100) - salary Increase
FROM     employees
ORDER BY employee_id;

/*5. 다음 작업을 수행합니다.
a. "J", "A" 또는 "M"으로 시작하는 이름을 가진 모든 사원의 성(첫번째 문자는 대문자,
나머지는 모두 소문자)과 성의 길이를 표시하는 query를 작성합니다. 각 열에 적절한
레이블을 지정합니다. 사원의 성을 기준으로 결과를 정렬합니다.*/

SELECT last_name "Name", LENGTH(last_name) "Length"
FROM employees
WHERE last_name LIKE 'J%' OR last_name LIKE 'A%' OR last_name LIKE 'M%'

/*b. 유저에게 성의 첫 문자를 입력하는 프롬프트를 표시하도록 query를 재작성합니다.
예를 들어, 문자 입력 프롬프트가 표시되었을 때 유저가 "H"(대문자)를 입력하면 성이
"H"로 시작하는 모든 사원이 출력에 표시되어야 합니다.*/

SELECT last_name "Name", LENGTH(last_name) "Length"
FROM employees
WHERE last_name LIKE '&Last_name%'

/*c. 입력된 문자의 대소문자 여부에 따라 출력이 달라지지 않도록 query를 수정합니다.
입력된 문자는 SELECT query에서 처리되기 전에 대문자로 변경해야 합니다.*/

SELECT last_name "Name", LENGTH(last_name) "Length"
FROM employees
WHERE UPPER(last_name) LIKE '&Last_name%'