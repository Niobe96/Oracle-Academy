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

-- 7 연습문제

set SERVEROUTPUT on

describe countries;

set VERIFY OFF

declare
    v_countryid varchar2(20) := 'CA';
    v_country_record countries%ROWTYPE;
begin
    select *  into v_country_record
    from countries
    where country_id = upper(v_countryid);

DBMS_OUTPUT.PUT_LINE ('Country Id: ' ||
v_country_record.country_id ||
' Country Name: ' || v_country_record.country_name
|| ' Region: ' || v_country_record.region_id);
END;
/


SET SERVEROUTPUT ON
DECLARE
TYPE dept_table_type is table of
departments.department_name%TYPE
INDEX BY PLS_INTEGER;
my_dept_table dept_table_type;
    f_loop_count NUMBER (2):=10;
    v_deptno NUMBER (4):=0;

BEGIN
    FOR i IN 1..f_loop_count
LOOP
    v_deptno:=v_deptno+10;
    SELECT department_name
    INTO my_dept_table(i)
    FROM departments
    WHERE department_id = v_deptno;
    DBMS_OUTPUT.PUT_LINE (my_dept_table(i));
END LOOP;
end;
/

-- 8 명시적 커서 사용

create table copy_emp
AS
select *
    from EMP
    where EXTRACT(year from HIREDATE) = '1981';

update copy_emp
set sal = sal / 2
where job = 'salesman';
commit;

SELECT * FROM COPY_EMP ;
SELECT * FROM EMP ; 

SET SERVEROUTPUT ON 
DECLARE 
 
 CURSOR CUR_EMP IS  -- 커서 사용 시 커서 먼저 변수 선언이 필요!
   SELECT *
     FROM EMP ; 

 REC_EMP   CUR_EMP%ROWTYPE ; --ROWTPYE : 테이블의 모든 칼럼을 가져오기 편함

BEGIN 

  OPEN CUR_EMP ;

  LOOP -- 모든 데이터를 가져오기 위해 루프문을 사용!
    FETCH CUR_EMP INTO REC_EMP ; -- 하나씩 가져오기 위한 FETCH
    EXIT WHEN CUR_EMP%NOTFOUND ; -- 루프문을 빠져나오기 위한 EXIT 문

    IF CUR_EMP%FOUND THEN 
      DBMS_OUTPUT.PUT_LINE(REC_EMP.EMPNO) ; 
    END IF ; 

  END LOOP ; 

  CLOSE CUR_EMP ; 

END ; 
/

DECLARE

 CURSOR CUR_EMP IS 
   SELECT *
     FROM EMP ; 

BEGIN 
  FOR REC_EMP IN CUR_EMP  LOOP -- REC_ 의 접두사 사용 시 ROWTYPE를 선언하지 않아도 자동으로 적용 됨!
      DBMS_OUTPUT.PUT_LINE(REC_EMP.empno) ; 
  END LOOP ; 
END ; 
/

BEGIN  -- declare 함수 없이 커서 및 for loop 문 시행!
  FOR REC_EMP IN (SELECT * 
                    FROM EMP)  LOOP 
      DBMS_OUTPUT.PUT_LINE(REC_EMP.EMPNO) ; 
  END LOOP ; 
END ; 
/

--Q. COPY_EMP의 데이터를 EMP 테이블의 데이터와 동일하게 수정하세요. 

BEGIN  
        delete copy_emp;
       insert into copy_emp select * from emp ;
END ; 
/

DECLARE 
  V_CNT   NUMBER ; 
BEGIN
  FOR REC_EMP IN (SELECT * FROM EMP) LOOP 
    SELECT COUNT(*) INTO V_CNT  
      FROM COPY_EMP  
     WHERE EMPNO = REC_EMP.EMPNO ;  

    IF V_CNT = 0 THEN 
      INSERT INTO COPY_EMP VALUES REC_EMP ; 
    ELSE 
      UPDATE COPY_EMP 
         SET ROW = REC_EMP 
       WHERE EMPNO = REC_EMP.EMPNO ;   
    END IF ;
  
   -- COMMIT ; 
  END LOOP ; 
  
  -- COMMIT ;  
END ; 
/


rollback;

select * from copy_emp;
select * from emp;

DECLARE
    v_salary NUMBER(12,2);  -- salary 컬럼의 데이터 타입을 직접 선언
