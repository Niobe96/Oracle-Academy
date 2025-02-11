-- 연습문제 2
/*다음 SELECT 문이 성공적으로 실행됩니다.*/

SELECT last_name,
       job_id,
       salary AS Sal
FROM   employees;

SELECT *
FROM   job_grades;

/*다음 명령문에 네 개의 코딩 오류가 있습니다. 식별할 수 있습니까?*/

SELECT employee_id,
       last_name sal x 12 annual salary
FROM   employees;

/*sal의 변수 명 지정 안됨 (AS), ANNUAL SALARY의 변수 명 지정 안됨 (AS),
last name 뒤에 쉼표, sal x 12 뒤에 쉼표 오지 않음*/

/* HR 부서에서 모든 사원과 해당 직무 ID에 대한 보고서를 요청했습니다. 성과 직무 ID를
이어서 표시하고(쉼표와 공백으로 구분) 열 이름을 Employee and Title로 지정합니다.*/

SELECT last_name
              || ', '
              || job_id AS "Employee and Title"
FROM   employees

/* HR 부서에서 모든 사원과 해당 직무 ID에 대한 보고서를 요청했습니다. 성과 직무 ID를 찾으십시오 */

select *
FROM   employees;

/* 9. HR 부서에서 모든 사원과 해당 직무 ID에 대한 보고서를 요청했습니다.
Employees의 모든 쿼리를 쉼표로 구분하여 "THE_OUTPUT"로 지정합니다. */

SELECT employee_id
              || ','
              || first_name
              || ','
              || last_name
              || ','
              || email
              || ','
              || phone_number
              || ','
              || hire_date
              || ','
              || job_id
              || ','
              || salary
              || ','
              || commission_pct
              || ','
              || manager_id
              || ','
              || department_id AS "THE_OUTPUT"
FROM   employees

       --user_tables 테이블의 모든 열을 표시하는 SELECT 문을 작성합니다.

SELECT *
from   user_tables;SELECT *
FROM   user_tab_columns
WHERE  table_name = 'EMPLOYEES';SELECT employee_id,
       first_name,
       last_name,
       email,
       phone_number,
       hire_date,
       job_id,
       0 SALARY,
       commission_pct,
       manager_id,
       department_id
FROM   employees;

-- UNION**은 중복된 행을 제거하고 결합합니다.
-- UNION ALL**은 중복된 행을 제거하지 않고 모든 행을 결합합니다.

    -- 연습문제 3

/*2. 새 SQL Worksheet를 엽니다. 사원 번호 176의 성과 부서 ID를 표시하는 보고서를
작성합니다. query를 실행합니다.*/

SELECT last_name,
       department_id
FROM   employees
WHERE  employee_id = 176;

/*3. HR 부서에서 급여가 높은 사원과 급여가 낮은 사원을 찾아야 합니다. 급여가 $5,000 ~
$12,000의 범위에 속하지 않는 모든 사원의 성 및 급여를 표시하도록 lab_03_01.sql을
수정합니다. 작성한 SQL 문을 lab_03_03.sql로 저장합니다.*/

SELECT   last_name,
         salary
FROM     employees
WHERE    salary NOT BETWEEN 5000 AND 12000
ORDER BY salary;

/*4. Matos 및 Taylor라는 성을 가진 사원의 성, 직무 ID, 채용 날짜를 표시하는 보고서를
작성합니다. 채용 날짜를 기준으로 오름차순으로 query를 정렬합니다.*/

SELECT   last_name,
         job_id,
         hire_date
FROM     employees
WHERE    last_name IN('Matos',
                      'Taylor')
ORDER BY hire_date;

/*5. 부서 20 또는 50에 속하는 모든 사원의 성과 부서 ID를 last_name별로 오름차순으로
정렬하여 표시합니다.*/

SELECT   last_name,
         department_id
FROM     employees
WHERE    department_id IN('20',
                          '50')
ORDER BY last_name;

/*7. HR 부서에서 2006년에 채용된 모든 사원의 성과 채용 날짜를 표시하는 보고서를
요구합니다.*/

SELECT   last_name,
         hire_date
FROM     employees
WHERE    hire_date BETWEEN '01/01/06' AND      '31/12/06'
ORDER BY hire_date;

/*담당 관리자가 없는 모든 사원의 성과 직책을 표시하는 보고서를 작성합니다.*/

SELECT last_name,
       job_id
FROM   employees
WHERE  manager_id IS NULL

