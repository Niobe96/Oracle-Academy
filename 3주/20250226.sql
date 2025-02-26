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
v_today date := SYSDATE;
v_tomorrow date := sysdate + 1;
BEGIN
v_tomorrow:=v_today +1;
DBMS_OUTPUT.PUT_LINE(' Hello World ');
DBMS_OUTPUT.PUT_LINE('TODAY IS : '|| v_today);
DBMS_OUTPUT.PUT_LINE('TOMORROW IS : ' || v_tomorrow);
END;
/

