begin
    --create_tables.create_tags_table(3);
    autograph_methods.new_tag(3, 2);
end;
set serveroutput on;
begin
    --create_tables.create_autographs_table(2);
    autograph_methods.new_autograph_dynamic(2, 3, 2, 1, 'now', 'no_ty');
end;

begin
    --create_tables.create_autographs_table(2);
    autograph_methods.delete_autograph(2, 3);
end;

select * from user_2_autographs;
describe user_2_autographs;
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

begin
    DBMS_OUTPUT.put_line(user_package.register_user('email@email', 'Email', 'email'));

end;
--------------------------------------------------




