EXPLAIN PLAN FOR
SELECT * FROM employees WHERE department_id = 50;
SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);

SELECT table_name, num_rows, blocks, avg_row_len, sample_size, last_analyzed
FROM dba_tables -- dba_tab_statistics
WHERE table_name = 'EMPLOYEES'
AND owner='HR';

create table cp_emp as select * from emp;

begin
dbms_stats.gather_table_stats('test','employees');
end;
/

SELECT num_rows, blocks, avg_row_len, sample_size, last_analyzed
FROM dba_tab_statistics
WHERE table_name='CP_EMP'
AND owner='TEST';

--컬럼 통계는 테이블 통계 수집시 같이 수집

SELECT column_name, num_distinct, density, num_nulls, low_value, high_value
FROM dba_tab_col_statistics
WHERE owner = 'TEST'
AND table_name = 'CP_EMP';

select /* sqlt1 */ * from hr.employees;

select sql_id, sql_text from v$sql
where sql_text like '%sqlt1%';

select name, value
from v$sql_optimizer_env -- v$sys_optimizer_env
where sql_id='ffq5r72vttp9u'
and child_number=0
order by name;


select * from employees
where employee_id = 100;

select * from table(DBMS_XPLAN.DISPLAY(null,null,'all'));

select * from emp;

SELECT sql_id, sql_text
FROM v$sql
WHERE sql_text LIKE '%SELECT e.last_name,%' ;

select * from table(dbms_xplan.display_cursor('bn95juaj8mgk4'));

SELECT sql_id, child_number, sql_text, parsing_schema_name,
executions, -- 총 수행횟수
cpu_time, elapsed_time, -- 총 CPU 사용시간, 수행시간(micro sec)
buffer_gets, disk_reads -- 총 logical/physical read blocks,
FROM v$sql
WHERE parsing_schema_name='HR'
AND sql_text LIKE '%departments%';

 select * from departments;
select * from table(dbms_xplan.display_cursor(null,null,'allstats last'));
