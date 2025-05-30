-- 사용자 관리
-- 사용자 목록 조회
select * from mysql.user;

-- 사용자 생성
create user 'bradkim97'@'%' identified by '4321';

-- 사용자에게 권한 부여
grant select on board.author to 'bradkim97'@'%';
grant select, insert on board.* to 'bradkim97'@'%';
grant all privileges on board.* to 'bradkim97'@'%';

-- 사용자 권한 회수
revoke select on board.author from 'bradkim97'@'%';

-- 사용자 권한 조회
show grants for 'bradkim97'@'%';

-- 사용자 계정 삭제
drop user 'bradkim97'@'%';
