desc kdt_sepsis_crf_apache

/*1. APACHE II 점수가 가장 높은 환자 10명을 조회하세요.

설명: APACHE II 점수가 높은 순으로 환자를 정렬하여 상위 10명의 점수, 예측 사망률, 실제 결과를 조회합니다.
목적: 높은 APACHE II 점수를 가진 환자의 예측 위험도와 실제 결과(생존/사망)를 비교합니다.
*/

select a.ID, a."APACHE II score" AS "APACHE II 점수", a."Mortality" AS "예측 사망률",
        CASE 
            WHEN s."Death_time" is not null THEN '사망'
            ELSE '생존' END AS "실제 결과", ROW_NUMBER() OVER (order by a."APACHE II score" DESC) AS RN
from kdt_sepsis_crf_apache a join kdt_sepsis_crf_sofa s on a.Id = s.ID
order by 2 DESC
fetch first 10 rows only;

select * from kdt_sepsis_crf_apache
where id = 264;

/*2. APACHE II 점수 분포를 구간별로 집계하세요.
설명: APACHE II 점수를 구간별(0–9, 10–19, 20–29, 30 이상)로 나누어 환자 수를 계산합니다.
*/

select 
    CASE 
        when "APACHE II score" between 0 and 9 then '0-9'
        when "APACHE II score" between 10 and 19 then '10-19'
        when "APACHE II score" between 20 and 29 then '20-29'
        ELSE '30'
        END AS "점수 구간",
        count(*) AS "환자 수"
    from kdt_sepsis_crf_apache
    group by CASE 
        when "APACHE II score" between 0 and 9 then '0-9'
        when "APACHE II score" between 10 and 19 then '10-19'
        when "APACHE II score" between 20 and 29 then '20-29'
        ELSE '30' END
    order by 1;

/*    3. 생존 환자와 사망 환자의 평균 APACHE II 점수를 비교하세요.

설명: 실제 생존 여부에 따라 평균 APACHE II 점수를 계산하여 비교합니다.
목적: APACHE II 점수와 실제 생존 결과의 상관성을 분석합니다.*/

select CASE
            WHEN s."Death_time" is not null THEN '사망 환자'
            ELSE '생존 환자' END AS "생존 그룹", round(avg(a."APACHE II score"),2) AS "평균 점수"
from kdt_sepsis_crf_apache a join kdt_sepsis_crf_sofa s on a.Id = s.ID
group by CASE
            WHEN s."Death_time" is not null THEN '사망 환자'
            ELSE '생존 환자' END;

/*4. APACHE II 점수를 기준으로 고위험군과 저위험군의 실제 사망률을 비교하세요.

설명: APACHE II 점수가 25점 이상이면 고위험군으로 정의하고, 그 미만은 저위험군으로 하여 실제 사망률을 비교합니다.
*/

select case
            when a."APACHE II score" >= 25 then '고위험군'
            ELSE '저위험군' END AS "위험군",
        count(*) AS "환자 수", ((select count(*) from kdt_sepsis_crf_sofa where "Death_time" is not null) / count(*) * 100) AS "실제 사망률"
from kdt_sepsis_crf_apache a join kdt_sepsis_crf_sofa s on a.Id = s.ID
group by CASE
            when a."APACHE II score" >= 25 then '고위험군'
            ELSE '저위험군' END;

-- 정답

WITH total_deaths AS (
    SELECT id
    FROM kdt_sepsis_crf_sofa
    WHERE "Death_time" IS NOT NULL
)
select case
            when a."APACHE II score" >= 25 then '고위험군'
            ELSE '저위험군' END AS "위험군",
        count(*) AS "환자 수", round((count(td.ID) / count(*) * 100),2) AS "실제 사망률"
from kdt_sepsis_crf_apache a join kdt_sepsis_crf_sofa s on a.Id = s.ID LEFT OUTER JOIN total_deaths td ON td.ID = s.ID
group by CASE
            when a."APACHE II score" >= 25 then '고위험군'
            ELSE '저위험군' END;


/*5. 예측 사망률은 높았으나 실제로 생존한 환자 목록을 조회하세요.

설명: APACHE II 기반 예측 사망률이 50% 초과임에도 실제로 생존한 환자만을 조회합니다.
*/

select * from 