/*9. 커미션을 받는 모든 사원의 성, 급여 및 커미션을 표시하는 보고서를 작성합니다. 
급여 및 커미션의 내림차순으로 데이터를 정렬합니다.
ORDER BY 절에서 열의 숫자 위치를 사용합니다.*/

select   last_name,
         salary,
         commission_pct
FROM     employees
WHERE    commission_pct IS NOT NULL
ORDER BY commission_pct DESC;

/*10. HR 부서의 멤버는 여러분이 작성 중인 query에 유연성이 강화되기를 원합니다. 유저가
프롬프트에 지정하는 액수보다 많은 급여를 받는 사원의 급여와 성을 표시하는 보고서를
기대합니다. 이 query를 lab_03_10.sql이라는 파일에 저장합니다. (작업 1에서 생성한
query를 사용하고 수정할 수 있습니다.) 프롬프트가 표시되었을 때 12000을 입력하면
보고서에 다음 결과가 표시됩니다.*/

SELECT last_name,
       salary
FROM   employees
WHERE  salary >
       &your_salary;

/*11. HR 부서에서 관리자를 기준으로 보고서를 실행하려고 합니다. 유저에게 관리자 ID 입력
프롬프트를 표시하고 해당 관리자에 속한 사원의 사원 ID, 성, 급여 및 부서를 생성하는
QUERY를 작성합니다. HR 부서에서 선택한 열을 기준으로 보고서를 정렬하는 기능을
원합니다. 다음 값으로 데이터를 테스트할 수 있습니다.*/

SELECT   employee_id,
         last_name,
         salary,
         department_id
FROM     employees
WHERE    manager_id =
         &your_maager_id
ORDER BY
         &your_column;

/*12. 이름의 세 번째 문자가 "a"인 모든 사원의 성을 표시합니다.*/

SELECT last_name
FROM   employees
WHERE  last_name LIKE '__a%';

/*13. 성에 "a"와 "e"가 모두 포함된 모든 사원의 성을 표시합니다.*/

SELECT   last_name
FROM     employees
WHERE    last_name LIKE '%a%'
AND      last_name LIKE '%e%'
ORDER BY last_name;

/*14. 직무가 판매 사원이나 자재 담당자이고 급여가 $2,500, $3,500 또는 $7,000가 아닌 
모든 사원의 성, 직무 및 급여를 표시합니다.*/

/*15. 커미션이 20%인 모든 사원의 성, 급여 및 커미션을 표시하도록 lab_03_06.sql을
수정합니다. lab_03_06.sql을 lab_03_15.sql로 다시 저장합니다. lab_03_15.sql의
명령문을 다시 실행합니다.*/

SELECT LAST_NAME Employee, SALARY Monthly_Salary, COMMISSION_PCT
FROM Employees
WHERE commission_pct = 0.2;

/* 직급이 SA_REP 또는 ST_CLERK이고 급여가 $2,500, $3,500 또는 $7,000이 아닌 모든 사원의 성,
 직급 및 급여를 표시합니다.*/

SELECT last_name,
       job_id,
       salary
FROM   employees
WHERE  job_id IN('SA_REP',
                 'ST_CLERK')
AND    (
              salary NOT IN 2500
       OR     salary NOT IN 3500
       OR     salary NOT IN 7000);

       -- 3. 데이터 제한 및 정렬

SELECT *
FROM employees 
WHERE department_id = 90

SELECT last_name, job_id, department_id 
FROM employees 
WHERE last_name = 'Whalen';

SELECT last_name,hire_date 
FROM employees
--WHERE hire_date = '17/10/03';
WHERE hire_date = to_date('20060103', 'YYYYMMDD');

-- VALUE 형식 확인
SELECT *
FROM nls_session_parameters;

-- DATE ALTER(형식 변경)
ALTER sessionset nls_date_format = 'YYYY-MM-DD HH24:MI:SS';

SELECT hire_date,TO_CHAR(hire_date, 'YYYY-MM-DD') 
FROM   employees;

SELECT *
FROM   employees
WHERE  first_name BETWEEN '1' AND 'C';

SELECT *
FROM   employees
WHERE  first_name LIKE 'S%';

-- AND 연산자 학습

