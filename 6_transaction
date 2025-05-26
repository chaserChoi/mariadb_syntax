-- 트랜잭션 테스트
alter table author and column post_count int default 0;

-- post에 글쓴 후에, author 테이블의 post_count 컬럼에 +1를 시키는 트랜잭션 테스트
start transaction;
update author set post_count=post_count + 1 where id = 3;
insert into post(title, content, author_id) values('hello', 'hello ...', 3);
commit;
-- rollback; -- 트랜잭션 취소

-- 위 트랜잭션은 실패 시 자동으로 rollback이 어러움
-- stored 프로시저 활용하여 성공 시, commit, 실패 시 rollback 등 다이나믹한 프로그래망
DELIMITER // 
create procedure transaction_test() 
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback; -- 트랜잭션 취소 
    end;
    start transaction;
    update author set post_count=post_count + 1 where id = 3;
    insert into post(title, content, author_id) values('hello', 'hello ...', 3);
    commit;
end // 
DELIMITER;

-- 프로시저 호출
call transaction_test();

-- 사용자에게 입력받는 프로시저 생성성
DELIMITER // 
create procedure transaction_test2(in titleInput varchar(255), in contentInput varchar(255), in idInput bigint) 
begin
    declare exit handler for SQLEXCEPTION
    begin
        rollback; 
    end;
    start transaction;
    update author set post_count=post_count + 1 where id = idInput;
    insert into post(title, content, author_id) values(titleInput, contentInput, idInput);
    commit;
end // 
DELIMITER;
