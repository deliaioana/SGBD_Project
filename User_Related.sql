CREATE OR REPLACE PACKAGE user_package AS
    procedure register_user(p_email_user IN VARCHAR2, p_username IN VARCHAR2, 
        p_password IN VARCHAR2, return_code out number);

    procedure login(p_email IN VARCHAR2, p_password IN VARCHAR2, return_code out number, p_id_user out number);
    function count_logged_users(p_email in varchar2, p_password in varchar2) return integer;
    function count_registered_users(p_email in varchar2) return integer;

    
END;


CREATE OR REPLACE PACKAGE BODY user_package AS

    procedure register_user(p_email_user IN VARCHAR2, p_username IN VARCHAR2, 
    p_password IN VARCHAR2, return_code out number) AS
    
    v_count INTEGER;
    counter2 INTEGER;
    v_user_counter INTEGER;
        
    BEGIN
        select count(*) into counter2 from accounts;
        v_user_counter := counter2+1;
        
        v_count := count_registered_users(p_email_user);
            exception
                when exceptions_package.already_registered then
                    return_code := 8;--create_tables.create_autographs_table(p_id_user); ---------de decomentat
                    
        IF (NOT p_email_user IS NULL AND NOT p_username IS NULL AND NOT p_password IS NULL) THEN
            IF (v_count = 0) THEN
                INSERT INTO accounts VALUES (v_user_counter, p_email_user, p_username, p_password);
                return_code := 0; -- successfully registered 

            END IF;
        else
            return_code := 2; -- invalid entry
        END IF;    
        
    END;

----------------------------------------------------------------------------------------------------
procedure login(p_email in varchar2, p_password in varchar2, return_code out number, p_id_user out number) as
    v_id_user integer;
    v_count integer;
    begin
        p_id_user := 0;
        v_count := count_logged_users (p_email, p_password);
        if v_count = 1 then
           return_code := 0; -- successfully logged in 
           select id_user into v_id_user from accounts where email=p_email and pass=p_password; 
           p_id_user := v_id_user;
        end if;
        
        exception
            when exceptions_package.user_not_registered then
                return_code := 5;
         
        --select count(*) into counter from accounts where email=p_email and pass=p_password;
        
        --return_code := 1; -- not registered
    end login;
     
----------------------------------------------------------------------------------------------------

    function count_logged_users(p_email in varchar2, p_password in varchar2) return integer as
    
    counter integer;
    begin
        select count(*) into counter from accounts where email=p_email and pass=p_password;
        if counter!=1 then
            raise exceptions_package.user_not_registered;
        else
            return 1;
        end if;
    end count_logged_users;
        
----------------------------------------------------------------------------------------------------

    function count_registered_users(p_email in varchar2) return integer as
    
    counter integer;
    begin
        select count(*) into counter from accounts where email=p_email;
        if counter = 1 then
            raise exceptions_package.already_registered;
        else
            return 1;
        end if;
    end count_registered_users;
    
END;