SELECT employee_id,last_name, job_id, salary 
FROM employees WHERE salary >= 10000AND
job_id LIKE '%MAN%';SELECT last_name
              || '''s job category is '
              || job_id AS"Job"
FROM   employees
WHERE  Substr(job_id, 4) = 'REP';

-- 우선 순위 규칙

SELECT last_name, department_id, salary
FROM   employees
WHERE  department_id = 60
OR     department_id = 80
AND    salary > 10000;

SELECT last_name, department_id, salary
FROM   employees
WHERE  (department_id = 60
OR     department_id = 80)
AND    salary > 10000;

-- rownun 연습 과제

SELECT rownum, last_name, job_id,
       department_id, to_char(hire_date, 'YYYY-MM-DD')
FROM   employees
WHERE  rownum <= 5
ORDER BY hire_date DESC;

SELECT rownum, last_name, job_id,
       department_id, to_char(hire_date, 'YYYY-MM-DD') AS "HIRE_DATE"
WHERE  rownum <= 5;

SELECT rownum, last_name, job_id, department_id, to_char(hire_date, 'YYYY-MM-DD') AS "HIRE_DATE"
FROM   (
       SELECT last_name, job_id, department_id, hire_date
       FROM employees
       ORDER BY hire_date DESC
       )      
WHERE rownum <= 5;

--SQL 행 제한 절 : 예제

SELECT rownum, employee_id, first_name
FROM employees
ORDER BY employee_id
FETCH FIRST 5 ROWS ONLY;

/*이 구문은 결과에서 처음 5개의 행만 가져오도록 제한합니다.
FETCH FIRST 5 ROWS ONLY는 쿼리 결과에서 상위 5개의 행만을 가져오는 기능을 합니다.*/

SELECT rownum, employee_id, first_name
FROM employees
ORDER BY employee_id
OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY

/*이 부분은 **행 페이징(paging)**을 처리하는 구문입니다.
OFFSET 5 ROWS: 첫 5개의 행을 건너뛰고 그 다음부터 결과를 반환합니다. 즉, 6번째 행부터 반환을 시작합니다.
FETCH NEXT 5 ROWS ONLY: 그 다음에 5개의 행만 가져옵니다. 즉, 6번째 행부터 10번째 행까지를 반환합니다.*/

              -- ORDER BY 함수 두 번 사용

              SELECT *
                     FROM (
                     SELECT employee_id, first_name
                     FROM employees
                     ORDER BY employee_id
                     OFFSET 5 ROWS FETCH NEXT 5 ROWS ONLY
                     )
              ORDER BY first_name;

-- 단일 앰퍼샌드 치환변수 사용

SELECT employee_id, last_name, salary, department_id
FROM   employees
WHERE  employee_id = &employee_num;

-- 치환 변수를 사용하는 예제 응용 BETWEEN 연산자 추가

SELECT employee_id, last_name, salary, department_id
FROM   employees
WHERE  employee_id BETWEEN &employee_first_num AND &employee_second_num;

-- 치환 변수를 사용하는 문자 및 날짜 값

SELECT last_name, department_id, salary*12
FROM   employees
WHERE  job_id = '&job_title' ;

SELECT COUNT(employee_id) AS EMPLOYEE_ID
FROM   employees

SELECT SYSDATE
FROM DUAL;

SELECT SESSIONTIMEZONE, CURRENT_DATE FROM DUAL;

SELECT SESSIONTIMEZONE, CURRENT_TIMESTAMP FROM DUAL;

SELECT last_name, (SYSDATE-hire_date)/7 "WEEKS"
FROM employees
WHERE department_id = 90;

/*HR 부서에서 각 사원에 대해 사원 번호, 성, 급여 및 15.5% 인상된 급여(정수로 표현)를
표시하는 보고서가 필요합니다. 열 레이블을 New Salary로 지정합니다. 작성한 SQL 문을
lab_04_02.sql이라는 파일에 저장합니다.*/

SELECT employee_id, last_name, salary, ROUND(salary*115.5/100) NEW_SALARY
FROM employees
ORDER BY employee_id;

SELECT *
FROM EMP w


1) 
SELECT *
FROM emp 
WHERE empno IN ( SELECT mgr FROM emp ) ;

2) 
SELECT M.*
FROM emp m, emp w 
WHERE m.empno = w.mgr ;

SELECT m.*
FROM emp m, emp w
WHERE m.empno = w.mgr

3) 
SELECT * 
FROM emp o
WHERE EXISTS ( SELECT '1' FROM emp i
                       WHERE i.mgr = o.empno ) ;
4) 
SELECT * 
FROM emp o
WHERE empno = ( SELECT mgr FROM emp i
                           WHERE i.mgr = o.empno 
                               AND rownum = 1 ) ;
                  