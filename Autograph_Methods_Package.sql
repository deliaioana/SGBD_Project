CREATE OR REPLACE PACKAGE autograph_methods AS
    function compute_points(p_author in number, p_item in varchar2, p_mentions in varchar2) return integer;
    function new_autograph ( 
        p_id_user in varchar2, p_author in number, p_item in varchar2,
        p_moment in varchar2, p_mentions in varchar2) return varchar2;
END;


CREATE OR REPLACE PACKAGE BODY autograph_methods AS
    function compute_points(p_author in number, p_item in varchar2, p_mentions in varchar2) 
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
        
        select count(*) into counter from autograph_authors where author=p_author;
        if (counter != 0) then 
            select importance into v_author_importance from autograph_authors where author=p_author;
        else 
            v_author_importance := 5;
        end if;
            
        select count(*) into counter from items where item_name=p_item;
        if (counter != 0) then 
            select importance into v_item_importance from items where item_name=p_item;
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
    p_id_user in varchar2, p_author in number, p_item in varchar2,
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
    
END;