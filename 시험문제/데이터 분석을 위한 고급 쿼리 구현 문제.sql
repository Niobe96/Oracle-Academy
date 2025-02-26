/*	
[문항1] 만기일자가 2024년도인 개별 대출 중 대출 금리가 4% 이상인 대출 계좌를 검색하세요.
- 연체 상태이거나 조기 상환된 계좌는 제외하고 만기 일자 기준으로 정렬하세요.
가) 테이블 : tacct (계좌정보)
나) 검색 : lnact, lnact_seq, lnid, branch, prod_cd, exp_dt, ln_amt, rate
다) 조건 : 다음의 조건을 모두 만족하는 행 검색
    ① 현재 대출 중인 계좌 (lmt_typ:NULL, dlq_cnt:NULL, repay:NULL)
    ② 개별 대출 (acct_typ:1)
    ③ 대출 금리가 4% 이상 (rate 가 0.04 보다 크거나 같은 행)
    ④ 만기 일자가 2024년도 (exp_dt 가 2024년도)
라) 정렬 : 만기 일자(exp_dt) 기준 오름차순

※ 검색 결과는 데이터 상태에 따라 다를 수 있습니다.*/

select lnact, lnact_seq, lnid, branch, prod_cd, exp_dt, ln_amt, rate
from tacct
where lmt_typ is NULL and dlq_cnt is NULL and repay is NULL
AND acct_typ = 1 and rate >= 0.04
and extract(year from exp_dt) = 2024
order by exp_dt; 

/*[문항2] 다음 요구 사항에 만족하는 정보를 검색하세요.
가) 테이블 : TACCT
나) 검색 : branch, prod_cd, COUNT(*), SUM(ln_amt)
다) 조건 : 다음 조건을 모두 만족하는 행 검색
    ① ACCT_TYP : 1
    ② BRANCH : 10 ~ 19
    ③ LMT_TYP : NULL
    ④ REPAY : NULL
    ⑤ DLQ_CNT : NULL
    ⑥ COUNT(*) : 3 이상
라) 그룹 : BRANCH, PROD_CD
마) 정렬 : BRANCH, PROD_CD

※ 검색 결과는 데이터 상태에 따라 다를 수 있습니다.*/

select branch, prod_cd, COUNT(*), SUM(ln_amt)
from tacct
where ACCT_TYP = 1 and branch BETWEEN 10 and 19 AND lmt_typ is null
                    and repay is null and dlq_cnt is null
group by BRANCH, PROD_CD
having count(*) >= 3
order by BRANCH, PROD_CD;

/*[문항3] 연체 계좌가 있는 차주 정보를 검색하세요.
가) 테이블 : tid (차주정보), tacct (계좌정보)
나) 관계 : tid.lnid (차주번호)는 하나 이상의 계좌를 가질 수 있다.
다) 검색 : lnid, id_typ, bthday, gender, score, grade
라) 조건 : 연체 계좌 (dlq_cnt가 0보다 큰 계좌)
마) 정렬 : 차주번호 (lnid) 오름차순 정렬 

※ 검색 결과는 데이터 상태에 따라 다를 수 있습니다.*/

describe tacct;

select lnid, id_typ, bthday, gender, score, grade
from Tid
where lnid in (select lnid
                from tacct
                where dlq_cnt >= 0 and dlq_cnt is not null)
order by lnid;

select lnid
from tacct
where dlq_cnt >= 0 and dlq_cnt is not null;

/*[문항4] 두 개이상의 담보가 사용된 설정 번호 정보를 다음과 같이 검색하세요.
가) 테이블 : tcoll (담보정보)
나) 검색 : setnum, 담보정보
    ① 담보정보 : 담보 일련번호(collid)와 인정금액(eval_amt)을 ','로 구분하여 나열
    ② 인정금액(eval_amt)은 백만원 단위로 검색 (eval_amt/1000000)
    ③ 담보 일련번호와 인정금액은 괄호를 이용하여 구분하고, 금액 단위를 함께 표시
    ④ 담보 일련번호를 기준으로 정렬하여 나열
다) 그룹 : 담보 설정번호(setnum)
라) 조건 : 두 개 이상의 담보가 사용된 그룹만 검색 (COUNT(*) 사용)
마) 정렬 : 담보 설정번호(setnum) 기준 오름차순 

※ 검색 결과는 데이터 상태에 따라 다를 수 있습니다.*/

select setnum, 
        listagg(collid || '(' || eval_amt/1000000 || '백만)',', ') within group (order by collid)  AS "담보정보"
from tcoll
group by setnum
having count(*) >= 2
order by setnum;

/*
[문항5] 다음 요구 사항에 만족하는 정보를 검색하세요.
가) 테이블 : TACCT
나) 검색 : 지점별, 상품별 계좌 수를 피벗테이블로 검색
다) 조건 : 다음 조건을 모두 만족하는 행 검색
    ① ACCT_TYP : 1
    ② BRANCH : 10 ~ 19
    ③ LMT_TYP : NULL
    ④ REPAY : NULL
    ⑤ DLQ_CNT : NULL
라) 정렬 : BRANCH*/

select branch, 
            COUNT(case prod_cd when '100' then prod_cd END) AS prod_100,
            COUNT(case prod_cd when '101' then prod_cd END) AS prod_101,
            COUNT(case prod_cd when '102' then prod_cd END) AS prod_102,
            COUNT(case prod_cd when '103' then prod_cd END) AS prod_103,
            COUNT(case prod_cd when '104' then prod_cd END) AS prod_104,
            COUNT(case prod_cd when '105' then prod_cd END) AS prod_105,
            COUNT(case prod_cd when '106' then prod_cd END) AS prod_106,
            COUNT(case prod_cd when '107' then prod_cd END) AS prod_107,
            COUNT(case prod_cd when '108' then prod_cd END) AS prod_108,
            COUNT(case prod_cd when '109' then prod_cd END) AS prod_109,
            COUNT(case prod_cd when '110' then prod_cd END) AS prod_110,
            count(branch) as total
from tacct
where ACCT_TYP = 1 and branch BETWEEN 10 and 19 AND lmt_typ is null
                    and repay is null and dlq_cnt is null
group by rollup(branch) 
order by branch;

