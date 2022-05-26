begin
    create_tables.create_tags_table(3);
end;

select * from autograph_3_tags;

SELECT * FROM accounts;
SELECT * FROM autograph_authors;
SELECT * FROM tags;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT * FROM exchange_autographs;
select * from user_test_email_autographs;
drop table used_tags;

--------------------------------------------------
set serveroutput on;
declare
a integer;
begin
    a:=11/5;
    dbms_output.put_line( a);
end;
--------------------------------------------------




