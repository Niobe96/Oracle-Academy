-- PL/SQL

--IF 문 / true

DECLARE
    v_myage number := 31;
BEGIN
    IF v_myage < 11
    THEN
        DBMS_OUTPUT.PUT_LINE(' I am a child ');
    END IF;
END;
/

-- IF THEN ELSE문 / true or false 

DECLARE
    v_myage number:=31;
BEGIN
  IF
    v_myage < 11 THEN
    DBMS_OUTPUT.PUT_LINE(' I am a child ');
  ELSE
    DBMS_OUTPUT.PUT_LINE(' I am not a child ');
  END IF;
END;
/

-- if elsif else 절 // NULL 값이 반환 될 시 else 값으로 반환됨!

DECLARE
    v_myage number:=31;
BEGIN
    IF v_myage < 11 THEN
        DBMS_OUTPUT.PUT_LINE(' I am a child ');
    ELSIF v_myage < 20 THEN
        DBMS_OUTPUT.PUT_LINE(' I am young ');
    ELSIF v_myage < 30 THEN
        DBMS_OUTPUT.PUT_LINE(' I am in my twenties');
    ELSIF v_myage < 40 THEN
        DBMS_OUTPUT.PUT_LINE(' I am in my thirties');
    ELSE
        DBMS_OUTPUT.PUT_LINE(' I am always young ');
    END IF;
END;
/

-- for loop example

DECLARE
    v_countryid locations.country_id%TYPE := 'CA';
    v_loc_id locations.location_id%TYPE;
    v_new_city locations.city%TYPE := 'Montreal';
BEGIN
    SELECT MAX(location_id) INTO v_loc_id
        FROM locations
        WHERE country_id = v_countryid;
    FOR i IN 1..3 LOOP
        INSERT INTO locations(location_id, city, country_id)
        VALUES((v_loc_id + i), v_new_city, v_countryid );
        END LOOP;
END;
/

begin
    for i in reverse 1..3 loop
        dbms_output.PUT_LINE ('count: ' ||to_char(i)) ;
    end loop;
end;
/

/*  • 루프 안의 명령문이 적어도 한 번 실행되어야 하는
    경우에는 기본 루프를 사용합니다.
    • 매번 반복을 시작할 때마다 조건이 평가되어야 하는
    경우에는 WHILE 루프를 사용합니다.
    • 반복 횟수를 알 수 있는 경우에는 FOR 루프를 사용합니다.    */

DECLARE
    n NUMBER := 10;
    a NUMBER := 0;
    b NUMBER := 1;
    temp NUMBER;
BEGIN
    DBMS_OUTPUT.PUT_LINE(a);
    DBMS_OUTPUT.PUT_LINE(b);

    FOR i IN 2..n-1 LOOP
        temp := a + b;
        a := b;
        b := temp;

        DBMS_OUTPUT.PUT_LINE(temp);
    END LOOP;
END;
/

--continue 문!

SET SERVEROUTPUT ON

DECLARE
    v_total		SIMPLE_INTEGER := 0;
BEGIN
    FOR i IN 1..5 LOOP
v_total := v_total + i;
    DBMS_OUTPUT.PUT_LINE ('Total is: '|| v_total) ;

CONTINUE WHEN i > 3 ;
    v_total := v_total + i;
    DBMS_OUTPUT.PUT_LINE ('Out of Loop Total is: '|| v_total);
    END LOOP;
END;
/

DECLARE
    n NUMBER := 10;
    a NUMBER := 0;
    b NUMBER := 1;
    temp NUMBER;
    i NUMBER := 2;
BEGIN
    --DBMS_OUTPUT.PUT_LINE(a);
    --DBMS_OUTPUT.PUT_LINE(b);

    WHILE i < n LOOP
        temp := a + b;
        a := b;
        b := temp;

        DBMS_OUTPUT.PUT_LINE(temp);

        i := i + 1;
    END LOOP;
END;
/

-- 6장 연습문제 2

create table employees_copy AS
select * from employees;

alter table employees_copy add stars varchar2(50);

DECLARE
    v_empno     employees_copy.employee_id%TYPE := 176;
    v_asterisk  employees_copy.stars%TYPE := NULL;
    v_sal       employees_copy.salary%TYPE;
BEGIN
    select NVL(round(salary/1000), 0) into v_sal
    from employees_copy where employee_id = v_empno;
    for i in 1..v_sal
        loop
        v_asterisk := v_asterisk||'*';
    end LOOP;
                DBMS_OUTPUT.PUT_LINE(v_asterisk);
UPDATE employees_copy SET stars = v_asterisk
WHERE employee_id = v_empno;
commit;
end;
/

SELECT employee_id,salary, stars
FROM employees_copy WHERE employee_id = 176;

select * from EMPLOYEES_COPY;

describe employees_copy;

-- 7장 : 조합 데이터 유형 작업

DECLARE 
	rec_emp	emp%ROWTYPE ; 
BEGIN 
	SELECT * INTO rec_emp 
	FROM emp 
	WHERE empno = 7788 ; 
END ;
/

select *
from EMP
where empno = 7788;

create table copy_emp
AS
select * from EMP
where deptno = 10;

select * from copy_emp;