BEGIN
    SELECT salary INTO v_salary FROM employees WHERE employee_id = 100;
    DBMS_OUTPUT.PUT_LINE('급여: ' || v_salary);
END;
/

DECLARE
    v.rec_emp employees%ROWTYPE;
BEGIN
    SELECT *
    INTO v.rec_emp
    FROM employees WHERE employee_id = 101;

    DBMS_OUTPUT.PUT_LINE('사원: ' || v_emp_rec_first_name || ' ' || v_last_name);
    DBMS_OUTPUT.PUT_LINE('급여: ' || v_salary);
END;
/


select *
from employees;
/


 declare
    v_id employees.EMPLOYEE_ID%TYPE := &check_your_id;
    v_sal employees.salary%TYPE;
    v_str varchar2(20) := NULL ;
     
BEGIN
    select employee_id, salary into v_id, v_sal
    from EMPLOYEES
    where employee_id = &check_your_id;

    for i in 1..(v_sal/1000) LOOP
        v_str := v_str||'*';
    end loop;

        DBMS_OUTPUT.PUT_LINE('사원번호: ' || v_id);
        DBMS_OUTPUT.PUT_LINE('급여: ' || v_sal);
        DBMS_OUTPUT.PUT_LINE('별점: ' || v_str);
end;
/

select employee_id, hire_date, trunc(months_between(sysdate, hire_date) / 12) 근속연수, salary
from EMPLOYEES
where employee_id = 100;
//


DECLARE
    v_id employees.employee_id%TYPE := 100;
    v_hiredate employees.hire_date%TYPE;
    v_salary employees.salary%TYPE;
BEGIN
    update employees
    set employees.salary = employees.salary * 1.1
    where employees.employee_id = 100;
    
    SELECT employee_id, hire_date, trunc(months_between(sysdate, v_hiredate) / 12), salary
     INTO v_id, v_hiredate, v_salary
     from employees
     where employee_id = 100;

        DBMS_OUTPUT.PUT_LINE(v_id || '사원 입사일은 ' || v_hiredate || '근속연수는' || trunc(months_between(sysdate, v_hiredate) / 12) || '년 입니다.');
        DBMS_OUTPUT.PUT_LINE(v_id || '사원의 급여가' || v_salary || '->'|| v_salary * 1.1 || '수정했습니다.');
end;
/

ROLLBACK;

DECLARE
    v_id employees.employee_id%TYPE := 100;
    v_day employees.hire_date%TYPE;
    v_years number := trunc(months_between(sysdate, v_day)/12);
    v_sal_before employees.salary%TYPE;
    v_sal_after employees.salary%TYPE;
BEGIN
    SELECT hire_date, salary
    INTO v_day, v_sal_before
    FROM employees
    WHERE employee_id = v_id;
    
    v_years := trunc(months_between(sysdate, v_day)/12);
    DBMS_OUTPUT.PUT_LINE(v_id||' 사원 입사일은 '||v_day||' 근속연수는 '||v_years||'년입니다.');        
    
    IF v_years >= 20 THEN -- 20년 이상 IF문
        UPDATE employees
        SET salary = salary*1.1
        WHERE employee_id = v_id;
       
        IF sql%found THEN -- sql%found IF문
            -- ture 이면 
            SELECT salary
            INTO v_sal_after
            FROM employees
            WHERE employee_id = v_id;
            
            DBMS_OUTPUT.PUT_LINE(v_id||' 사원의 급여가 '||v_sal_before||' → '||v_sal_after||' 수정했습니다.');
            COMMIT;
        ELSE
            ROLLBACK;
        END IF; -- sql%found IF-END
        
    ELSE
        DBMS_OUTPUT.PUT_LINE(v_id||'사원은 급여를 수정할 수 없습니다.');
    END IF; -- 20년 이상 IF-END
    
END;
/

declare 
    i number :=  1;
    i_sum number := 0;
BEGIN
    
    while i <= 100 LOOP
    i_sum := i_sum + i;
    i := i + 1;
    end loop;
     dbms_output.put_line('i_sum : '||i_sum);
END;
/

DECLARE
    i NUMBER := 1;
BEGIN
    
    while i <= 99 LOOP
        i := i + 1;
        IF MOD(i, 2) = 1 THEN continue;

        END IF;
        dbms_output.put_line(i);
    END LOOP;
END;
/