begin
    create_tables.create_tags_table(3);
    --autograph_methods.new_tag(3, 2);
end;
set serveroutput on;
begin
    --create_tables.create_autographs_table(2);
    autograph_methods.new_autograph_dynamic(2, 6, 2, 1, 'last summer', 'cute');
end;

begin
    autograph_methods.delete_autograph(2, 3);
end;

set serveroutput on;
begin

end;

describe user_2_autographs;
select * from user_2_autographs;

drop table user_2_autographs;

SELECT * FROM accounts;
SELECT * FROM autograph_authors;
SELECT * FROM tags;
SELECT TABLE_NAME FROM USER_TABLES;
SELECT * FROM exchange_autographs;
select * from user_test_email_autographs;
drop table user_test_email_autographs;

--------------------------------------------------
set serveroutput on;
declare
output varchar2(500);
begin
    autograph_methods.get_user_autographs(2, output);
end;
--------------------------------------------------

commit;

set serveroutput on;
declare
output varchar2(500);
begin
    user_package.register_user('EMAIL0', 'EMAIL0', 'EMAIL0', output);
end;

SELECT * FROM accounts;
SELECT TABLE_NAME FROM USER_TABLES;

select table_name from user_tables where table_name='accounts';


----------------------------------------------------------------------------------------------------
--prezentare

--register
SELECT * FROM accounts;

set serveroutput on;
output varchar2(500);
begin
    user_package.register_user('ok1', 'ok2', 'ok3', output);
end;

--login
SELECT * FROM accounts;

set serveroutput on;
begin
    user_package.login('ok1', 'ok3')
end;


--new auto
SELECT * FROM accounts;
SELECT TABLE_NAME FROM USER_TABLES;
select * from user_2_autographs;

set serveroutput on;
declare
output varchar2(500);
begin
    autograph_methods.new_autograph_dynamic(2, 2, 4, 2, 'summer', 'cool');
end;


--delete auto:
SELECT * FROM accounts;
SELECT TABLE_NAME FROM USER_TABLES;
select * from user_2_autographs;

set serveroutput on;
declare
output varchar2(500);
begin
    autograph_methods.delete_autograph(2, 3);
end;


--create autograph table
SELECT TABLE_NAME FROM USER_TABLES;
select * from user_2_autographs;

set serveroutput on;
begin
    create_tables.create_autographs_table(2);
end;


--create tag table
SELECT TABLE_NAME FROM USER_TABLES;

set serveroutput on;
begin
    create_tables.create_tags_table(3);
end;



--add new tag
set serveroutput on;
begin
    autograph_methods.new_tag(3, 3);
end;


--get all autographs
set serveroutput on;
declare
output2 varchar2(500);
begin
    autograph_methods.get_user_autographs(2, output2);
end;























