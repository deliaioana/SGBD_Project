CREATE OR REPLACE PACKAGE create_tables AS
    PROCEDURE create_tags_table(p_id_autograph IN autographs.id_autograph%TYPE);
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
            ' (id_autograph NUMBER(38) NOT NULL, id_tag NUMBER(38) NOT NULL)', DBMS_SQL.NATIVE);
        v_ok := DBMS_SQL.EXECUTE(v_cursor_id);
        DBMS_SQL.CLOSE_CURSOR(v_cursor_id);
    END;
END;






