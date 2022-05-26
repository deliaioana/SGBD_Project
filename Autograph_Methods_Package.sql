CREATE OR REPLACE PACKAGE autograph_methods AS
    function compute_points(p_id_author in number, p_id_item in number, p_mentions in varchar2) return integer;
    function new_autograph ( 
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
        if (v_has_mentions = true) then
            v_points := v_points + 5/100*v_points;
        end if;
        
        return v_points;
            
    end compute_points;
    
----------------------------------------------------------------------------------------------------
    function new_autograph ( 
    p_id_user in number, p_author in number, p_item in varchar2,
    p_moment in varchar2, p_mentions in varchar2) return varchar2 as

    counter integer;
    v_id_autograph integer;
    v_points integer := 0;
    begin
    
        select count(*) into counter from autographs;
        v_id_autograph := counter+1;
        
        v_points := compute_points(p_author, p_item, p_mentions);
        
        if (p_id_user is not null and p_author is not null) then
            insert into autographs values (v_id_autograph, p_id_user, p_author, p_item, 
                p_moment, p_mentions, v_points);
            return '0'; -- successfully inserted
        end if;
        return '1'; -- incorrect entry
    end new_autograph;
    
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


   





