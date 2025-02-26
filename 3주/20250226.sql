--PL/SQL

SET SERVEROUTPUT ON;

DECLARE
    v_fname varchar(20);
BEGIN
    select first_name into v_fname from EMPLOYEES
    where EMPLOYEE_ID = 100;

    DBMS_OUTPUT.PUT_LINE(' The First Name of the
    Employee is ' || v_fname);
END;
/

--변수는 한 줄에 하나씩!
-- := 할당 연산자

DECLARE
    v_myName VARCHAR(20);
    BEGIN
    DBMS_OUTPUT.PUT_LINE('My name is: '|| v_myName);
    v_myName := 'John';
    DBMS_OUTPUT.PUT_LINE('My name is: '|| v_myName);
END;
/

DECLARE
    v_myName VARCHAR2(20):= 'John';
    BEGIN
    DBMS_OUTPUT.PUT_LINE('My name is: '|| v_myName);
    v_myName := 'Steven';
    DBMS_OUTPUT.PUT_LINE('My name is: '|| v_myName);
END;
/

/*스칼라 데이터 유형
    -단일 값 보유, 내부 구성 요소 없음*/

variable B_SAL number

print B_SAL

begin 
    select sal into :B_SAL
    from EMP
    where empno = 7788;
end ;
/

DECLARE
   v_hiredate 	DATE ;
   v_deptno 	   NUMBER(2) NOT NULL 	:= 10 ;
   v_location 	VARCHAR2(13) 		   := 'Atlanta';
   c_comm 	   CONSTANT NUMBER 	   := 1400 ; 
BEGIN 
   DBMS_OUTPUT.PUT_LINE ( v_hiredate ) ; 
   DBMS_OUTPUT.PUT_LINE ( v_deptno ) ; 
   DBMS_OUTPUT.PUT_LINE ( v_location ) ; 
   DBMS_OUTPUT.PUT_LINE ( c_comm ) ; 
END ; 
/

DECLARE
v_amount INTEGER(10);
BEGIN
DBMS_OUTPUT.PUT_LINE(v_amount);
END;
/

BEGIN
DBMS_OUTPUT.PUT_LINE ('Hello World');
END;
/

DECLARE
v_fname VARCHAR2(20);
v_lname VARCHAR2(15) DEFAULT 'fernandez';
BEGIN
DBMS_OUTPUT.PUT_LINE(v_fname ||' ' ||v_lname);
END;
/

DECLARE
V_TODAY DATE := SYSDATE;
V_TOMORROW DATE := SYSDATE + 1;
BEGIN
V_TOMORROW:=V_TODAY +1;
DBMS_OUTPUT.PUT_LINE(' HELLO WORLD ');
DBMS_OUTPUT.PUT_LINE('TODAY IS : '|| V_TODAY);
DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || V_TOMORROW);
END;
/

--※ PL/SQL 에서의 함수 사용
SET SERVEROUTPUT ON 
DECLARE 
  v_desc_size		INTEGER(5);
  v_prod_description 	VARCHAR2(70) := 
    'You can use this product with your radios for higher frequency';

BEGIN 
  v_desc_size := LENGTH(v_prod_description) ;
  DBMS_OUTPUT.PUT_LINE (v_desc_size) ; 
END ;
/

DECLARE 
  v_desc_size		INTEGER(5);
  v_prod_description 	VARCHAR2(70) := 
    'You can use this product with your radios for higher frequency';

BEGIN 
  v_desc_size := MAX(v_prod_description) ;
  DBMS_OUTPUT.PUT_LINE (v_desc_size) ; 
END ;
/

select trunc( sysdate, 'MM')
from dual;

--!!!*중첩 블록에서 변수 범위*!!! 

BEGIN <<outer>>
  DECLARE
    v_sal NUMBER(7,2) := 60000;
    v_comm NUMBER(7,2) := v_sal * 0.20;
    v_message VARCHAR2(255) := ' eligible for commission';
BEGIN
  DECLARE
    v_sal NUMBER(7,2) := 50000;
    v_comm NUMBER(7,2) := 0;
    v_total_comp NUMBER(7,2) := v_sal + v_comm;
  BEGIN
    v_message := 'CLERK not'||v_message;
    outer.v_comm := v_sal * 0.30;
  END;
    v_message := 'SALESMAN'||v_message;
END;
END outer;
/

--※ DML( INSERT, UPDATE, DELETE ) 문 

BEGIN 
  INSERT INTO emp(empno, ename, sal, deptno) 
  VALUES (1234, 'RYU', 3000, 20) ; 
END ;
/

begin 
  delete EMP
  where empno = 1234;
end;
/

--반드시 하나의 행만 가능! 0개도 안됨

declare 
  v_sal emp.sal%TYPE;
begin
    select sal into v_sal
    from emp
    where empno = 7788 ;
end;
/

select sal
from emp
where empno = 1234 ;

BEGIN 
  INSERT INTO emp(empno, ename, sal, deptno) 
  VALUES (1234, 'RYU', 3000, 20) ; 

  INSERT INTO emp(empno, ename, sal, deptno) 
  VALUES (4321, 'RYU', 3000, 20) ; 

  UPDATE emp 
  SET sal = 4000 
  WHERE empno = 2222 ; 
END ;
/

rollback;

DECLARE
    v_rows_deleted VARCHAR2(30);
    v_empno employees.employee_id%TYPE := 176;
BEGIN
    DELETE FROM employees
    WHERE employee_id = v_empno;
    v_rows_deleted := (SQL%ROWCOUNT ||
    ' row deleted.');
    DBMS_OUTPUT.PUT_LINE (v_rows_deleted);
END;
/


BEGIN
  UPDATE emp 
  SET sal = 4000 
  WHERE empno = 2222 ;

  if sql%notfound then 
    dbms_output.put_line('수정행은 없습니다.!!') ;
  END IF;
END;
/

CREATE OR REPLACE TRIGGER trg_salary_check
AFTER INSERT OR UPDATE ON employees
FOR EACH ROW
DECLARE
    v_avg_salary NUMBER;
BEGIN
    -- 현재 전체 직원의 평균 급여 계산
    SELECT AVG(salary) INTO v_avg_salary FROM employees;

    -- 방금 추가/수정된 급여가 평균보다 낮다면 메시지 출력
    IF :NEW.salary < v_avg_salary THEN
        DBMS_OUTPUT.PUT_LINE('⚠️ 방금 입력된 급여(' || :NEW.salary || ')가 평균 급여(' || v_avg_salary || ')보다 낮습니다!');
    END IF;
END;
/

select *
from employees;

CREATE OR REPLACE FUNCTION get_bonus(p_salary NUMBER) 
RETURN NUMBER AS
    v_bonus NUMBER;
BEGIN
    v_bonus := p_salary * 0.1;
    RETURN v_bonus;
END;
/

SELECT object_name, object_type 
FROM user_objects 
WHERE object_type = 'FUNCTION';

SELECT get_bonus(5000) FROM dual;

DECLARE
    v_bonus NUMBER;
BEGIN
    v_bonus := get_bonus(6000);
    DBMS_OUTPUT.PUT_LINE('보너스: ' || v_bonus);
END;
/
