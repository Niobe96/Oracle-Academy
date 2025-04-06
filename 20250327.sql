select /*+full*/ * from emp;


-- 별칭 사용 시 반드시 힌트 안에도 별칭을 명시해야함!

SELECT table_name, blocks, num_rows, empty_blocks
FROM user_tables
WHERE blocks - empty_blocks > 100;


set autot traceonly exp
select * from new_employees where employee_id = 100;

select  /*+ index_desc(emp(sal)) */ *
from emp
where sal is not null
order by sal;

select  *
from emp
where sal is not null
order by sal desc;

SELECT cust_id, cust_fname, cust_lname, postal_code
FROM customers
WHERE cust_lname like 'You%';
