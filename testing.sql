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

select * from user_2_autographs;
describe user_2_autographs;
select * from autograph_3_tags;

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


