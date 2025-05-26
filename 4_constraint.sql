-- not null 제약 조건 추가
alter table author modify column name varchar(255) not null;
alter table author modify title name varchar(255) not null;

-- not null 제약 조건 제거 => 제약 조건 있는 컬럼에 덮어 쓰기 
alter table author modify column name varchar(255);

-- not null, unique 제약 조건 동시 추가
alter table author modify column email varchar(255) not null unique;

-- 테이블 차원의 제약 조건(pk, fk) 추가/제거
-- 제약 조건 삭제(fk) (사용할 일 X -> risk 있음)
alter table post drop foreign key 제약조건명; -- 권고
alter table post drop constraint 제약조건명; 
-- 제약 조건 삭제(pk)
-- 제약 조건명 명시 필요 X => 하나밖에 없기 때문 
-- fk는 여러 개 있을 수 있기 때문에 제약 조건명 명시 필요`
alter table post drop primary key; 

-- 제약 조건 추가
alter table post add constraint post_pk(제약조건명) primary key(id);
alter table post add constraint post_fk foreign key(author_id) references author(id);

-- in delete /update 제약 조건 테스트
-- 부모 테이블 데이터 delete 자식 fx컬럼 set null, update 시에 자식 fk 컬럼 cascede
alter table post add constraint post_fk_new foreign key(author_id) references author(id) on delete set null on update cascade;

-- default 옵션
-- enum 타입 및 현재시간(current_timestamp)에서 많이 사용
alter table author modify column name varchar(255) default 'anonymous';

-- auto_increment 옵션
-- 입력 안했을때, 마지막에 입력된 가장 큰 값에서 +1만큼 자동으로 증가된 숫자 값을 적용용
alter table author modify column id bigint auto_increment;
alter table post modify column id bigint auto_increment;

-- uuid 타입
alter table post add column user_id char(36) default (uuid());