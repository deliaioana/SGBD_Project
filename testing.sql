begin
    create_tables.create_tags_table(3);
end;

select * from autograph_3_tags;

SELECT * FROM accounts;
SELECT * FROM autographs;
SELECT * FROM autograph_authors;
SELECT * FROM tags;
SELECT * FROM used_tags;
SELECT TABLE_NAME FROM USER_TABLES;


--------------------------------------------------
set serveroutput on;
declare
begin
    DBMS_OUTPUT.put_line();
end;
--------------------------------------------------