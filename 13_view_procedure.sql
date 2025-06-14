-- View : 실제 데이터를 참조먼 허눈 가상의 테이블. SELECT만 가능
-- 사용목적 : 1) 복잡한 쿼리를 사전 생성 2) 권한 분리

-- View 생성
create view author_for_view as 
select name, email
from author;

-- View 조회
select * from author_for_view;

-- View 권한 부여
grant select on board.author_for_view to '계정명'@'%';

-- View 삭제
drop view author_for_view;

-- 프로시저 생성
delimiter // 
create procedure hello_procedure() 
begin
    select 'hello world';
end 
// delimiter ;

-- 프로시저 호출
call hello_procedure();

-- 프로시저 삭제
drop procedure hello_procedure;

-- 회원 목록 조회 : 한글명 프로시저 가능
delimiter // 
create procedure 회원목록조회() 
begin
    select * from author;
end 
// delimiter ;

-- 회원 상세 조회 : input값 사용 가능
delimiter // 
create procedure 회원상세조회(in emailInput varchar(255))
begin
    select * from author where email = emailInput;
end
// delimiter ;

-- 글쓰기
delimiter // 
create procedure 글쓰기(in titleInput varchar(255), in contentsInput varchar(255), in emailInput varchar(255))
begin
    -- declare는 begin 밑에 위치치
    declare authorIdInput bigint;
    declare postIdInput bigint;
    declare exit handler for SQLEXCEPTION
    begin
        rollback;
    end;
    start transaction;
        select * from author where email = emailInput;
        insert into post(title, contents) values(titleInput, contentsInput);
        select id from post order by id desc limit 1;
        insert into author_post(author_id, post_id) values(authorIdInput, postIdInput);
    commit;
end
// delimiter ;

-- 글 삭제
delimiter // 
create procedure 글삭제(in postInput bigint, in emailInput varchar(255))
begin
    declare authorId bigint;
    declare postPostCount bigint;
    select count(*) into authorPostCount from author_post where post_id = postIdInput;
    select id into authorId from author where email = emailInput;
    -- 글쓴이가 나밖에 없는 경우 : author_post 삭제, post까지 삭제
    -- 글쓴이가 나 이외에 다른 사람도 있는 경우 : author_post만 삭제 
    if authorPostCount=1 then 
    -- elseif도 사용 가능
        delete from author_post where author_id = authorId and post_id = postInput ;
        delete from post where id = postInput ;
    else
        delete from author_post where author_id = authorId and post_id = postInput ;
    end if;

end
// delimiter ;

-- 반복문을 통한 post 대량 생성
delimiter // 
create procedure 대량글쓰기(int countInput bigint, in emailInput varchar(255))
begin
    -- declare는 begin 밑에 위치치
    declare authorIdInput bigint;
    declare postIdInput bigint;
    declare countValue bigint default 0;
    while countValue<countInput do 
        select id into authorIdInput from author where email = emailInput;
        insert into post(title) values("안녕하세요");
        select id into postIdInput from post order by id desc limit 1;
        insert into author_post(author_id, post_id) values(authorIdInput, postIdInput);
        set countValue = countValue+1; -- set : 변수 값 변경 
    end while;
end
// delimiter ;