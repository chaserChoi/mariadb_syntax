-- tyni : -128~127 
-- author  테이블에 ege 컬럼 변경
alter TABLE author modify column age tinyint unsigned;
INSERT INTO author(id, email, age) values(6, 'abc@naver.com', 20);

-- int : 4바이트(대략 40억 숫자범위)

-- bigint : 8바이트
-- author, post 테이블 int 값 bigint 변경
ALTER TABLE author modify column id bigint;

-- decimal(총자리수, 소수부 자리수)
ALTER TABLE post add column price decimal(10, 3);
INSERT INTO post(id, title, price, author_id) values()


-- 문자 타이비 고정 길이(CHAR) vs 가변 길이(varchar, text)
alter TABLE author add column gender CHAR(10);
alter TABLE author add column self_introduction text;

-- blob(바이너리 데이터) 타입 실습
-- 일반적으로 blob으로 저장하기 보다, varchar로 설계하고 이미지 경로만 저장함.
ALTER TABLE author add column profile_image longblob;
INSERT INTO author(id, email, profile_image) values(8, 'aaa@naver.com', LOAD_FILE(''))

-- ENUM : 삽입될 수 있는 데이터의 종류를 한정하는 데이터 타입
-- role 컬럼 추가
alter TABLE author add column role ENU('admin', 'user') NOT null default 'user';
-- enum에 지정된 값이 아닌 경우
insert into author(id, email, role) values(10, "sss@naver.com", 'admin2');
-- role을 지정 안한 경우
insert into author(id, email) values(11, "sss@naver.com", 'admin');
-- enum
insert into author(id, email, role) values(12, "sss@naver.com", 'admin');

-- date & datetime
-- 날짜타입의 입력, 수정, 조회시, 문자열 형식 사용
ALTER TABLE author add column birthday date;
ALTER TABLE post add column created_time datetime;
INSERT INTO post(id, title, author_id, created_time) values(7, 'hello', 3, '2025-05-23 12:00:00');

-- 비교 연산자
SELECT * FROM author WHERE id >= 2 AND id <= 4;
SELECT * FROM author WHERE id BETWEEN 2 AND 4; -- 위 구문과 같음
SELECT * FROM author WHERE id IN(2, 3, 4); -- 위 구문과 같음

-- like : 특정 문자를 포함하는 데이터를 조회하기 위한 키워드
SELECT * FROM post WHERE title like 'h%'; -- h로 시작하는 모든 데이터
SELECT * FROM post WHERE title like '%h'; -- h로 끝나는 모든 데이터
SELECT * FROM post WHERE title like '%h%'; -- h가 포함된 모든 데이터

-- regexp : 정규표현식 활용한 조회
SELECT * FROM post WHERE title regexp '[a-z]'; -- 하나라도 알파벳 소문자가 들어있으면 
SELECT * FROM post WHERE title regexp '[가-힣]'; -- 하나라도 한글이 있으면 

-- 날짜 변환 : 숫자 -> 날짜
SELECT cast(20250523 AS date) from author; -- 2025-05-23
-- 문자 -> 날짜
SELECT cast('20250523' AS date); -- 2025-05-23
-- 문자 -> 숫자
select cast('12' as unsigned); -- ('문자' as int) => 시스템 상 사용 추천 X

-- 날짜조회 방법 : 2025-05-23 14:30:25
-- like 패턴, 부등호 활용, date_format
SELECT * from post where created_time like '2025-05%'; -- 문자열처럼 조회
-- 5월 1일부터 5월 20일까지, 날짜만 입력시 시간부분은 00:00:00 자동으로 붙음 
select * from post where created_time >= '2025-05-01' and created_time <= '2025-05-21';

select date_format(created_time, '%Y-%m-%d') from post;
select date_format(created_time, '%H:%i:%s') from post;
select * from post where date_format(created_time, '%m') = '05';

select * from post where cast(date_format(created_time, '%m') as unsigned) = 5;