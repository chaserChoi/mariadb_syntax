-- insert : 테이블에 데이터 삽입
insert into 테이블명(컬럼1, 컬럼2, 컬럼3) values(데이터1, 데이터2, 데이터3);
insert into author(id, name, email) values(3, 'hong3', 'hong3@naver.com'); -- 문자열 -> 일반적으로 ''(작은따옴표) 사용

-- update : 테이블에 데이터 변경
update author set name="홍길동", email="hong100@naver.com" where id=3;

-- select : 조회
select 컬럼1, 컬럼2 from 테이블명;
select name, email from author;
select * from author; -- * : 모든 컬럼 

-- delete : 삭제 
delete from 테이블명 where 조건;
delete from author where id=3; 

-- select 조건절 활용 조회
-- 테스트 데이터 삽입
-- insert 문을 활용해서 author 데이터 3개, post 데이터 5개
select * from author; -- 어떤 조회 조건 없이 모든 컬럼 조회
select * from author where id=1; -- where 뒤에 조회조건 통해 filtering
select * from author where name='hong1'; 
select * from author where id>3;
select * from author where id>2 and name='honggildong4';

-- 중복 제거 조회: distinct
select name from author;
select distinct name from author;

-- 정렬 : order by + 컬럼명
-- asc : 오름차순(default), desc : 내림차순
-- 아무런 정렬조건 없이 조회할 경우에는 pk 기준으로 오름차순 
SELECT * FROM author ORDER BY name DESC;

-- (중요!) 멀티 컬럼 order by : 여러 컬럼으로 정렬시에, 먼저 쓴 컬럼 우선정렬, 중복 시, 그 다음 정렬 옵션 적용
SELECT * FROM author ORDER BY name DESC, email ASC; -- name으로 먼저 정렬 후, name 중복돠면 email로 정렬 

-- 결과 값 개수 제한
SELECT* FROM author ORDER BY id DESC LIMIT 1;

-- 별칭(alias)를 이용한 select
SELECT name as '이름', email as '이메일' FROM author;
SELECT a.name, a.email, p.name, p.contents FROM author as a INNER JOIN post as p;
SELECT a.name, a.email FROM author as a;
SELECT a.name, a.email FROM author a; -- as 생략 가능

-- null을 조회 조건으로 활용
SELECT * FROM author WHERE password IS NULL;
SELECT * FROM author WHERE password IS NOT NULL;

-- 프로그래머스 sql문제 풀기
-- 여러 기준으로 정렬하기
select ANIMAL_ID, NAME, DATETIME 
from ANIMAL_INS 
order by NAME, DATETIME DESC;

-- 상위 n개 레코드
SELECT NAME 
FROM ANIMAL_INS 
ORDER BY DATETIME LIMIT 1;

