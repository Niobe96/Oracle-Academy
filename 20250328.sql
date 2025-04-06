SELECT empno, sal, ROWNUM
FROM emp
WHERE ROWNUM <= 5;

select a.*, ROWNUM as r_num
from (select empno, sal
        from emp
        order by sal DESC) a
where rownum <= 10;

SELECT *
    FROM (SELECT empno, sal, ROWNUM r_num
            FROM (SELECT empno, sal
                FROM emp
                ORDER BY sal DESC) a
            WHERE ROWNUM <= 10) b
WHERE r_num >= 6;

select empno, deptno, sal,
        sum(sal) over(partition by deptno) as sum_sal
    from EMP
order by deptno;


-- 각 행마다의 합계 구하는 식
select empno, deptno, sal,
        sum(sal) over(order by sal) as sum_sal
    from EMP;

select empno, deptno, sal,
        row_number() over(order by sal) as a_sal
    from EMP;

