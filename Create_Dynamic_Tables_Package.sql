CREATE OR REPLACE PACKAGE create_tables AS
    PROCEDURE create_tags_table(p_id_autograph IN autographs.id_autograph%TYPE);
    PROCEDURE create_autographs_table(p_id_user IN accounts.email%TYPE);
END;


CREATE OR REPLACE PACKAGE BODY create_tables AS  
    PROCEDURE create_tags_table(p_id_autograph IN autographs.id_autograph%TYPE) AS 
    v_cursor_id INTEGER;
    v_ok INTEGER;
    table_name VARCHAR2(3200);
    BEGIN
        table_name := 'autograph_' || p_id_autograph || '_tags';
    
        v_cursor_id := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(v_cursor_id, 'CREATE TABLE ' || table_name || 
            ' (id_tag NUMBER(38) NOT NULL)', DBMS_SQL.NATIVE);
        v_ok := DBMS_SQL.EXECUTE(v_cursor_id);
        DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    END;
    
----------------------------------------------------------------------------------------------------

    PROCEDURE create_autographs_table(p_id_user IN accounts.email%TYPE) AS 
    v_cursor_id INTEGER;
    v_ok INTEGER;
    table_name VARCHAR2(3200);
    BEGIN
        table_name := 'user_' || p_id_user || '_autographs';
    
        v_cursor_id := DBMS_SQL.OPEN_CURSOR;
        DBMS_SQL.PARSE(v_cursor_id, 'CREATE TABLE ' || table_name || 
            ' (id_autograph NUMBER(38) NOT NULL, id_author NUMBER(38) NOT NULL, ID_ITEM NUMBER(38) NOT NULL, MOMENT VARCHAR2(50), MENTIONS VARCHAR2(50), POINTS NUMBER(10))', DBMS_SQL.NATIVE);
        v_ok := DBMS_SQL.EXECUTE(v_cursor_id);
        DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    END;
END;







