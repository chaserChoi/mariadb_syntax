-- mariadb 서버에 접속 (터미널 접속 시)
mariadb -u root -p -- 입력 후 비밀번호 별도 입력 

-- 스키마(database) 생성
-- 명령문(문법) => 보통 대문자가 관례 (실무에선 대부분 소문자 사용)
-- 테이블명, 열, 제약조건명 등은 소문자 사용
create database board;

-- 스키마 삭제
drop database board;

-- 스키마 목록 조회
show databases;

-- 스키마 선택
use 스키마명;

-- 문자 인코딩 변경
alter database board default character set = utf8mb4;

-- 문자 인코딩 조회
show variables like 'character_set_server';

-- 테이블  생성
create table author(id int primary key, name varchar(255), email varchar(255) unique, password varchar(255));

-- 테이블 목록 조회
show tables;

-- 테이블 컬럼정보 조회
describe author;

-- 테이블 생성명령문 조회
show create table author;

-- posts 테이블 신규 생성 (id, title, contents, author_id)
create table posts(
    id int primary key, 
    title varchar(255), 
    contents varchar(255), 
    author_id int references author(id), 
    -- primary key(id) 제약 조건 추가할 경우 
    foreign key(author_id) references author(id) 
)

-- 테이블 제약 조건 조회
select * from information_schema.key_column_usage where table_name = 'posts';

-- 테이블 index 조회
show index from author;

-- alter : 테이블 구조 변경
-- 테이블 이름 변경
alter table posts rename post;
-- 테이블 컬럼 추가
alter table author add column age int;
-- 테이블 컬럼 삭제
alter table author drop column age;
-- 테이블 컬럼명 변경
alter table post change column contents content varchar(255);
-- 테이블 컬럼의 타입과 제약조건 변경 => 덮어쓰기 
alter table author modify column email varchar(100) not null unique;

-- 실습 : author 테이블에 address 컬럼 추가(vaechar(255))
drop table abc;
-- 실습 : post 테이블에 title은 not null로 변경, content는 3000자 변경) 
alter authoradd column exaikkkkoiu
