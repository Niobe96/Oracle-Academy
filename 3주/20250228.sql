-- 9 예외처리

SET SERVEROUTPUT ON

declare 
    rec_emp emp%rowtype ;

BEGIN
    select * into rec_emp
    from EMP
    where deptno = 10;

EXCEPTION
    WHEN OTHERS THEN ROLLBACK;
    DBMS_OUTPUT.PUT_LINE (SQLERRM);
end;
/

alter table emp
add constraint emp_ck check (sal > 0);

rollback;

select empno, ename, sal
from EMP
where deptno = 10;

SET SERVEROUTPUT ON 
DECLARE 
   REC_EMP   EMP%ROWTYPE ; 
BEGIN 

    SELECT * INTO REC_EMP 
      FROM EMP 
     WHERE EMPNO = 1234 ;

EXCEPTION 
 WHEN OTHERS THEN  
     ROLLBACK  ;
     DBMS_OUTPUT.PUT_LINE(SQLERRM) ;  
END ; 
/

DECLARE
        e_name EXCEPTION;
    BEGIN
        DELETE FROM employees
        WHERE last_name = 'Higgins';
        IF SQL%NOTFOUND THEN RAISE e_name;
        END IF;
        EXCEPTION
        WHEN e_name THEN
        RAISE_APPLICATION_ERROR (-20999, 'This is not a valid last
        name');
END;
/


SET SERVEROUTPUT ON 
DECLARE 
   REC_EMP   EMP%ROWTYPE ; 
BEGIN 
    SELECT * INTO REC_EMP 
      FROM EMP 
     WHERE EMPNO = 1234 ;

EXCEPTION 
 WHEN OTHERS THEN  
     RAISE_APPLICATION_ERROR ( -20001, '사원번호가 없어요', TRUE ) ; 
END ; 
/

SET SERVEROUTPUT ON
BEGIN
    UPDATE emp 
    SET sal = 7777
    WHERE empno = 7788 ; 

    BEGIN 
            UPDATE emp 
            SET sal = 9999
            WHERE empno = 7566 ; 

            UPDATE emp 
            SET sal = 0 
            WHERE empno = 7839 ;

            UPDATE emp 
            SET sal = 9999 
            WHERE empno = 7499 ;

            EXCEPTION 
            WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE (SQLERRM) ; 
    END ;

    UPDATE emp  -- 실행 O
    SET sal = 7777
    WHERE empno = 7369 ; 

END ; 
/

rollback;


SELECT empno, ename, sal 
FROM emp 
WHERE empno IN (7788, 7566, 7839, 7369,7499) ; 


SET SERVEROUTPUT ON
BEGIN
    UPDATE emp     ------  7777
    SET sal = 7777
    WHERE empno = 7788 ; 

            BEGIN 
            UPDATE emp     ---- 
            SET sal = 9999
            WHERE empno = 7566 ; 

            UPDATE emp 
            SET sal = 0 
            WHERE empno = 7839 ;

            UPDATE emp       --- 실행 X 
            SET sal = 9999 
            WHERE empno = 7499 ;

            END ;
  
    UPDATE emp            --- 실행 X 
    SET sal = 7777
    WHERE empno = 7369 ; 

EXCEPTION 
WHEN OTHERS THEN 
DBMS_OUTPUT.PUT_LINE (SQLERRM) ; 
END ; 
/

BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, PL/SQL!');
END;
/

DECLARE
    v_age NUMBER := 30;
    v_city varchar2(50) := 'Seoul';
BEGIN
     DBMS_OUTPUT.PUT_LINE ('나이: ' || v_age) ;
     DBMS_OUTPUT.PUT_LINE ('도시: ' ||v_city) ;
end;
/

DECLARE
    v_price number := 20000;
    v_discount number := v_price / 100 * 15;
    v_final_price number := v_price - v_discount;
BEGIN
    DBMS_OUTPUT.PUT_LINE ('원래 가격: ' || v_price||', 할인 금액:'||v_discount||', 최종 가격:'||v_final_price) ;
end;
/

DECLARE
    v_score number := '&점수';

BEGIN
     DBMS_OUTPUT.PUT_LINE ('점수: ' ||v_score) ;
    
    IF v_score >= 90 
        then DBMS_OUTPUT.PUT_LINE ('학점: A 학점') ;
    ELSIF v_score >= 80 
        then DBMS_OUTPUT.PUT_LINE ('학점: B 학점') ;
    ELSIF v_score >= 70
        then DBMS_OUTPUT.PUT_LINE ('학점: C 학점') ;
    ELSE 
        DBMS_OUTPUT.PUT_LINE ('F 학점') ;
    end if;
end;
/

declare 
    v_num number := 1;
BEGIN
    for i in 1..10 Loop
     DBMS_OUTPUT.PUT_LINE('현재 숫자: ' || v_num);
     v_num := v_num + 1;
     end loop;
end;
/

declare
    v_num number := 1;
begin
    for i in 1..20 loop
        if mod(i,3) = 0 then
            DBMS_OUTPUT.PUT_LINE(v_num||'는(은) 3의 배수입니다.');
            v_num := v_num + 1;
        ELSE
            DBMS_OUTPUT.PUT_LINE(v_num||'는(은) 3의 배수가 아닙니다.');
            v_num := v_num + 1;
        end if;
    end loop;
end;
/

declare
    v_salary emp.sal%TYPE;
BEGIN
    SELECT sal into v_salary
    from EMP
    where empno = 7788;
    DBMS_OUTPUT.PUT_LINE('급여 : '||v_salary);
end;
/



select * from EMPLOYEES;
select * from DEPARTMENTS;
select * from locations;


CREATE OR REPLACE PROCEDURE delete_emp
( p_empno	NUMBER) 
IS 
  emp_rec   emp%ROWTYPE ;
BEGIN 
  SELECT * INTO emp_rec 
  FROM emp
  WHERE empno = p_empno ; 

  DELETE emp
  WHERE empno = p_empno ; 

  UPDATE emp_sum
  SET sum_sal = sum_sal - emp_rec.sal 
  WHERE deptno = emp_rec.deptno ; 

EXCEPTION 
  WHEN OTHERS THEN 
    DBMS_OUTPUT.PUT_LINE (SQLERRM) ; 
END delete_emp ;
/


-- 파라미터에 대한 설명!
-- 파라미터(Parameter) 는 함수(Function)나 프로시저(Procedure)에 값을 전달하기 위해 사용하는 변수

CREATE OR REPLACE PROCEDURE say_hello(p_name VARCHAR2) IS
BEGIN
    DBMS_OUTPUT.PUT_LINE('Hello, ' || p_name || '!');
END;
/

BEGIN
    say_hello('dik');  -- 파라미터 값 작성!
END;
/

create view emp_view as
select empno, sal, job, deptno from EMP;

select *
from EMP_VIEW;

SET TIMING ON;
DECLARE 
   CURSOR cur_sales IS SELECT /*+ basic_cursor */ * FROM sh.sales ; 
   rec_sales  cur_sales%rowtype ; 
 BEGIN
   OPEN cur_sales ; 
   LOOP 
	 FETCH cur_sales INTO rec_sales ; 
	 EXIT WHEN cur_sales%NOTFOUND ; 
   END LOOP ;  
   CLOSE cur_sales ;
 END ;
/


