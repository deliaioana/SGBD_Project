CREATE OR REPLACE PACKAGE autograph_methods AS
    function compute_points(p_id_author in number, p_id_item in number, p_mentions in varchar2) return integer;

    procedure exchange_auto(p_id_user in number, p_id_auto in number, p_id_ex_auto in number);
        p_id_user in number, p_author in number, p_item in varchar2,
        p_moment in varchar2, p_mentions in varchar2) return varchar2;
    procedure new_tag (p_id_auto in number, p_id_tag in number);
    procedure new_autograph_dynamic(
        p_id_user in number, p_id_auto in NUMBER, p_id_author NUMBER,
        p_id_item NUMBER, p_moment VARCHAR2, p_mentions VARCHAR2);
    procedure delete_autograph(p_id_user in number, p_id_auto in number);
END;


CREATE OR REPLACE PACKAGE BODY autograph_methods AS
    function compute_points(p_id_author in number, p_id_item in number, p_mentions in varchar2) 
    return integer as
    
    v_author_importance integer;
    v_item_importance integer;
    v_has_mentions boolean;
    v_points integer;
    
    counter integer;
    begin
        
        if (p_mentions is not null) then
            v_has_mentions := true;
        else
            v_has_mentions := false;
        end if;
        
        select count(*) into counter from autograph_authors where id_author=p_id_author;
        if (counter != 0) then 
            select importance into v_author_importance from autograph_authors where id_author=p_id_author;
        else 
            v_author_importance := 5;
        end if;
            
        select count(*) into counter from items where id_item=p_id_item;
        if (counter != 0) then 
            select importance into v_item_importance from items where id_item=p_id_item;
        else 
            v_item_importance := 2;
        end if;
            
        v_points := 70/100*v_author_importance + 30/100*v_item_importance;
        dbms_output.put_line(v_points);
        if (v_has_mentions = true) then
            v_points := v_points + 5/100*v_points;
        end if;
        
        dbms_output.put_line(v_points);
        return v_points;
            
    end compute_points;
    
    
----------------------------------------------------------------------------------------------------
    procedure exchange_auto(p_id_user in number, p_id_auto in number, p_id_ex_auto in number) as
    v_auto_points integer;
    v_ex_auto_points integer;
    plsql_stmt varchar2(100);
    this_users_autographs varchar2(50);
    this_autographs_tags varchar2(50);
    copys integer;
    begin
        this_users_autographs := 'user_' || p_id_user || '_autographs';
        this_autographs_tags := 'autograph_' || p_id_auto || '_tags';
        
        plsql_stmt := 'select points into v_auto_points from ' || this_users_autographs || ' where id_autograph=p_id_auto';
        execute immediate plsql_stmt;
        
        select points into v_ex_auto_points from exchange_autographs where id_autograph=p_id_ex_auto;
        
        DBMS_OUTPUT.put_line(v_auto_points);
        DBMS_OUTPUT.put_line(v_ex_auto_points);
        if(v_auto_points > v_ex_auto_points) then
            copys := v_auto_points / v_ex_auto_points;
            DBMS_OUTPUT.put_line(copys);
        --else
            --throw exception -> cannot exchange for something more valuable.
        end if;

        
        --delete autograph p_id_auto from this_users_autographs
        --insert x=copys autographs p_id_ex_auto into this_users_autographs
        
    end;
    
----------------------------------------------------------------------------------------------------
    procedure new_tag (p_id_auto in number, p_id_tag in number) as
    sql_stmt VARCHAR2(1000); 
    table_name VARCHAR2(100);
    
    begin 
        table_name := 'autograph_' || p_id_auto || '_tags';
        sql_stmt := 'INSERT INTO ' || table_name || ' VALUES ( ' || p_id_tag ||' )';
        execute IMMEDIATE sql_stmt;
    end new_tag;
    
----------------------------------------------------------------------------------------------------
    procedure new_autograph_dynamic(
        p_id_user in number, 
        p_id_auto in NUMBER,
        p_id_author NUMBER,
        p_id_item NUMBER,
        p_moment VARCHAR2,
        p_mentions VARCHAR2
        )
    as
    
    sql_stmt VARCHAR2(1000); 
    table_name VARCHAR2(100);
    v_points NUMBER;
    begin 
        v_points :=compute_points(p_id_author, p_id_item, p_mentions);
        table_name := 'user_' || p_id_user || '_autographs';
        sql_stmt := 'INSERT INTO ' || table_name || ' VALUES ( ' 
            || p_id_auto || ' , ' || p_id_author || ' , ' || p_id_item 
            || ' , ' || ' '' ' || p_moment || ' '' ' 
            || ' , ' || ' '' ' || p_mentions || ' '' ' 
            || ' , ' || v_points || ' ) '; 
        execute IMMEDIATE sql_stmt;
    end new_autograph_dynamic;
    
----------------------------------------------------------------------------------------------------
    procedure delete_autograph(p_id_user in number, p_id_auto in number) as
    
    sql_stmt VARCHAR2(1000); 
    table_name VARCHAR2(100);
    
    begin 
        table_name := 'user_' || p_id_user || '_autographs';
        sql_stmt := 'DELETE FROM ' || table_name || ' WHERE id_autograph = ' || p_id_auto;
        execute IMMEDIATE sql_stmt;
    end delete_autograph;
END;


   



